'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.resolve(__dirname, '..');
const read = rel => fs.readFileSync(path.join(ROOT, rel), 'utf8');

test('login y enrutamiento del panel siguen presentes', () => {
  const app = read('app.js');
  assert.match(app, /\['\/', '\/login'\]/);
  assert.match(app, /public[\s\S]*views[\s\S]*login\.html/);
  assert.match(app, /if \(!req\.session\?\.usuario\)[\s\S]*redirect\('\/login'\)/);
  assert.match(read('routes/index.js'), /router\.post\('\/auth\/login'/);
  assert.ok(fs.existsSync(path.join(ROOT, 'public/views/login.html')));
});

test('productos e inventario no exigen columnas de transferencia para listar', () => {
  const producto = read('models/ProductoModel.js');
  const inventario = read('models/InventarioModel.js');
  for (const src of [producto, inventario]) {
    assert.match(src, /getTableColumns\(db, 'productos'\)/);
    assert.match(src, /0 AS es_transferido/);
    assert.match(src, /NULL AS producto_origen_id/);
    assert.match(src, /1 AS transferencia_venta_habilitada/);
  }
  assert.match(producto, /INSERT INTO productos \(\$\{names\.join\(','\)\}\)/);
});

test('aprobación web se adapta a clientes sin columnas cifradas', () => {
  const src = read('controllers/PedidoWebController.js');
  assert.match(src, /SHOW COLUMNS FROM clientes/);
  assert.match(src, /columns\.has\('direccion_enc'\)/);
  assert.match(src, /normalizeApprovedClient/);
  assert.match(src, /INSERT INTO ventas/);
  assert.match(src, /'web'/);
  assert.match(src, /numero_venta:num\.numero/);
});

test('reportes contienen comparación web y presencial detallada', () => {
  const model = read('models/ReporteModel.js');
  const front = read('public/assets/js/pages/reportes.js');
  for (const token of ['ventasPorDiaCanal','ventasMetodoPorCanal','ventasEntregaPorCanal','ventasDetalleCanal','pedidosWebResumen','pedidosWebDetalle']) {
    assert.match(model, new RegExp(token));
  }
  assert.match(front, /Comparación: página web vs atención presencial/);
  assert.match(front, /Trazabilidad completa de pedidos web/);
  assert.match(front, /Detalle completo de ventas web y presenciales/);
});

test('versión y caché pertenecen a V45 sin perder estabilidad', () => {
  const pkg = JSON.parse(read('package.json'));
  assert.equal(pkg.version, '46.0.0');
  assert.match(read('public/assets/js/core/app.js'), /\?v=46\.0\.0/);
  assert.match(read('public/index.html'), /stable-v46/);
});

test('modelos listan y crean con un esquema antiguo de productos', async () => {
  const dbPath = require.resolve('../config/database');
  const productPath = require.resolve('../models/ProductoModel');
  const inventoryPath = require.resolve('../models/InventarioModel');
  const schemaPath = require.resolve('../helpers/dbSchema');
  const originalDb = require(dbPath);
  const queries = [];
  const legacyColumns = [
    'id','nombre','descripcion','marca','precio_costo','precio_venta','porcentaje_oferta',
    'stock_actual','stock_minimo','garantia_meses','atributo_extra','sucursal_id','estado'
  ];
  const mockDb = {
    async query(sql, params = []) {
      queries.push({ sql: String(sql), params });
      if (/SHOW COLUMNS FROM `productos`/i.test(sql)) return [legacyColumns.map(Field => ({ Field }))];
      if (/INSERT INTO productos/i.test(sql)) return [{ insertId: 91, affectedRows: 1 }];
      return [[]];
    }
  };

  require.cache[dbPath].exports = { ...originalDb, getDB: () => mockDb };
  delete require.cache[productPath];
  delete require.cache[inventoryPath];
  delete require.cache[schemaPath];
  try {
    const ProductoModel = require(productPath);
    const InventarioModel = require(inventoryPath);
    await ProductoModel.getAll(null);
    await InventarioModel.getStock(null);
    const id = await ProductoModel.crear({
      nombre:'Bidón prueba', descripcion:'', marca:'', precio_costo:10, precio_venta:12,
      porcentaje_oferta:0, stock_actual:0, stock_minimo:0, garantia_meses:0,
      atributo_extra:null, sucursal_id:2
    }, 1);
    assert.equal(id, 91);

    const selects = queries.filter(q => /^\s*SELECT/i.test(q.sql));
    assert.equal(selects.length >= 2, true);
    for (const q of selects.slice(0, 2)) {
      assert.doesNotMatch(q.sql, /p\.sucursal_origen_id/);
      assert.doesNotMatch(q.sql, /p\.producto_origen_id/);
      assert.doesNotMatch(q.sql, /p\.es_transferido/);
      assert.doesNotMatch(q.sql, /p\.transferencia_venta_habilitada/);
    }
    const insert = queries.find(q => /INSERT INTO productos/i.test(q.sql));
    assert.ok(insert);
    assert.doesNotMatch(insert.sql, /es_transferido/);
    assert.doesNotMatch(insert.sql, /transferencia_venta_habilitada/);
  } finally {
    require.cache[dbPath].exports = originalDb;
    delete require.cache[productPath];
    delete require.cache[inventoryPath];
    delete require.cache[schemaPath];
  }
});
