const { getDB } = require('../config/database');

function isAdminSession(req) {
  const u = req.session?.usuario;
  const perfil = String(u?.perfil_nombre || '').trim().toLowerCase();
  return !!u && !!u.es_global;
}

async function hasPermission(req, slug) {
  if (!req.session?.usuario) return false;
  if (isAdminSession(req)) return true;

  const cache = req.session.permisosAccion || {};
  if (Object.prototype.hasOwnProperty.call(cache, slug)) return !!cache[slug];

  const db = getDB();
  const [[row]] = await db.query(`
    SELECT 1 AS permitido
    FROM perfil_permisos_accion ppa
    JOIN permisos_accion pa ON pa.id = ppa.permiso_id
    WHERE ppa.perfil_id = ? AND pa.slug = ?
    LIMIT 1
  `, [req.session.usuario.perfil_id, slug]);

  cache[slug] = !!row;
  req.session.permisosAccion = cache;
  return !!row;
}

function requirePermission(slug) {
  return async (req, res, next) => {
    try {
      if (!(await hasPermission(req, slug))) {
        return res.status(403).json({ ok: false, msg: 'No tienes permiso para realizar esta acción' });
      }
      req.permission = slug;
      next();
    } catch (error) {
      next(error);
    }
  };
}

function requireAny(...slugs) {
  return async (req, res, next) => {
    try {
      for (const slug of slugs) {
        if (await hasPermission(req, slug)) {
          req.permission = slug;
          return next();
        }
      }
      return res.status(403).json({ ok: false, msg: 'No tienes permiso para realizar esta acción' });
    } catch (error) {
      next(error);
    }
  };
}

function userScope(req) {
  const u = req.session?.usuario || {};
  return {
    isGlobal: !!u.es_global,
    sucursalId: u.es_global ? null : (Number(u.sucursal_id) || null),
    userId: Number(u.id) || null
  };
}

async function hasGlobalScope(req, slug) {
  const scope = userScope(req);
  return !!scope.isGlobal && (!slug || await hasPermission(req, slug));
}

module.exports = { hasPermission, requirePermission, requireAny, userScope, isAdminSession, hasGlobalScope };
