<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Disponibilités - ${doctor.user.name}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        :root {
            --primary: #6366F1;
            --primary-dark: #4F46E5;
            --primary-light: #818CF8;
            --text: #1F2937;
            --text-light: #6B7280;
            --bg: #F3F4F6;
            --card: #FFFFFF;
            --green: #10B981;
            --danger: #EF4444;
        }
        body { font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial; background: var(--bg); margin: 0; color: var(--text); }
        .container { max-width: 1100px; margin: 2rem auto; padding: 0 1rem; }
        .header { display:flex; align-items:center; justify-content:space-between; margin-bottom: 1.25rem; }
        .back { text-decoration:none; color: var(--primary-dark); font-weight:600; }
        .card { background: var(--card); border-radius: 16px; box-shadow: 0 6px 18px rgba(0,0,0,.08); padding: 1.25rem; margin-bottom: 1rem; /* ensure calendar not clipped */ overflow: visible; }
        .doctor { display:flex; align-items:center; gap: 1rem; }
        .avatar { width:56px; height:56px; border-radius: 50%; background: linear-gradient(135deg,var(--primary),var(--primary-light)); display:flex; align-items:center; justify-content:center; color:#fff; font-weight:800; font-size:1.2rem; }
        .title { font-size:1.1rem; color: var(--text-light); }
        .calendar-grid { display:grid; grid-template-columns: repeat(7, minmax(0,1fr)); gap: .5rem; grid-auto-flow: row; grid-auto-rows: minmax(72px, auto); }
        .dow { text-align:center; font-weight:700; color: var(--text-light); padding:.5rem 0; }
        .day { background:#fff; border: 2px solid #E5E7EB; border-radius:12px; min-height:72px; padding:.5rem; position:relative; cursor: default; }
        .day .num { font-weight:700; }
        .day.available { border-color: var(--green); background: #ECFDF5; cursor: pointer; }
        .day.selected { outline: 3px solid var(--primary-light); }
        .legend { display:flex; align-items:center; gap:.75rem; color: var(--text-light); font-size:.95rem; }
        .legend .box { width:14px; height:14px; border-radius:4px; background:#ECFDF5; border:2px solid var(--green); }
        .cal-header { display:flex; align-items:center; justify-content:space-between; margin-bottom:.75rem; }
        .nav a { text-decoration:none; color:#fff; background: var(--primary); padding:.5rem .75rem; border-radius:8px; font-weight:600; }
        .weekly ul { margin: .5rem 0 0 1rem; color: var(--text-light);}
        .badge { display:inline-block; padding:.25rem .5rem; border-radius:8px; background: #EEF2FF; color: #3730A3; font-size:.8rem; font-weight:700; }
        /* Modal */
        .modal { display:none; position:fixed; inset:0; background: rgba(0,0,0,.45); z-index: 9999; }
        .modal.open { display:flex; align-items:center; justify-content:center; }
        .modal .content { background: #fff; border-radius: 16px; box-shadow: 0 20px 60px rgba(0,0,0,.25); width: min(520px, 92%); max-height: 84vh; overflow:auto; }
        .modal .header { display:flex; align-items:center; justify-content:space-between; padding: 1rem 1.25rem; border-bottom: 2px solid #F3F4F6; margin:0; }
        .modal .body { padding: 1rem 1.25rem; }
        .close { border:none; background:#F3F4F6; color:#111; border-radius:10px; padding:.4rem .6rem; cursor:pointer; }
        .slots { display:flex; flex-wrap: wrap; gap: .5rem; margin-top: .5rem; }
        .slot { padding: .5rem .75rem; border-radius: 10px; border: 2px solid #E5E7EB; background: #fff; cursor: pointer; font-weight: 700; }
        .slot:hover { border-color: var(--primary-light); }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <a class="back" href="${pageContext.request.contextPath}/patient">&larr; Retour aux recherches</a>
        <div class="legend"><span class="box"></span> Jours disponibles</div>
    </div>

    <div class="card doctor">
        <div class="avatar">
            <c:choose>
                <c:when test="${not empty doctor.user.name}">${fn:toUpperCase(fn:substring(doctor.user.name,0,1))}</c:when>
                <c:otherwise>DR</c:otherwise>
            </c:choose>
        </div>
        <div>
            <div style="font-size:1.25rem; font-weight:800;">Dr. ${doctor.user.name}</div>
            <div class="title">${doctor.titre != null ? doctor.titre : 'Médecin'} • <strong>${doctor.specialite.name}</strong></div>
            <div style="margin-top:.35rem;"><span class="badge">Matricule: ${doctor.matricule}</span></div>
        </div>
    </div>

    <div class="card weekly">
        <div style="font-weight:800; margin-bottom:.5rem;">Créneaux hebdomadaires</div>
        <c:choose>
            <c:when test="${empty weekly}">
                <div class="muted">Aucune disponibilité renseignée.</div>
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach var="e" items="${weekly}">
                        <li>
                            <strong>${e.key}</strong>:
                            <c:forEach var="label" items="${e.value}" varStatus="s">
                                ${label}<c:if test="${!s.last}">, </c:if>
                            </c:forEach>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="card">
        <div class="cal-header">
            <div style="font-weight:800; font-size:1.1rem;">${fn:toUpperCase(monthLabel)} ${year}</div>
            <div class="nav">
                <a href="${pageContext.request.contextPath}/patient/doctor?id=${doctor.id}&year=${prevYear}&month=${prevMonth}">Précédent</a>
                <a href="${pageContext.request.contextPath}/patient/doctor?id=${doctor.id}&year=${nextYear}&month=${nextMonth}" style="margin-left:.5rem; background: var(--primary-dark);">Suivant</a>
            </div>
        </div>
        <div id="calendar" class="calendar-grid" data-year="${year}" data-month="${month}" data-doctor-id="${doctor.id}" data-context="${pageContext.request.contextPath}">
            <div class="dow">Lun</div>
            <div class="dow">Mar</div>
            <div class="dow">Mer</div>
            <div class="dow">Jeu</div>
            <div class="dow">Ven</div>
            <div class="dow">Sam</div>
            <div class="dow">Dim</div>
            <!-- leading blanks -->
            <c:forEach var="i" begin="1" end="${firstDow - 1}">
                <div></div>
            </c:forEach>
            <!-- days -->
            <c:forEach var="cell" items="${dayCells}">
                <div class="day ${cell.available ? 'available' : ''}"
                     data-day="${cell.day}"
                     data-available="${cell.available}">
                    <div class="num">${cell.day}</div>
                </div>
            </c:forEach>
            <!-- trailing blanks to complete last week (optional visual balance) -->
            <c:set var="totalCells" value="${(firstDow - 1) + daysInMonth}" />
            <c:set var="rem" value="${totalCells % 7}" />
            <c:if test="${rem != 0}">
                <c:forEach var="i" begin="1" end="${7 - rem}">
                    <div></div>
                </c:forEach>
            </c:if>
        </div>
    </div>
</div>

<!-- Modal slots -->
<div id="slotsModal" class="modal" aria-hidden="true">
  <div class="content">
    <div class="header">
      <div style="font-weight:800">Créneaux disponibles</div>
      <button class="close" id="closeModal">Fermer</button>
    </div>
    <div class="body">
      <div id="modalDate" style="color: var(--text-light);"></div>
      <div id="modalSlots" class="slots"></div>
      <div id="modalMsg" style="margin-top:.5rem; color: var(--text-light);"></div>
    </div>
  </div>
</div>

<script>
(function() {
  const cal = document.getElementById('calendar');
  if (!cal) return;
  const year = parseInt(cal.dataset.year, 10);
  const month = parseInt(cal.dataset.month, 10);

  // Export des créneaux hebdo en JS
  const weeklySlots = {};
  <c:forEach var="e" items="${weekly}">
    weeklySlots['${e.key}'] = [
      <c:forEach var="label" items="${e.value}" varStatus="s">
        '${fn:trim(label)}'<c:if test="${!s.last}">,</c:if>
      </c:forEach>
    ];
  </c:forEach>

  const modal = document.getElementById('slotsModal');
  const closeBtn = document.getElementById('closeModal');
  const modalSlots = document.getElementById('modalSlots');
  const modalMsg = document.getElementById('modalMsg');
  const modalDate = document.getElementById('modalDate');

  function pad(n){ return (n<10 ? '0':'')+n; }
  function toJour(date){
    // JS: 0=Dimanche..6=Samedi
    const d = date.getDay();
    return ['DIMANCHE','LUNDI','MARDI','MERCREDI','JEUDI','VENDREDI','SAMEDI'][d];
  }
  function parseTime(str){
    const [h,m] = str.split(':').map(Number);
    return h*60 + m;
  }
  function fmt(minutes){
    const h = Math.floor(minutes/60); const m = minutes%60;
    return pad(h)+':'+pad(m);
  }
  function openModal(){ modal.classList.add('open'); modal.setAttribute('aria-hidden','false'); }
  function closeModal(){ modal.classList.remove('open'); modal.setAttribute('aria-hidden','true'); }
  closeBtn.addEventListener('click', closeModal);
  modal.addEventListener('click', (e)=>{ if(e.target===modal) closeModal(); });

  function buildSlots(ranges){
    // ranges: array of strings 'HH:MM - HH:MM'
    const set = new Set();
    for(const label of ranges){
      const parts = label.split('-');
      if(parts.length!==2) continue;
      const start = parseTime(parts[0].trim());
      const end = parseTime(parts[1].trim());
      if (!(end>start)) continue;
      for(let t=start; t+30<=end; t+=30){
        set.add(fmt(t));
      }
    }
    return Array.from(set).sort();
  }

  cal.addEventListener('click', (e)=>{
    const dayEl = e.target.closest('.day.available');
    if(!dayEl) return;
    const day = parseInt(dayEl.dataset.day, 10);
    const jsDate = new Date(year, month-1, day);
    const jour = toJour(jsDate);
   
    modalDate.textContent = "Pour le " + jsDate.getFullYear() + "-" + pad(jsDate.getMonth()+1) + "-" + pad(jsDate.getDate()) + " (" + jour + ")";

    const ranges = weeklySlots[jour] || [];
    const slots = buildSlots(ranges);
    modalSlots.innerHTML = '';
    modalMsg.textContent = '';
    if(slots.length===0){
      modalMsg.textContent = 'Aucun créneau pour ce jour.';
    } else {
      for(const s of slots){
        const b = document.createElement('button');
        b.type='button'; b.className='slot'; b.textContent = s;
        b.addEventListener('click', ()=>{
          document.querySelectorAll('#modalSlots .slot.selected').forEach(x=>x.classList.remove('selected'));
          b.classList.add('selected');
          // Ici, on pourrait rediriger vers une étape de confirmation si besoin
        });
        modalSlots.appendChild(b);
      }
    }
    openModal();
  });
})();
</script>
</body>
</html>
