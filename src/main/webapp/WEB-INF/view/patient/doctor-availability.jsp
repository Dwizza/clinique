<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Disponibilités - ${doctor.user.name}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #2563eb;
            --primary-dark: #1e40af;
            --primary-light: #3b82f6;
            --secondary: #8b5cf6;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --dark: #0f172a;
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --white: #ffffff;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1);
        }

        body {
            font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
            color: var(--gray-800);
            padding: 1rem 0;
            line-height: 1.5;
            font-size: 14px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .back {
            text-decoration: none;
            color: var(--white);
            font-weight: 600;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.3);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        .back:hover {
            background: rgba(255,255,255,0.3);
            transform: translateX(-5px);
            box-shadow: var(--shadow-md);
        }

        .legend {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--white);
            font-size: 0.875rem;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            border: 1px solid rgba(255,255,255,0.3);
            font-weight: 500;
        }

        .legend .box {
            width: 18px;
            height: 18px;
            border-radius: 8px;
            background: var(--success);
            border: 2px solid var(--white);
            box-shadow: 0 2px 8px rgba(16,185,129,0.3);
        }

        /* Layout principal en 2 colonnes */
        .main-layout {
            display: grid;
            grid-template-columns: 380px 1fr;
            gap: 2rem;
            align-items: start;
        }

        /* Sidebar gauche avec infos docteur */
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            padding: 1.5rem;
            border: 1px solid rgba(255,255,255,0.5);
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--shadow-lg);
        }

        .doctor-card {
            text-align: center;
            background: linear-gradient(135deg, rgba(255,255,255,0.98), rgba(255,255,255,0.95));
            border: 1px solid var(--gray-200);
        }

        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 800;
            font-size: 2.5rem;
            box-shadow: var(--shadow-lg);
            border: 4px solid var(--white);
            margin: 0 auto 1rem;
        }

        .doctor-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
        }

        .doctor-title {
            font-size: 0.95rem;
            color: var(--gray-600);
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            background: linear-gradient(135deg, var(--primary-light), var(--secondary));
            color: var(--white);
            font-size: 0.8rem;
            font-weight: 600;
            box-shadow: var(--shadow-sm);
            margin-top: 0.5rem;
        }

        .description-card {
            border-left: 4px solid var(--primary);
        }

        .card-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 1rem;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-title::before {
            content: '●';
            color: var(--primary);
            font-size: 1.5rem;
        }

        .description-text {
            color: var(--gray-600);
            line-height: 1.7;
            font-size: 0.9rem;
        }

        .description-text p {
            margin: 0.75rem 0;
        }

        .weekly-card {
            border-left: 4px solid var(--success);
        }

        .weekly-card ul {
            margin: 0.5rem 0 0 1.2rem;
            padding: 0;
            color: var(--gray-600);
            line-height: 1.8;
        }

        .weekly-card ul li {
            margin: 0.5rem 0;
            font-size: 0.9rem;
        }

        .weekly-card strong {
            color: var(--gray-800);
            font-weight: 600;
        }

        /* Calendrier à droite - plus compact */
        .calendar-section {
            position: sticky;
            top: 1rem;
        }

        .calendar-card {
            padding: 1.5rem;
        }

        .cal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .cal-month {
            font-weight: 700;
            font-size: 1.3rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav {
            display: flex;
            gap: 0.5rem;
        }

        .nav a {
            text-decoration: none;
            color: var(--white);
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
            font-size: 0.85rem;
        }

        .nav a:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 0.4rem;
            grid-auto-rows: minmax(50px, auto);
        }

        .dow {
            text-align: center;
            font-weight: 700;
            color: var(--primary);
            padding: 0.5rem 0;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .day {
            background: var(--white);
            border: 2px solid var(--gray-200);
            border-radius: 12px;
            min-height: 50px;
            padding: 0.5rem;
            position: relative;
            cursor: default;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .day .num {
            font-weight: 600;
            font-size: 0.9rem;
            color: var(--gray-700);
        }

        .day.available {
            border-color: var(--success);
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            cursor: pointer;
            box-shadow: var(--shadow-sm);
        }

        .day.available:hover {
            transform: translateY(-4px) scale(1.08);
            box-shadow: var(--shadow-lg);
            border-color: var(--success);
        }

        .day.available:hover .num {
            color: var(--primary);
            font-weight: 700;
        }

        .day.selected {
            outline: 3px solid var(--primary-light);
        }

        .day.past {
            opacity: 0.4;
            cursor: not-allowed;
            background: var(--gray-50);
            border-color: var(--gray-200);
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.5);
            z-index: 9999;
            backdrop-filter: blur(8px);
        }

        .modal.open {
            display: flex;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal .content {
            background: var(--white);
            border-radius: 16px;
            box-shadow: var(--shadow-xl);
            width: min(550px, 92%);
            max-height: 85vh;
            overflow: auto;
            animation: slideUp 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        @keyframes slideUp {
            from { transform: translateY(50px) scale(0.9); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }

        .modal .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.25rem 1.5rem;
            border-bottom: 2px solid var(--gray-200);
            margin: 0;
            background: var(--gray-50);
        }

        .modal .header > div {
            font-weight: 700;
            color: var(--gray-800);
        }

        .modal .body {
            padding: 1.5rem;
        }

        .close {
            border: none;
            background: var(--gray-200);
            color: var(--gray-700);
            border-radius: 8px;
            padding: 0.5rem 0.8rem;
            cursor: pointer;
            transition: all 0.2s ease;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .close:hover {
            background: var(--gray-300);
            transform: scale(1.05);
        }

        .slots {
            display: flex;
            flex-wrap: wrap;
            gap: 0.6rem;
            margin-top: 0.8rem;
        }

        .slot {
            padding: 0.6rem 0.9rem;
            border-radius: 8px;
            border: 2px solid var(--gray-200);
            background: var(--white);
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.85rem;
            color: var(--gray-700);
        }

        .slot:hover {
            border-color: var(--primary);
            background: var(--gray-50);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .slot.disabled {
            opacity: 0.4;
            cursor: not-allowed;
            background: var(--gray-50);
        }

        .slot.disabled:hover {
            transform: none;
            box-shadow: none;
            border-color: var(--gray-200);
        }

        .slot.selected {
            border-color: var(--primary);
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: var(--white);
            box-shadow: var(--shadow-md);
        }

        #confirmBtn {
            background: linear-gradient(135deg, var(--primary), var(--secondary)) !important;
            color: var(--white) !important;
            font-weight: 600 !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 50px !important;
            transition: all 0.3s ease !important;
            box-shadow: var(--shadow-md) !important;
            border: none !important;
            font-size: 0.875rem !important;
            cursor: pointer !important;
        }

        #confirmBtn:hover:not(:disabled) {
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-lg) !important;
        }

        #confirmBtn:disabled {
            opacity: 0.5 !important;
            cursor: not-allowed !important;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .main-layout {
                grid-template-columns: 1fr;
            }

            .calendar-section {
                position: static;
            }

            .sidebar {
                order: 2;
            }

            .calendar-section {
                order: 1;
            }
        }

        @media (max-width: 640px) {
            .container {
                padding: 0 1rem;
            }

            .card {
                padding: 1.25rem;
            }

            .calendar-grid {
                gap: 0.3rem;
                grid-auto-rows: minmax(45px, auto);
            }

            .day {
                min-height: 45px;
                padding: 0.3rem;
            }

            .day .num {
                font-size: 0.8rem;
            }

            .dow {
                font-size: 0.7rem;
                padding: 0.4rem 0;
            }

            .header {
                flex-direction: column;
                align-items: stretch;
            }

            .nav {
                flex-wrap: wrap;
            }

            .nav a {
                flex: 1;
                text-align: center;
            }
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            background: var(--gray-50);
            border-radius: 12px;
            margin-bottom: 0.75rem;
            transition: all 0.2s ease;
        }

        .info-item:hover {
            background: var(--gray-100);
        }

        .info-icon {
            width: 36px;
            height: 36px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--primary-light), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 1.1rem;
            flex-shrink: 0;
            box-shadow: var(--shadow-sm);
        }

        .info-text {
            flex: 1;
        }

        .info-label {
            font-size: 0.7rem;
            color: var(--gray-500);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        .info-value {
            font-size: 0.9rem;
            color: var(--gray-800);
            font-weight: 600;
            margin-top: 0.2rem;
        }

        #modalDate {
            color: var(--gray-600);
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        #modalMsg {
            margin-top: 0.5rem;
            color: var(--gray-500);
            font-size: 0.85rem;
            font-style: italic;
        }

        #bookForm {
            margin-top: 1rem;
            display: flex;
            gap: 0.5rem;
            align-items: end;
            flex-wrap: wrap;
        }

        #bookForm > div {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
            min-width: 180px;
            flex: 1;
        }

        #bookForm label {
            font-weight: 600;
            color: var(--gray-600);
            font-size: 0.85rem;
        }

        #bookForm select {
            padding: 0.7rem 0.8rem;
            border: 2px solid var(--gray-200);
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--gray-700);
            background: var(--white);
            transition: all 0.2s ease;
        }

        #bookForm select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <a class="back" href="${pageContext.request.contextPath}/patient">
            <span>←</span>
            <span>Retour aux recherches</span>
        </a>
        <div class="legend">
            <span class="box"></span>
            <span>Jours disponibles</span>
        </div>
    </div>

    <div class="main-layout">
        <!-- Sidebar gauche avec informations du docteur -->
        <aside class="sidebar">
            <!-- Carte du docteur -->
            <div class="card doctor-card">
                <div class="avatar">
                    <c:choose>
                        <c:when test="${not empty doctor.user.name}">${fn:toUpperCase(fn:substring(doctor.user.name,0,1))}</c:when>
                        <c:otherwise>DR</c:otherwise>
                    </c:choose>
                </div>
                <div class="doctor-name">Dr. ${doctor.user.name}</div>
                <div class="doctor-title">
                    ${doctor.titre != null ? doctor.titre : 'Médecin'} • ${doctor.specialite.name}
                </div>
                <div class="badge">Matricule: ${doctor.matricule}</div>
            </div>

            <!-- Carte description -->
            <div class="card description-card">
                <div class="card-title">À propos du docteur</div>
                <div class="description-text">
                    <p>
                        <strong>Dr. ${doctor.user.name}</strong> est un professionnel de santé hautement qualifié,
                        spécialisé en <strong>${doctor.specialite.name}</strong>.
                    </p>
                    <p>
                        Avec plusieurs années d'expérience, le docteur offre des soins de qualité
                        et un accompagnement personnalisé à chaque patient.
                    </p>
                    <p>
                        Notre clinique digitale vous permet de prendre rendez-vous facilement
                        et de consulter les disponibilités en temps réel.
                    </p>
                </div>

                <div style="margin-top: 1.5rem;">
                    <div class="info-item">
                        <div class="info-icon">🏥</div>
                        <div class="info-text">
                            <div class="info-label">Spécialité</div>
                            <div class="info-value">${doctor.specialite.name}</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">📋</div>
                        <div class="info-text">
                            <div class="info-label">Matricule</div>
                            <div class="info-value">${doctor.matricule}</div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">✓</div>
                        <div class="info-text">
                            <div class="info-label">Statut</div>
                            <div class="info-value">Disponible pour consultations</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Carte créneaux hebdomadaires -->
            <div class="card weekly-card">
                <div class="card-title">Créneaux hebdomadaires</div>
                <c:choose>
                    <c:when test="${empty weekly}">
                        <div style="color: var(--gray-500); font-style: italic; font-size: 0.9rem;">
                            Aucune disponibilité renseignée.
                        </div>
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
        </aside>

        <!-- Section calendrier à droite -->
        <section class="calendar-section">
            <div class="card calendar-card">
                <div class="cal-header">
                    <div class="cal-month">${fn:toUpperCase(monthLabel)} ${year}</div>
                    <div class="nav">
                        <a href="${pageContext.request.contextPath}/patient/doctor?id=${doctor.id}&year=${prevYear}&month=${prevMonth}">← Préc.</a>
                        <a href="${pageContext.request.contextPath}/patient/doctor?id=${doctor.id}&year=${nextYear}&month=${nextMonth}">Suiv. →</a>
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
                    <!-- trailing blanks -->
                    <c:set var="totalCells" value="${(firstDow - 1) + daysInMonth}" />
                    <c:set var="rem" value="${totalCells % 7}" />
                    <c:if test="${rem != 0}">
                        <c:forEach var="i" begin="1" end="${7 - rem}">
                            <div></div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </section>
    </div>
