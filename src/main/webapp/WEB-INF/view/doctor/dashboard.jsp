<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Dashboard Médecin - Clinique Digitale</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #0EA5E9;
            --primary-dark: #0284C7;
            --primary-light: #38BDF8;
            --secondary: #8B5CF6;
            --accent: #EC4899;
            --success: #22C55E;
            --warning: #F97316;
            --error: #EF4444;
            --info: #06B6D4;
            --text: #0F172A;
            --text-light: #64748B;
            --bg: #F8FAFC;
            --card-bg: #FFFFFF;
            --border: #E2E8F0;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #0EA5E9 0%, #8B5CF6 50%, #EC4899 100%);
            background-size: 400% 400%;
            animation: gradientShift 20s ease infinite;
            overflow-x: hidden;
            color: var(--text);
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .bg-effects {
            position: fixed;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
            pointer-events: none;
        }
        .floating-shape {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            animation: floatAround 25s infinite ease-in-out;
        }
        .floating-shape:nth-child(1){width:400px;height:400px;top:-200px;left:-100px;animation-delay:0s;}
        .floating-shape:nth-child(2){width:300px;height:300px;bottom:-150px;right:-80px;animation-delay:5s;}
        .floating-shape:nth-child(3){width:200px;height:200px;top:50%;left:15%;animation-delay:10s;}
        .floating-shape:nth-child(4){width:350px;height:350px;bottom:20%;right:10%;animation-delay:15s;}
        @keyframes floatAround {
            0%,100%{transform:translate(0,0) scale(1);}
            25%{transform:translate(30px,30px) scale(1.1);}
            50%{transform:translate(-30px,50px) scale(0.9);}
            75%{transform:translate(50px,-30px) scale(1.05);}
        }

        .header {
            position: relative;
            z-index: 10;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(24px);
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            animation: slideDown 0.6s ease-out;
            border-bottom: 1px solid var(--border);
        }
        @keyframes slideDown {
            from {opacity:0;transform:translateY(-30px);}
            to {opacity:1;transform:translateY(0);}
        }
        .nav-container {
            max-width:1600px;margin:0 auto;
            padding:1.5rem 2.5rem;
            display:flex;justify-content:space-between;align-items:center;gap:2rem;
        }
        .logo-section {display:flex;align-items:center;gap:1rem;}
        .logo-icon {
            width:50px;height:50px;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            border-radius:14px;display:flex;align-items:center;justify-content:center;
            box-shadow:0 8px 20px rgba(14,165,233,0.35);
            font-weight:900;color:white;font-size:1.2rem;
        }
        .logo-text {
            font-size:1.5rem;font-weight:900;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;
        }
        .nav-links {
            display:flex;align-items:center;gap:0.5rem;list-style:none;
        }
        .nav-links a {
            text-decoration:none;font-weight:600;color:var(--text-light);
            padding:0.85rem 1.3rem;border-radius:14px;transition:all 0.3s ease;
            font-size:0.95rem;
        }
        .nav-links a:hover,.nav-links a.active {
            background:linear-gradient(135deg,rgba(14,165,233,0.12),rgba(139,92,246,0.12));
            color:var(--primary);
        }
        .nav-actions {display:flex;align-items:center;gap:1.2rem;}
        .avatar {
            width:50px;height:50px;border-radius:14px;
            background:linear-gradient(135deg,var(--secondary),var(--accent));
            display:flex;align-items:center;justify-content:center;
            color:white;font-weight:700;font-size:1.1rem;
            box-shadow:0 6px 16px rgba(139,92,246,0.3);
        }

        .main-container {
            position:relative;z-index:1;
            max-width:1600px;margin:2.5rem auto 4rem;
            padding:0 2.5rem;
        }
        .welcome-section {
            background:rgba(255,255,255,0.98);backdrop-filter:blur(24px);
            border-radius:28px;padding:3rem;margin-bottom:3rem;
            box-shadow:0 20px 50px rgba(15,23,42,0.15);
            display:flex;flex-wrap:wrap;justify-content:space-between;gap:2.5rem;
            border:1px solid var(--border);
        }
        .welcome-content h1 {
            font-size:2.5rem;font-weight:900;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;
            margin-bottom:1rem;
        }
        .welcome-content p {
            color:var(--text-light);font-size:1.1rem;max-width:600px;line-height:1.7;
        }
        .welcome-actions {display:flex;flex-wrap:wrap;gap:1.2rem;}
        .btn {
            padding:1rem 1.8rem;border-radius:16px;font-size:1rem;
            font-weight:600;cursor:pointer;transition:all 0.3s ease;border:none;
            display:inline-flex;align-items:center;gap:0.6rem;text-decoration:none;
        }
        .btn-primary {
            background:linear-gradient(135deg,var(--primary),var(--primary-light));
            color:white;
            box-shadow:0 10px 25px rgba(14,165,233,0.3);
        }
        .btn-outline {
            background:white;color:var(--text);
            border:2px solid var(--border);
            box-shadow:0 4px 12px rgba(0,0,0,0.05);
        }
        .btn-primary:hover {transform:translateY(-3px);box-shadow:0 14px 32px rgba(14,165,233,0.4);}
        .btn-outline:hover {
            color:var(--primary);border-color:var(--primary);
            transform:translateY(-3px);
            box-shadow:0 8px 20px rgba(14,165,233,0.15);
        }

        .stats-grid {
            display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
            gap:2rem;margin-bottom:3rem;
        }
        .stat-card {
            background:rgba(255,255,255,0.98);backdrop-filter:blur(20px);
            border-radius:24px;padding:2rem;
            box-shadow:0 12px 32px rgba(15,23,42,0.12);
            transition:all 0.3s ease;
            border:1px solid var(--border);
            display:flex;flex-direction:column;gap:1rem;
        }
        .stat-card:hover {transform:translateY(-8px);box-shadow:0 20px 48px rgba(15,23,42,0.18);}
        .stat-header {display:flex;justify-content:space-between;align-items:flex-start;}
        .stat-value {font-size:2.5rem;font-weight:900;color:var(--text);line-height:1;}
        .stat-label {color:var(--text-light);font-size:0.95rem;margin-top:0.5rem;font-weight:500;}
        .stat-icon {
            width:60px;height:60px;border-radius:18px;
            display:flex;align-items:center;justify-content:center;
            font-size:1.8rem;
        }
        .stat-icon.primary {background:linear-gradient(135deg,#0EA5E9,#38BDF8);}
        .stat-icon.success {background:linear-gradient(135deg,#22C55E,#4ADE80);}
        .stat-icon.warning {background:linear-gradient(135deg,#F97316,#FB923C);}
        .stat-icon.info {background:linear-gradient(135deg,#06B6D4,#22D3EE);}
        .stat-trend {
            margin-top:0.5rem;font-weight:600;font-size:0.9rem;
            padding:0.4rem 0.8rem;border-radius:8px;display:inline-block;
        }
        .stat-trend.positive {color:#15803D;background:#DCFCE7;}
        .stat-trend.warning {color:#C2410C;background:#FED7AA;}

        .availability-section {
            background:rgba(255,255,255,0.98);backdrop-filter:blur(24px);
            border-radius:28px;padding:2.5rem;margin-bottom:3rem;
            box-shadow:0 20px 50px rgba(15,23,42,0.15);
            border:1px solid var(--border);
        }
        .section-header {
            display:flex;justify-content:space-between;align-items:center;
            margin-bottom:2rem;flex-wrap:wrap;gap:1rem;
        }
        .section-title {
            font-size:1.8rem;font-weight:800;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;
        }
        .status-badge {
            padding:0.6rem 1.2rem;border-radius:12px;font-weight:600;
            font-size:0.9rem;display:inline-flex;align-items:center;gap:0.5rem;
        }
        .status-badge.available {background:#DCFCE7;color:#15803D;}
        .status-badge.busy {background:#FEE2E2;color:#991B1B;}
        .status-badge.offline {background:#F1F5F9;color:#475569;}

        .availability-grid {
            display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));
            gap:1.5rem;
        }
        .time-slot {
            background:var(--bg);border-radius:18px;padding:1.5rem;
            border:2px solid var(--border);transition:all 0.3s ease;
            cursor:pointer;
        }
        .time-slot:hover {border-color:var(--primary);transform:translateY(-2px);}
        .time-slot.active {
            border-color:var(--primary);
            background:linear-gradient(135deg,rgba(14,165,233,0.08),rgba(139,92,246,0.08));
        }
        .slot-header {
            display:flex;justify-content:space-between;align-items:center;
            margin-bottom:1rem;
        }
        .slot-time {font-size:1.2rem;font-weight:700;color:var(--text);}
        .slot-toggle {
            width:52px;height:28px;background:var(--border);
            border-radius:14px;position:relative;transition:all 0.3s ease;
            cursor:pointer;
        }
        .slot-toggle.on {background:var(--success);}
        .slot-toggle::after {
            content:'';position:absolute;top:3px;left:3px;
            width:22px;height:22px;background:white;
            border-radius:50%;transition:all 0.3s ease;
        }
        .slot-toggle.on::after {left:27px;}
        .slot-info {color:var(--text-light);font-size:0.9rem;line-height:1.6;}

        /* APPOINTMENTS SECTION */
        .appointments-section {
            background:rgba(255,255,255,0.98);backdrop-filter:blur(24px);
            border-radius:28px;padding:2.5rem;margin-bottom:3rem;
            box-shadow:0 20px 50px rgba(15,23,42,0.15);
            border:1px solid var(--border);
        }
        .appointment-card {
            background:var(--bg);border-radius:18px;padding:1.5rem;
            border:2px solid var(--border);margin-bottom:1.25rem;
            transition:all 0.3s ease;cursor:pointer;
        }
        .appointment-card:hover {
            border-color:var(--primary);
            transform:translateY(-2px);
            box-shadow:0 8px 20px rgba(14,165,233,0.15);
        }
        .appointment-header {
            display:flex;justify-content:space-between;align-items:flex-start;
            margin-bottom:1rem;gap:1rem;flex-wrap:wrap;
        }
        .patient-info h3 {
            font-size:1.2rem;font-weight:700;color:var(--text);
            margin-bottom:0.3rem;
        }
        .patient-info p {color:var(--text-light);font-size:0.9rem;}
        .appointment-time {
            background:linear-gradient(135deg,var(--primary),var(--primary-light));
            color:white;padding:0.6rem 1.2rem;border-radius:12px;
            font-weight:700;font-size:0.95rem;
            white-space:nowrap;
        }
        .appointment-details {
            display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
            gap:1rem;margin-bottom:1rem;
        }
        .detail-item {
            display:flex;align-items:center;gap:0.5rem;
            color:var(--text-light);font-size:0.9rem;
        }
        .appointment-actions {
            display:flex;gap:0.75rem;flex-wrap:wrap;
        }
        .btn-sm {
            padding:0.6rem 1.2rem;border-radius:10px;font-size:0.85rem;
            font-weight:600;cursor:pointer;transition:all 0.3s ease;border:none;
        }
        .btn-sm.primary {
            background:var(--primary);color:white;
        }
        .btn-sm.outline {
            background:white;color:var(--text);border:2px solid var(--border);
        }
        .btn-sm:hover {transform:translateY(-2px);}

        /* MODAL */
        .modal {
            display:none;position:fixed;top:0;left:0;width:100%;height:100%;
            background:rgba(0,0,0,0.6);backdrop-filter:blur(4px);
            z-index:1000;align-items:center;justify-content:center;
            animation:fadeIn 0.3s ease;
        }
        .modal.active {display:flex;}
        @keyframes fadeIn {from{opacity:0;}to{opacity:1;}}
        .modal-content {
            background:white;border-radius:24px;padding:2.5rem;
            max-width:600px;width:90%;max-height:80vh;overflow-y:auto;
            animation:slideUp 0.3s ease;
            box-shadow:0 24px 60px rgba(0,0,0,0.3);
        }
        @keyframes slideUp {from{transform:translateY(30px);opacity:0;}to{transform:translateY(0);opacity:1;}}
        .modal-header {
            display:flex;justify-content:space-between;align-items:center;
            margin-bottom:1.5rem;
        }
        .modal-title {
            font-size:1.8rem;font-weight:800;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;
        }
        .close-modal {
            background:none;border:none;font-size:2rem;
            cursor:pointer;color:var(--text-light);
            transition:all 0.3s ease;padding:0;
            width:36px;height:36px;border-radius:8px;
        }
        .close-modal:hover {background:var(--bg);color:var(--text);}
        .form-group {margin-bottom:1.5rem;}
        .form-group label {
            display:block;font-weight:600;color:var(--text);
            margin-bottom:0.5rem;font-size:0.95rem;
        }
        .form-group textarea {
            width:100%;padding:1rem;border:2px solid var(--border);
            border-radius:14px;font-family:inherit;font-size:0.95rem;
            resize:vertical;min-height:150px;
            transition:all 0.3s ease;
        }
        .form-group textarea:focus {
            outline:none;border-color:var(--primary);
            box-shadow:0 0 0 3px rgba(14,165,233,0.1);
        }

        @media (max-width:1100px){.nav-links{display:none;}}
        @media (max-width:768px){
            .main-container{padding:0 1.5rem;}
            .welcome-section,.availability-section,.appointments-section{padding:2rem;}
            .nav-container{padding:1.25rem 1.5rem;}
        }
        @media (max-width:600px){
            .stats-grid,.availability-grid{gap:1.25rem;}
            .welcome-content h1{font-size:2rem;}
        }
    </style>
</head>
<body>
<div class="bg-effects">
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
</div>

<header class="header">
    <nav class="nav-container">
        <div class="logo-section">
            <div class="logo-icon">CD</div>
            <div class="logo-text">Clinique Digitale</div>
        </div>
        <ul class="nav-links">
            <li><a href="#" class="active">Tableau de bord</a></li>
            <li><a href="#appointments">Mes rendez-vous</a></li>
            <li><a href="#availability">Disponibilité</a></li>
        </ul>
        <div class="nav-actions">
            <div class="avatar">${avatarInitials}</div>
        </div>
    </nav>
</header>

<main class="main-container">
    <section class="welcome-section">
        <div class="welcome-content">
            <h1>Bonjour ${doctorName} 👋</h1>
            <p>Voici un aperçu de votre activité pour aujourd'hui. Gérez votre disponibilité et consultez vos rendez-vous programmés.</p>
        </div>
        <div class="welcome-actions">
            <a href="${pageContext.request.contextPath}/doctor/availability" class="btn btn-primary">⏰ Gérer mes disponibilités</a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="btn btn-outline">📅 Mes rendez-vous</a>
        </div>
    </section>

    <section class="stats-grid">
        <article class="stat-card">
            <div class="stat-header">
                <div>
                    <div class="stat-value">${appointmentsCount}</div>
                    <div class="stat-label">Consultations du jour</div>
                </div>
                <div class="stat-icon primary">🩺</div>
            </div>
            <div class="stat-trend positive">Aujourd'hui</div>
        </article>
        <article class="stat-card">
            <div class="stat-header">
                <div>
                    <div class="stat-value">${availableHoursLabel}</div>
                    <div class="stat-label">Heures disponibles aujourd'hui</div>
                </div>
                <div class="stat-icon success">⏰</div>
            </div>
            <div class="stat-trend positive">Planning à jour</div>
        </article>
        <article class="stat-card">
            <div class="stat-header">
                <div>
                    <div class="stat-value">${notesCount}</div>
                    <div class="stat-label">Notes à compléter</div>
                </div>
                <div class="stat-icon info">📝</div>
            </div>
            <div class="stat-trend warning">À faire</div>
        </article>
        <article class="stat-card">
            <div class="stat-header">
                <div>
                    <div class="stat-value">${monthConsultations}</div>
                    <div class="stat-label">Consultations ce mois</div>
                </div>
                <div class="stat-icon warning">📊</div>
            </div>
            <div class="stat-trend positive">Live</div>
        </article>
    </section>

    <section class="availability-section" id="availability">
        <div class="section-header">
            <h2 class="section-title">⏰ Ma disponibilité</h2>
            <c:choose>
                <c:when test="${not empty todayAvailabilities}">
                    <span class="status-badge available">● Disponible</span>
                </c:when>
                <c:otherwise>
                    <span class="status-badge offline">● Hors ligne</span>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="availability-grid">
            <c:if test="${empty todayAvailabilities}">
                <div class="time-slot">
                    <div class="slot-header">
                        <span class="slot-time">—</span>
                        <div class="slot-toggle"></div>
                    </div>
                    <div class="slot-info">
                        Aucune disponibilité aujourd’hui
                    </div>
                </div>
            </c:if>
            <c:forEach var="slot" items="${todayAvailabilities}">
                <div class="time-slot active">
                    <div class="slot-header">
                        <span class="slot-time">${slot.heureDebut} - ${slot.heureFin}</span>
                        <div class="slot-toggle on"></div>
                    </div>
                    <div class="slot-info">
                        Créneau • Disponible<br>
                        Cabinet
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <section class="appointments-section" id="appointments">
        <div class="section-header">
            <h2 class="section-title">📅 Mes rendez-vous du jour</h2>
        </div>

        <c:if test="${empty appointments}">
            <div class="appointment-card">
                <div class="appointment-header">
                    <div class="patient-info">
                        <h3>Aucun rendez-vous</h3>
                        <p>Vous n'avez pas de rendez-vous programmés aujourd'hui.</p>
                    </div>
                </div>
            </div>
        </c:if>

        <c:forEach var="a" items="${appointments}">
            <div class="appointment-card">
                <div class="appointment-header">
                    <div class="patient-info">
                        <h3><c:out value="${a.patient.user.name}"/></h3>
                        <p>
                            <c:choose>
                                <c:when test="${not empty a.type}">Type: <c:out value="${a.type}"/></c:when>
                                <c:otherwise>Type: Consultation</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="appointment-time"><c:out value="${a.hour}"/></div>
                </div>
                <div class="appointment-details">
                    <div class="detail-item">📋 Statut: <c:out value="${a.statut}"/></div>
                    <c:if test="${not empty a.patient.telephone}">
                        <div class="detail-item">📞 Tél: <c:out value="${a.patient.telephone}"/></div>
                    </c:if>
                </div>
                <div class="appointment-actions">
                    <button class="btn-sm primary" onclick="openNoteModal('<c:out value='${a.patient.user.name}'/>','<c:out value='${a.hour}'/>')">📝 Ajouter note</button>
                    <button class="btn-sm outline">👁️ Voir dossier</button>
                </div>
            </div>
        </c:forEach>
    </section>
</main>

<div class="modal" id="noteModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">📝 Ajouter une note</h2>
            <button class="close-modal" onclick="closeNoteModal()">×</button>
        </div>
        <div class="form-group">
            <label>Patient</label>
            <input type="text" id="patientName" readonly style="width:100%;padding:0.85rem;border:2px solid var(--border);border-radius:12px;background:var(--bg);font-weight:600;"/>
        </div>
        <div class="form-group">
            <label>Heure de consultation</label>
            <input type="text" id="appointmentTime" readonly style="width:100%;padding:0.85rem;border:2px solid var(--border);border-radius:12px;background:var(--bg);font-weight:600;"/>
        </div>
        <div class="form-group">
            <label>Note</label>
            <textarea id="noteText" placeholder="Écrire une note..." ></textarea>
        </div>
        <div style="display:flex;gap:0.75rem;justify-content:flex-end;">
            <button class="btn btn-outline" onclick="closeNoteModal()">Annuler</button>
            <button class="btn btn-primary" onclick="saveNote()">Enregistrer</button>
        </div>
    </div>
</div>

<script>
    function openNoteModal(name, time) {
        try {
            document.getElementById('patientName').value = name || '';
            document.getElementById('appointmentTime').value = time || '';
            document.getElementById('noteModal').classList.add('active');
        } catch (e) { console.error(e); }
    }
    function closeNoteModal() {
        document.getElementById('noteModal').classList.remove('active');
    }
    function saveNote() {
        // TODO: brancher l'enregistrement de note si besoin
        closeNoteModal();
        alert('Note enregistrée');
    }
</script>
</body>
</html>
