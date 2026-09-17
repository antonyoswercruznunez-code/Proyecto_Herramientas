'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const read = rel => fs.readFileSync(path.join(ROOT, rel), 'utf8');
const MailService = require('../services/MailService');

test('normaliza una contraseña de aplicación de Gmail copiada con guiones', () => {
  assert.equal(
    MailService.normalizeMailPassword('smtp.gmail.com', 'abcd-efgh-ijkl-mnop'),
    'abcdefghijklmnop'
  );
});

test('Google Login permite comunicación con su popup', () => {
  const app = read('app.js');
  assert.match(app, /crossOriginOpenerPolicy:[\s\S]{0,100}same-origin-allow-popups/);
  assert.match(app, /crossOriginEmbedderPolicy:\s*false/);
});

test('el descuento directo del producto tiene prioridad sobre su temporada', () => {
  const store = read('controllers/TiendaController.js');
  assert.match(store, /directProductDiscount > 0[\s\S]{0,180}else price=Math\.max\(0,price-Number\(rules\?\.descuento_monto/);
  assert.match(store, /tipo_descuento='monto'[\s\S]{0,500}tdp\.producto_id=\$\{alias\}\.id/);
  assert.doesNotMatch(store, /categorySeasonDiscount|tdc\.categoria_id/);
});

test('temporadas rechaza nuevas fechas pasadas y valida el porcentaje', () => {
  const controller = read('controllers/TemporadaController.js');
  assert.match(controller, /La fecha de inicio no puede estar en el pasado/);
  assert.match(controller, /La fecha final no puede estar en el pasado/);
  assert.match(controller, /tipo_descuento==='porcentaje' && valor>100/);
  assert.match(controller, /tipo_descuento==='monto' && valor>=Number\(product\.precio_venta/);
});
