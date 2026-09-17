window.init_rentabilidad = async function () {
  const root = document.getElementById('contenido');
  const hoy = new Intl.DateTimeFormat('en-CA',{timeZone:'America/Lima',year:'numeric',month:'2-digit',day:'2-digit'}).format(new Date());
  const mes = hoy.slice(0,7) + '-01';
  const money = n => `S/ ${Number(n||0).toLocaleString('es-PE',{minimumFractionDigits:2,maximumFractionDigits:2})}`;
  const esc = v => String(v??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));

  root.innerHTML = `
    <div class="page-header"><div class="page-header-left"><h2><i class="ti ti-chart-pie-2"></i> Rentabilidad</h2><p>Comprueba si el negocio gana, pierde y qué productos sostienen el resultado.</p></div></div>
    <div class="card" style="padding:16px;margin-bottom:16px"><div style="display:grid;grid-template-columns:1fr 1fr 1fr auto;gap:10px;align-items:end">
      <div class="form-group"><label class="form-label">Desde</label><input class="form-control" type="date" id="ren-desde" value="${mes}" max="${hoy}"></div>
      <div class="form-group"><label class="form-label">Hasta</label><input class="form-control" type="date" id="ren-hasta" value="${hoy}" max="${hoy}"></div>
      <div class="form-group" id="ren-sucursal-wrap"><label class="form-label">Sucursal</label><select class="form-control" id="ren-sucursal"><option value="">Todas</option></select></div>
      <button class="btn btn-primary" id="ren-aplicar"><i class="ti ti-refresh"></i> Aplicar</button>
    </div></div>
    <div id="ren-body"><div class="loading-center"><div class="spinner spinner-lg"></div></div></div>`;

  const sucWrap=document.getElementById('ren-sucursal-wrap');
  if(!window._esGlobal) sucWrap.style.display='none';
  else {
    const d=await Http.get('/sucursales');
    if(d?.ok) document.getElementById('ren-sucursal').innerHTML='<option value="">Todas</option>'+d.sucursales.map(x=>`<option value="${x.id}">${esc(x.nombre)}</option>`).join('');
  }

  function bars(rows, key='margen') {
    if(!rows?.length) return '<div class="empty-state"><i class="ti ti-chart-bar-off"></i><p>Sin datos en el periodo</p></div>';
    const max=Math.max(...rows.map(x=>Number(x[key]||0)),1);
    return rows.slice(0,12).map(x=>`<div style="margin:10px 0"><div style="display:flex;justify-content:space-between;gap:10px;font-size:12px"><b>${esc(x.nombre||x.canal||'—')}</b><span>${money(x[key])}</span></div><div style="height:10px;background:var(--input-bg);border-radius:999px;overflow:hidden;margin-top:5px"><div style="width:${Math.max(2,Number(x[key]||0)/max*100)}%;height:100%;background:linear-gradient(90deg,#16a34a,#0ea5e9);border-radius:999px"></div></div></div>`).join('');
  }

  function lineChart(rows) {
    if(!rows?.length) return '<div class="empty-state"><p>Sin movimiento diario</p></div>';
    const vals=rows.map(x=>Number(x.margen||0)); const max=Math.max(...vals,1); const W=720,H=210,p=28;
    const pts=rows.map((x,i)=>`${p+i*(W-2*p)/Math.max(1,rows.length-1)},${H-p-(Number(x.margen||0)/max)*(H-2*p)}`).join(' ');
    return `<svg viewBox="0 0 ${W} ${H}" style="width:100%;height:230px"><defs><linearGradient id="ren-fill" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#16a34a" stop-opacity=".3"/><stop offset="1" stop-color="#16a34a" stop-opacity="0"/></linearGradient></defs><polyline points="${pts}" fill="none" stroke="#16a34a" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>${rows.map((x,i)=>{const cx=p+i*(W-2*p)/Math.max(1,rows.length-1),cy=H-p-(Number(x.margen||0)/max)*(H-2*p);return `<circle cx="${cx}" cy="${cy}" r="4" fill="#0ea5e9"><title>${esc(x.fecha)} · ${money(x.margen)}</title></circle>`}).join('')}</svg>`;
  }

  async function cargar(){
    const desde=document.getElementById('ren-desde').value, hasta=document.getElementById('ren-hasta').value;
    if(desde>hoy||hasta>hoy) return Swal.fire({icon:'warning',title:'Fecha futura',text:'Solo puedes consultar hasta hoy.'});
    const qs=new URLSearchParams({desde,hasta}); const sid=document.getElementById('ren-sucursal')?.value;if(sid)qs.set('sucursal_id',sid);
    const body=document.getElementById('ren-body');body.innerHTML='<div class="loading-center"><div class="spinner spinner-lg"></div></div>';
    const d=await Http.get('/rentabilidad/resumen?'+qs.toString());
    if(!d?.ok){body.innerHTML=`<div class="empty-state"><i class="ti ti-alert-triangle"></i><p>${esc(d?.msg||'No se pudo cargar')}</p></div>`;return;}
    const k=d.kpis;
    body.innerHTML=`
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(190px,1fr));gap:14px;margin-bottom:16px">
        ${[['Ingresos',money(k.ingresos),'ti-cash','#0ea5e9'],['Costo utilizado',money(k.costo),'ti-package-export','#64748b'],['Margen bruto',money(k.margen_bruto),'ti-trending-up','#16a34a'],['Margen %',Number(k.margen_pct).toFixed(2)+'%','ti-percentage','#7c3aed'],['Egresos',money(k.egresos),'ti-cash-off','#f59e0b'],['Resultado estimado',money(k.resultado_estimado),k.resultado_estimado>=0?'ti-circle-check':'ti-alert-triangle',k.resultado_estimado>=0?'#16a34a':'#dc2626'],['Ticket promedio',money(k.ticket_promedio),'ti-receipt','#0891b2'],['Ventas / unidades',`${k.ventas} / ${k.unidades}`,'ti-shopping-cart','#475569']].map(x=>`<div class="card" style="padding:18px;border-top:4px solid ${x[3]}"><i class="ti ${x[2]}" style="float:right;font-size:25px;color:${x[3]}"></i><div style="font-size:11px;color:var(--texto-muted);text-transform:uppercase;font-weight:700">${x[0]}</div><div style="font-size:24px;font-weight:900;margin-top:7px;color:${x[0]==='Resultado estimado'?(k.resultado_estimado>=0?'var(--success)':'var(--danger)'):'var(--texto-fuerte)'}">${x[1]}</div></div>`).join('')}
      </div>
      <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:14px;margin-bottom:16px">
        ${[['Inversión actual en inventario',money(k.inversion_inventario),'Capital inmovilizado en stock'],['Valor potencial de venta',money(k.valor_venta_inventario),'Valor estimado si se vende el stock'],['Ganancia potencial del inventario',money(k.ganancia_potencial_inventario),'Diferencia entre venta y costo'],['ROI del periodo',Number(k.roi_periodo||0).toFixed(2)+'%','Resultado frente a costo y egresos'],['Punto de equilibrio',money(k.punto_equilibrio),'Ventas necesarias para cubrir egresos'],['Productos críticos',`${k.productos_criticos||0} de ${k.productos_activos||0}`,'Stock igual o menor al mínimo']].map(x=>`<div class="card" style="padding:16px"><div style="font-size:11px;color:var(--texto-muted);text-transform:uppercase;font-weight:800">${x[0]}</div><div style="font-size:22px;font-weight:900;color:var(--texto-fuerte);margin:7px 0">${x[1]}</div><small style="color:var(--texto-muted)">${x[2]}</small></div>`).join('')}
      </div>
      ${k.items_costo_inconsistente?`<div class="card" style="padding:14px;margin-bottom:16px;border-left:5px solid #f59e0b;background:#fffbeb"><b><i class="ti ti-alert-triangle"></i> ${k.items_costo_inconsistente} línea(s) con costo inconsistente</b><p style="font-size:12px;margin-top:5px;color:#92400e">${esc(d.nota_costos)}</p></div>`:''}
      <div style="display:grid;grid-template-columns:2fr 1fr;gap:14px;margin-bottom:16px"><div class="card" style="padding:18px"><h3>Margen diario</h3>${lineChart(d.diario)}</div><div class="card" style="padding:18px"><h3>Margen por canal</h3>${bars(d.canales)}</div></div>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:16px"><div class="card" style="padding:18px"><h3>Productos que más margen generan</h3>${bars(d.productos)}</div><div class="card" style="padding:18px"><h3>Alertas de precio y costo</h3>${d.alertas?.length?`<div class="tabla-container"><table class="tabla"><thead><tr><th>Producto</th><th>Costo</th><th>Venta</th><th>Alerta</th></tr></thead><tbody>${d.alertas.map(x=>`<tr><td><b>${esc(x.nombre)}</b><small style="display:block">${esc(x.sucursal_nombre||'')}</small></td><td>${money(x.precio_costo)}</td><td>${money(x.precio_venta)}</td><td><span class="badge badge-warning">${esc(String(x.tipo).replaceAll('_',' '))}</span></td></tr>`).join('')}</tbody></table></div>`:'<div class="empty-state"><i class="ti ti-circle-check"></i><p>Sin alertas de costos</p></div>'}</div></div>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:16px"><div class="card" style="padding:18px"><h3>Ingresos por medio de pago</h3>${bars((d.medios_pago||[]).map(x=>({...x,nombre:String(x.metodo||'').toUpperCase(),margen:x.monto})))}</div><div class="card" style="padding:18px"><h3>Lectura rápida del negocio</h3><div style="display:grid;gap:10px;font-size:13px"><div class="alert ${k.resultado_estimado>=0?'alert-success':'alert-danger'}" style="margin:0"><b>${k.resultado_estimado>=0?'El periodo genera utilidad':'El periodo genera pérdida'}</b><br>${money(Math.abs(k.resultado_estimado))}</div><div class="alert alert-info" style="margin:0"><b>Margen bruto:</b> ${Number(k.margen_pct||0).toFixed(2)}%. <b>ROI:</b> ${Number(k.roi_periodo||0).toFixed(2)}%.</div><div class="alert alert-warning" style="margin:0"><b>Capital en inventario:</b> ${money(k.inversion_inventario)}. Revisa productos sin rotación y stock crítico.</div></div></div></div>
      ${d.sucursales?.length?`<div class="card" style="padding:18px"><h3>Rentabilidad por sucursal</h3>${bars(d.sucursales)}</div>`:''}`;
  }
  document.getElementById('ren-aplicar').onclick=cargar;
  cargar();
};
