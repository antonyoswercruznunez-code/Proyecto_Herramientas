'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
process.env.APP_ENCRYPTION_KEY = 'test-key-only-for-automated-tests-1234567890-abcdef';
const Crypto = require('../services/CryptoService');

function read(rel) { return fs.readFileSync(path.join(ROOT, rel), 'utf8'); }

test('AES-GCM cifra y descifra sin guardar el texto plano', () => {
  const plain = 'K7P4-X9M2';
  const encrypted = Crypto.encrypt(plain);
  assert.notEqual(encrypted, plain);
  assert.match(encrypted, /^v1\./);
  assert.equal(Crypto.decrypt(encrypted), plain);
});

test('los códigos de recojo tienen formato fuerte y no se repiten en la muestra', () => {
  const codes = new Set();
  for (let i = 0; i < 500; i++) {
    const code = Crypto.randomPickupCode();
    assert.match(code, /^[A-HJ-NP-Z2-9]{4}-[A-HJ-NP-Z2-9]{4}$/);
    assert.equal(codes.has(code), false);
    codes.add(code);
  }
});

test('la aplicación no contiene credenciales conocidas de respaldo', () => {
  const source = [read('app.js'), read('config/database.js')].join('\n');
  assert.equal(source.includes('admin123'), false);
  assert.equal(source.includes('sv_secret_2024'), false);
  assert.match(source, /SESSION_SECRET debe tener al menos 32 caracteres/);
});

test('las rutas críticas exigen autenticación y permisos de backend', () => {
  const routes = read('routes/index.js');
  assert.match(routes, /\/pedidos-web\/:id\/aprobar[^\n]+auth[^\n]+requireAny/);
  assert.match(routes, /\/dashboard\/resumen[^\n]+auth[^\n]+dashboard\.ver/);
  assert.match(routes, /\/inventario-transferencias[^\n]+inventario\.transferir/);
  assert.match(routes, /\/ventas\/:id\/anular[^\n]+ventas\.anular/);
});

test('el SQL consolidado contiene snapshots, reservas, unicidad y alcance', () => {
  const sql = read('database/gas_sistema.sql');
  for (const fragment of [
    '`cliente_snapshot` longtext', 'reservas_web', 'pedido_entregas_sucursal',
    'pagos_operaciones_unicas', 'pedido_recojo_reservas',
    "'pedidos_web.aprobar_multisucursal'", "'dashboard.ver_global'", "'ANULACION'"
  ]) assert.ok(sql.includes(fragment), `Falta ${fragment}`);
});

test('los archivos privados no se publican mediante express.static', () => {
  const app = read('app.js');
  assert.match(app, /express\.static\(\s*path\.join\(__dirname, 'public'\)/);
  assert.equal(app.includes("express.static(path.join(__dirname, 'storage')"), false);
  assert.match(app, /'\/uploads\/vouchers'/);
});

test('el Ecommerce conserva una sola venta y origen por sucursal', () => {
  const controller = read('controllers/PedidoWebController.js');
  assert.match(controller, /INSERT INTO ventas/);
  assert.match(controller, /INSERT INTO venta_items[\s\S]{0,300}sucursal_id/);
  assert.match(controller, /SELECT \* FROM pedidos_web WHERE id=\? FOR UPDATE/);
  assert.match(controller, /El pedido ya fue procesado/);
});


test('la CSP permite los atributos de evento usados por los botones actuales', () => {
  const app = read('app.js');
  assert.match(app, /scriptSrcAttr:\s*\[\s*"'unsafe-inline'"\s*\]/);
  assert.match(app, /connectSrc:[\s\S]{0,220}https:\/\/cdn\.jsdelivr\.net/);
});
