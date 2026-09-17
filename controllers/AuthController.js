const bcrypt = require('bcrypt');
const crypto = require('crypto');
const { getDB } = require('../config/database');
const { wrap } = require('../helpers/response');
const { ensureCsrf } = require('../middleware/security');
const Audit = require('../services/AuditService');
const Mail = require('../services/MailService');
const Crypto = require('../services/CryptoService');

const MAX_FAILS = 3;
const LOCK_MINUTES = Math.max(5, Number(process.env.LOGIN_LOCK_MINUTES || 15));
const RESET_MINUTES = Math.max(5, Number(process.env.PASSWORD_RESET_MINUTES || 10));

function validPassword(value) {
  const p = String(value || '');
  return p.length >= 8 && p.length <= 72 && /[A-Za-z]/.test(p) && /\d/.test(p);
}

function genericLoginError(res) {
  return res.status(401).json({ ok: false, msg: 'Usuario o contraseña incorrectos' });
}

async function loadOptions(db, perfilId) {
  const [opciones] = await db.query(`
    SELECT o.slug, o.nombre, o.icono, o.orden
    FROM perfil_opciones po
    JOIN opciones o ON o.id = po.opcion_id
    WHERE po.perfil_id = ? AND o.estado = 0
    ORDER BY o.orden ASC
  `, [perfilId]);
  return opciones;
}

async function loadActionPermissions(db, perfilId, isGlobal, perfilNombre) {
  if (isGlobal) {
    const [rows] = await db.query('SELECT slug FROM permisos_accion');
    return rows.map(r => r.slug);
  }
  const [rows] = await db.query(`
    SELECT pa.slug
    FROM perfil_permisos_accion ppa
    JOIN permisos_accion pa ON pa.id = ppa.permiso_id
    WHERE ppa.perfil_id = ?
  `, [perfilId]);
  return rows.map(r => r.slug);
}

async function regenerateSession(req) {
  return new Promise((resolve, reject) => req.session.regenerate(err => err ? reject(err) : resolve()));
}