</div>

<!-- Modal slots -->
<div id="slotsModal" class="modal" aria-hidden="true">
  <div class="content">
    <div class="header">
      <div>Créneaux disponibles</div>
      <button class="close" id="closeModal">Fermer</button>
    </div>
    <div class="body">
      <div id="modalDate"></div>
      <div id="modalSlots" class="slots"></div>
      <div id="modalMsg"></div>
      <!-- Formulaire de réservation -->
      <form id="bookForm" method="post" action="${pageContext.request.contextPath}/patient/appointments/book">
          <input type="hidden" name="doctorId" value="${doctor.id}">
          <input type="hidden" name="date" id="bookDate">
          <input type="hidden" name="time" id="bookTime">
          <div>
              <label for="bookType">Type de consultation</label>
              <select id="bookType" name="type">
                  <option value="CONSULTATION">Consultation</option>
                  <option value="SUIVI">Suivi</option>
                  <option value="URGENCE">Urgence</option>
              </select>
          </div>
          <button id="confirmBtn" type="submit" disabled>Confirmer le rendez-vous</button>
      </form>
    </div>
  </div>
</div>

<script>
(function() {
  const cal = document.getElementById('calendar');
  if (!cal) return;
  const year = parseInt(cal.dataset.year, 10);
  const month = parseInt(cal.dataset.month, 10);
  const doctorId = cal.dataset.doctorId;
  const ctx = cal.dataset.context || '';

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
  const bookDate = document.getElementById('bookDate');
  const bookTime = document.getElementById('bookTime');
  const confirmBtn = document.getElementById('confirmBtn');

  function pad(n){ return (n<10 ? '0':'')+n; }
  function toJour(date){
    const d = date.getDay();
    return ['DIMANCHE','LUNDI','MARDI','MERCREDI','JEUDI','VENDEDI','SAMEDI'][d];
  }
  function parseTime(str){ const [h,m] = str.split(':').map(Number); return h*60 + m; }
  function fmt(minutes){ const h = Math.floor(minutes/60), m = minutes%60; return pad(h)+':'+pad(m); }
  function openModal(){ modal.classList.add('open'); modal.setAttribute('aria-hidden','false'); }
  function closeModal(){ modal.classList.remove('open'); modal.setAttribute('aria-hidden','true'); }
  closeBtn.addEventListener('click', closeModal);
  modal.addEventListener('click', (e)=>{ if(e.target===modal) closeModal(); });

  function buildAllTimesForRanges(ranges){
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

  (function markPastDays(){
    const today = new Date();
    const cells = cal.querySelectorAll('.day');
    cells.forEach(el => {
      const d = parseInt(el.getAttribute('data-day'), 10);
      if (!d) return;
      const jsDate = new Date(year, month-1, d);
      if (jsDate.setHours(0,0,0,0) < today.setHours(0,0,0,0)) {
        el.classList.add('past');
        el.classList.remove('available');
      }
    });
  })();

  cal.addEventListener('click', (e)=>{
    const dayEl = e.target.closest('.day');
    if(!dayEl) return;
    if (dayEl.classList.contains('past')) return;
    if (!dayEl.classList.contains('available')) return;

    const day = parseInt(dayEl.dataset.day, 10);
    if (!day) return;

    const jsDate = new Date(year, month-1, day);
    const jour = toJour(jsDate);
    const ymd = jsDate.getFullYear() + '-' + pad(jsDate.getMonth()+1) + '-' + pad(jsDate.getDate());

    modalDate.textContent = 'Pour le ' + ymd + ' (' + jour + ')';
    if (bookDate) bookDate.value = ymd;
    if (bookTime) bookTime.value = '';
    if (confirmBtn) confirmBtn.disabled = true;

    modalSlots.innerHTML = '';
    modalMsg.textContent = '';

    const ranges = weeklySlots[jour] || [];
    const allTimes = buildAllTimesForRanges(ranges);

    fetch(ctx + '/appointment?action=slots&doctorId=' + doctorId + '&date=' + ymd)
      .then(r => r.ok ? r.json() : Promise.resolve([]))
      .then(available => {
        const availSet = new Set(available || []);

        if (allTimes.length === 0) {
          modalMsg.textContent = 'Aucun créneau pour ce jour.';
        } else {
          allTimes.forEach(t => {
            const b = document.createElement('button');
            b.type='button'; b.className='slot'; b.textContent = t;
            const isOk = availSet.has(t);
            if (!isOk) {
              b.classList.add('disabled');
              b.disabled = true;
            } else {
              b.addEventListener('click', ()=>{
                document.querySelectorAll('#modalSlots .slot.selected').forEach(x=>x.classList.remove('selected'));
                b.classList.add('selected');
                if (bookTime) bookTime.value = t;
                if (confirmBtn) confirmBtn.disabled = false;
              });
            }
            modalSlots.appendChild(b);
          });

          if (available.length === 0) {
            modalMsg.textContent = 'Aucun créneau disponible pour cette date.';
          }
        }

        openModal();
      })
      .catch(() => {
        modalMsg.textContent = 'Erreur lors du chargement des créneaux.';
        openModal();
      });
  });
})();
</script>
</body>
</html>
