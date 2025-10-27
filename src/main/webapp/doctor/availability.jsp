<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Gestion des Disponibilités - Clinique Digitale</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #6366F1;
            --primary-dark: #4F46E5;
            --primary-light: #818CF8;
            --secondary: #EC4899;
            --success: #10B981;
            --warning: #F59E0B;
            --danger: #EF4444;
            --info: #3B82F6;
            --text: #1F2937;
            --text-light: #6B7280;
            --white: #FFFFFF;
            --bg-main: #F9FAFB;
            --sidebar-bg: rgba(255, 255, 255, 0.98);
            --sidebar-width: 280px;
            --border: #E5E7EB;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
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

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: var(--sidebar-bg);
            backdrop-filter: blur(20px);
            padding: 2rem 0;
            z-index: 100;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 30px rgba(0,0,0,0.08);
            border-right: 1px solid rgba(255,255,255,0.5);
        }

        .sidebar-logo {
            padding: 0 1.5rem 2rem;
            border-bottom: 2px solid var(--border);
            margin-bottom: 2rem;
        }

        .logo-content {
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.3s ease;
        }

        .logo-content:hover { transform: scale(1.02); }

        .logo-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: 900;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
        }

        .logo-text {
            font-size: 1.25rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .sidebar-menu {
            flex: 1;
            padding: 0 1rem;
            overflow-y: auto;
        }

        .menu-section {
            margin-bottom: 2rem;
        }

        .menu-section-title {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-light);
            padding: 0 1rem;
            margin-bottom: 0.75rem;
            letter-spacing: 0.5px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.25rem;
            margin-bottom: 0.5rem;
            border-radius: 14px;
            color: var(--text);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
        }

        .menu-item:hover {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.08), rgba(236, 72, 153, 0.08));
            color: var(--primary);
            transform: translateX(5px);
        }

        .menu-item.active {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
            transform: translateX(5px);
        }

        .menu-icon {
            font-size: 1.3rem;
            flex-shrink: 0;
        }

        .sidebar-footer {
            padding: 1.5rem;
            border-top: 2px solid var(--border);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.25rem;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05), rgba(236, 72, 153, 0.05));
            border-radius: 14px;
            margin-bottom: 1rem;
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .user-avatar {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 800;
            font-size: 1.2rem;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .user-info {
            flex: 1;
            min-width: 0;
        }

        .user-info h4 {
            color: var(--text);
            font-size: 1rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .user-info p {
            color: var(--text-light);
            font-size: 0.85rem;
            font-weight: 500;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem;
            background: white;
            border: 2px solid var(--border);
            border-radius: 12px;
            color: var(--text);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            justify-content: center;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.08), rgba(248, 113, 113, 0.08));
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
        }

        /* MAIN CONTENT */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
            min-height: 100vh;
        }

        .topbar {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem 2.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.5);
            animation: fadeInDown 0.6s ease-out;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .topbar h1 {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .topbar-subtitle {
            color: var(--text-light);
            font-size: 1rem;
            font-weight: 500;
        }

        .availability-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.5);
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .tabs-container {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            border-bottom: 2px solid var(--border);
            padding-bottom: 0;
        }

        .tab-button {
            padding: 1rem 2rem;
            background: transparent;
            border: none;
            border-bottom: 3px solid transparent;
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text-light);
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            bottom: -2px;
            font-family: inherit;
        }

        .tab-button:hover {
            color: var(--primary);
        }

        .tab-button.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
        }

        .tab-icon {
            font-size: 1.3rem;
        }

        .tab-content {
            display: none;
            animation: fadeIn 0.5s ease-out;
        }

        .tab-content.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .weekly-mode {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.08), rgba(236, 72, 153, 0.08));
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .weekly-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .weekly-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            box-shadow: 0 8px 24px rgba(99, 102, 241, 0.3);
        }

        .weekly-info h3 {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 0.25rem;
        }

        .weekly-info p {
            color: var(--text-light);
            font-size: 0.95rem;
        }

        .days-selector {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .day-checkbox {
            position: relative;
        }

        .day-checkbox input {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        .day-checkbox label {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            padding: 1.25rem 1rem;
            background: white;
            border: 2px solid var(--border);
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            color: var(--text);
        }

        .day-checkbox input:checked + label {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-color: var(--primary);
            color: white;
            box-shadow: 0 8px 24px rgba(99, 102, 241, 0.4);
            transform: translateY(-4px);
        }

        .day-initial {
            width: 45px;
            height: 45px;
            background: var(--bg-main);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 800;
        }

        .day-checkbox input:checked + label .day-initial {
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        .week-grid {
            display: grid;
            gap: 1.5rem;
        }

        .day-card {
            background: var(--bg-main);
            border-radius: 16px;
            padding: 1.5rem;
            border: 2px solid var(--border);
            transition: all 0.3s ease;
        }

        .day-card:hover {
            border-color: var(--primary);
            box-shadow: 0 4px 20px rgba(99, 102, 241, 0.15);
        }

        .day-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .day-name {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 56px;
            height: 32px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: #CBD5E1;
            transition: 0.3s;
            border-radius: 9999px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 24px;
            width: 24px;
            left: 4px;
            bottom: 4px;
            background: white;
            transition: 0.3s;
            border-radius: 50%;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        input:checked + .slider {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
        }

        input:checked + .slider:before {
            transform: translateX(24px);
        }

        .time-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .time-card {
            background: white;
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 1rem;
        }

        .time-label {
            font-weight: 700;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .time-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 1rem;
            transition: border-color 0.2s;
            font-family: inherit;
        }

        .time-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        }

        .actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1.5rem;
            align-items: center;
        }

        .btn {
            padding: 0.85rem 1.25rem;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-family: inherit;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            box-shadow: 0 6px 18px rgba(99, 102, 241, 0.35);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
        }

        .btn-outline {
            background: white;
            border: 2px solid var(--border);
            color: var(--text);
        }

        .btn-outline:hover {
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .note {
            font-size: 0.9rem;
            color: var(--text-light);
            font-style: italic;
        }

        .saved-alert {
            display: none;
            margin-top: 1rem;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            background: rgba(16, 185, 129, 0.1);
            border: 2px solid rgba(16, 185, 129, 0.25);
            color: #065F46;
            font-weight: 600;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 1024px) {
            .sidebar { transform: translateX(-100%); }
            .main-content { margin-left: 0; }
        }

        @media (max-width: 768px) {
            .main-content { padding: 1.5rem; }
            .topbar { padding: 1.5rem; }
            .days-selector { grid-template-columns: repeat(auto-fit, minmax(100px, 1fr)); }
            .tabs-container { overflow-x: auto; }
        }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-content">
            <div class="logo-icon">CD</div>
            <div class="logo-text">Clinique Digitale</div>
        </div>
    </div>

    <nav class="sidebar-menu">
        <div class="menu-section">
            <div class="menu-section-title">Menu Principal</div>
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="menu-item">
                <span class="menu-icon">🏠</span>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="menu-item">
                <span class="menu-icon">📅</span>
                <span>Rendez-vous</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="menu-item active">
                <span class="menu-icon">🕐</span>
                <span>Disponibilités</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/patients" class="menu-item">
                <span class="menu-icon">👥</span>
                <span>Patients</span>
            </a>
        </div>

        <div class="menu-section">
            <div class="menu-section-title">Gestion</div>
            <a href="${pageContext.request.contextPath}/doctor/reports" class="menu-item">
                <span class="menu-icon">📊</span>
                <span>Rapports</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/settings" class="menu-item">
                <span class="menu-icon">⚙️</span>
                <span>Paramètres</span>
            </a>
        </div>
    </nav>

    <div class="sidebar-footer">
        <div class="user-profile">
            <div class="user-avatar">Dr</div>
            <div class="user-info">
                <h4>Dr. ${sessionScope.user.firstName}</h4>
                <p>Médecin</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <span>🚪</span>
            <span>Déconnexion</span>
        </a>
    </div>
</aside>

<!-- MAIN CONTENT -->
<main class="main-content">
    <div class="topbar">
        <div>
            <h1>🕐 Gestion des disponibilités</h1>
            <p class="topbar-subtitle">Définissez vos créneaux de disponibilité hebdomadaires</p>
        </div>
    </div>

    <div class="availability-container">
        <div class="tabs-container">
            <button class="tab-button active" data-tab="weekly">
                <span class="tab-icon">📅</span> Semaine complète
            </button>
            <button class="tab-button" data-tab="daily">
                <span class="tab-icon">🗓️</span> Par jour
            </button>
        </div>

        <section id="tab-weekly" class="tab-content active">
            <div class="weekly-mode">
                <div class="weekly-header">
                    <div class="weekly-icon">📆</div>
                    <div class="weekly-info">
                        <h3>Appliquer les mêmes horaires à plusieurs jours</h3>
                        <p>Sélectionnez les jours concernés puis définissez une plage horaire</p>
                    </div>
                </div>

                <div class="days-selector">
                    <div class="day-checkbox">
                        <input id="day-lundi" type="checkbox"/>
                        <label for="day-lundi">
                            <span class="day-initial">L</span>
                            <span>Lundi</span>
                        </label>
                    </div>
                    <div class="day-checkbox">
                        <input id="day-mardi" type="checkbox"/>
                        <label for="day-mardi">
                            <span class="day-initial">M</span>
                            <span>Mardi</span>
                        </label>
                    </div>
                    <div class="day-checkbox">
                        <input id="day-mercredi" type="checkbox"/>
                        <label for="day-mercredi">
                            <span class="day-initial">M</span>
                            <span>Mercredi</span>
                        </label>
                    </div>
                    <div class="day-checkbox">
                        <input id="day-jeudi" type="checkbox"/>
                        <label for="day-jeudi">
                            <span class="day-initial">J</span>
                            <span>Jeudi</span>
                        </label>
                    </div>
                    <div class="day-checkbox">
                        <input id="day-vendredi" type="checkbox"/>
                        <label for="day-vendredi">
                            <span class="day-initial">V</span>
                            <span>Vendredi</span>
                        </label>
                    </div>
                    <div class="day-checkbox">
                        <input id="day-samedi" type="checkbox"/>
                        <label for="day-samedi">
                            <span class="day-initial">S</span>
                            <span>Samedi</span>
                        </label>
                    </div>
                    <div class="day-checkbox">
                        <input id="day-dimanche" type="checkbox"/>
                        <label for="day-dimanche">
                            <span class="day-initial">D</span>
                            <span>Dimanche</span>
                        </label>
                    </div>
                </div>

                <div class="time-grid">
                    <div class="time-card">
                        <label for="weekly-start" class="time-label">Heure de début</label>
                        <input id="weekly-start" class="time-input" type="time" value="08:00"/>
                    </div>
                    <div class="time-card">
                        <label for="weekly-end" class="time-label">Heure de fin</label>
                        <input id="weekly-end" class="time-input" type="time" value="17:00"/>
                    </div>
                </div>

                <div class="actions">
                    <button id="apply-weekly" class="btn btn-primary">✓ Appliquer aux jours sélectionnés</button>
                    <span class="note">💡 Personnalisez chaque jour dans l'onglet "Par jour"</span>
                </div>
            </div>
        </section>

        <section id="tab-daily" class="tab-content">
            <div class="week-grid" id="week-grid">
                <!-- Les cartes de jours seront injectées par JS -->
            </div>
        </section>

        <div class="actions" style="border-top: 2px solid var(--border); padding-top: 2rem;">
            <button id="save-all" class="btn btn-primary">💾 Sauvegarder les disponibilités</button>
            <button id="reset-all" class="btn btn-outline">🔄 Réinitialiser tout</button>
        </div>
        <div id="saved-alert" class="saved-alert">
            ✅ Vos disponibilités ont été sauvegardées avec succès !
        </div>
    </div>
</main>

<script>
    const days = [
        { key: 'lundi', label: 'Lundi', icon: '📅' },
        { key: 'mardi', label: 'Mardi', icon: '📅' },
        { key: 'mercredi', label: 'Mercredi', icon: '📅' },
        { key: 'jeudi', label: 'Jeudi', icon: '📅' },
        { key: 'vendredi', label: 'Vendredi', icon: '📅' },
        { key: 'samedi', label: 'Samedi', icon: '📅' },
        { key: 'dimanche', label: 'Dimanche', icon: '📅' }
    ];

    const state = JSON.parse(localStorage.getItem('doctor_availability') || '{}');

    function renderDayCards() {
        const grid = document.getElementById('week-grid');
        grid.innerHTML = '';
        days.forEach(d => {
            const dayState = state[d.key] || { active: false, start: '08:00', end: '17:00' };
            const card = document.createElement('div');
            card.className = 'day-card';
            card.innerHTML = `
                <div class="day-header">
                    <div class="day-name">${d.icon} ${d.label}</div>
                    <label class="switch">
                        <input type="checkbox" ${dayState.active ? 'checked' : ''} data-day="${d.key}" class="toggle-active">
                        <span class="slider"></span>
                    </label>
                </div>
                <div class="time-grid">
                    <div class="time-card">
                        <div class="time-label">Début</div>
                        <input type="time" class="time-input input-start" data-day="${d.key}" value="${dayState.start}" ${dayState.active ? '' : 'disabled'}>
                    </div>
                    <div class="time-card">
                        <div class="time-label">Fin</div>
                        <input type="time" class="time-input input-end" data-day="${d.key}" value="${dayState.end}" ${dayState.active ? '' : 'disabled'}>
                    </div>
                </div>
            `;
            grid.appendChild(card);
        });

        grid.querySelectorAll('.toggle-active').forEach(chk => {
            chk.addEventListener('change', e => {
                const key = e.target.getAttribute('data-day');
                state[key] = state[key] || { start: '08:00', end: '17:00', active: false };
                state[key].active = e.target.checked;
                saveLocal(false);
                renderDayCards();
            });
        });

        grid.querySelectorAll('.input-start').forEach(inp => {
            inp.addEventListener('change', e => {
                const key = e.target.getAttribute('data-day');
                state[key] = state[key] || { start: '08:00', end: '17:00', active: true };
                state[key].start = e.target.value;
                saveLocal(false);
            });
        });

        grid.querySelectorAll('.input-end').forEach(inp => {
            inp.addEventListener('change', e => {
                const key = e.target.getAttribute('data-day');
                state[key] = state[key] || { start: '08:00', end: '17:00', active: true };
                state[key].end = e.target.value;
                saveLocal(false);
            });
        });
    }

    function applyWeekly() {
        const start = document.getElementById('weekly-start').value;
        const end = document.getElementById('weekly-end').value;
        const selected = Array.from(document.querySelectorAll('.days-selector input:checked'))
            .map(i => i.id.replace('day-', ''));

        if (selected.length === 0) {
            alert('⚠️ Veuillez sélectionner au moins un jour');
            return;
        }

        selected.forEach(key => {
            state[key] = { active: true, start, end };
        });
        saveLocal(false);
        renderDayCards();

        // Switch to daily tab to show results
        document.querySelector('[data-tab="daily"]').click();
    }

    function saveLocal(showAlert = true) {
        localStorage.setItem('doctor_availability', JSON.stringify(state));
        if (showAlert) {
            const el = document.getElementById('saved-alert');
            el.style.display = 'block';
            setTimeout(() => el.style.display = 'none', 3000);
        }
    }

    function resetAll() {
        if (confirm('⚠️ Êtes-vous sûr de vouloir réinitialiser toutes les disponibilités ?')) {
            Object.keys(state).forEach(k => delete state[k]);
            localStorage.removeItem('doctor_availability');
            document.querySelectorAll('.days-selector input').forEach(i => i.checked = false);
            document.getElementById('weekly-start').value = '08:00';
            document.getElementById('weekly-end').value = '17:00';
            renderDayCards();
            alert('✅ Disponibilités réinitialisées avec succès');
        }
    }

    // Tabs
    document.querySelectorAll('.tab-button').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            const tab = btn.dataset.tab;
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            document.getElementById(`tab-${tab}`).classList.add('active');
        });
    });

    document.getElementById('apply-weekly').addEventListener('click', applyWeekly);
    document.getElementById('save-all').addEventListener('click', () => saveLocal(true));
    document.getElementById('reset-all').addEventListener('click', resetAll);

    // Initial render
    renderDayCards();
</script>
</body>
</html>

