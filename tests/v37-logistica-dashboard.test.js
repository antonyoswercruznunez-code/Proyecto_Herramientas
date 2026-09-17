const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('fs');
const path = require('path');
const root = path.join(__dirname,'..');
const read = p => fs.readFileSync(path.join(root,p),'utf8');

test('la versión final incluye módulo completo de logística y SQL consolidado',()=>{
  const routes=read('routes/index.js');
  const migration=read('database/gas_sistema.sql');
  const frontend=read('public/assets/js/core/app.js');
  for(const token of ['/logistica/rutas','/logistica/repartidores','/logistica/vehiculos','/logistica/candidatos']) assert.match(routes,new RegExp(token.replaceAll('/','\\/')));
  for(const table of ['repartidores','vehiculos','rutas_reparto','ruta_reparto_pedidos']) assert.match(migration,new RegExp('CREATE TABLE IF NOT EXISTS `'+table+'`'));
  assert.match(migration,/logistica\.operar/);
  assert.match(frontend,/Logística y Reparto/);
});

test('el visor de comprobantes permite PDF de MiAPI sin cambiar la emisión SUNAT',()=>{
  const app=read('app.js');
  assert.match(app,/frameSrc:[\s\S]*https:\/\/miapi\.cloud/);
  assert.ok(fs.existsSync(path.join(root,'services','SunatService.js')));
  assert.ok(fs.existsSync(path.join(root,'controllers','ComprobanteController.js')));
});

test('dashboard usa consultas parciales para no dejar el panel completamente en blanco',()=>{
  const dashboard=read('controllers/DashboardController.js');
  assert.match(dashboard,/async function safe/);
  assert.match(dashboard,/\[DASHBOARD PARCIAL\]/);
  assert.match(dashboard,/res\.json\(\{ok:true/);
});

test('reportes incluye distribución y exportación de rutas',()=>{
  assert.match(read('public/views/pages/reportes.html'),/data-tab="logistica"/);
  assert.match(read('public/assets/js/pages/reportes.js'),/renderLogistica/);
  assert.match(read('routes/index.js'),/\/reportes\/logistica/);
});

test('logística limita rutas y maestros a la sucursal del usuario',()=>{
  const controller=read('controllers/LogisticaController.js');
  const model=read('models/LogisticaModel.js');
  assert.match(controller,/ensureRouteScope/);
  assert.match(controller,/No tienes acceso a esta ruta/);
  assert.match(controller,/sucursal_id: scope\.sucursalId/);
  assert.match(model,/El repartidor pertenece a otra sucursal/);
  assert.match(model,/El camión pertenece a otra sucursal/);
  assert.match(model,/No se puede planificar una ruta en una fecha pasada/);
});

test('la asignación logística recalcula unidades y mantiene la operación sin peso de producto',()=>{
  const model=read('models/LogisticaModel.js');
  assert.match(model,/SUM\(pi\.cantidad\)/);
  assert.match(model,/SUM\(vi\.cantidad\)/);
  assert.doesNotMatch(model,/pp\.peso_kg/);
  assert.match(model,/v\.pedido_web_id IS NULL/);
  assert.match(model,/Los pedidos seleccionados ya fueron asignados/);
  assert.match(model,/UPDATE pedidos_web pw JOIN ruta_reparto_pedidos/);
  assert.match(model,/Ruta cancelada/);
});
