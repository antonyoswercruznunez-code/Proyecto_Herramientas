window.init_recojo = async function initRecojo() {
  document.getElementById('contenido').innerHTML = await fetch('/views/pages/recojo.html').then((r) => r.text());

  const esc = (value) => String(value ?? '').replace(/[&<>"']/g, (char) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'
  }[char]));
  const today = () => new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Lima', year: 'numeric', month: '2-digit', day: '2-digit'
  }).format(new Date());
  const statusLabel = {
    pendiente: 'Pendiente', preparando: 'Preparando', listo: 'Listo', en_ruta: 'En ruta',
    incidencia: 'Con incidencia', entregado: 'Entregado', cancelado: 'Cancelado'
  };
  const statusClass = (status) => status === 'entregado' ? 'badge-success'
    : status === 'incidencia' ? 'badge-danger'
      : status === 'listo' || status === 'en_ruta' ? 'badge-info' : 'badge-warning';
  let rows = [];

  async function load() {
    const query = new URLSearchParams();
    const estado = document.getElementById('rc-estado').value;
    const tipo = document.getElementById('rc-tipo').value;
    const buscar = document.getElementById('rc-buscar').value.trim();
    if (estado) query.set('estado', estado);
    if (tipo) query.set('tipo', tipo);
    if (buscar) query.set('buscar', buscar);
    const response = await Http.get(`/recojo?${query}`);
    rows = response?.entregas || [];
    render();
  }

  function nextButtons(row) {
    const buttons = [`<button class="btn btn-outline btn-xs" onclick="_rcDetalle(${row.id})" title="Ver detalle"><i class="ti ti-eye"></i></button>`];
    if (row.estado === 'pendiente') {
      buttons.push(`<button class="btn btn-info btn-xs" onclick="_rcEstado(${row.id},'preparando')"><i class="ti ti-package"></i> Preparar</button>`);
    } else if (row.estado === 'preparando') {
      buttons.push(`<button class="btn btn-success btn-xs" onclick="_rcEstado(${row.id},'listo')"><i class="ti ti-check"></i> ${row.tipo_entrega === 'recojo' ? 'Listo para recojo' : 'Listo para despacho'}</button>`);
    } else if (row.estado === 'listo' && row.tipo_entrega === 'delivery') {
      buttons.push(`<button class="btn btn-info btn-xs" onclick="_rcEstado(${row.id},'en_ruta')"><i class="ti ti-truck-delivery"></i> Iniciar ruta</button>`);
    } else if (row.estado === 'en_ruta' && row.tipo_entrega === 'delivery') {
      buttons.push(`<button class="btn btn-success btn-xs" onclick="_rcEntregaDelivery(${row.id})"><i class="ti ti-map-pin-check"></i> Confirmar entrega</button>`);
    }
    if (row.tipo_entrega === 'recojo' && !['entregado', 'cancelado'].includes(row.estado)) {
      buttons.push(`<button class="btn btn-outline btn-xs" onclick="_rcReprogramar(${row.id},${row.sucursal_id})"><i class="ti ti-calendar-time"></i> Reprogramar</button>`);
    }
    if (!['entregado', 'cancelado'].includes(row.estado)) {
      buttons.push(`<button class="btn btn-danger btn-xs" onclick="_rcIncidencia(${row.id})" title="Registrar incidencia"><i class="ti ti-alert-triangle"></i></button>`);
    }
    return buttons.join('');
  }

  function render() {
    const tbody = document.getElementById('rc-tbody');
    tbody.innerHTML = rows.length ? rows.map((row) => `
      <tr>
        <td><b>${esc(row.numero_orden)}</b><br><small>${esc(row.venta_numero || 'Sin nota')}</small></td>
        <td>${esc(row.cliente_nombre || 'Cliente web')}<br><small>${esc(row.cliente_doc || '')}</small></td>
        <td>${esc(row.sucursal_nombre)}</td>
        <td><span class="delivery-chip ${row.tipo_entrega === 'recojo' ? 'pickup' : 'delivery'}"><i class="ti ${row.tipo_entrega === 'recojo' ? 'ti-building-store' : 'ti-truck-delivery'}"></i> ${row.tipo_entrega === 'recojo' ? 'Recojo' : 'Delivery'}</span></td>
        <td><span class="badge ${statusClass(row.estado)}">${esc(statusLabel[row.estado] || row.estado)}</span></td>
        <td>${row.recojo_fecha ? `${esc(row.recojo_fecha)}<br><small>${esc(row.recojo_hora_inicio || '')}–${esc(row.recojo_hora_fin || '')}</small>` : '—'}</td>
        <td><div class="action-cluster">${nextButtons(row)}</div></td>
      </tr>`).join('') : '<tr><td colspan="7"><div class="empty-state"><i class="ti ti-package-off"></i><p>No existen pedidos para los filtros seleccionados.</p></div></td></tr>';
  }

  window._rcEstado = async (id, estado, observacion = '') => {
    const response = await Http.patch(`/recojo/${id}/estado`, { estado, observacion });
    await Swal.fire(response?.ok ? 'Actualizado' : 'Error', response?.msg || '', response?.ok ? 'success' : 'error');
    if (response?.ok) await load();
  };

  window._rcIncidencia = async (id) => {
    const result = await Swal.fire({
      title: 'Registrar incidencia',
      text: 'Describe claramente qué ocurrió para que quede registrado en el expediente.',
      input: 'textarea', inputPlaceholder: 'Ej. El cliente no se encontraba en la dirección...',
      showCancelButton: true, confirmButtonText: 'Guardar incidencia',
      inputValidator: (value) => String(value || '').trim().length < 5 ? 'Describe la incidencia con al menos 5 caracteres.' : undefined
    });
    if (result.isConfirmed) await window._rcEstado(id, 'incidencia', result.value);
  };

  window._rcEntregaDelivery = async (id) => {
    const result = await Swal.fire({
      title: 'Confirmar entrega por delivery',
      html: '<input id="rc-recibe" class="swal2-input" placeholder="Persona que recibe"><input id="rc-doc" class="swal2-input" inputmode="numeric" placeholder="Documento (opcional)"><textarea id="rc-obs" class="swal2-textarea" placeholder="Observación (opcional)"></textarea>',
      showCancelButton: true, confirmButtonText: 'Confirmar entrega',
      preConfirm: () => ({
        persona_recibe: document.getElementById('rc-recibe').value.trim(),
        documento_recibe: document.getElementById('rc-doc').value.replace(/\D/g, ''),
        observacion: document.getElementById('rc-obs').value.trim()
      })
    });
    if (!result.isConfirmed) return;
    const response = await Http.patch(`/recojo/${id}/estado`, { estado: 'entregado', ...result.value });
    await Swal.fire(response?.ok ? 'Entrega registrada' : 'Error', response?.msg || '', response?.ok ? 'success' : 'error');
    if (response?.ok) await load();
  };

  window._rcDetalle = async (id) => {
    const response = await Http.get(`/recojo/${id}`);
    if (!response?.ok) return Swal.fire('Error', response?.msg || 'No se pudo cargar el expediente.', 'error');
    const delivery = response.entrega || {};
    const client = response.cliente || {};
    const items = response.items || [];
    const name = client.razon_social || client.nombre_completo || [client.nombres || client.nombre, client.apellido_paterno, client.apellido_materno].filter(Boolean).join(' ') || 'Cliente web';
    const address = client.direccion_entrega || client.direccion || delivery.direccion_entrega || 'No registrada';
    const itemRows = items.map((item) => `<tr><td>${esc(item.producto)}</td><td>${Number(item.cantidad)}</td><td>S/ ${Number(item.precio_unit || 0).toFixed(2)}</td><td>S/ ${Number(item.subtotal || 0).toFixed(2)}</td><td>${Number(item.stock_actual ?? 0)}</td></tr>`).join('');
    await Swal.fire({
      title: `Expediente ${esc(delivery.numero_orden || '')}`,
      width: 900,
      html: `<div class="pickup-detail">
        <div class="pickup-detail-grid">
          <section><span>Comprador</span><b>${esc(name)}</b><small>${esc(client.tipo_doc || '')} ${esc(client.numero_doc || '')}</small></section>
          <section><span>Contacto</span><b>${esc(client.telefono || 'Sin teléfono')}</b><small>${esc(client.email || 'Sin correo')}</small></section>
          <section><span>Sucursal</span><b>${esc(delivery.sucursal_nombre || '')}</b><small>${esc(delivery.tipo_entrega || '')}</small></section>
          <section><span>Estado</span><b>${esc(statusLabel[delivery.estado] || delivery.estado)}</b><small>Nota: ${esc(delivery.venta_numero || 'Pendiente')}</small></section>
        </div>
        <div class="pickup-address"><i class="ti ti-map-pin"></i><div><b>Dirección o punto de entrega</b><p>${esc(address)}</p></div></div>
        <div class="tabla-container"><table class="tabla"><thead><tr><th>Producto</th><th>Cant.</th><th>Precio</th><th>Subtotal</th><th>Stock actual</th></tr></thead><tbody>${itemRows || '<tr><td colspan="5">Sin productos registrados.</td></tr>'}</tbody></table></div>
        ${delivery.observacion ? `<div class="incident-note"><b>Observación o incidencia</b><p>${esc(delivery.observacion)}</p></div>` : ''}
      </div>`,
      confirmButtonText: 'Cerrar'
    });
  };

  const codeInput = document.getElementById('rc-codigo');
  codeInput.addEventListener('input', () => {
    let clean = codeInput.value.toUpperCase().replace(/[^A-Z0-9]/g, '').slice(0, 8);
    if (clean.length > 4) clean = `${clean.slice(0, 4)}-${clean.slice(4)}`;
    codeInput.value = clean;
  });
  document.getElementById('rc-verificar').onclick = async () => {
    const codigo = codeInput.value.trim().toUpperCase();
    const response = await Http.post('/recojo/verificar-codigo', { codigo });
    const root = document.getElementById('rc-codigo-info');
    if (!response?.ok) {
      root.innerHTML = `<span class="code-error"><i class="ti ti-circle-x"></i> ${esc(response?.msg || 'Código inválido')}</span>`;
      return;
    }
    const delivery = response.entrega;
    root.innerHTML = `<div class="verified-code"><i class="ti ti-circle-check"></i><div><b>${esc(delivery.cliente_nombre)}</b><small>${esc(delivery.cliente_doc)} · ${esc(delivery.numero_orden)} · ${esc(delivery.sucursal_nombre)}</small></div><span class="badge badge-info">${esc(statusLabel[delivery.estado] || delivery.estado)}</span>${response.puede_entregar ? `<button class="btn btn-success btn-sm" onclick="_rcEntregar('${esc(codigo)}')">Confirmar entrega</button>` : ''}</div>`;
  };

  window._rcEntregar = async (codigo) => {
    const result = await Swal.fire({
      title: 'Confirmar recojo en tienda',
      html: '<input id="sw-r" class="swal2-input" placeholder="Persona que recibe"><input id="sw-d" class="swal2-input" inputmode="numeric" placeholder="DNI opcional"><textarea id="sw-o" class="swal2-textarea" placeholder="Observación opcional"></textarea>',
      showCancelButton: true, confirmButtonText: 'Entregar pedido',
      preConfirm: () => ({
        persona_recibe: document.getElementById('sw-r').value.trim(),
        documento_recibe: document.getElementById('sw-d').value.replace(/\D/g, ''),
        observacion: document.getElementById('sw-o').value.trim()
      })
    });
    if (!result.isConfirmed) return;
    const response = await Http.post('/recojo/entregar', { codigo, ...result.value });
    await Swal.fire(response?.ok ? 'Pedido entregado' : 'Error', response?.msg || '', response?.ok ? 'success' : 'error');
    if (response?.ok) {
      document.getElementById('rc-codigo-info').innerHTML = '';
      codeInput.value = '';
      await load();
    }
  };

  window._rcReprogramar = async (id, sucursalId) => {
    const response = await Http.get('/recojo-horarios');
    const schedules = (response?.horarios || []).filter((schedule) => Number(schedule.sucursal_id) === Number(sucursalId)
      && Number(schedule.estado) === 0 && Number(schedule.cupos_usados) < Number(schedule.cupos_total) && String(schedule.fecha) >= today());
    if (!schedules.length) return Swal.fire('Sin horarios', 'No hay horarios activos con cupo para esta sucursal.', 'info');
    const result = await Swal.fire({
      title: 'Reprogramar recojo', input: 'select',
      inputOptions: Object.fromEntries(schedules.map((schedule) => [schedule.id, `${schedule.fecha} · ${schedule.hora_inicio}–${schedule.hora_fin} · ${Number(schedule.cupos_total) - Number(schedule.cupos_usados)} cupos`])),
      showCancelButton: true, confirmButtonText: 'Reprogramar'
    });
    if (!result.isConfirmed) return;
    const saved = await Http.patch(`/recojo/${id}/reprogramar`, { horario_id: Number(result.value) });
    await Swal.fire(saved?.ok ? 'Recojo reprogramado' : 'Error', saved?.msg || '', saved?.ok ? 'success' : 'error');
    if (saved?.ok) { await load(); await loadHorarios(); }
  };

  async function loadHorarios() {
    const response = await Http.get('/recojo-horarios');
    const root = document.getElementById('rc-h-tbody');
    if (!root) return;
    if (!response?.ok) { document.getElementById('rc-horarios-card').style.display = 'none'; return; }
    const schedules = response.horarios || [];
    root.innerHTML = schedules.length ? schedules.map((schedule) => `
      <tr><td>${esc(schedule.sucursal_nombre)}</td><td>${esc(schedule.fecha)}</td><td>${esc(schedule.hora_inicio)}–${esc(schedule.hora_fin)}</td><td>${Number(schedule.cupos_usados)}/${Number(schedule.cupos_total)}</td><td><span class="badge ${Number(schedule.estado) === 0 ? 'badge-success' : 'badge-muted'}">${Number(schedule.estado) === 0 ? 'Activo' : 'Inactivo'}</span></td><td><button class="btn btn-outline btn-xs" onclick="_rcToggleHorario(${Number(schedule.id)},${Number(schedule.estado)},'${esc(schedule.fecha)}','${esc(schedule.hora_inicio)}','${esc(schedule.hora_fin)}',${Number(schedule.cupos_total)})">${Number(schedule.estado) === 0 ? 'Desactivar' : 'Activar'}</button> <button class="btn btn-danger btn-xs" onclick="_rcDeleteHorario(${Number(schedule.id)})"><i class="ti ti-trash"></i></button></td></tr>`).join('') : '<tr><td colspan="6"><div class="empty-state"><p>Sin horarios configurados.</p></div></td></tr>';
  }

  async function loadSucursales() {
    const response = await Http.get('/sucursales');
    const select = document.getElementById('rc-h-sucursal');
    if (select) select.innerHTML = (response?.sucursales || []).map((branch) => `<option value="${Number(branch.id)}">${esc(branch.nombre)}</option>`).join('');
  }

  window._rcToggleHorario = async (id, estado, fecha, inicio, fin, cupos) => {
    const response = await Http.put(`/recojo-horarios/${id}`, { fecha, hora_inicio: inicio, hora_fin: fin, cupos_total: cupos, estado: estado === 0 ? 1 : 0 });
    await Swal.fire(response?.ok ? 'Actualizado' : 'Error', response?.msg || '', response?.ok ? 'success' : 'error');
    if (response?.ok) await loadHorarios();
  };
  window._rcDeleteHorario = async (id) => {
    const result = await Swal.fire({ title: '¿Eliminar horario?', text: 'Solo se eliminará si no tiene reservas activas.', icon: 'warning', showCancelButton: true, confirmButtonText: 'Eliminar' });
    if (!result.isConfirmed) return;
    const response = await Http.delete(`/recojo-horarios/${id}`);
    await Swal.fire(response?.ok ? 'Eliminado' : 'Error', response?.msg || '', response?.ok ? 'success' : 'error');
    if (response?.ok) await loadHorarios();
  };

  const dateInput = document.getElementById('rc-h-fecha');
  dateInput.min = today();
  dateInput.value = today();
  dateInput.addEventListener('change', () => {
    if (dateInput.value < today()) dateInput.value = today();
  });
  document.getElementById('rc-h-crear').onclick = async () => {
    const body = {
      sucursal_id: Number(document.getElementById('rc-h-sucursal').value),
      fecha: dateInput.value,
      hora_inicio: document.getElementById('rc-h-inicio').value,
      hora_fin: document.getElementById('rc-h-fin').value,
      cupos_total: Number(document.getElementById('rc-h-cupos').value)
    };
    if (body.fecha < today()) return Swal.fire('Fecha inválida', 'No puedes crear horarios en fechas pasadas.', 'warning');
    if (!body.hora_inicio || !body.hora_fin || body.hora_inicio >= body.hora_fin) return Swal.fire('Horario inválido', 'La hora final debe ser posterior a la hora inicial.', 'warning');
    const response = await Http.post('/recojo-horarios', body);
    await Swal.fire(response?.ok ? 'Horario creado' : 'Error', response?.msg || '', response?.ok ? 'success' : 'error');
    if (response?.ok) await loadHorarios();
  };

  document.getElementById('rc-estado').onchange = load;
  document.getElementById('rc-tipo').onchange = load;
  document.getElementById('rc-buscar').oninput = () => { clearTimeout(window._rcTimer); window._rcTimer = setTimeout(load, 300); };
  document.getElementById('rc-refrescar').onclick = load;
  await load();
  await loadSucursales();
  await loadHorarios();
};
