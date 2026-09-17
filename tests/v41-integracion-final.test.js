'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.resolve(__dirname, '..');
const read = rel => fs.readFileSync(path.join(ROOT, rel), 'utf8');
const exists = rel => fs.existsSync(path.join(ROOT, rel));

test('la entrega usa .env real y no incluye .env.example ni migraciones', () => {
  assert.equal(exists('.env'), true);
  assert.equal(exists('.env.example'), false);
  assert.equal(exists('database/migrations'), false);
  const env = read('.env');
  assert.match(env, /^SESSION_SECRET=.{64,}$/m);
  assert.match(env, /^APP_ENCRYPTION_KEY=.{64,}$/m);
});

test('el logo se administra solo en Configuración y Gestión Tienda no lo duplica', () => {
  const tienda = read('public/views/pages/tienda.html');
  const tiendaJs = read('public/assets/js/pages/tienda.js');
  const config = read('public/views/pages/config.html');
  assert.doesNotMatch(tienda, /id="td-logo/i);
  assert.doesNotMatch(tiendaJs, /uploadLogo|activarLogo|deleteLogo/);
  assert.match(config, /cfg-logo-file/);
  assert.match(tienda, /Gestión Tienda no crea ni duplica logos/);
});

test('Gestión Tienda administra sliders y datos visuales de todos los medios de pago', () => {
  const view = read('public/views/pages/tienda.html');
  const js = read('public/assets/js/pages/tienda.js');
  const routes = read('routes/index.js');
  const config = read('controllers/ConfigController.js');
  for (const token of ['td-slider', 'td-yape-numero', 'td-plin-numero', 'td-transferencia-banco', 'td-transferencia-cuenta', 'td-transferencia-cci', 'td-izipay-instrucciones']) {
    assert.match(view, new RegExp(token));
  }
  assert.match(js, /metodo-pago-imagen/);
  assert.match(routes, /\/config\/metodo-pago-imagen/);
  for (const key of ['yape_qr_ruta','plin_qr_ruta','transferencia_imagen_ruta','izipay_imagen_ruta']) assert.match(config, new RegExp(key));
});

test('el Ecommerce publica solo métodos activos y muestra sus datos configurados', () => {
  const controller = read('controllers/TiendaController.js');
  const store = read('public/tienda-app.js');
  assert.match(controller, /const metodos_pago = \[\]/);
  assert.match(controller, /yape_activo/);
  assert.match(controller, /plin_activo/);
  assert.match(controller, /transferencia_activo/);
  assert.match(controller, /izipay_activo/);
  assert.match(controller, /El método de pago seleccionado ya no está disponible/);
  assert.match(store, /paymentMethodsHTML/);
  assert.match(store, /paymentInfoHTML/);
  assert.match(store, /renderPaymentInfo/);
});

test('ventas y tienda aceptan códigos de operación variables sin forzar 3 u 8 dígitos', () => {
  const ventaBack = read('controllers/VentaController.js');
  const ventaFront = read('public/assets/js/pages/ventas.js');
  const tienda = read('controllers/TiendaController.js');
  assert.doesNotMatch(ventaFront, /Código \(3 díg\.\)|Código \(8 díg\.\)/);
  assert.match(ventaBack, /3,40/);
  assert.match(tienda, /3,100/);
});

test('productos no depende de campos retirados y bloquea precio costo mayor a venta', () => {
  const view = read('public/views/pages/productos.html');
  const front = read('public/assets/js/pages/productos.js');
  const back = read('controllers/ProductoController.js');
  for (const removed of ['prod-sku','prod-codigo-barras','prod-peso','prod-dimensiones','prod-categoria']) assert.doesNotMatch(view, new RegExp(`id="${removed}"`));
  for (const legacy of ['sku','codigo_barras','peso_kg','dimensiones','categoria_id']) {
    assert.doesNotMatch(front, new RegExp(legacy));
  }
  assert.match(front, /El precio costo no puede ser mayor al precio de venta/);
  assert.match(back, /El precio costo no puede ser mayor al precio de venta/);
  assert.match(back, /esAdministradorDeProductos/);
});

test('SQL consolidado incluye configuración visual de pagos y versión 45', () => {
  const sql = read('database/gas_sistema.sql');
  for (const key of ['yape_activo','yape_titular','plin_activo','plin_titular','transferencia_activo','transferencia_imagen_ruta','izipay_activo','izipay_imagen_ruta']) assert.match(sql, new RegExp(`'${key}'`));
  assert.match(sql, /schema_version','45/);
});

test('los recursos usan versión nueva para evitar JavaScript antiguo en caché', () => {
  const app = read('public/assets/js/core/app.js');
  assert.match(app, /\?v=46\.0\.0/);
  assert.doesNotMatch(app, /final-fix-1/);
});
