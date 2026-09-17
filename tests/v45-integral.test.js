'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const ROOT = path.resolve(__dirname, '..');
const read = rel => fs.readFileSync(path.join(ROOT, rel), 'utf8');
const exists = rel => fs.existsSync(path.join(ROOT, rel));

test('la aprobación web siempre nace como nota de venta y usa snapshots del comprador', () => {
  const c = read('controllers/PedidoWebController.js');
  assert.match(c, /VALUES \(\?,\?,'nota_venta'/);
  assert.match(c, /normalizeApprovedClient\(p\.cliente_snapshot,addressSnapshot,billingSnapshot,p\)/);
  assert.match(c, /client\.direccion_api[\s\S]{0,180}address\.direccion/);
  assert.match(c, /direccion_snapshot/);
  assert.match(c, /facturacion_snapshot/);
  assert.match(c, /clienteWeb|clientes_web/);
  assert.doesNotMatch(c, /solicitar_factura[^\n]{0,200}tipo_comprobante/);
});

test('nota de venta y cotización tienen visor PDF y usan el mismo documento al imprimir', () => {
  const ventas = read('public/assets/js/pages/ventas.js');
  const cot = read('public/assets/js/pages/cotizaciones.js');
  assert.match(ventas, /_vVerDocumento/);
  assert.match(ventas, /\/ventas\/\$\{id\}\/pdf\?formato=a4/);
  assert.match(ventas, /Nota de venta → utilizar el mismo PDF corporativo/);
  assert.match(cot, /_ctVerDocumento/);
  assert.match(cot, /\/cotizaciones\/\$\{id\}\/pdf\?formato=a4/);
});

test('todos los archivos públicos nuevos usan uploads y media no existe', () => {
  assert.equal(exists('public/media'), false);
  for (const dir of ['public/uploads/logos','public/uploads/sliders','public/uploads/qr','public/uploads/pagos','public/uploads/productos']) {
    assert.equal(exists(dir), true, `Falta ${dir}`);
  }
  const upload = read('middleware/upload.js');
  assert.match(upload, /\.\.\/public\/uploads/);
  assert.match(upload, /image\/jpeg|image\/png|image\/webp/);
});

test('login bloquea exactamente al tercer fallo y escala 15, 25 y siguientes', () => {
  const auth = read('controllers/AuthController.js');
  const env = read('.env');
  assert.match(auth, /const MAX_FAILS = 3/);
  assert.match(auth, /LOCK_MINUTES \+ Number\(cycles\?\.n \|\| 0\) \* 10/);
  assert.match(auth, /Math\.min\(120/);
  assert.match(env, /^LOGIN_MAX_ATTEMPTS=3$/m);
  assert.match(env, /^LOGIN_LOCK_MINUTES=15$/m);
});

test('recuperación de contraseña es modal y adaptable', () => {
  const login = read('public/views/login.html');
  assert.match(login, /id="recover-modal"/);
  assert.match(login, /recover-form/);
  assert.match(login, /recover-code/);
  assert.match(login, /max-height:[^;]*vh|overflow-y:auto/);
});

test('la tienda conserva sesión web y usa colores Mundo Pet', () => {
  const auth = read('controllers/TiendaAuthController.js');
  const app = read('public/tienda-app.js');
  const html = read('public/tienda.html');
  assert.match(auth, /req\.session\.clienteWeb/);
  assert.match(auth, /web_login_at/);
  assert.match(app, /auth\/session/);
  assert.match(app, /credentials:'include'/);
  assert.match(html, /--brand:#18a94b/);
  assert.doesNotMatch(html, /--brand:#e8552d/);
});

test('checkout exige correo del comprador, solo acepta imagen y permite ampliar el pago', () => {
  const app = read('public/tienda-app.js');
  const html = read('public/tienda.html');
  assert.match(app, /correo obligatorio del comprador/);
  assert.match(app, /accept="image\/jpeg,image\/png,image\/webp"/);
  assert.match(app, /verImagenPago/);
  assert.match(html, /\.mp-file-picker/);
});

test('Caja Web está desarrollada y el historial entrega desglose completo', () => {
  const back = read('controllers/CajaController.js');
  const model = read('models/CajaModel.js');
  const front = read('public/assets/js/pages/cajas.js');
  assert.match(back, /web:\s*wrap/);
  assert.match(model, /web|ecommerce/i);
  assert.match(front, /Caja Web/i);
  assert.doesNotMatch(front, /Próximamente/);
  assert.match(model, /efectivo|yape|plin|izipay|transferencia/i);
});

test('inventario limita transferencias al stock y controla venta del transferido', () => {
  const front = read('public/assets/js/pages/inventario.js');
  const back = read('controllers/InventarioController.js');
  assert.match(front, /cantidad[^\n]{0,300}stock|max=/i);
  assert.match(back, /Stock insuficiente|cantidad.*stock/i);
  assert.match(front, /transferencia_venta_habilitada|habilitar/i);
});

test('logística crea evidencia faltante y diferencia filtros de fechas de creación', () => {
  const schema = read('services/SchemaCompatibilityService.js');
  const c = read('controllers/LogisticaController.js');
  const r = read('controllers/RecojoController.js');
  assert.match(schema, /CREATE TABLE IF NOT EXISTS reparto_evidencias/);
  assert.match(c, /licencia no puede registrarse vencida|SOAT no puede registrarse vencido/);
  assert.match(r, /fecha < today|fecha.*pasad/i);
  assert.match(r, /fecha.*futuro|hasta.*today|CURDATE/i);
});

test('reportes consulta hasta 1000 registros y separa web de presencial', () => {
  const model = read('models/ReporteModel.js');
  const front = read('public/assets/js/pages/reportes.js');
  assert.match(model, /LIMIT 1000/);
  assert.match(front, /página web vs atención presencial/i);
  assert.match(front, /pedidos web|Trazabilidad/i);
  assert.match(front, /Ventas|Productos|Clientes|Finanzas|Cotizaciones|Inventario|Comprobantes|Logística/);
});

test('Rentabilidad existe con costos históricos, margen y alertas', () => {
  const routes = read('routes/index.js');
  const c = read('controllers/RentabilidadController.js');
  const f = read('public/assets/js/pages/rentabilidad.js');
  assert.match(routes, /rentabilidad\/resumen/);
  assert.match(c, /costo_unitario/);
  assert.match(c, /margen|rentabilidad/i);
  assert.match(c, /alert/i);
  assert.match(f, /Ganancia|Pérdida|Margen|Rentabilidad/i);
});

test('temporadas admite porcentaje o soles y evita duplicar productos', () => {
  const c = read('controllers/TemporadaController.js');
  const m = read('models/TemporadaModel.js');
  const sql = read('database/gas_sistema.sql');
  assert.match(c, /tipo_descuento==='monto'/);
  assert.match(c, /duplicate/);
  assert.match(c, /temporada vigente no se puede eliminar/i);
  assert.match(m, /tipo_descuento/);
  assert.match(sql, /uq_temporada_producto/);
});

test('usuarios permiten números y el administrador global solo se edita a sí mismo', () => {
  const c = read('controllers/UsuarioController.js');
  const f = read('public/assets/js/pages/usuarios.js');
  assert.match(c, /0-9/);
  assert.match(c, /GLOBAL_ADMIN_ID|PRINCIPAL|id === 1|Number\(id\) === 1/);
  assert.match(f, /0-9/);
  assert.match(c, /Administrador[^\n]{0,180}eliminar|administrador[^\n]{0,180}elimin/i);
});

test('perfiles permiten configurar administradores sin quitar el bypass global', () => {
  const c = read('controllers/PerfilController.js');
  const p = read('middleware/permisos.js');
  const f = read('public/assets/js/pages/perfiles.js');
  assert.match(c, /reactiv|estado.*2/i);
  assert.match(f, /Permisos/);
  assert.match(p, /es_global/);
});

test('la base consolidada queda en V45 y contiene compatibilidad requerida', () => {
  const sql = read('database/gas_sistema.sql');
  assert.match(sql, /schema_version','45/);
  assert.match(sql, /`direccion_enc`/);
  assert.match(sql, /`es_transferido`/);
  assert.match(sql, /`tipo_descuento` enum\('porcentaje','monto'\)/);
  assert.match(sql, /CREATE TABLE IF NOT EXISTS `reparto_evidencias`/);
  assert.match(sql, /'rentabilidad'/);
});
