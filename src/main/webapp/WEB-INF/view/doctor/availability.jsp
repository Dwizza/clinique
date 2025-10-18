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
            max-width:1600px;
            margin:0 auto;
            padding:1.5rem 2.5rem;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:2rem;
        }

        .logo-section {
            display:flex;
            align-items:center;
            gap:1rem;
        }

        .logo-icon {
            width:50px;
            height:50px;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            border-radius:14px;
            display:flex;
            align-items:center;
            justify-content:center;
            box-shadow:0 8px 20px rgba(14,165,233,0.35);
            font-weight:900;
            color:white;
            font-size:1.2rem;
        }

        .logo-text {
            font-size:1.5rem;
            font-weight:900;
            background:linear-gradient(135deg,var(--primary),var(--secondary));
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
        }

        .nav-links {
            display:flex;
            gap:0.5rem;
            align-items:center;
        }

        .nav-link {
            padding:0.75rem 1.5rem;
            border-radius:10px;
            text-decoration:none;
            color:var(--text);
            font-weight:600;
            transition:all 0.3s ease;
            font-size:0.95rem;
        }

        .nav-link:hover {
            background:var(--bg);
            color:var(--primary);
        }

        .nav-link.active {
            background:var(--primary);
            color:white;
        }

        .btn-logout {
            padding:0.75rem 1.5rem;
            background:linear-gradient(135deg,var(--error),#DC2626);
            color:white;
            border:none;
            border-radius:10px;
            font-weight:600;
            cursor:pointer;
            transition:all 0.3s ease;
            font-size:0.95rem;
        }

        .btn-logout:hover {
            transform:translateY(-2px);
            box-shadow:0 8px 20px rgba(239,68,68,0.4);
        }

        .main-container {
            position: relative;
            z-index: 1;
            max-width: 1600px;
            margin: 2rem auto;
            padding: 0 2.5rem 2.5rem;
        }

        .page-header {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(24px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.08);
            animation: fadeInUp 0.6s ease-out;
            border: 1px solid var(--border);
        }

        @keyframes fadeInUp {
            from {opacity:0;transform:translateY(30px);}
            to {opacity:1;transform:translateY(0);}
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .page-description {
            color: var(--text-light);
            font-size: 1rem;
        }

        .availability-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(24px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.08);
            animation: fadeInUp 0.8s ease-out;
            border: 1px solid var(--border);
        }

        /* Tabs Style */
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
            from {opacity:0;transform:translateY(10px);}
            to {opacity:1;transform:translateY(0);}
        }

        /* Weekly Mode Style */
        .weekly-mode {
            background: linear-gradient(135deg, rgba(14,165,233,0.08), rgba(139,92,246,0.08));
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
            box-shadow: 0 8px 24px rgba(14,165,233,0.3);
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
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border-color: var(--primary);
            color: white;
            box-shadow: 0 8px 24px rgba(14,165,233,0.3);
            transform: translateY(-4px);
        }

        .day-initial {
            width: 45px;
            height: 45px;
            background: var(--bg);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 800;
        }

        .day-checkbox input:checked + label .day-initial {
            background: rgba(255,255,255,0.2);
            color: white;
        }

        .week-grid {
            display: grid;
            gap: 1.5rem;
        }

        .day-card {
            background: var(--bg);
            border-radius: 16px;
            padding: 1.5rem;
            border: 2px solid var(--border);
            transition: all 0.3s ease;
        }

        .day-card:hover {
            border-color: var(--primary);
            box-shadow: 0 4px 20px rgba(14,165,233,0.15);
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

        .day-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
        }

        .day-toggle {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .toggle-label {
            font-weight: 600;
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .toggle-switch {
            position: relative;
            width: 60px;
            height: 32px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: #CBD5E1;
            border-radius: 32px;
            transition: 0.3s;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 24px;
            width: 24px;
            left: 4px;
            bottom: 4px;
            background: white;
            border-radius: 50%;
            transition: 0.3s;
        }

        .toggle-switch input:checked + .toggle-slider {
            background: var(--success);
        }

        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(28px);
        }

        .time-slots {
            display: grid;
            gap: 1rem;
        }

        .time-slot {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 1rem;
            align-items: center;
        }

        .time-input-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .time-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-light);
        }

        .time-input {
            padding: 0.75rem 1rem;
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            color: var(--text);
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        .time-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(14,165,233,0.1);
        }

        .time-input:disabled {
            background: #F1F5F9;
            color: var(--text-light);
            cursor: not-allowed;
        }

        .btn-add-slot {
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, var(--success), #16A34A);
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-add-slot:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(34,197,94,0.4);
        }

        .btn-add-slot:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .btn-remove-slot {
            padding: 0.75rem;
            background: var(--error);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-remove-slot:hover {
            background: #DC2626;
            transform: scale(1.1);
        }

        .btn-remove-slot:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid var(--border);
        }

        .btn-primary {
            padding: 1rem 2.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(14,165,233,0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(14,165,233,0.5);
        }

        .btn-secondary {
            padding: 1rem 2.5rem;
            background: var(--bg);
            color: var(--text);
            border: 2px solid var(--border);
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: white;
            border-color: var(--primary);
            color: var(--primary);
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-weight: 600;
            animation: slideInRight 0.5s ease-out;
        }

        @keyframes slideInRight {
            from {opacity:0;transform:translateX(50px);}
            to {opacity:1;transform:translateX(0);}
        }

        .alert-success {
            background: #DCFCE7;
            color: #166534;
            border: 2px solid #86EFAC;
        }

        .alert-error {
            background: #FEE2E2;
            color: #991B1B;
            border: 2px solid #FCA5A5;
        }

        .disabled-overlay {
            opacity: 0.5;
            pointer-events: none;
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                padding: 1rem;
            }

            .main-container {
                padding: 0 1rem 1rem;
            }

            .availability-container {
                padding: 1.5rem;
            }

            .time-slot {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-primary, .btn-secondary {
                width: 100%;
            }

            .tabs-container {
                flex-direction: column;
                gap: 0.5rem;
            }

            .tab-button {
                justify-content: center;
            }
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
                <div class="logo-icon">C+</div>
                <div class="logo-text">Clinique Digitale</div>
            </div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/doctor/dashboard" class="nav-link">Dashboard</a>
                <a href="${pageContext.request.contextPath}/doctor/availability" class="nav-link active">Disponibilités</a>
                <a href="${pageContext.request.contextPath}/doctor/appointments" class="nav-link">Rendez-vous</a>
                <button class="btn-logout" onclick="logout()">Déconnexion</button>
            </div>
        </nav>
    </header>

    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title">⏰ Gestion des Disponibilités</h1>
            <p class="page-description">Définissez vos horaires de disponibilité jour par jour</p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <span style="font-size: 1.5rem;">✓</span>
                ${successMessage}
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <span style="font-size: 1.5rem;">✕</span>
                ${errorMessage}
            </div>
        </c:if>

        <div class="availability-container">
            <!-- Daily Mode uniquement -->
            <div id="dailyContent">
                <form id="dailyForm" action="${pageContext.request.contextPath}/doctor/availability/save-daily" method="POST">
                    <div class="week-grid">
                        <!-- Lundi -->
                        <div class="day-card">
                            <div class="day-header">
                                <div class="day-name">
                                    <div class="day-icon">L</div>
                                    Lundi
                                </div>
                                <div class="day-toggle">
                                    <span class="toggle-label">Disponible</span>
                                    <label class="toggle-switch">
                                        <input type="checkbox" name="lundi_enabled" id="lundi_enabled" onchange="toggleDay('lundi', this)">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="lundi_slots" class="time-slots">
                                <div class="time-slot">
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de début</label>
                                        <input type="time" name="lundi_debut[]" class="time-input" value="08:00">
                                    </div>
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de fin</label>
                                        <input type="time" name="lundi_fin[]" class="time-input" value="17:00">
                                    </div>
                                    <button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-slot" id="lundi_add" onclick="addSlot('lundi')">+ Ajouter un créneau</button>
                        </div>

                        <!-- Mardi -->
                        <div class="day-card">
                            <div class="day-header">
                                <div class="day-name">
                                    <div class="day-icon">M</div>
                                    Mardi
                                </div>
                                <div class="day-toggle">
                                    <span class="toggle-label">Disponible</span>
                                    <label class="toggle-switch">
                                        <input type="checkbox" name="mardi_enabled" id="mardi_enabled" onchange="toggleDay('mardi', this)">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="mardi_slots" class="time-slots">
                                <div class="time-slot">
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de début</label>
                                        <input type="time" name="mardi_debut[]" class="time-input" value="08:00">
                                    </div>
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de fin</label>
                                        <input type="time" name="mardi_fin[]" class="time-input" value="17:00">
                                    </div>
                                    <button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-slot" id="mardi_add" onclick="addSlot('mardi')">+ Ajouter un créneau</button>
                        </div>

                        <!-- Mercredi -->
                        <div class="day-card">
                            <div class="day-header">
                                <div class="day-name">
                                    <div class="day-icon">M</div>
                                    Mercredi
                                </div>
                                <div class="day-toggle">
                                    <span class="toggle-label">Disponible</span>
                                    <label class="toggle-switch">
                                        <input type="checkbox" name="mercredi_enabled" id="mercredi_enabled" onchange="toggleDay('mercredi', this)">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="mercredi_slots" class="time-slots">
                                <div class="time-slot">
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de début</label>
                                        <input type="time" name="mercredi_debut[]" class="time-input" value="08:00">
                                    </div>
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de fin</label>
                                        <input type="time" name="mercredi_fin[]" class="time-input" value="17:00">
                                    </div>
                                    <button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-slot" id="mercredi_add" onclick="addSlot('mercredi')">+ Ajouter un créneau</button>
                        </div>

                        <!-- Jeudi -->
                        <div class="day-card">
                            <div class="day-header">
                                <div class="day-name">
                                    <div class="day-icon">J</div>
                                    Jeudi
                                </div>
                                <div class="day-toggle">
                                    <span class="toggle-label">Disponible</span>
                                    <label class="toggle-switch">
                                        <input type="checkbox" name="jeudi_enabled" id="jeudi_enabled" onchange="toggleDay('jeudi', this)">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="jeudi_slots" class="time-slots">
                                <div class="time-slot">
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de début</label>
                                        <input type="time" name="jeudi_debut[]" class="time-input" value="08:00">
                                    </div>
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de fin</label>
                                        <input type="time" name="jeudi_fin[]" class="time-input" value="17:00">
                                    </div>
                                    <button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-slot" id="jeudi_add" onclick="addSlot('jeudi')">+ Ajouter un créneau</button>
                        </div>

                        <!-- Vendredi -->
                        <div class="day-card">
                            <div class="day-header">
                                <div class="day-name">
                                    <div class="day-icon">V</div>
                                    Vendredi
                                </div>
                                <div class="day-toggle">
                                    <span class="toggle-label">Disponible</span>
                                    <label class="toggle-switch">
                                        <input type="checkbox" name="vendredi_enabled" id="vendredi_enabled" onchange="toggleDay('vendredi', this)">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="vendredi_slots" class="time-slots">
                                <div class="time-slot">
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de début</label>
                                        <input type="time" name="vendredi_debut[]" class="time-input" value="08:00">
                                    </div>
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de fin</label>
                                        <input type="time" name="vendredi_fin[]" class="time-input" value="17:00">
                                    </div>
                                    <button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-slot" id="vendredi_add" onclick="addSlot('vendredi')">+ Ajouter un créneau</button>
                        </div>

                        <!-- Samedi -->
                        <div class="day-card">
                            <div class="day-header">
                                <div class="day-name">
                                    <div class="day-icon">S</div>
                                    Samedi
                                </div>
                                <div class="day-toggle">
                                    <span class="toggle-label">Disponible</span>
                                    <label class="toggle-switch">
                                        <input type="checkbox" name="samedi_enabled" id="samedi_enabled" onchange="toggleDay('samedi', this)">
                                        <span class="toggle-slider"></span>
                                    </label>
                                </div>
                            </div>
                            <div id="samedi_slots" class="time-slots">
                                <div class="time-slot">
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de début</label>
                                        <input type="time" name="samedi_debut[]" class="time-input" value="08:00">
                                    </div>
                                    <div class="time-input-group">
                                        <label class="time-label">Heure de fin</label>
                                        <input type="time" name="samedi_fin[]" class="time-input" value="13:00">
                                    </div>
                                    <button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>
                                </div>
                            </div>
                            <button type="button" class="btn-add-slot" id="samedi_add" onclick="addSlot('samedi')">+ Ajouter un créneau</button>
                        </div>
                    </div>

                    <div class="action-buttons">
                        <button type="button" class="btn-secondary" onclick="resetDailyForm()">Réinitialiser</button>
                        <button type="submit" class="btn-primary">💾 Enregistrer les disponibilités</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Données serveurs pour pré-remplissage
        const availabilitiesData = {};
        <c:forEach var="a" items="${availabilities}">
            (function(){
                const day = '${a.jour}';
                const start = ('${a.heureDebut}'||'').substring(0,5);
                const end = ('${a.heureFin}'||'').substring(0,5);
                if (!availabilitiesData[day]) availabilitiesData[day] = [];
                availabilitiesData[day].push({ start: start, end: end });
            })();
        </c:forEach>

        const jours = ['lundi','mardi','mercredi','jeudi','vendredi','samedi'];
        const jourToKey = { LUNDI:'lundi', MARDI:'mardi', MERCREDI:'mercredi', JEUDI:'jeudi', VENDREDI:'vendredi', SAMEDI:'samedi' };

        // Daily Mode Functions
        function toggleDay(day, checkbox) {
            const slotsContainer = document.getElementById(day + '_slots');
            const addButton = document.getElementById(day + '_add');
            const inputs = slotsContainer.querySelectorAll('input');
            const buttons = slotsContainer.querySelectorAll('button');

            if (checkbox.checked) {
                slotsContainer.classList.remove('disabled-overlay');
                if (addButton) addButton.disabled = false;
                inputs.forEach(function(input){ input.disabled = false; });
                buttons.forEach(function(button){ button.disabled = false; });
            } else {
                slotsContainer.classList.add('disabled-overlay');
                if (addButton) addButton.disabled = true;
                inputs.forEach(function(input){ input.disabled = true; });
                buttons.forEach(function(button){ button.disabled = true; });
            }
        }

        function addSlot(day) {
            const slotsContainer = document.getElementById(day + '_slots');
            const newSlot = document.createElement('div');
            newSlot.className = 'time-slot';
            var html = ''
                + '<div class="time-input-group">'
                +   '<label class="time-label">Heure de début</label>'
                +   '<input type="time" name="' + day + '_debut[]" class="time-input" value="08:00">'
                + '</div>'
                + '<div class="time-input-group">'
                +   '<label class="time-label">Heure de fin</label>'
                +   '<input type="time" name="' + day + '_fin[]" class="time-input" value="17:00">'
                + '</div>'
                + '<button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>';
            newSlot.innerHTML = html;
            slotsContainer.appendChild(newSlot);
        }

        function removeSlot(button) {
            const slot = button.closest('.time-slot');
            const slotsContainer = slot.parentElement;

            if (slotsContainer.children.length > 1) {
                slot.remove();
            } else {
                alert('Vous devez garder au moins un créneau horaire par jour actif.');
            }
        }

        function resetDailyForm() {
            if (confirm('Êtes-vous sûr de vouloir réinitialiser tous les champs ?')) {
                document.getElementById('dailyForm').reset();

                const days = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'];
                days.forEach(function(day){
                    const checkbox = document.querySelector('input[name="' + day + '_enabled"]');
                    if (checkbox && checkbox.checked) {
                        checkbox.checked = false;
                        toggleDay(day, checkbox);
                    }

                    const slotsContainer = document.getElementById(day + '_slots');
                    while (slotsContainer && slotsContainer.children.length > 1) {
                        slotsContainer.removeChild(slotsContainer.lastChild);
                    }
                });
            }
        }

        function createSlotElement(day, start, end) {
            const slot = document.createElement('div');
            slot.className = 'time-slot';
            var s = start && start.length ? start : '08:00';
            var e = end && end.length ? end : '17:00';
            var html = ''
                + '<div class="time-input-group">'
                +   '<label class="time-label">Heure de début</label>'
                +   '<input type="time" name="' + day + '_debut[]" class="time-input" value="' + s + '">'
                + '</div>'
                + '<div class="time-input-group">'
                +   '<label class="time-label">Heure de fin</label>'
                +   '<input type="time" name="' + day + '_fin[]" class="time-input" value="' + e + '">'
                + '</div>'
                + '<button type="button" class="btn-remove-slot" onclick="removeSlot(this)">✕</button>';
            slot.innerHTML = html;
            return slot;
        }

        function initFromAvailabilities() {
            // Daily: pour chaque jour, activer et remplir les créneaux s'il y a des dispos; sinon, laisser décoché
            jours.forEach(function(day){
                const checkbox = document.getElementById(day + '_enabled');
                const slotsContainer = document.getElementById(day + '_slots');
                if (!checkbox || !slotsContainer) return;

                // Reset
                checkbox.checked = false;
                while (slotsContainer.firstChild) {
                    slotsContainer.removeChild(slotsContainer.firstChild);
                }

                var jourEnum = null;
                for (var k in jourToKey) { if (jourToKey[k] === day) { jourEnum = k; break; } }
                const slots = jourEnum ? (availabilitiesData[jourEnum] || []) : [];
                if (slots.length > 0) {
                    checkbox.checked = true;
                    slots.forEach(function(s){
                        const el = createSlotElement(day, s.start, s.end);
                        slotsContainer.appendChild(el);
                    });
                } else {
                    const defaultEnd = (day === 'samedi') ? '13:00' : '17:00';
                    slotsContainer.appendChild(createSlotElement(day, '08:00', defaultEnd));
                }
                toggleDay(day, checkbox);
            });
        }

        function logout() {
            if (confirm('Voulez-vous vraiment vous déconnecter ?')) {
                window.location.href = '${pageContext.request.contextPath}/logout';
            }
        }

        // Form Validation - Daily uniquement
        document.getElementById('dailyForm').addEventListener('submit', function(e) {
            e.preventDefault();

            const checkedDays = this.querySelectorAll('input[name$="_enabled"]:checked');
            // On autorise zéro jour coché (tout ON_LEAVE)

            for (var idx = 0; idx < checkedDays.length; idx++) {
                const chk = checkedDays[idx];
                const day = chk.name.replace('_enabled', '');
                const debutInputs = this.querySelectorAll('input[name="' + day + '_debut[]"]');
                const finInputs = this.querySelectorAll('input[name="' + day + '_fin[]"]');

                for (let i = 0; i < debutInputs.length; i++) {
                    const debut = debutInputs[i].value;
                    const fin = finInputs[i].value;

                    if (!debut || !fin) {
                        alert('Veuillez remplir tous les horaires pour ' + day);
                        return;
                    }

                    if (debut >= fin) {
                        alert('L\'heure de début doit être avant l\'heure de fin pour ' + day);
                        return;
                    }
                }
            }

            this.submit();
        });

        document.addEventListener('DOMContentLoaded', initFromAvailabilities);
    </script>
</body>
</html>
