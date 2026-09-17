const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const root = path.resolve(__dirname, '..');
const read = p => fs.readFileSync(path.join(root,p),'utf8');

test('V47 permite el visor PDF del mismo origen y conserva cabeceras seguras', () => {
  const app = read('app.js');
  assert.match(app, /frameAncestors:\s*\["'self'"\]/);
  assert.doesNotMatch(app, /frameAncestors:\s*\["'none'"\]/);
});

test('V47 recojo usa el snapshot real disponible en la base consolidada', () => {
  const c = read('controllers/RecojoController.js');
  assert.match(c, /pw\.facturacion_snapshot/);
  assert.doesNotMatch(c, /pw\.datos_facturacion_snapshot/);
});

test('V47 ventas y cotizaciones globales derivan la sucursal desde los productos', () => {
  const venta = read('controllers/VentaController.js');
  const cot = read('controllers/CotizacionController.js');
  for (const src of [venta,cot]) {
    assert.match(src, /SELECT DISTINCT sucursal_id FROM productos/);
    assert.match(src, /sucursalesValidas\.length !== 1/);
    assert.match(src, /sucursal_id = sucursalesValidas\[0\]/);
  }
});

test('V47 perfiles muestra solo módulos visibles y oculta permisos por acción', () => {
  const html = read('public/views/pages/perfiles.html');
  const js = read('public/assets/js/pages/perfiles.js');
  assert.doesNotMatch(html, /Permisos por acción/i);
  assert.doesNotMatch(html, /Buscar permiso/i);
  assert.match(html, /Módulos visibles/i);
  assert.doesNotMatch(js, /guardarPermisosAccion|renderPermisosAccion/);
});

test('V47 protege cambios sensibles de usuarios con contraseña', () => {
  const ctrl = read('controllers/UsuarioController.js');
  const ui = read('public/assets/js/pages/usuarios.js');
  assert.match(ctrl, /current_password/);
  assert.match(ctrl, /admin_password/g);
  assert.match(ui, /current_password/);
  assert.match(ui, /admin_password/g);
});

test('V47 configura direcciones de sucursal enlazadas a la tienda', () => {
  const route = read('routes/index.js');
  const ctrl = read('controllers/SucursalController.js');
  const model = read('models/SucursalModel.js');
  const html = read('public/views/pages/config.html');
  assert.match(route, /put\('\/sucursales\/:id'/);
  assert.match(ctrl, /update:/);
  assert.match(model, /updateDatos/);
  assert.match(html, /Direcciones de las sucursales/);
});

test('V47 conserva sesión antes del checkout y amplía pagos sin destruir el modal', () => {
  const tienda = read('public/tienda-app.js');
  assert.match(tienda, /async irCheckout/);
  assert.match(tienda, /\/auth\/session/);
  assert.match(tienda, /payment-image-overlay/);
});

test('V47 rentabilidad incluye inversión, ROI y punto de equilibrio', () => {
  const ctrl = read('controllers/RentabilidadController.js');
  const ui = read('public/assets/js/pages/rentabilidad.js');
  assert.match(ctrl, /inversion_inventario/);
  assert.match(ctrl, /punto_equilibrio/);
  assert.match(ui, /ROI del periodo/);
  assert.match(ui, /Ingresos por medio de pago/);
});
