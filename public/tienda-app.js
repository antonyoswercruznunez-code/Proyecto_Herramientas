const API = '/api/tienda';

const Tienda = {
  cfg: null,
  cliente: null,
  cart: [],
  slideIndex: 0,
  slideTimer: null,
  googleReady: false,
  docSnapshot: null,
  _voucherFile: null,

  // ── INIT ──
  async init() {
    this.cart = JSON.parse(localStorage.getItem('mp_cart') || '[]');
    this.updateCartBadge();
    document.getElementById('foot-year').textContent = new Date().getFullYear();

    await this.cargarConfig();
    await this.cargarCategorias();
    await this.cargarProductos();
    await this.checkSession();

    // Buscador con debounce
    let t;
    document.getElementById('buscador').addEventListener('input', () => {
      clearTimeout(t); t = setTimeout(() => this.cargarProductos(), 350);
    });

    document.getElementById('btn-cart').onclick = () => this.abrirCarrito();
    document.getElementById('btn-user').onclick = () => this.cliente ? this.menuUsuario() : this.abrirAuth();
  },

  // ── CONFIG ──
  async cargarConfig() {
    try {
      const r = await fetch(`${API}/config`);
      const d = await r.json();
      if (!d.ok) return;
      this.cfg = d;

      document.title = d.nombre + ' — Tienda';
      document.getElementById('brand-name').textContent = d.nombre;
      document.getElementById('foot-nombre').textContent = d.nombre;
      document.getElementById('foot-desc').textContent = d.descripcion || '';
      document.getElementById('foot-direccion').textContent = d.direccion || '';
      document.getElementById('foot-horario').textContent = d.horario || '';
      if (d.logo) document.getElementById('brand-logo').innerHTML = `<img src="${d.logo}" alt="logo">`;

      // Redes sociales
      const soc = document.getElementById('foot-social');
      let s = '';
      if (d.facebook)  s += `<a href="${d.facebook}" target="_blank"><i class="ti ti-brand-facebook"></i></a>`;
      if (d.instagram) s += `<a href="${d.instagram}" target="_blank"><i class="ti ti-brand-instagram"></i></a>`;
      if (d.whatsapp)  s += `<a href="https://wa.me/${d.whatsapp.replace(/\D/g,'')}" target="_blank"><i class="ti ti-brand-whatsapp"></i></a>`;
      soc.innerHTML = s;

      // Slider
      if (d.sliders && d.sliders.length) this.renderSlider(d.sliders);

      // Google (si hay client_id)
      if (d.google_client_id) this.initGoogle(d.google_client_id);
    } catch(e) { console.error(e); }
  },

  // ── SLIDER ──
  renderSlider(sliders) {
    const cont = document.getElementById('slider');
    cont.style.display = 'block';
    document.getElementById('slides').innerHTML = sliders.map(s =>
      `<div class="slide"><img src="${s.ruta}" alt="${s.nombre||''}"></div>`).join('');
    document.getElementById('slider-dots').innerHTML = sliders.map((_,i) =>
      `<span class="dot ${i===0?'active':''}" onclick="Tienda.goSlide(${i})"></span>`).join('');
    this.slideCount = sliders.length;
    this.startSlider();
  },
  startSlider() {
    if (this.slideCount <= 1) return;
    clearInterval(this.slideTimer);
    this.slideTimer = setInterval(() => this.slideNext(), 5000);
  },
  goSlide(i) {
    this.slideIndex = i;
    document.getElementById('slides').style.transform = `translateX(-${i*100}%)`;
    document.querySelectorAll('.dot').forEach((d,idx) => d.classList.toggle('active', idx===i));
  },
  slideNext(){ this.goSlide((this.slideIndex+1) % this.slideCount); this.startSlider(); },
  slidePrev(){ this.goSlide((this.slideIndex-1+this.slideCount) % this.slideCount); this.startSlider(); },

  // El catálogo trabaja directamente con productos; no usa categorías.
  async cargarCategorias() { const bar=document.getElementById('cats-bar'); if(bar) bar.style.display='none'; },

  // ── PRODUCTOS ──
  async cargarProductos() {
    const grid = document.getElementById('grid');
    grid.innerHTML = '<div class="loading"><div class="spin"></div>Cargando productos...</div>';
    const buscar = document.getElementById('buscador').value.trim();
    const orden = document.getElementById('orden').value;
    const qs = new URLSearchParams();
    if (buscar) qs.append('buscar', buscar);
    if (orden) qs.append('orden', orden);

    try {
      const r = await fetch(`${API}/productos?${qs}`);
      const d = await r.json();
      if (!d.ok || !d.productos.length) {
        grid.innerHTML = `<div class="empty-state"><i class="ti ti-package-off"></i>No se encontraron productos</div>`;
        return;
      }
      grid.innerHTML = d.productos.map(p => this.cardHTML(p)).join('');
    } catch(e) {
      grid.innerHTML = `<div class="empty-state"><i class="ti ti-alert-triangle"></i>Error al cargar</div>`;
    }
  },

  esc(v) { return String(v ?? '').replace(/[&<>'"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c])); },

  cardHTML(p) {
    const tieneOferta = Number(p.precio_final) < Number(p.precio_venta);
    const img = p.imagen
      ? `<img src="${this.esc(p.imagen)}" alt="${this.esc(p.nombre)}">`
      : `<span class="noimg"><i class="ti ti-paw"></i></span>`;
    const item = {id:Number(p.id),nombre:p.nombre,precio:Number(p.precio_final),imagen:p.imagen||'',sucursal_id:Number(p.sucursal_id),sucursal_nombre:p.sucursal_nombre||'Sucursal',stock:Number(p.stock_disponible||0)};
    return `<div class="card">
      ${tieneOferta ? `<span class="badge-oferta">Oferta</span>` : ''}
      <div class="card-img" onclick="Tienda.verProducto(${Number(p.id)})">${img}</div>
      <div class="card-body">
        <div class="card-cat">${this.esc(p.sucursal_nombre || 'Mundo Pet')}</div>
        <div class="card-name" onclick="Tienda.verProducto(${Number(p.id)})">${this.esc(p.nombre)}</div>
        <div class="card-price">
          <span class="price-now">S/ ${Number(p.precio_final).toFixed(2)}</span>
          ${tieneOferta ? `<span class="price-old">S/ ${Number(p.precio_venta).toFixed(2)}</span>` : ''}
        </div>
        <button class="btn-add" onclick='Tienda.addCart(${JSON.stringify(item).replace(/'/g,"&#39;")})'>
          <i class="ti ti-shopping-cart-plus"></i> Agregar
        </button>
      </div>
    </div>`;
  },

  async verProducto(id) {
    try {
      const r = await fetch(`${API}/productos/${id}`);
      const d = await r.json();
      if (!d.ok) return this.toast(d.msg || 'Producto no disponible', 'err');
      const p = d.producto;
      const tieneOferta = Number(p.precio_final) < Number(p.precio_venta);
      const img = p.imagen ? `<img src="${this.esc(p.imagen)}" alt="${this.esc(p.nombre)}">` : `<div style="display:flex;align-items:center;justify-content:center;height:100%;font-size:80px;color:#d9b8ac"><i class="ti ti-paw"></i></div>`;
      const item={id:Number(p.id),nombre:p.nombre,precio:Number(p.precio_final),imagen:p.imagen||'',sucursal_id:Number(p.sucursal_id),sucursal_nombre:p.sucursal_nombre||'Sucursal',stock:Number(p.stock_disponible||0)};
      this.showModal(`
        <div class="modal-head"><h3>Detalle</h3><button class="close-x" onclick="Tienda.cerrarModal()"><i class="ti ti-x"></i></button></div>
        <div class="modal-body">
          <div class="pd-img">${img}</div>
          <div class="pd-cat">${this.esc(p.sucursal_nombre || 'Mundo Pet')}</div>
          <div class="pd-name">${this.esc(p.nombre)}</div>
          <div class="pd-price">S/ ${Number(p.precio_final).toFixed(2)}
            ${tieneOferta ? `<span style="font-size:16px;color:var(--muted);text-decoration:line-through;font-weight:500">S/ ${Number(p.precio_venta).toFixed(2)}</span>`:''}</div>
          <p class="pd-desc">${this.esc(p.descripcion || 'Sin descripción disponible.')}</p>
          <div style="font-size:13px;color:var(--muted);margin-bottom:16px"><i class="ti ti-building-store"></i> ${this.esc(p.sucursal_nombre || '')} · Stock disponible: ${Number(p.stock_disponible)}</div>
          <button class="btn-block" onclick='Tienda.addCart(${JSON.stringify(item).replace(/'/g,"&#39;")});Tienda.cerrarModal()'>
            <i class="ti ti-shopping-cart-plus"></i> Agregar al carrito</button>
        </div>`);
    } catch(e) { this.toast('Error al cargar el producto', 'err'); }
  },

  // ── CARRITO ──
  addCart(prod) {
    const ex = this.cart.find(i => i.id === prod.id);
    if (ex) ex.cantidad++;
    else this.cart.push({ ...prod, cantidad: 1 });
    this.saveCart();
    this.toast('Agregado al carrito', 'ok');
  },
  changeQty(id, delta) {
    const it = this.cart.find(i => i.id === id);
    if (!it) return;
    it.cantidad += delta;
    if (it.cantidad <= 0) this.cart = this.cart.filter(i => i.id !== id);
    this.saveCart(); this.renderCart();
  },
  delCart(id) { this.cart = this.cart.filter(i => i.id !== id); this.saveCart(); this.renderCart(); },
  saveCart() { localStorage.setItem('mp_cart', JSON.stringify(this.cart)); this.updateCartBadge(); },
  updateCartBadge() {
    const n = this.cart.reduce((a,i) => a+i.cantidad, 0);
    const b = document.getElementById('cart-badge');
    b.style.display = n ? 'flex' : 'none';
    b.textContent = n;
  },
  cartTotal() { return this.cart.reduce((a,i) => a + i.precio*i.cantidad, 0); },

  abrirCarrito() { this.renderCart(); document.getElementById('cart-drawer').classList.add('show'); document.getElementById('overlay').classList.add('show'); },

  renderCart() {
    const body = document.getElementById('cart-body');
    const foot = document.getElementById('cart-foot');
    if (!this.cart.length) {
      body.innerHTML = `<div class="empty-state"><i class="ti ti-shopping-cart-off"></i>Tu carrito está vacío</div>`;
      foot.innerHTML = '';
      return;
    }
    const groups = new Map();
    this.cart.forEach(i => { const k=Number(i.sucursal_id||0); if(!groups.has(k))groups.set(k,{nombre:i.sucursal_nombre||'Sucursal',items:[]}); groups.get(k).items.push(i); });
    body.innerHTML = `${groups.size>1?`<div style="background:#fff7ed;border:1px solid #fed7aa;color:#9a3412;padding:12px;border-radius:10px;margin-bottom:14px;font-size:13px"><b>Carrito multisucursal.</b> Cada local preparará o entregará los productos que le corresponden.</div>`:''}` + [...groups.values()].map(g=>`
      <div style="font-size:12px;font-weight:800;color:var(--brand);text-transform:uppercase;margin:12px 0 7px"><i class="ti ti-building-store"></i> ${this.esc(g.nombre)}</div>
      ${g.items.map(i => `<div class="cart-item">
        <img src="${this.esc(i.imagen || '')}" onerror="this.style.background='var(--brand-soft)';this.removeAttribute('src')">
        <div class="cart-item-info">
          <div class="cart-item-name">${this.esc(i.nombre)}</div>
          <div class="cart-item-price">S/ ${Number(i.precio).toFixed(2)}</div>
          <div class="qty"><button onclick="Tienda.changeQty(${Number(i.id)},-1)">−</button><span>${Number(i.cantidad)}</span><button onclick="Tienda.changeQty(${Number(i.id)},1)">+</button></div>
        </div>
        <button class="cart-item-del" onclick="Tienda.delCart(${Number(i.id)})"><i class="ti ti-trash"></i></button>
      </div>`).join('')}`).join('');
    foot.innerHTML = `<div class="cart-total-row big"><span>Total estimado</span><span>S/ ${this.cartTotal().toFixed(2)}</span></div><button class="btn-block" onclick="Tienda.irCheckout()"><i class="ti ti-credit-card"></i> Finalizar compra</button>`;
  },

  // ── CHECKOUT / MEDIOS DE PAGO ──
  getPaymentMethods() {
    const rows = Array.isArray(this.cfg?.metodos_pago) ? this.cfg.metodos_pago : [];
    if (rows.length) return rows.filter(x => x && x.id);
    const fallback = [];
    if (this.cfg?.yape_numero || this.cfg?.yape_qr_ruta) fallback.push({id:'yape',nombre:'Yape',numero:this.cfg.yape_numero||'',imagen:this.cfg.yape_qr_ruta||''});
    if (this.cfg?.plin_numero || this.cfg?.plin_qr_ruta) fallback.push({id:'plin',nombre:'Plin',numero:this.cfg.plin_numero||'',imagen:this.cfg.plin_qr_ruta||''});
    if (this.cfg?.transferencia_cuenta || this.cfg?.transferencia_cci) fallback.push({
      id:'transferencia',nombre:'Transferencia',banco:this.cfg.transferencia_banco||'',
      titular:this.cfg.transferencia_titular||'',cuenta:this.cfg.transferencia_cuenta||'',cci:this.cfg.transferencia_cci||''
    });
    return fallback;
  },
  paymentMethodsHTML(methods) {
    return methods.map((m,i) => `<button type="button" class="metodo-chip ${i===0?'active':''}" data-m="${this.esc(m.id)}" onclick="Tienda.selMetodo(this)">${this.esc(m.nombre || m.id)}</button>`).join('');
  },
  paymentInfoHTML(method) {
    if (!method) return '<div style="font-size:12px;color:var(--muted)">Selecciona un método de pago.</div>';
    const rows = [];
    if (method.numero) rows.push(`<div><b>Número:</b> ${this.esc(method.numero)}</div>`);
    if (method.banco) rows.push(`<div><b>Banco:</b> ${this.esc(method.banco)}</div>`);
    if (method.titular) rows.push(`<div><b>Titular:</b> ${this.esc(method.titular)}</div>`);
    if (method.cuenta) rows.push(`<div><b>Cuenta:</b> ${this.esc(method.cuenta)}</div>`);
    if (method.cci) rows.push(`<div><b>CCI:</b> ${this.esc(method.cci)}</div>`);
    if (method.instrucciones) rows.push(`<div>${this.esc(method.instrucciones)}</div>`);
    const image = method.imagen ? `<button type="button" onclick="Tienda.verImagenPago('${this.esc(method.imagen)}','${this.esc(method.nombre || method.id)}')" style="border:0;background:transparent;padding:0;cursor:zoom-in" title="Ampliar imagen"><img src="${this.esc(method.imagen)}" alt="${this.esc(method.nombre || method.id)}" style="max-width:220px;max-height:220px;object-fit:contain;border-radius:10px;background:#fff;padding:6px;border:1px solid var(--line)"></button>` : '';
    return `<div style="display:grid;grid-template-columns:${image?'minmax(140px,220px) 1fr':'1fr'};gap:14px;align-items:center">
      ${image}<div style="font-size:13px;line-height:1.7">${rows.join('') || '<span style="color:var(--muted)">Sigue las indicaciones del negocio para completar el pago.</span>'}</div>
    </div>`;
  },
  renderPaymentInfo() {
    const method = (this._paymentMethods || []).find(x => x.id === this._metodo);
    const box = document.getElementById('ck-payment-info');
    if (box) box.innerHTML = this.paymentInfoHTML(method);
  },
  verImagenPago(src, titulo='Medio de pago') {
    if (!src) return;
    document.getElementById('payment-image-overlay')?.remove();
    const overlay=document.createElement('div');
    overlay.id='payment-image-overlay';
    overlay.style.cssText='position:fixed;inset:0;z-index:99999;background:rgba(15,23,42,.82);display:flex;align-items:center;justify-content:center;padding:20px';
    overlay.innerHTML=`<div style="position:relative;max-width:min(820px,94vw);max-height:90vh;background:#fff;border-radius:18px;padding:18px;box-shadow:0 24px 70px rgba(0,0,0,.35)"><button type="button" aria-label="Cerrar" style="position:absolute;right:10px;top:10px;width:38px;height:38px;border:0;border-radius:50%;background:#0f172a;color:#fff;font-size:22px;cursor:pointer" onclick="document.getElementById('payment-image-overlay')?.remove()">×</button><h3 style="margin:0 45px 12px 0;color:#0f172a">${this.esc(titulo)}</h3><img src="${this.esc(src)}" alt="${this.esc(titulo)}" style="display:block;max-width:88vw;max-height:76vh;object-fit:contain;border-radius:12px;margin:auto"></div>`;
    overlay.addEventListener('click',e=>{if(e.target===overlay)overlay.remove();});
    document.body.appendChild(overlay);
  },

  // ── CHECKOUT ──
  async irCheckout() {
    if (!this.cart.length) return this.toast('Carrito vacío', 'err');
    // Revalida la sesión en el servidor antes de pedir login otra vez. Esto
    // evita el falso cierre cuando la página terminó de cargar antes que la sesión.
    if (!this.cliente) await this.checkSession();
    if (!this.cliente) { this.cerrarTodo(); this.toast('Primero inicia sesión', 'err'); return this.abrirAuth(true); }
    this.cerrarTodo(); this.docSnapshot=null; this._voucherFile=null;
    const branches=[...new Map(this.cart.map(i=>{const id=Number(i.sucursal_id||0);return [id,{id,nombre:i.sucursal_nombre||'Sucursal'}]})).values()];this._checkoutBranches=branches;this._pickupSlots={};
    const methods=this.getPaymentMethods();
    if(!methods.length)return this.toast('No hay medios de pago habilitados. Comunícate con la tienda.','err');
    this._paymentMethods=methods;
    const entregas=[];
    if(this.cfg?.delivery_activo)entregas.push(`<div class="radio-card" data-ent="delivery" onclick="Tienda.selEntrega(this)"><i class="ti ti-truck-delivery"></i>Delivery</div>`);
    if(this.cfg?.recojo_activo)entregas.push(`<div class="radio-card" data-ent="recojo" onclick="Tienda.selEntrega(this)"><i class="ti ti-building-store"></i>Recojo en tienda</div>`);
    this.showModal(`
      <div class="modal-head"><h3>Finalizar compra</h3><button class="close-x" onclick="Tienda.cerrarModal()"><i class="ti ti-x"></i></button></div>
      <div class="modal-body">
        ${branches.length>1?`<div style="background:#fff7ed;border:1px solid #fed7aa;color:#9a3412;padding:13px;border-radius:10px;margin-bottom:16px"><b>Compra de ${branches.length} sucursales.</b><br><span style="font-size:12px">Se generará un solo pedido y una sola nota de venta. Cada sucursal preparará su parte.</span></div>`:''}
        <div style="display:flex;gap:8px;margin-bottom:18px"><span style="background:var(--brand);color:#fff;border-radius:999px;padding:5px 10px;font-size:12px">1 Identidad</span><span style="background:#e2e8f0;border-radius:999px;padding:5px 10px;font-size:12px">2 Entrega</span><span style="background:#e2e8f0;border-radius:999px;padding:5px 10px;font-size:12px">3 Pago</span></div>
        <div style="font-weight:800;margin-bottom:8px">Confirma tus datos</div>
        <div style="display:flex;gap:8px">
          <select id="ck-tipo-doc" style="width:105px;border:1px solid var(--line);border-radius:9px;padding:10px"><option value="dni">DNI</option><option value="ruc">RUC</option></select>
          <input id="ck-doc" style="flex:1;border:1px solid var(--line);border-radius:9px;padding:10px" maxlength="11" inputmode="numeric" placeholder="Número de documento">
          <button id="ck-doc-search" onclick="Tienda.buscarDocumento()" style="border:0;border-radius:9px;background:var(--brand);color:#fff;padding:0 14px;cursor:pointer"><i class="ti ti-search"></i></button>
        </div>
        <div id="ck-doc-result" style="margin:10px 0 14px"></div>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px">
          <div class="field"><label>Teléfono</label><input id="ck-telefono" inputmode="tel" placeholder="987654321"></div>
          <div class="field"><label>Correo del comprador *</label><input id="ck-email" type="email" placeholder="correo@ejemplo.com" autocomplete="email"></div>
        </div>
        <label style="font-size:13px;font-weight:700;margin:9px 0 8px;display:block">Tipo de entrega</label>
        <div class="radio-group">${entregas.join('')}</div>
        <div id="dir-wrap" style="display:none">
          <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:8px"><div class="field"><label>Departamento</label><input id="ck-dep"></div><div class="field"><label>Provincia</label><input id="ck-prov"></div><div class="field"><label>Distrito</label><input id="ck-dist"></div></div>
          <div class="field"><label>Dirección de entrega</label><textarea id="ck-direccion" rows="2" placeholder="Av./Calle, número, lote"></textarea></div>
          <div class="field"><label>Referencia</label><input id="ck-ref" placeholder="Cerca de..."></div>
        </div>
        <div id="pickup-info" style="display:none;background:#eff6ff;border:1px solid #bfdbfe;padding:11px;border-radius:9px;font-size:12px;color:#1e40af;margin-bottom:12px">${branches.length>1?'Deberás recoger cada grupo en su sucursal: '+branches.map(x=>this.esc(x.nombre)).join(', '):'Recogerás tu compra en la sucursal correspondiente.'}<div id="pickup-slots" style="margin-top:10px"></div></div>
        <label style="font-size:13px;font-weight:700;margin:9px 0 8px;display:block">Método de pago</label>
        <div class="metodo-pago">${this.paymentMethodsHTML(methods)}</div>
        <div id="ck-payment-info" style="background:#f8fafc;border:1px solid var(--line);border-radius:12px;padding:13px;margin:0 0 12px">${this.paymentInfoHTML(methods[0])}</div>
        <div class="field"><label>Número o código de operación (opcional)</label><input id="ck-codigo" maxlength="100" placeholder="Puede tener distinta longitud según la app o banco"></div>
        <div class="field"><label>Captura del pago (opcional)</label><label class="mp-file-picker"><i class="ti ti-photo-up"></i><span id="ck-voucher-name">Elegir una imagen</span><input id="ck-voucher" type="file" accept="image/jpeg,image/png,image/webp" onchange="Tienda._voucherFile=this.files[0]||null;document.getElementById('ck-voucher-name').textContent=this.files[0]?.name||'Elegir una imagen'"></label><small>Solo JPG, PNG o WEBP.</small></div>
        <label class="check-line" style="margin:10px 0"><input type="checkbox" id="ck-solicita-factura" onchange="document.getElementById('ck-factura-comentario').style.display=this.checked?'block':'none'"> Solicitar factura después de aprobar el pedido</label>
        <div class="field" id="ck-factura-comentario" style="display:none"><label>Comentario para facturación (opcional)</label><textarea id="ck-comentario-factura" rows="2" maxlength="500" placeholder="Ej.: enviar la factura a este correo o indicar una referencia. La venta siempre se crea primero como nota de venta."></textarea></div>
        <div class="cart-total-row big" style="margin:18px 0"><span>Total estimado</span><span>S/ ${this.cartTotal().toFixed(2)}</span></div>
        <button class="btn-block" id="ck-confirm" onclick="Tienda.confirmarPedido()"><i class="ti ti-check"></i> Confirmar pedido</button>
        <p style="font-size:12px;color:var(--muted);text-align:center;margin-top:12px">El stock físico baja recién cuando un usuario autorizado aprueba y genera la nota de venta.</p>
      </div>`, 'wide');
    this._entrega=null;this._metodo=methods[0].id;
  },
  async selEntrega(el) {
    document.querySelectorAll('[data-ent]').forEach(x=>x.classList.remove('active'));el.classList.add('active');this._entrega=el.dataset.ent;
    document.getElementById('dir-wrap').style.display=this._entrega==='delivery'?'block':'none';
    document.getElementById('pickup-info').style.display=this._entrega==='recojo'?'block':'none';
    if(this._entrega==='recojo')await this.cargarHorariosRecojo();
  },
  async cargarHorariosRecojo(){
    const root=document.getElementById('pickup-slots');if(!root)return;root.innerHTML='<div style="color:#64748b">Cargando horarios...</div>';
    const ids=(this._checkoutBranches||[]).map(x=>x.id).filter(Boolean);
    try{const r=await fetch(`${API}/recojo-horarios?sucursales=${encodeURIComponent(ids.join(','))}`,{credentials:'include'});const d=await r.json();const rows=d.horarios||[];
      root.innerHTML=(this._checkoutBranches||[]).map(b=>{const opts=rows.filter(x=>Number(x.sucursal_id)===Number(b.id));return `<div class="field"><label>${this.esc(b.nombre)}</label><select class="pickup-slot" data-sid="${Number(b.id)}"><option value="">Selecciona fecha y hora</option>${opts.map(x=>`<option value="${Number(x.id)}">${this.esc(x.fecha)} · ${this.esc(x.hora_inicio)}–${this.esc(x.hora_fin)} (${Number(x.disponibles)} cupos)</option>`).join('')}</select>${opts.length?'':'<small style="color:#dc2626">No hay horarios disponibles.</small>'}</div>`}).join('');
    }catch(_){root.innerHTML='<div style="color:#dc2626">No se pudieron cargar los horarios.</div>';}
  },
  selMetodo(el){
    document.querySelectorAll('.metodo-chip').forEach(x=>x.classList.remove('active'));
    el.classList.add('active');
    this._metodo=el.dataset.m;
    this.renderPaymentInfo();
  },
  async buscarDocumento(){
    const tipo=document.getElementById('ck-tipo-doc').value;const doc=document.getElementById('ck-doc').value.replace(/\D/g,'');
    if(doc.length!==(tipo==='dni'?8:11))return this.toast('Documento inválido','err');
    const btn=document.getElementById('ck-doc-search');btn.disabled=true;
    try{const r=await fetch(`${API}/documento?tipo=${encodeURIComponent(tipo)}&doc=${encodeURIComponent(doc)}`,{credentials:'include'});const d=await r.json();if(!d.ok)return this.toast(d.msg||'No encontrado','err');this.docSnapshot=d.cliente;document.getElementById('ck-doc').disabled=true;document.getElementById('ck-tipo-doc').disabled=true;document.getElementById('ck-doc-result').innerHTML=`<div style="display:flex;align-items:center;justify-content:space-between;background:#ecfdf5;border:1px solid #a7f3d0;padding:11px;border-radius:9px;color:#166534"><div><b><i class="ti ti-circle-check"></i> ${this.esc(d.cliente.nombre_completo||d.cliente.razon_social||d.cliente.nombre)}</b><div style="font-size:11px">Documento validado</div></div><button onclick="Tienda.limpiarDocumento()" title="Cambiar documento" style="border:0;background:transparent;color:#166534;font-size:20px;cursor:pointer"><i class="ti ti-x"></i></button></div>`;document.getElementById('ck-telefono').value=d.cliente.telefono||'';document.getElementById('ck-dep').value=d.cliente.departamento||'';document.getElementById('ck-prov').value=d.cliente.provincia||'';document.getElementById('ck-dist').value=d.cliente.distrito||'';document.getElementById('ck-direccion').value=d.cliente.direccion_api||'';}finally{btn.disabled=false;}
  },
  limpiarDocumento(){this.docSnapshot=null;const d=document.getElementById('ck-doc');const t=document.getElementById('ck-tipo-doc');d.disabled=false;t.disabled=false;d.value='';document.getElementById('ck-doc-result').innerHTML='';d.focus();},
  async confirmarPedido(){
    if(!this.docSnapshot)return this.toast('Busca y confirma tu DNI o RUC','err');
    if(!this._entrega)return this.toast('Selecciona tipo de entrega','err');
    const direccion=document.getElementById('ck-direccion')?.value.trim()||'';if(this._entrega==='delivery'&&!direccion)return this.toast('Ingresa la dirección','err');
    const email=document.getElementById('ck-email')?.value.trim().toLowerCase()||'';
    if(!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))return this.toast('Ingresa el correo obligatorio del comprador','err');
    const recojo_horarios={};if(this._entrega==='recojo'){for(const el of document.querySelectorAll('.pickup-slot')){if(!el.value)return this.toast('Selecciona un horario para cada sucursal','err');recojo_horarios[el.dataset.sid]=Number(el.value);}}
    const btn=document.getElementById('ck-confirm');btn.disabled=true;btn.textContent='Registrando...';
    const body={recojo_horarios,items:this.cart.map(i=>({producto_id:i.id,cantidad:i.cantidad})),numero_doc:this.docSnapshot.numero_doc,tipo_entrega:this._entrega,direccion_entrega:direccion,departamento:document.getElementById('ck-dep')?.value||'',provincia:document.getElementById('ck-prov')?.value||'',distrito:document.getElementById('ck-dist')?.value||'',referencia:document.getElementById('ck-ref')?.value||'',telefono:document.getElementById('ck-telefono')?.value||'',email,persona_recibe:this.docSnapshot.nombre_completo||this.docSnapshot.nombre,metodo_pago:this._metodo,codigo_operacion:document.getElementById('ck-codigo')?.value.trim()||'',solicitar_factura:!!document.getElementById('ck-solicita-factura')?.checked,comentario_facturacion:document.getElementById('ck-comentario-factura')?.value.trim()||''};
    try{const r=await fetch(`${API}/pedidos`,{method:'POST',headers:{'Content-Type':'application/json'},credentials:'include',body:JSON.stringify(body)});const d=await r.json();if(!d.ok)return this.toast(d.msg||'No se pudo crear','err');let voucherOk=false;if(this._voucherFile){const fd=new FormData();fd.append('voucher',this._voucherFile);const vr=await fetch(`${API}/mis-pedidos/${d.pedido_id}/voucher`,{method:'POST',credentials:'include',body:fd});voucherOk=vr.ok;}this.cart=[];this.saveCart();this.cerrarModal();this.showModal(`<div class="modal-body" style="text-align:center;padding:40px 30px"><div style="width:80px;height:80px;background:var(--brand-soft);border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 20px"><i class="ti ti-circle-check" style="font-size:48px;color:var(--ok)"></i></div><h3 style="font-size:22px;margin-bottom:8px">¡Pedido registrado!</h3><p style="color:var(--muted)">Orden <b>${this.esc(d.numero_orden)}</b> · S/ ${Number(d.total).toFixed(2)}</p><p style="font-size:12px;color:var(--muted);margin:10px 0 22px">Reserva temporal: ${Number(d.reserva_minutos)} minutos.${d.multisucursal?' Pedido multisucursal.':''}${voucherOk?' Captura guardada.':''}</p><button class="btn-block" onclick="Tienda.cerrarModal();Tienda.verPedidos()"><i class="ti ti-package"></i> Ver mis pedidos</button></div>`);}catch(e){this.toast('Error al crear pedido','err');}finally{if(btn){btn.disabled=false;btn.innerHTML='<i class="ti ti-check"></i> Confirmar pedido';}}
  },

  // ── AUTH ──
  async checkSession() {
    try {
      const r = await fetch(`${API}/auth/session`, { credentials:'include' });
      const d = await r.json();
      if (d.ok) { this.cliente = d.cliente; this.renderUser(); }
    } catch(e) {}
  },
  renderUser() {
    const label = document.getElementById('user-label');
    const btn = document.getElementById('btn-user');
    if (this.cliente) {
      label.textContent = this.cliente.nombre.split(' ')[0];
      btn.querySelector('i').outerHTML = this.cliente.avatar
        ? `<img src="${this.cliente.avatar}" alt="">`
        : `<i class="ti ti-user-circle"></i>`;
    }
  },
  abrirAuth(checkout=false) {
    this._postLoginCheckout = checkout;
    this.showModal(`
      <div class="modal-head"><h3>Mi cuenta</h3><button class="close-x" onclick="Tienda.cerrarModal()"><i class="ti ti-x"></i></button></div>
      <div class="modal-body">
        <div class="tabs">
          <button class="active" id="tab-login" onclick="Tienda.switchAuth('login')">Ingresar</button>
          <button id="tab-reg" onclick="Tienda.switchAuth('reg')">Crear cuenta</button>
        </div>
        <div id="auth-login">
          <div class="field"><label>Correo</label><input type="email" id="lg-email" placeholder="tucorreo@gmail.com"></div>
          <div class="field"><label>Contraseña</label><input type="password" id="lg-pass" placeholder="••••••••"></div>
          <button class="btn-block" onclick="Tienda.doLogin()">Ingresar</button>
        </div>
        <div id="auth-reg" style="display:none">
          <div class="field"><label>Nombre completo</label><input id="rg-nombre" placeholder="Tu nombre"></div>
          <div class="field"><label>Correo</label><input type="email" id="rg-email" placeholder="tucorreo@gmail.com"></div>
          <div class="field"><label>Teléfono (opcional)</label><input id="rg-tel" placeholder="987654321"></div>
          <div class="field"><label>Contraseña</label><input type="password" id="rg-pass" placeholder="Mínimo 8 caracteres, con letra y número"></div>
          <button class="btn-block" onclick="Tienda.doRegistro()">Crear cuenta</button>
        </div>
        <div class="divider" id="gdiv">o continúa con</div>
        <div class="gbtn-wrap"><div id="gbtn"></div><div id="gfallback" style="display:none;color:var(--muted);font-size:13px;text-align:center">Google Login no configurado</div></div>
      </div>`);
    // Renderizar botón de Google
    setTimeout(() => this.renderGoogleButton(), 100);
  },
  switchAuth(t) {
    document.getElementById('tab-login').classList.toggle('active', t==='login');
    document.getElementById('tab-reg').classList.toggle('active', t==='reg');
    document.getElementById('auth-login').style.display = t==='login' ? 'block':'none';
    document.getElementById('auth-reg').style.display = t==='reg' ? 'block':'none';
  },
  async doLogin() {
    const email = document.getElementById('lg-email').value.trim();
    const password = document.getElementById('lg-pass').value;
    if (!email || !password) return this.toast('Completa los campos', 'err');
    const r = await fetch(`${API}/auth/login`, { method:'POST', headers:{'Content-Type':'application/json'}, credentials:'include', body: JSON.stringify({email,password}) });
    const d = await r.json();
    if (!d.ok) return this.toast(d.msg, 'err');
    this.afterLogin(d.cliente);
  },
  async doRegistro() {
    const nombre = document.getElementById('rg-nombre').value.trim();
    const email = document.getElementById('rg-email').value.trim();
    const telefono = document.getElementById('rg-tel').value.trim();
    const password = document.getElementById('rg-pass').value;
    if (!nombre || !email || !password) return this.toast('Completa los campos obligatorios', 'err');
    const r = await fetch(`${API}/auth/registro`, { method:'POST', headers:{'Content-Type':'application/json'}, credentials:'include', body: JSON.stringify({nombre,email,telefono,password}) });
    const d = await r.json();
    if (!d.ok) return this.toast(d.msg, 'err');
    this.afterLogin(d.cliente);
  },
  afterLogin(cliente) {
    this.cliente = cliente;
    this.renderUser();
    this.cerrarModal();
    this.toast('¡Bienvenido ' + cliente.nombre.split(' ')[0] + '!', 'ok');
    if (this._postLoginCheckout) { this._postLoginCheckout = false; setTimeout(() => this.irCheckout(), 400); }
  },

  // ── GOOGLE ──
  initGoogle(clientId) {
    this._gClientId = clientId;
    this.googleReady = false;

    const initialize = () => {
      if (!(window.google?.accounts?.id) || !this._gClientId) return false;

      google.accounts.id.initialize({
        client_id: String(this._gClientId).trim(),
        callback: (resp) => this.onGoogle(resp),
        ux_mode: 'popup',
        context: 'signin',
        auto_select: false,
        itp_support: true
      });

      this.googleReady = true;
      this.renderGoogleButton();
      return true;
    };

    if (initialize()) return;

    let attempts = 0;
    const wait = setInterval(() => {
      attempts++;
      if (initialize() || attempts >= 60) clearInterval(wait);
    }, 250);
  },
  renderGoogleButton() {
    const box = document.getElementById('gbtn');
    const divider = document.getElementById('gdiv');
    const fallback = document.getElementById('gfallback');
    if (!box) return;

    if (this.googleReady && this._gClientId && window.google?.accounts?.id) {
      box.innerHTML = '';
      if (divider) divider.style.display = '';
      if (fallback) fallback.style.display = 'none';
      google.accounts.id.renderButton(box, {
        theme: 'outline',
        size: 'large',
        width: 340,
        text: 'continue_with',
        shape: 'pill'
      });
      return;
    }

    // No ocultar definitivamente el espacio: Google puede cargar después.
    if (divider) divider.style.display = '';
    if (fallback) {
      fallback.style.display = 'block';
      fallback.textContent = this._gClientId
        ? 'Cargando acceso con Google...'
        : 'Google Login no configurado';
    }
  },
  async onGoogle(resp) {
    if (!resp?.credential) return this.toast('Google no devolvió una credencial válida', 'err');
    try {
      const r = await fetch(`${API}/auth/google`, {
        method: 'POST',
        headers: {'Content-Type':'application/json'},
        credentials: 'include',
        body: JSON.stringify({ credential: resp.credential })
      });
      const d = await r.json().catch(() => ({ok:false,msg:'Respuesta inválida del servidor'}));
      if (!r.ok || !d.ok) return this.toast(d.msg || 'No se pudo iniciar sesión con Google', 'err');
      this.afterLogin(d.cliente);
    } catch (_) {
      this.toast('No se pudo conectar con el servidor para iniciar sesión', 'err');
    }
  },

  // ── MENÚ USUARIO / PEDIDOS ──
  menuUsuario() {
    this.showModal(`
      <div class="modal-head"><h3>Hola, ${this.cliente.nombre.split(' ')[0]}</h3><button class="close-x" onclick="Tienda.cerrarModal()"><i class="ti ti-x"></i></button></div>
      <div class="modal-body">
        <button class="btn-block secondary" onclick="Tienda.cerrarModal();Tienda.verPedidos()"><i class="ti ti-package"></i> Mis pedidos</button>
        <button class="btn-block" style="background:#dc2626" onclick="Tienda.logout()"><i class="ti ti-logout"></i> Cerrar sesión</button>
      </div>`);
  },
  async verPedidos() {
    if (!this.cliente) return this.abrirAuth();
    this.showModal(`<div class="modal-head"><h3>Mis pedidos</h3><button class="close-x" onclick="Tienda.cerrarModal()"><i class="ti ti-x"></i></button></div><div class="modal-body" id="pedidos-body"><div class="loading"><div class="spin"></div>Cargando...</div></div>`, 'wide');
    const r = await fetch(`${API}/mis-pedidos`, { credentials:'include' });
    const d = await r.json();
    const body = document.getElementById('pedidos-body');
    if (!d.ok || !d.pedidos.length) { body.innerHTML = `<div class="empty-state"><i class="ti ti-package-off"></i>Aún no tienes pedidos</div>`; return; }
    const estadoColor = { pendiente:'#f59e0b', verificado:'#16a34a', rechazado:'#dc2626', preparando:'#3b82f6', despachado:'#8b5cf6', entregado:'#16a34a', cancelado:'#dc2626' };
    body.innerHTML = d.pedidos.map(p => `
      <div onclick="Tienda.verPedidoDetalle(${p.id})" style="border:1px solid var(--line);border-radius:12px;padding:16px;margin-bottom:12px;cursor:pointer">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px">
          <b>${p.numero_orden}</b>
          <span style="font-size:12px;font-weight:600;color:${estadoColor[p.estado_pedido]||'#666'};text-transform:capitalize">${p.estado_pedido}</span>
        </div>
        <div style="font-size:13px;color:var(--muted);display:flex;justify-content:space-between">
          <span>${p.created_at} · ${p.tipo_entrega}</span>
          <b style="color:var(--brand)">S/ ${Number(p.total).toFixed(2)}</b>
        </div>
        <div style="font-size:12px;color:var(--muted);margin-top:6px">Pago: ${p.metodo_pago} · <span style="color:${estadoColor[p.estado_pago]||'#666'}">${p.estado_pago}</span></div>
      </div>`).join('');
  },
  async verPedidoDetalle(id) {
    const r=await fetch(`${API}/mis-pedidos/${id}`,{credentials:'include'});const d=await r.json();if(!d.ok)return this.toast(d.msg||'No encontrado','err');
    const groups=new Map();d.items.forEach(i=>{const k=i.sucursal_nombre||'Sucursal';if(!groups.has(k))groups.set(k,[]);groups.get(k).push(i);});
    const codes=(d.entregas||[]).map(e=>`<div style="border:1px solid var(--line);border-radius:10px;padding:12px;margin-top:10px"><b>${this.esc(e.sucursal_nombre)}</b><div style="font-size:12px;color:var(--muted)">Estado: ${this.esc(e.estado)}</div>${e.codigo_recojo?`<div style="font-size:24px;letter-spacing:4px;font-weight:800;text-align:center;background:#f1f5f9;padding:12px;border-radius:8px;margin-top:8px">${this.esc(e.codigo_recojo)}</div><div style="font-size:11px;text-align:center;color:var(--muted)">Muestra el código y tu documento en el local.</div>`:''}</div>`).join('');
    this.showModal(`<div class="modal-head"><h3>${this.esc(d.pedido.numero_orden)}</h3><button class="close-x" onclick="Tienda.cerrarModal()"><i class="ti ti-x"></i></button></div><div class="modal-body">${[...groups.entries()].map(([n,it])=>`<h4 style="margin:12px 0 6px">${this.esc(n)}</h4>${it.map(x=>`<div style="display:flex;justify-content:space-between;font-size:13px;padding:5px 0"><span>${Number(x.cantidad)} × ${this.esc(x.nombre_snapshot)}</span><b>S/ ${Number(x.subtotal).toFixed(2)}</b></div>`).join('')}`).join('')}<hr style="border:0;border-top:1px solid var(--line);margin:15px 0"><div style="display:flex;justify-content:space-between"><b>Total</b><b>S/ ${Number(d.pedido.total).toFixed(2)}</b></div>${d.pedido.rechazo_motivo?`<div style="background:#fef2f2;color:#991b1b;padding:10px;border-radius:8px;margin-top:12px">${this.esc(d.pedido.rechazo_motivo)}</div>`:''}${codes}</div>`,'wide');
  },

  async logout() {
    await fetch(`${API}/auth/logout`, { method:'POST', credentials:'include' });
    this.cliente = null;
    document.getElementById('user-label').textContent = 'Ingresar';
    const btn = document.getElementById('btn-user');
    const ic = btn.querySelector('img') || btn.querySelector('i');
    if (ic) ic.outerHTML = '<i class="ti ti-user"></i>';
    this.cerrarModal();
    this.toast('Sesión cerrada', 'ok');
  },

  // ── UI HELPERS ──
  showModal(html, wide) {
    document.getElementById('modales').innerHTML = `<div class="modal show" id="modal-active"><div class="modal-card ${wide||''}">${html}</div></div>`;
    document.getElementById('modal-active').onclick = (e) => { if (e.target.id === 'modal-active') this.cerrarModal(); };
  },
  cerrarModal() { document.getElementById('modales').innerHTML = ''; },
  cerrarTodo() {
    document.getElementById('cart-drawer').classList.remove('show');
    document.getElementById('overlay').classList.remove('show');
  },
  toast(msg, tipo) {
    const el = document.createElement('div');
    el.className = 'toast ' + (tipo||'');
    el.innerHTML = `<i class="ti ti-${tipo==='ok'?'circle-check':tipo==='err'?'alert-circle':'info-circle'}"></i> ${msg}`;
    document.getElementById('toasts').appendChild(el);
    setTimeout(() => el.remove(), 2800);
  }
};

document.addEventListener('DOMContentLoaded', () => Tienda.init());