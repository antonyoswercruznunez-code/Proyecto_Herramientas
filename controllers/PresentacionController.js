const { getDB } = require('../config/database');
const { wrap }  = require('../helpers/response');
const { hasPermission, userScope, hasGlobalScope } = require('../middleware/permisos');

const PresentacionController = {

  list: wrap(async (req, res) => {
    const db = getDB();
    const scope=userScope(req);
    const global=await hasGlobalScope(req,'dashboard.ver_global');
    const canCost=await hasPermission(req,'productos.ver_costo');
    const [presentaciones] = await db.query(
      `SELECT pr.* FROM presentaciones pr JOIN productos p ON p.id=pr.producto_id
       WHERE pr.estado != 2 ${!global?'AND p.sucursal_id=?':''} ORDER BY pr.es_principal DESC`,
      !global?[scope.sucursalId]:[]
    );
    if(!canCost) presentaciones.forEach(x=>delete x.precio_costo);
    res.json({ ok: true, presentaciones });
  }),

  create: wrap(async (req, res) => {
    const db = getDB();
    const { producto_id, nombre, precio_costo = 0,
            precio_venta, es_principal = 0, stock = 0 } = req.body;

    if (!producto_id || !String(nombre).trim() || !Number.isFinite(Number(precio_venta)) || Number(precio_venta)<=0)
      return res.status(400).json({ ok: false, msg: 'Datos incompletos o inválidos' });
    const [[prod]]=await db.query('SELECT sucursal_id FROM productos WHERE id=? AND estado<>2',[Number(producto_id)]);
    const scope=userScope(req); const global=await hasGlobalScope(req,'dashboard.ver_global');
    if(!prod || (!global && Number(prod.sucursal_id)!==Number(scope.sucursalId))) return res.status(403).json({ok:false,msg:'Producto fuera de tu alcance'});

    if (es_principal) {
      await db.query(
        'UPDATE presentaciones SET es_principal = 0 WHERE producto_id = ?',
        [producto_id]
      );
    }

    const [r] = await db.query(`
      INSERT INTO presentaciones
        (producto_id, nombre, precio_costo, precio_venta, es_principal, stock, estado)
      VALUES (?,?,?,?,?,?,0)
    `, [producto_id, nombre, precio_costo, precio_venta,
        es_principal ? 1 : 0, +stock]);

    res.json({ ok: true, msg: 'Presentación creada', id: r.insertId });
  }),

  update: wrap(async (req, res) => {
    const db = getDB();
    const id = +req.params.id;
    const { nombre, precio_costo = 0, precio_venta,
            es_principal = 0, producto_id: requestedProductId, stock = 0 } = req.body;

    if (!String(nombre||'').trim() || !Number.isFinite(Number(precio_venta)) || Number(precio_venta)<=0)
      return res.status(400).json({ ok: false, msg: 'Datos incompletos o inválidos' });
    const [[current]]=await db.query('SELECT pr.producto_id,p.sucursal_id FROM presentaciones pr JOIN productos p ON p.id=pr.producto_id WHERE pr.id=?',[id]);
    const scope=userScope(req); const global=await hasGlobalScope(req,'dashboard.ver_global');
    if(!current || (!global && Number(current.sucursal_id)!==Number(scope.sucursalId))) return res.status(403).json({ok:false,msg:'Presentación fuera de tu alcance'});

    if (es_principal) {
      const producto_id=current.producto_id;
      await db.query(
        'UPDATE presentaciones SET es_principal = 0 WHERE producto_id = ?',
        [producto_id]
      );
    }

    await db.query(`
      UPDATE presentaciones SET
        nombre=?, precio_costo=?, precio_venta=?,
        es_principal=?, stock=?
      WHERE id=?
    `, [nombre, precio_costo, precio_venta,
        es_principal ? 1 : 0, +stock, id]);

    res.json({ ok: true, msg: 'Presentación actualizada' });
  }),

  remove: wrap(async (req, res) => {
    const db = getDB(); const id=Number(req.params.id);
    const [[current]]=await db.query('SELECT p.sucursal_id FROM presentaciones pr JOIN productos p ON p.id=pr.producto_id WHERE pr.id=?',[id]);
    const scope=userScope(req); const global=await hasGlobalScope(req,'dashboard.ver_global');
    if(!current || (!global && Number(current.sucursal_id)!==Number(scope.sucursalId))) return res.status(403).json({ok:false,msg:'Presentación fuera de tu alcance'});
    await db.query(
      'UPDATE presentaciones SET estado = 2 WHERE id = ?',
      [id]
    );
    res.json({ ok: true, msg: 'Presentación eliminada' });
  })
};

module.exports = PresentacionController;