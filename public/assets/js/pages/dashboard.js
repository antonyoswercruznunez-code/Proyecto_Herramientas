window.init_dashboard = async function () {
  const root = document.getElementById('contenido');
  const hoy = new Intl.DateTimeFormat('en-CA',{timeZone:'America/Lima',year:'numeric',month:'2-digit',day:'2-digit'}).format(new Date());
  const mes = `${hoy.slice(0,7)}-01`;
  const money = n => `S/ ${Number(n||0).toLocaleString('es-PE',{minimumFractionDigits:2,maximumFractionDigits:2})}`;
  const esc = v => String(v??'').replace(/[&<>'"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));

  if(!document.getElementById('dash-v45-style')){
    const st=document.createElement('style');st.id='dash-v45-style';st.textContent=`
      .d45-filter{display:grid;grid-template-columns:1fr 1fr 1fr auto;gap:10px;align-items:end;padding:16px;margin-bottom:16px}
      .d45-kpis{display:grid;grid-template-columns:repeat(auto-fit,minmax(185px,1fr));gap:13px;margin-bottom:16px}
      .d45-kpi{position:relative;overflow:hidden;padding:18px;border:1px solid var(--card-border);background:var(--card-bg);border-radius:15px;box-shadow:0 5px 20px rgba(15,23,42,.04)}
      .d45-kpi:after{content:'';position:absolute;right:-20px;bottom:-26px;width:95px;height:95px;border-radius:50%;background:var(--ksoft,#dcfce7)}
      .d45-kpi i{position:relative;z-index:1;float:right;font-size:25px;color:var(--kcol,#16a34a)}
      .d45-kpi .label{font-size:11px;text-transform:uppercase;letter-spacing:.5px;font-weight:800;color:var(--texto-muted)}
      .d45-kpi .value{position:relative;z-index:1;font-size:24px;font-weight:900;color:var(--texto-fuerte);margin-top:7px}
      .d45-kpi .detail{position:relative;z-index:1;font-size:11px;color:var(--texto-muted);margin-top:5px}
      .d45-grid2{display:grid;grid-template-columns:2fr 1fr;gap:14px;margin-bottom:16px}.d45-grid-eq{display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:16px}
      .d45-card{padding:18px;background:var(--card-bg);border:1px solid var(--card-border);border-radius:15px;box-shadow:0 5px 20px rgba(15,23,42,.035)}
      .d45-card h3{font-size:14px;margin:0 0 14px;display:flex;align-items:center;gap:8px}.d45-card h3 i{color:#16a34a;font-size:19px}
      .d45-bar{margin:10px 0}.d45-bar-head{display:flex;justify-content:space-between;gap:8px;font-size:12px}.d45-track{height:11px;background:var(--input-bg);border-radius:999px;overflow:hidden;margin-top:5px}.d45-fill{height:100%;background:linear-gradient(90deg,#16a34a,#0ea5e9);border-radius:999px}
      .d45-alert{display:flex;gap:10px;align-items:flex-start;padding:10px 0;border-bottom:1px solid var(--card-border);font-size:12px}.d45-alert:last-child{border-bottom:0}
      .d45-shortcuts{display:flex;gap:9px;flex-wrap:wrap;margin-bottom:16px}.d45-shortcuts button{flex:1;min-width:145px;border:1px solid var(--card-border);background:var(--card-bg);border-radius:12px;padding:12px;font-weight:700;color:var(--texto-fuerte);transition:.2s}.d45-shortcuts button:hover{transform:translateY(-2px);border-color:#16a34a}.d45-shortcuts i{color:#16a34a;margin-right:5px}
      @media(max-width:900px){.d45-filter{grid-template-columns:1fr 1fr}.d45-grid2,.d45-grid-eq{grid-template-columns:1fr}}@media(max-width:560px){.d45-filter{grid-template-columns:1fr}}
    `;document.head.appendChild(st);
  }

  root.innerHTML=`
    <div class="page-header"><div class="page-header-left"><h2><i class="ti ti-layout-dashboard"></i> Dashboard de gestión</h2><p>Indicadores comerciales, operaciones, alertas y rentabilidad para tomar decisiones.</p></div></div>
    <div class="card d45-filter">
      <div class="form-group"><label class="form-label">Desde</label><input id="dash-desde" class="form-control" type="date" value="${mes}" max="${hoy}"></div>
      <div class="form-group"><label class="form-label">Hasta</label><input id="dash-hasta" class="form-control" type="date" value="${hoy}" max="${hoy}"></div>
      <div class="form-group" id="dash-sucursal-wrap"><label class="form-label">Sucursal</label><select id="dash-sucursal" class="form-control"><option value="">Todas</option></select></div>
      <button id="dash-aplicar" class="btn btn-primary"><i class="ti ti-filter"></i> Aplicar</button>
    </div>
    <div class="d45-shortcuts">
      <button onclick="Router.navegar('ventas')"><i class="ti ti-shopping-cart-plus"></i>Nueva venta</button>
      <button onclick="Router.navegar('pagos')"><i class="ti ti-credit-card"></i>Pagos web</button>
      <button onclick="Router.navegar('inventario')"><i class="ti ti-package"></i>Inventario</button>
      <button onclick="Router.navegar('logistica')"><i class="ti ti-truck-delivery"></i>Distribución</button>
      <button onclick="Router.navegar('rentabilidad')"><i class="ti ti-chart-pie-2"></i>Rentabilidad</button>
    </div>
    <div id="dash-body"><div class="loading-center"><div class="spinner spinner-lg"></div></div></div>`;

  if(!window._esGlobal)document.getElementById('dash-sucursal-wrap').style.display='none';
  else {const s=await Http.get('/sucursales');if(s?.ok)document.getElementById('dash-sucursal').innerHTML='<option value="">Todas</option>'+s.sucursales.map(x=>`<option value="${x.id}">${esc(x.nombre)}</option>`).join('');}

  function bars(rows,name='nombre',value='total',formatter=money){
    if(!rows?.length)return '<div class="empty-state"><p>Sin datos en el periodo</p></div>';
    const max=Math.max(...rows.map(x=>Number(x[value]||0)),1);
    return rows.slice(0,10).map(x=>`<div class="d45-bar"><div class="d45-bar-head"><b title="${esc(x[name]||'')}">${esc(x[name]||'—')}</b><span>${formatter(x[value],x)}</span></div><div class="d45-track"><div class="d45-fill" style="width:${Math.max(2,Number(x[value]||0)/max*100).toFixed(1)}%"></div></div></div>`).join('');
  }
  function lineChart(rows){
    if(!rows?.length)return '<div class="empty-state"><p>Sin ventas</p></div>';
    const W=760,H=230,p=32,max=Math.max(...rows.map(x=>Number(x.total||0)),1);const X=i=>p+i*(W-2*p)/Math.max(1,rows.length-1),Y=v=>H-p-Number(v||0)/max*(H-2*p);const pts=rows.map((x,i)=>`${X(i)},${Y(x.total)}`).join(' ');
    return `<svg viewBox="0 0 ${W} ${H}" style="width:100%;height:250px"><defs><linearGradient id="d45g" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#16a34a" stop-opacity=".3"/><stop offset="1" stop-color="#16a34a" stop-opacity="0"/></linearGradient></defs><polygon points="${p},${H-p} ${pts} ${W-p},${H-p}" fill="url(#d45g)"/><polyline points="${pts}" fill="none" stroke="#16a34a" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>${rows.map((x,i)=>`<circle cx="${X(i)}" cy="${Y(x.total)}" r="4" fill="#0ea5e9"><title>${esc(x.fecha)} · ${money(x.total)} · ${x.n} ventas</title></circle>`).join('')}${rows.map((x,i)=>i%Math.ceil(rows.length/7||1)===0?`<text x="${X(i)}" y="${H-8}" text-anchor="middle" font-size="9" fill="#64748b">${esc(x.fecha.slice(5))}</text>`:'').join('')}</svg>`;
  }
  function donut(rows){
    const total=(rows||[]).reduce((a,x)=>a+Number(x.s||x.total||0),0);if(!total)return '<div class="empty-state"><p>Sin pagos</p></div>';const cols=['#16a34a','#0ea5e9','#7c3aed','#f59e0b','#ec4899','#64748b'];let acc=0;const seg=[];rows.forEach((x,i)=>{const start=acc/total*360;acc+=Number(x.s||x.total||0);seg.push(`${cols[i%cols.length]} ${start}deg ${acc/total*360}deg`)});return `<div style="display:flex;align-items:center;gap:18px;flex-wrap:wrap"><div style="width:145px;height:145px;border-radius:50%;background:conic-gradient(${seg.join(',')});position:relative"><div style="position:absolute;inset:30px;background:var(--card-bg);border-radius:50%;display:flex;align-items:center;justify-content:center;text-align:center;font-size:12px;font-weight:800">${money(total)}</div></div><div style="flex:1">${rows.map((x,i)=>`<div style="display:flex;justify-content:space-between;gap:8px;font-size:12px;margin:7px 0"><span><i style="display:inline-block;width:10px;height:10px;border-radius:3px;background:${cols[i%cols.length]};margin-right:6px"></i>${esc(x.m||x.canal||'Otro')}</span><b>${money(x.s||x.total)}</b></div>`).join('')}</div></div>`;
  }
  function kpi(label,value,detail,icon,col,soft){return `<div class="d45-kpi" style="--kcol:${col};--ksoft:${soft}"><i class="ti ${icon}"></i><div class="label">${label}</div><div class="value">${value}</div><div class="detail">${detail}</div></div>`;}

  async function cargar(){
    const desde=document.getElementById('dash-desde').value,hasta=document.getElementById('dash-hasta').value;if(desde>hoy||hasta>hoy)return Swal.fire({icon:'warning',title:'Fecha futura',text:'El dashboard solo permite consultar hasta hoy.'});
    const qs=new URLSearchParams({desde,hasta});const sid=document.getElementById('dash-sucursal')?.value;if(sid)qs.set('sucursal_id',sid);const body=document.getElementById('dash-body');body.innerHTML='<div class="loading-center"><div class="spinner spinner-lg"></div></div>';
    const d=await Http.get('/dashboard/resumen?'+qs.toString());if(!d?.ok){body.innerHTML=`<div class="card empty-state"><i class="ti ti-alert-triangle"></i><p>${esc(d?.msg||'No se pudo cargar')}</p></div>`;return;}
    const k=d.kpis,r=d.rentabilidad,trend=Number(k.variacionVentas||0);
    const channelMap=Object.fromEntries((d.canales||[]).map(x=>[x.canal,x]));
    const alertas=[];if(k.stockBajo)alertas.push(['Stock bajo',`${k.stockBajo} producto(s) requieren atención`,'inventario']);if(k.pagosPendientes)alertas.push(['Pagos web',`${k.pagosPendientes} pago(s) pendientes u observados`,'pagos']);if(k.comprobantesRevisar)alertas.push(['SUNAT',`${k.comprobantesRevisar} comprobante(s) por revisar`,'comprobantes']);if(k.cajasAbiertas)alertas.push(['Cajas abiertas',`${k.cajasAbiertas} turno(s) siguen abiertos`,'cajas']);if(k.incidenciasEntrega)alertas.push(['Incidencias de entrega',`${k.incidenciasEntrega} caso(s) requieren seguimiento`,'logistica']);
    body.innerHTML=`
      <div class="d45-kpis">
        ${kpi('Ventas del periodo',money(k.ventasMesMonto),`${k.ventasMesCount} ventas · ${trend>=0?'+':''}${trend.toFixed(1)}% vs anterior`,'ti-cash','#16a34a','#dcfce7')}
        ${kpi('Ventas de hoy',money(k.ventasHoyMonto),`${k.ventasHoyCount} operaciones`,'ti-calendar-dollar','#0ea5e9','#e0f2fe')}
        ${kpi('Ticket promedio',money(k.ticketPromedio),'Monto promedio por venta','ti-receipt','#7c3aed','#ede9fe')}
        ${kpi('Web',money(channelMap.web?.total),`${channelMap.web?.n||0} ventas aprobadas`,'ti-world-www','#0891b2','#cffafe')}
        ${kpi('Presencial',money(channelMap.presencial?.total),`${channelMap.presencial?.n||0} ventas`,'ti-building-store','#f59e0b','#fef3c7')}
        ${kpi('Cotizaciones',`${Number(k.conversionCotizaciones||0).toFixed(1)}%`,`${k.cotizaciones} creadas · conversión`,'ti-file-percent','#ec4899','#fce7f3')}
        ${kpi('Entregas activas',k.entregasActivas,`${k.incidenciasEntrega} incidencia(s)`,'ti-truck-delivery','#0284c7','#e0f2fe')}
        ${kpi('Productos críticos',k.stockBajo,`${k.productos} productos activos`,'ti-package','#dc2626','#fee2e2')}
        ${r?kpi('Margen bruto',money(r.margen_bruto),`${Number(r.margen_pct||0).toFixed(2)}%${r.inconsistencias?` · ${r.inconsistencias} costo(s) por revisar`:''}`,'ti-trending-up','#16a34a','#dcfce7'):''}
      </div>
      ${r?.inconsistencias?`<div class="d45-card" style="margin-bottom:16px;border-left:5px solid #f59e0b;background:#fffbeb"><b><i class="ti ti-alert-triangle"></i> Datos de costo por corregir</b><p style="font-size:12px;color:#92400e;margin-top:5px">${esc(r.nota)}</p></div>`:''}
      <div class="d45-grid2"><div class="d45-card"><h3><i class="ti ti-chart-line"></i>Evolución de ventas</h3>${lineChart(d.serie14)}</div><div class="d45-card"><h3><i class="ti ti-wallet"></i>Métodos de pago</h3>${donut(d.metodos)}</div></div>
      <div class="d45-grid-eq"><div class="d45-card"><h3><i class="ti ti-trophy"></i>Productos más vendidos</h3>${bars(d.topProductos,'nombre','cant',(v)=>`${v} u.`)}</div><div class="d45-card"><h3><i class="ti ti-clock-hour-4"></i>Horas con más movimiento</h3>${bars((d.horas||[]).map(x=>({...x,nombre:`${String(x.hora).padStart(2,'0')}:00`})),'nombre','total',money)}</div></div>
      <div class="d45-grid-eq"><div class="d45-card"><h3><i class="ti ti-bell-ringing"></i>Centro de alertas</h3>${alertas.length?alertas.map(a=>`<button class="d45-alert" onclick="Router.navegar('${a[2]}')" style="width:100%;border:0;background:transparent;text-align:left;cursor:pointer"><i class="ti ti-alert-circle" style="color:#f59e0b;font-size:19px"></i><span><b>${a[0]}</b><small style="display:block;color:var(--texto-muted);margin-top:2px">${a[1]}</small></span></button>`).join(''):'<div class="empty-state"><i class="ti ti-circle-check" style="color:#16a34a"></i><p>Sin alertas críticas</p></div>'}</div><div class="d45-card"><h3><i class="ti ti-history"></i>Últimas ventas</h3><div class="tabla-container"><table class="tabla"><thead><tr><th>Número</th><th>Cliente</th><th>Total</th></tr></thead><tbody>${(d.ultimasVentas||[]).map(x=>`<tr><td><b>${esc(x.numero)}</b><small style="display:block">${esc(x.sucursal_nombre||'')}</small></td><td>${esc(x.cliente_nombre)}</td><td style="color:var(--success);font-weight:800">${money(x.total)}</td></tr>`).join('')||'<tr><td colspan="3">Sin ventas</td></tr>'}</tbody></table></div></div></div>
      ${d.porSucursal?.length?`<div class="d45-card"><h3><i class="ti ti-building-store"></i>Resultado por sucursal</h3>${bars(d.porSucursal,'nombre','total',money)}</div>`:''}`;
  }
  document.getElementById('dash-aplicar').onclick=cargar;cargar();
};
