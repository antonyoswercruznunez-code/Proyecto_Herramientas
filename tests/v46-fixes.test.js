const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
const read = p => fs.readFileSync(path.join(root,p),'utf8');

test('ventas y cotizaciones envían la sucursal seleccionada', () => {
  assert.match(read('public/assets/js/pages/ventas.js'), /sucursal_id:\s*nvSucursalVenta/);
  assert.match(read('public/assets/js/pages/cotizaciones.js'), /sucursal_id:\s*ctSucursalActiva/);
});

test('visor interno permite embeber PDFs del mismo origen', () => {
  const src = read('controllers/DocumentController.js');
  assert.match(src, /frame-ancestors 'self'/);
  assert.match(src, /X-Frame-Options', 'SAMEORIGIN/);
  assert.match(src, /Content-Disposition.*inline/);
});

test('delivery y recojo generan y muestran código por sucursal', () => {
  const ctrl = read('controllers/PedidoWebController.js');
  const front = read('public/assets/js/pages/pagos.js');
  assert.match(ctrl, /asegurarCodigosEntrega/);
  assert.match(ctrl, /Código de entrega y seguimiento/);
  assert.doesNotMatch(ctrl, /if \(p\.tipo_entrega==='recojo'\) \{/);
  assert.match(front, /Códigos y estado de entrega/);
});

test('comprobantes conserva la hora local exacta de emisión', () => {
  assert.match(read('controllers/VentaController.js'), /const emitidoAtPeru = peruNowSQL\(\)/);
  assert.match(read('controllers/ComprobanteController.js'), /DATE_FORMAT\(c\.emitido_at/);
  assert.match(read('public/assets/js/pages/comprobantes.js'), /fechaHoraExacta/);
});

test('admin global elige sucursal y las cajas cierran automáticamente', () => {
  const controller = read('controllers/CajaController.js');
  const front = read('public/assets/js/pages/apertura-caja.js');
  const app = read('app.js');
  assert.match(controller, /esGlobal\(u\) \? Number\(req\.query\.sucursal_id/);
  assert.match(controller, /Contraseña del administrador incorrecta/);
  assert.match(front, /apertura-sucursal-select/);
  assert.match(app, /cerrarCajasVencidas/);
  assert.match(read('services/CajaAutoCloseService.js'), /Cierre automático diario/);
});
