const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
const read = p => fs.readFileSync(path.join(root, p), 'utf8');

test('todos los módulos registrados tienen archivo JavaScript y vista cuando corresponde', () => {
  const app = read('public/assets/js/core/app.js');
  const matches = [...app.matchAll(/'([^']+)':\s*\(\)\s*=>\s*cargarModulo\('([^']+)',\s*'([^']+)'\)/g)];
  assert.ok(matches.length >= 15, 'No se detectaron los módulos registrados');
  for (const [, slug, jsPath] of matches) {
    const absJs = path.join(root, 'public', jsPath.replace(/^\//, ''));
    assert.ok(fs.existsSync(absJs), `Falta JS para ${slug}: ${jsPath}`);
    if (slug !== 'dashboard') {
      const view = path.join(root, 'public/views/pages', `${slug}.html`);
      const aliases = { pagos:'pagos.html', tienda:'tienda.html', config:'config.html', 'apertura-caja':'apertura-caja.html' };
      const resolved = path.join(root, 'public/views/pages', aliases[slug] || `${slug}.html`);
      assert.ok(fs.existsSync(resolved), `Falta vista para ${slug}`);
    }
  }
});

test('login permite usuario o correo y no recorta la contraseña', () => {
  const auth = read('controllers/AuthController.js');
  const login = read('public/views/login.html');
  assert.match(auth, /LOWER\(u\.username\).*LOWER\(u\.email\)/s);
  assert.match(login, /const password = inpPass\.value;/);
  assert.doesNotMatch(login, /const password = inpPass\.value\.trim\(\)/);
});

test('recuperación solo abre el segundo paso cuando el correo fue enviado', () => {
  const auth = read('controllers/AuthController.js');
  const login = read('public/views/login.html');
  assert.match(auth, /MAIL_SEND_FAILED/);
  assert.match(auth, /sent:\s*true/);
  assert.match(login, /d\.ok && d\.sent !== false/);
  assert.match(login, /r\.status === 429/);
});