const AuthController = {
  login: wrap(async (req, res) => {
    const username = String(req.body?.username || '').trim().slice(0, 150);
    const password = String(req.body?.password || '');
    if (!username || !password) return res.status(400).json({ ok: false, msg: 'Usuario y contraseña requeridos' });

    const db = getDB();
    const [[usuario]] = await db.query(`
      SELECT u.*, p.nombre AS perfil_nombre
      FROM usuarios u
      JOIN perfiles p ON p.id = u.perfil_id
      WHERE (LOWER(u.username) = LOWER(?) OR LOWER(u.email) = LOWER(?))
        AND u.estado != 2
      LIMIT 1
    `, [username, username]);

    const isLocked = usuario?.locked_until && new Date(usuario.locked_until).getTime() > Date.now();
    if (!usuario || Number(usuario.estado) !== 0) {
      await db.query(`INSERT INTO login_intentos (usuario_id, identificador, ip, user_agent, exitoso, motivo)
                      VALUES (?,?,?,?,0,'credenciales')`, [usuario?.id || null, username, Audit.clientIp(req), String(req.get('user-agent') || '').slice(0, 500)]);
      await Audit.log(req, { accion: 'login_fallido', modulo: 'auth', descripcion: 'Intento de inicio de sesión fallido' });
      return genericLoginError(res);
    }
    if (isLocked) {
      const seconds = Math.max(1, Math.ceil((new Date(usuario.locked_until).getTime() - Date.now()) / 1000));
      await db.query(`INSERT INTO login_intentos (usuario_id, identificador, ip, user_agent, exitoso, motivo)
                      VALUES (?,?,?,?,0,'bloqueado')`, [usuario.id, username, Audit.clientIp(req), String(req.get('user-agent') || '').slice(0, 500)]);
      res.setHeader('Retry-After', String(seconds));
      return res.status(423).json({
        ok: false,
        code: 'ACCOUNT_LOCKED',
        retry_after: seconds,
        msg: `Usuario bloqueado temporalmente. Intenta nuevamente en ${Math.ceil(seconds / 60)} minuto(s).`
      });
    }

    const passwordOk = await bcrypt.compare(password, usuario.password_hash);
    if (!passwordOk) {
      const fails = Number(usuario.login_fail_count || 0) + 1;
      const lock = fails >= MAX_FAILS;
      let lockMinutes = 0;

      if (lock) {
        const [[cycles]] = await db.query(`
          SELECT COUNT(*) AS n
          FROM login_intentos
          WHERE usuario_id = ?
            AND motivo = 'bloqueado_por_intentos'
            AND created_at >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
        `, [usuario.id]);
        // Primer bloqueo: 15 min. Segundo ciclo: 25 min. Luego aumenta 10 min,
        // con un máximo de 120 minutos para evitar bloqueos indefinidos.
        lockMinutes = Math.min(120, LOCK_MINUTES + Number(cycles?.n || 0) * 10);
      }

      await db.query(`
        UPDATE usuarios
        SET login_fail_count = ?, locked_until = ${lock ? 'DATE_ADD(NOW(), INTERVAL ? MINUTE)' : 'NULL'}
        WHERE id = ?
      `, lock ? [0, lockMinutes, usuario.id] : [fails, usuario.id]);
      await db.query(`INSERT INTO login_intentos (usuario_id, identificador, ip, user_agent, exitoso, motivo)
                      VALUES (?,?,?,?,0,?)`, [usuario.id, username, Audit.clientIp(req), String(req.get('user-agent') || '').slice(0, 500), lock ? 'bloqueado_por_intentos' : 'password']);

      if (lock) {
        res.setHeader('Retry-After', String(lockMinutes * 60));
        return res.status(423).json({
          ok: false,
          code: 'ACCOUNT_LOCKED',
          retry_after: lockMinutes * 60,
          msg: `Se alcanzaron ${MAX_FAILS} intentos incorrectos. El usuario quedó bloqueado por ${lockMinutes} minutos.`
        });
      }

      return res.status(401).json({
        ok: false,
        code: 'INVALID_PASSWORD',
        remaining_attempts: Math.max(0, MAX_FAILS - fails),
        msg: `Usuario o contraseña incorrectos. Quedan ${Math.max(0, MAX_FAILS - fails)} intento(s) antes del bloqueo.`
      });
    }

    const [opciones, permisos] = await Promise.all([
      loadOptions(db, usuario.perfil_id),
      loadActionPermissions(db, usuario.perfil_id, usuario.es_global, usuario.perfil_nombre)
    ]);

    const webSession = {
      clienteWeb: req.session?.clienteWeb || null,
      web_login_at: req.session?.web_login_at || null,
      documentoWeb: req.session?.documentoWeb || null
    };
    await regenerateSession(req);
    if (webSession.clienteWeb) {
      req.session.clienteWeb = webSession.clienteWeb;
      req.session.web_login_at = webSession.web_login_at;
      req.session.documentoWeb = webSession.documentoWeb;
    }
    const sesion = {
      id: usuario.id,
      nombre: usuario.nombre,
      username: usuario.username,
      email: usuario.email,
      perfil_id: usuario.perfil_id,
      perfil_nombre: usuario.perfil_nombre,
      sucursal_id: usuario.sucursal_id,
      es_global: Number(usuario.es_global) === 1,
      session_version: Number(usuario.session_version || 1)
    };
    req.session.usuario = sesion;
    req.session.opciones = opciones;
    req.session.permisos = permisos;
    req.session.login_at = Date.now();
    req.session.last_user_activity_at = Date.now();
    req.session.locked = false;
    const csrfToken = ensureCsrf(req);

    await db.query('UPDATE usuarios SET login_fail_count = 0, locked_until = NULL, last_login_at = NOW() WHERE id = ?', [usuario.id]);
    await db.query(`INSERT INTO login_intentos (usuario_id, identificador, ip, user_agent, exitoso, motivo)
                    VALUES (?,?,?,?,1,'ok')`, [usuario.id, username, Audit.clientIp(req), String(req.get('user-agent') || '').slice(0, 500)]);
    await Audit.log(req, { accion: 'login_exitoso', modulo: 'auth', entidad: 'usuario', entidad_id: usuario.id });

    res.json({ ok: true, usuario: sesion, opciones, permisos, csrfToken });
  }),

  logout(req, res) {
    Audit.log(req, { accion: 'logout', modulo: 'auth' });
    const keepWebSession = !!req.session?.clienteWeb;
    for (const key of [
      'usuario','opciones','permisos','login_at','last_user_activity_at',
      'locked','locked_at','user_checked_at','csrfToken'
    ]) delete req.session[key];

    if (keepWebSession) {
      return req.session.save(() => res.json({ ok: true }));
    }

    req.session.destroy(() => {
      res.clearCookie(process.env.SESSION_COOKIE_NAME || 'sv.sid');
      res.json({ ok: true });
    });
  },

  session(req, res) {
    res.json({
      ok: true,
      usuario: req.session.usuario,
      opciones: req.session.opciones || [],
      permisos: req.session.permisos || [],
      csrfToken: ensureCsrf(req),
      locked: !!req.session.locked,
      lockMinutes: Number(process.env.SESSION_LOCK_MINUTES || 20)
    });
  },

  forgot: wrap(async (req, res) => {
    const identificador = String(req.body?.identificador || '').trim().toLowerCase().slice(0, 150);
    const respuesta = { ok: true, msg: 'Si la cuenta existe y tiene correo, recibirás un código.' };
    if (!identificador) return res.json(respuesta);

    const db = getDB();
    const [[u]] = await db.query(`
      SELECT id, nombre, email FROM usuarios
      WHERE estado = 0 AND (LOWER(username) = ? OR LOWER(email) = ?) LIMIT 1
    `, [identificador, identificador]);
    if (!u?.email) return res.json(respuesta);

    const code = String(crypto.randomInt(100000, 1000000));
    const tokenHash = Crypto.hash(`${code}:${process.env.APP_ENCRYPTION_KEY || process.env.SESSION_SECRET || ''}`);
    await db.query('UPDATE password_reset_tokens SET used_at = NOW() WHERE usuario_id = ? AND used_at IS NULL', [u.id]);
    await db.query(`
      INSERT INTO password_reset_tokens (usuario_id, token_hash, expires_at)
      VALUES (?, ?, DATE_ADD(NOW(), INTERVAL ? MINUTE))
    `, [u.id, tokenHash, RESET_MINUTES]);

    try {
      await Mail.send({
        to: u.email,
        subject: 'Código para recuperar tu contraseña',
        text: `Tu código es ${code}. Vence en ${RESET_MINUTES} minutos.`,
        html: `<div style="font-family:Arial;max-width:520px;margin:auto"><h2>Recuperación de contraseña</h2><p>Hola ${String(u.nombre || '').replace(/[<>]/g, '')},</p><p>Tu código de seguridad es:</p><div style="font-size:32px;font-weight:800;letter-spacing:7px;padding:18px;background:#f1f5f9;text-align:center;border-radius:12px">${code}</div><p>Vence en ${RESET_MINUTES} minutos y solo puede utilizarse una vez.</p></div>`
      });
      await Audit.log(req, { accion: 'recuperacion_solicitada', modulo: 'auth', entidad: 'usuario', entidad_id: u.id });
      return res.json({ ok: true, sent: true, msg: `Código enviado al correo registrado. Vence en ${RESET_MINUTES} minutos.` });
    } catch (error) {
      console.error('[MAIL RESET]', error.message);
      await db.query('UPDATE password_reset_tokens SET used_at = NOW() WHERE usuario_id = ? AND used_at IS NULL', [u.id]);
      return res.status(503).json({
        ok: false,
        sent: false,
        code: 'MAIL_SEND_FAILED',
        msg: Mail.friendlyError(error)
      });
    }
  }),

  resetPassword: wrap(async (req, res) => {
    const identificador = String(req.body?.identificador || '').trim().toLowerCase().slice(0, 150);
    const code = String(req.body?.codigo || '').trim();
    const nueva = String(req.body?.nueva_password || '');
    if (!identificador || !/^\d{6}$/.test(code) || !validPassword(nueva)) {
      return res.status(400).json({ ok: false, msg: 'Datos inválidos. La contraseña debe tener 8 caracteres, una letra y un número.' });
    }

    const db = getDB();
    const conn = await db.getConnection();
    try {
      await conn.beginTransaction();
      const [[u]] = await conn.query(`SELECT id FROM usuarios WHERE estado = 0 AND (LOWER(username)=? OR LOWER(email)=?) LIMIT 1 FOR UPDATE`, [identificador, identificador]);
      if (!u) throw new Error('Código inválido o vencido');
      const [[t]] = await conn.query(`SELECT * FROM password_reset_tokens WHERE usuario_id=? AND used_at IS NULL ORDER BY id DESC LIMIT 1 FOR UPDATE`, [u.id]);
      const expected = Crypto.hash(`${code}:${process.env.APP_ENCRYPTION_KEY || process.env.SESSION_SECRET || ''}`);
      if (!t || new Date(t.expires_at).getTime() < Date.now() || Number(t.intentos) >= 5 || t.token_hash !== expected) {
        if (t) await conn.query('UPDATE password_reset_tokens SET intentos = intentos + 1 WHERE id = ?', [t.id]);
        throw new Error('Código inválido o vencido');
      }
      const hash = await bcrypt.hash(nueva, 12);
      await conn.query(`UPDATE usuarios SET password_hash=?, password_changed_at=NOW(), session_version=session_version+1, login_fail_count=0, locked_until=NULL WHERE id=?`, [hash, u.id]);
      await conn.query('UPDATE password_reset_tokens SET used_at=NOW() WHERE id=?', [t.id]);
      await conn.commit();
      await Audit.log(req, { accion: 'password_restaurado', modulo: 'auth', entidad: 'usuario', entidad_id: u.id });
      res.json({ ok: true, msg: 'Contraseña actualizada. Inicia sesión nuevamente.' });
    } catch (error) {
      await conn.rollback();
      res.status(400).json({ ok: false, msg: error.message || 'No se pudo actualizar la contraseña' });
    } finally {
      conn.release();
    }
  })
};

module.exports = AuthController;
