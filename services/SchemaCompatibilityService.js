const fs = require('fs/promises');
const path = require('path');

async function tableExists(db, table) {
  const [[row]] = await db.query(
    `SELECT COUNT(*) AS n FROM information_schema.tables
     WHERE table_schema=DATABASE() AND table_name=?`,
    [table]
  );
  return Number(row?.n || 0) > 0;
}

async function columnExists(db, table, column) {
  const [[row]] = await db.query(
    `SELECT COUNT(*) AS n FROM information_schema.columns
     WHERE table_schema=DATABASE() AND table_name=? AND column_name=?`,
    [table, column]
  );
  return Number(row?.n || 0) > 0;
}

async function addColumn(db, table, column, definition) {
  if (!(await tableExists(db, table)) || (await columnExists(db, table, column))) return false;
  await db.query(`ALTER TABLE \`${table}\` ADD COLUMN \`${column}\` ${definition}`);
  return true;
}

async function ensureFilesAndPaths(db, projectRoot) {
  const mediaRoot = path.join(projectRoot, 'public', 'media');
  const uploadsRoot = path.join(projectRoot, 'public', 'uploads');
  await fs.mkdir(uploadsRoot, { recursive: true });

  async function copyTree(src, dst) {
    let entries;
    try { entries = await fs.readdir(src, { withFileTypes: true }); } catch (_) { return; }
    await fs.mkdir(dst, { recursive: true });
    for (const entry of entries) {
      const from = path.join(src, entry.name);
      const to = path.join(dst, entry.name);
      if (entry.isDirectory()) await copyTree(from, to);
      else {
        try { await fs.access(to); } catch (_) { await fs.copyFile(from, to); }
      }
    }
  }

  await copyTree(mediaRoot, uploadsRoot);

  // La aplicación usa una sola raíz pública. Primero migramos los archivos y
  // las rutas; al final retiramos la carpeta antigua para evitar duplicados.

  if (await tableExists(db, 'tienda_imagenes')) {
    await db.query("UPDATE tienda_imagenes SET ruta=REPLACE(ruta,'/media/','/uploads/') WHERE ruta LIKE '/media/%'");
  }
  if (await tableExists(db, 'configuracion')) {
    await db.query("UPDATE configuracion SET valor=REPLACE(valor,'/media/','/uploads/') WHERE valor LIKE '/media/%'");
  }
  if (await tableExists(db, 'producto_imagenes')) {
    await db.query("UPDATE producto_imagenes SET ruta=REPLACE(ruta,'/media/','/uploads/') WHERE ruta LIKE '/media/%'");
  }
  if (await tableExists(db, 'productos') && await columnExists(db, 'productos', 'imagen')) {
    await db.query("UPDATE productos SET imagen=REPLACE(imagen,'/media/','/uploads/') WHERE imagen LIKE '/media/%'");
  }

  await fs.rm(mediaRoot, { recursive: true, force: true }).catch(() => {});
}

