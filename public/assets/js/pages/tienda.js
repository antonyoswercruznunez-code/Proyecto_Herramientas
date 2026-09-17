window.init_tienda = async function () {
  document.getElementById('contenido').innerHTML = await fetch('/views/pages/tienda.html').then(r => r.text());

  const esc = v => String(v ?? '').replace(/[&<>"']/g, c => ({
    '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'
  }[c]));
  const val = id => document.getElementById(id)?.value?.trim() || '';
  const check = id => !!document.getElementById(id)?.checked;
  let data = null;
  const alerta = (icon, title, text = '', timer = 0) => Swal.fire({
    icon, title, text, timer: timer || undefined, showConfirmButton: !timer,
    confirmButtonColor: '#16a34a'
  });
  const imageOk = file => !!file && ['image/jpeg','image/png','image/webp'].includes(file.type) && /\.(jpe?g|png|webp)$/i.test(file.name || '');

  function renderPreview(tipo, ruta) {
    const box = document.getElementById(`td-${tipo}-preview`);
    if (!box) return;
    box.innerHTML = ruta
      ? `<img src="${esc(ruta)}" alt="Imagen de ${esc(tipo)}">`
      : `<span><i class="ti ti-photo-off"></i> Sin imagen configurada</span>`;
    box.dataset.ruta = ruta || '';
  }

  function renderSliders(rows) {
    const root = document.getElementById('td-sliders');
    if (!rows.length) {
      root.innerHTML = '<div class="empty-state" style="grid-column:1/-1"><i class="ti ti-photo-off"></i><p>Sin sliders registrados</p></div>';
      return;
    }
    root.innerHTML = rows.map(x => `
      <article class="card" style="padding:10px">
        <img src="${esc(x.ruta)}" alt="${esc(x.nombre)}" style="width:100%;height:150px;object-fit:cover;border-radius:8px">
        <div style="display:flex;gap:8px;align-items:center;margin-top:8px;flex-wrap:wrap">
          <b style="flex:1;min-width:120px">${esc(x.nombre)}</b>
          <label style="font-size:11px;color:var(--texto-muted)">Orden</label>
          <input type="number" value="${Number(x.orden)||0}" min="0" max="999" style="width:72px" class="form-control" onchange="_tdOrden(${Number(x.id)},this.value)">
          <button class="btn btn-xs ${Number(x.estado)===1?'btn-warning':'btn-success'}" onclick="_tdEstado(${Number(x.id)},${Number(x.estado)===1?0:1})">
            ${Number(x.estado)===1?'Ocultar':'Publicar'}
          </button>
          <button class="btn btn-danger btn-xs" onclick="_tdEliminarSlider(${Number(x.id)})"><i class="ti ti-trash"></i></button>
        </div>
      </article>`).join('');
  }

  async function load() {
    const res = await Http.get('/config');
    if (!res?.ok) {
      alerta('error', 'Error', res?.msg || 'No se pudo cargar la configuración');
      return;
    }
    data = res;
    const c = res.cfg || {};
    renderSliders(res.sliders || []);

    document.getElementById('td-yape-activo').checked = c.yape_activo !== 'false';
    document.getElementById('td-yape-numero').value = c.yape_numero || '';
    document.getElementById('td-yape-titular').value = c.yape_titular || '';
    renderPreview('yape', c.yape_qr_ruta || c.yape_imagen_ruta || '');

    document.getElementById('td-plin-activo').checked = c.plin_activo !== 'false';
    document.getElementById('td-plin-numero').value = c.plin_numero || '';
    document.getElementById('td-plin-titular').value = c.plin_titular || '';
    renderPreview('plin', c.plin_qr_ruta || c.plin_imagen_ruta || '');

    document.getElementById('td-transferencia-activo').checked = c.transferencia_activo !== 'false';
    document.getElementById('td-transferencia-banco').value = c.transferencia_banco || '';
    document.getElementById('td-transferencia-titular').value = c.transferencia_titular || '';
    document.getElementById('td-transferencia-cuenta').value = c.transferencia_cuenta || '';
    document.getElementById('td-transferencia-cci').value = c.transferencia_cci || '';
    renderPreview('transferencia', c.transferencia_imagen_ruta || '');

    document.getElementById('td-izipay-activo').checked = c.izipay_activo === 'true';
    document.getElementById('td-izipay-instrucciones').value = c.izipay_instrucciones || '';
    renderPreview('izipay', c.izipay_imagen_ruta || '');
  }

  async function upload(url, input, key) {
    if (upload.busy) return;
    const element = document.getElementById(input);
    const file = element?.files?.[0];
    if (!imageOk(file)) return alerta('warning', 'Imagen no válida', 'Selecciona únicamente JPG, PNG o WEBP');
    const fd = new FormData();
    fd.append(key, file);
    upload.busy = true;
    const result = await Http.postForm(url, fd);
    upload.busy = false;
    if (!result?.ok) return alerta('error', 'Error', result?.msg || 'No se pudo subir');
    element.value = '';
    alerta('success', 'Imagen guardada', result.msg || '', 1500);
    await load();
  }

  document.getElementById('td-slider-form').addEventListener('submit', e => {
    e.preventDefault();
    upload('/config/slider', 'td-slider', 'slider');
  });

  document.getElementById('td-guardar-pagos').addEventListener('click', async () => {
    const payload = {
      yape_activo: String(check('td-yape-activo')),
      yape_numero: val('td-yape-numero'),
      yape_titular: val('td-yape-titular'),
      plin_activo: String(check('td-plin-activo')),
      plin_numero: val('td-plin-numero'),
      plin_titular: val('td-plin-titular'),
      transferencia_activo: String(check('td-transferencia-activo')),
      transferencia_banco: val('td-transferencia-banco'),
      transferencia_titular: val('td-transferencia-titular'),
      transferencia_cuenta: val('td-transferencia-cuenta'),
      transferencia_cci: val('td-transferencia-cci'),
      izipay_activo: String(check('td-izipay-activo')),
      izipay_instrucciones: val('td-izipay-instrucciones')
    };
    if (payload.yape_activo === 'true' && !payload.yape_numero && !document.getElementById('td-yape-preview').dataset.ruta)
      return alerta('warning', 'Yape incompleto', 'Ingresa un número o sube una imagen');
    if (payload.plin_activo === 'true' && !payload.plin_numero && !document.getElementById('td-plin-preview').dataset.ruta)
      return alerta('warning', 'Plin incompleto', 'Ingresa un número o sube una imagen');
    if (payload.transferencia_activo === 'true' && !payload.transferencia_cuenta && !payload.transferencia_cci)
      return alerta('warning', 'Transferencia incompleta', 'Ingresa una cuenta o CCI');

    const btn = document.getElementById('td-guardar-pagos');
    btn.disabled = true;
    const res = await Http.post('/config/medios-pago', payload);
    btn.disabled = false;
    if (!res?.ok) return alerta('error', 'Error', res?.msg || 'No se pudo guardar');
    alerta('success', 'Guardado', 'Los medios de pago ya están disponibles en el checkout', 1800);
    await load();
  });

  window._tdSubirPago = async tipo => {
    const input = document.getElementById(`td-${tipo}-file`);
    const file = input?.files?.[0];
    if (!imageOk(file)) return alerta('warning', 'Imagen no válida', 'Selecciona únicamente JPG, PNG o WEBP');
    const fd = new FormData();
    fd.append('imagen_pago', file);
    fd.append('tipo', tipo);
    const res = await Http.postForm('/config/metodo-pago-imagen', fd);
    if (!res?.ok) return alerta('error', 'Error', res?.msg || 'No se pudo subir');
    input.value = '';
    alerta('success', 'Imagen guardada', '', 1400);
    await load();
  };

  window._tdEliminarPago = async tipo => {
    const preview = document.getElementById(`td-${tipo}-preview`);
    if (!preview?.dataset?.ruta) return;
    const c = await Swal.fire({title:'¿Quitar esta imagen?',icon:'warning',showCancelButton:true,confirmButtonText:'Sí, quitar',cancelButtonText:'Cancelar'});
    if (!c.isConfirmed) return;
    const res = await Http.delete(`/config/metodo-pago-imagen/${encodeURIComponent(tipo)}`);
    if (!res?.ok) return alerta('error', 'Error', res?.msg || 'No se pudo eliminar');
    await load();
  };

  window._tdEstado = async (id, estado) => {
    const r = await Http.patch(`/config/slider/${id}/estado`, { estado });
    if (!r?.ok) return alerta('error', 'Error', r?.msg || 'No se pudo cambiar');
    await load();
  };
  window._tdOrden = async (id, orden) => {
    const r = await Http.patch(`/config/slider/${id}/orden`, { orden: Number(orden) });
    if (!r?.ok) alerta('error', 'Error', r?.msg || 'No se pudo ordenar');
  };
  window._tdEliminarSlider = async id => {
    const c = await Swal.fire({title:'¿Eliminar slider?',icon:'warning',showCancelButton:true,confirmButtonText:'Sí, eliminar',cancelButtonText:'Cancelar'});
    if (!c.isConfirmed) return;
    const r = await Http.delete(`/config/slider/${id}`);
    if (!r?.ok) return alerta('error', 'Error', r?.msg || 'No se pudo eliminar');
    await load();
  };

  await load();
};
