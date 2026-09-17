'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const ROOT = path.resolve(__dirname, '..');
const read = rel => fs.readFileSync(path.join(ROOT, rel), 'utf8');

const appFilesWithoutLegacyProductFields = [
  'controllers/ProductoController.js', 'models/ProductoModel.js',
  'public/assets/js/pages/productos.js', 'public/views/pages/productos.html',
  'controllers/VentaController.js', 'models/VentaModel.js',
  'controllers/CotizacionController.js', 'models/CotizacionModel.js',
  'controllers/ReporteController.js', 'models/ReporteModel.js'
];

test('ventas usa referencia flexible, sucursal correcta y oculta acciones anuladas', () => {
  const back = read('controllers/VentaController.js');
  const front = read('public/assets/js/pages/ventas.js');
  assert.match(back, /\{3,40\}/);
  assert.match(front, /POS Izipay/);
  assert.match(back, /prod\.sucursal_id != null/);
  assert.match(front, /const anulada = v\.estado_venta === 'anulada'/);
  assert.match(front, /Una venta anulada queda sin acciones/);
  assert.match(back, /InternalDocumentService/);
  assert.match(back, /#159447|#168b45|#148a43/i);
});

test('cotizaciones vigentes se editan y las vencidas solo se eliminan', () => {
  const routes = read('routes/index.js');
  const back = read('controllers/CotizacionController.js');
  const front = read('public/assets/js/pages/cotizaciones.js');
  assert.match(routes, /router\.put\('\/cotizaciones\/:id'/);
  assert.match(back, /Solo un administrador puede editar cotizaciones/);
  assert.match(back, /cotización vencida|Cotización vencida/i);
  assert.match(front, /Una cotización vencida solo puede eliminarse/);
  assert.match(front, /manual: true/);
  assert.match(front, /max = hoy|max', hoy|\.max = hoy/);
});

test('pagos web muestra detalle completo y aprobación deja trazabilidad web', () => {
  const front = read('public/assets/js/pages/pagos.js');
  const back = read('controllers/PedidoWebController.js');
  for (const token of ['Comprador identificado','Departamento','Provincia','Distrito','Motivo del rechazo','Stock actual']) {
    assert.match(front, new RegExp(token));
  }
  assert.match(front, /event\.target === modal/);
  assert.match(back, /Canal: ecommerce/);
  assert.match(back, /manualNotes\.length/);
  assert.match(back, /FOR UPDATE/);
});

test('comprobantes filtra por la fecha real de emisión y bloquea futuro', () => {
  const back = read('controllers/ComprobanteController.js');
  const front = read('public/assets/js/pages/comprobantes.js');
  assert.match(back, /DATE\(c\.emitido_at\)/);
  assert.match(back, /no puede ser futura/);
  assert.match(front, /America\/Lima/);
  assert.match(front, /\.max = hoy/);
});

test('producto activo no usa campos retirados y protege precios', () => {
  for (const rel of appFilesWithoutLegacyProductFields) {
    const src = read(rel);
    for (const legacy of ['sku','codigo_barras','peso_kg','dimensiones','categoria_id']) {
      assert.doesNotMatch(src, new RegExp(`\\b${legacy}\\b`, 'i'), `${rel} todavía usa ${legacy}`);
    }
  }
  const back = read('controllers/ProductoController.js');
  const model = read('models/ProductoModel.js');
  assert.match(back, /Solo un administrador puede/);
  assert.match(back, /precio costo no puede ser mayor/i);
  assert.match(model, /'perdida'/);
  assert.match(model, /'sin_margen'/);
});

test('transferencias son globales, trazables y controlan la venta destino', () => {
  const back = read('controllers/InventarioController.js');
  const model = read('models/ProductoModel.js');
  const routes = read('routes/index.js');
  assert.match(back, /Solo el administrador global/);
  assert.match(back, /es_transferido/);
  assert.match(back, /producto_origen_id/);
  assert.match(routes, /venta-transferida/);
  assert.match(model, /transferencia_venta_habilitada/);
});

test('clientes cifra ubicación recuperable para la tienda', () => {
  const model = read('models/ClienteModel.js');
  const store = read('controllers/TiendaController.js');
  const sql = read('database/gas_sistema.sql');
  assert.match(model, /CryptoService/);
  for (const field of ['direccion_enc','distrito_enc','provincia_enc','departamento_enc']) {
    assert.match(model, new RegExp(field));
    assert.match(sql, new RegExp('`' + field + '`'));
  }
  assert.match(store, /ClienteModel\.getByDoc/);
});

test('logística protege evidencias, exige foto y mantiene historial', () => {
  const routes = read('routes/index.js');
  const controller = read('controllers/LogisticaController.js');
  const model = read('models/LogisticaModel.js');
  const sql = read('database/gas_sistema.sql');
  assert.match(routes, /logistica\/rutas\/:id\/pedidos\/:detalleId\/evidencias/);
  assert.match(controller, /storage\/private\/reparto/);
  assert.match(model, /Agrega al menos una fotografía/);
  assert.match(model, /máximo cinco fotografías/);
  assert.match(model, /sha256/);
  assert.match(sql, /CREATE TABLE IF NOT EXISTS `reparto_historial`/);
});

test('reportes incluye inventario, kardex y comprobantes', () => {
  const routes = read('routes/index.js');
  const model = read('models/ReporteModel.js');
  const view = read('public/views/pages/reportes.html');
  assert.match(routes, /\/reportes\/inventario/);
  assert.match(routes, /\/reportes\/comprobantes/);
  assert.match(model, /inventarioResumen/);
  assert.match(model, /comprobantesResumen/);
  assert.match(view, /data-tab="inventario"/);
  assert.match(view, /data-tab="comprobantes"/);
});

test('recuperación y Google Login tienen controles de seguridad completos', () => {
  const auth = read('controllers/AuthController.js');
  const google = read('controllers/TiendaAuthController.js');
  for (const token of ['crypto.randomInt','token_hash','expires_at','used_at','intentos','FOR UPDATE']) assert.match(auth, new RegExp(token));
  assert.match(google, /accounts\.google\.com/);
  assert.match(google, /data\.aud/);
  assert.match(google, /email_verified/);
  assert.match(google, /data\.exp/);
});

test('base consolidada conserva requisitos V42 y avanza a versión 45 y categorías deshabilitadas', () => {
  const sql = read('database/gas_sistema.sql');
  const pkg = JSON.parse(read('package.json'));
  assert.equal(pkg.version, '46.0.0');
  assert.match(sql, /schema_version','45/);
  assert.match(sql, /WHERE `slug`='categorias'/);
  assert.match(read('public/assets/js/core/app.js'), /\?v=46\.0\.0/);
});