async function ensureSchema(db, projectRoot) {
  const changes = [];

  for (const [column, definition] of [
    ['direccion_enc', 'TEXT NULL AFTER `departamento`'],
    ['distrito_enc', 'TEXT NULL AFTER `direccion_enc`'],
    ['provincia_enc', 'TEXT NULL AFTER `distrito_enc`'],
    ['departamento_enc', 'TEXT NULL AFTER `provincia_enc`']
  ]) {
    if (await addColumn(db, 'clientes', column, definition)) changes.push(`clientes.${column}`);
  }

  if (await addColumn(db, 'cotizaciones', 'updated_at', 'DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP')) {
    changes.push('cotizaciones.updated_at');
  }

  for (const [column, definition] of [
    ['es_transferido', 'TINYINT(1) NOT NULL DEFAULT 0'],
    ['producto_origen_id', 'INT NULL'],
    ['sucursal_origen_id', 'INT NULL'],
    ['transferencia_venta_habilitada', 'TINYINT(1) NOT NULL DEFAULT 1']
  ]) {
    if (await addColumn(db, 'productos', column, definition)) changes.push(`productos.${column}`);
  }

  for (const [column, definition] of [
    ['tipo_descuento', "ENUM('porcentaje','monto') NOT NULL DEFAULT 'porcentaje' AFTER `producto_id`"],
    ['monto', 'DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER `porcentaje`']
  ]) {
    if (await addColumn(db, 'temporada_descuentos', column, definition)) changes.push(`temporada_descuentos.${column}`);
  }
  if (await tableExists(db, 'temporada_descuentos')) {
    await db.query(`ALTER TABLE temporada_descuentos ADD UNIQUE KEY uq_temporada_producto (temporada_id,producto_id)`).catch(() => {});
  }

  await db.query(`CREATE TABLE IF NOT EXISTS reparto_evidencias (
    id BIGINT NOT NULL AUTO_INCREMENT,
    ruta_id INT NOT NULL,
    ruta_detalle_id INT NOT NULL,
    tipo ENUM('fachada','entrega','incidencia') NOT NULL DEFAULT 'entrega',
    archivo_privado VARCHAR(500) NOT NULL,
    sha256 CHAR(64) NOT NULL,
    created_by INT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    eliminado_at DATETIME NULL,
    eliminado_por INT NULL,
    motivo_eliminacion VARCHAR(300) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    KEY idx_evidencia_ruta (ruta_id,ruta_detalle_id,eliminado_at),
    UNIQUE KEY uq_evidencia_detalle_hash (ruta_detalle_id,sha256)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci`);

  await db.query(`CREATE TABLE IF NOT EXISTS reparto_historial (
    id BIGINT NOT NULL AUTO_INCREMENT,
    ruta_id INT NOT NULL,
    ruta_detalle_id INT NULL,
    estado_anterior VARCHAR(40) NOT NULL DEFAULT '',
    estado_nuevo VARCHAR(40) NOT NULL DEFAULT '',
    comentario VARCHAR(500) NOT NULL DEFAULT '',
    lat DECIMAL(10,7) NULL,
    lng DECIMAL(10,7) NULL,
    precision_m DECIMAL(10,2) NULL,
    usuario_id INT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_historial_ruta (ruta_id,ruta_detalle_id,created_at)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci`);

  // Nuevo módulo de rentabilidad. No se asigna por nombre de perfil:
  // el admin global recibe todas las opciones en la sesión y los otros perfiles
  // pueden configurarse desde Perfiles.
  if (await tableExists(db, 'opciones')) {
    await db.query(`INSERT INTO opciones (slug,nombre,icono,ruta,orden,estado,activo)
      VALUES ('rentabilidad','Rentabilidad','ti-chart-pie-2','/rentabilidad',85,0,0)
      ON DUPLICATE KEY UPDATE nombre=VALUES(nombre),icono=VALUES(icono),estado=0,activo=0`);
  }
  if (await tableExists(db, 'permisos_accion')) {
    for (const row of [
      ['rentabilidad.ver','rentabilidad','Ver rentabilidad','Consultar ganancias, costos y pérdidas'],
      ['rentabilidad.ver_costos','rentabilidad','Ver costos de rentabilidad','Consultar costos, márgenes y alertas']
    ]) {
      await db.query(`INSERT INTO permisos_accion (slug,modulo,nombre,descripcion)
        VALUES (?,?,?,?) ON DUPLICATE KEY UPDATE modulo=VALUES(modulo),nombre=VALUES(nombre),descripcion=VALUES(descripcion)`, row);
    }
  }

  if (await tableExists(db, 'configuracion')) {
    await db.query(`INSERT INTO configuracion (clave,valor,grupo)
      VALUES ('schema_version','45','sistema')
      ON DUPLICATE KEY UPDATE valor='45',grupo='sistema',updated_at=CURRENT_TIMESTAMP`);
  }

  await ensureFilesAndPaths(db, projectRoot);

  // Limpieza segura: horarios pasados sin reservas activas. No elimina historial
  // que haya sido utilizado por pedidos.
  if (await tableExists(db, 'recojo_fechas')) {
    await db.query(`DELETE rf FROM recojo_fechas rf
      LEFT JOIN pedido_recojo_reservas prr ON prr.horario_id=rf.id
      WHERE rf.fecha < CURDATE() AND prr.id IS NULL`).catch(() => {});
  }

  return changes;
}

module.exports = { ensureSchema, tableExists, columnExists };
