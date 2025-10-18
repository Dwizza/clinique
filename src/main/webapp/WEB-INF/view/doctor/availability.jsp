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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --primary: #6366F1;
            --primary-dark: #4F46E5;
            --primary-light: #818CF8;
            --secondary: #EC4899;
            --accent: #F59E0B;
            --success: #10B981;
            --warning: #F59E0B;
            --error: #EF4444;
            --info: #3B82F6;
            --text: #1F2937;
            --text-light: #6B7280;
            --text-lighter: #9CA3AF;
            --bg: #F9FAFB;
            --card-bg: #FFFFFF;
            --border: #E5E7EB;
            --sidebar-bg: #1F2937;
            --sidebar-hover: #374151;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            overflow-x: hidden;
            color: var(--text);
        }

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 280px;
            background: var(--sidebar-bg);
            padding: 2rem 0;
            z-index: 100;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 24px rgba(0,0,0,0.1);
        }

        .sidebar-logo {
            padding: 0 1.5rem 2rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 1.5rem;
        }

        .logo-content {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            color: white;
            font-size: 1.2rem;
            box-shadow: 0 4px 12px rgba(99,102,241,0.3);
        }

        .logo-text {
            color: white;
            font-size: 1.25rem;
            font-weight: 800;
        }

        .sidebar-menu {
            flex: 1;
            padding: 0 1rem;
            overflow-y: auto;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.25rem;
            margin-bottom: 0.5rem;
            border-radius: 12px;
            color: #D1D5DB;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .menu-item:hover {
            background: var(--sidebar-hover);
            color: white;
        }

        .menu-item.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: white;
            box-shadow: 0 4px 12px rgba(99,102,241,0.4);
        }

        .menu-item svg {
            width: 22px;
            height: 22px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .sidebar-footer {
            padding: 1.5rem;
            border-top: 1px solid rgba(255,255,255,0.1);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: rgba(255,255,255,0.05);
            border-radius: 12px;
            margin-bottom: 1rem;
        }

        .user-avatar {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .user-info h4 {
            color: white;
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .user-info p {
            color: #9CA3AF;
            font-size: 0.8rem;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.85rem 1rem;
            background: rgba(239,68,68,0.1);
            border: 1px solid rgba(239,68,68,0.3);
            border-radius: 10px;
            color: #FCA5A5;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            width: 100%;
            justify-content: center;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: rgba(239,68,68,0.2);
            color: #EF4444;
        }

        .logout-btn svg {
            width: 18px;
            height: 18px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        /* MAIN CONTENT */
        .main-content {
            margin-left: 280px;
            padding: 2rem;
            min-height: 100vh;
        }

        .page-header {
            background: rgba(255,255,255,0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.5rem;
        }

        .page-description {
            color: var(--text-light);
            font-size: 0.95rem;
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-weight: 600;
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

        .availability-container {
            background: rgba(255,255,255,0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        }

        /* WEEK GRID */
        .week-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .day-card {
            background: var(--bg);
            border-radius: 14px;
            padding: 1rem;
            border: 2px solid var(--border);
            transition: all 0.3s ease;
        }

        .day-card:hover {
            border-color: var(--primary);
            box-shadow: 0 4px 16px rgba(99,102,241,0.1);
        }

        .day-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .day-name {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 0.65rem;
        }

        .day-icon {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 9px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 0.85rem;
        }

        .day-toggle {
            display: flex;
            align-items: center;
            gap: 0.65rem;
        }

        .toggle-label {
            font-weight: 600;
            color: var(--text-light);
            font-size: 0.8rem;
        }

        .toggle-switch {
            position: relative;
            width: 48px;
            height: 26px;
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
            border-radius: 26px;
            transition: 0.3s;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 4px;
            bottom: 4px;
            background: white;
            border-radius: 50%;
            transition: 0.3s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .toggle-switch input:checked + .toggle-slider {
            background: var(--success);
        }

        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(22px);
        }

        .time-slots {
            display: grid;
            gap: 0.75rem;
        }

        .time-slot {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 0.75rem;
            align-items: end;
        }

        .time-input-group {
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
        }

        .time-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-light);
        }

        .time-input {
            padding: 0.6rem 0.8rem;
            border: 2px solid var(--border);
            border-radius: 9px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text);
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        .time-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
        }

        .time-input:disabled {
            background: #F1F5F9;
            color: var(--text-light);
            cursor: not-allowed;
        }

        .btn-add-slot {
            padding: 0.6rem 1.1rem;
            background: linear-gradient(135deg, var(--success), #16A34A);
            color: white;
            border: none;
            border-radius: 9px;
            font-weight: 600;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            margin-top: 0.65rem;
        }

        .btn-add-slot:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(34,197,94,0.3);
        }

        .btn-add-slot:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .btn-remove-slot {
            padding: 0.6rem;
            background: var(--error);
            color: white;
            border: none;
            border-radius: 9px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
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
            padding: 0.9rem 2rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(99,102,241,0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 24px rgba(99,102,241,0.4);
        }

        .btn-secondary {
            padding: 0.9rem 2rem;
            background: var(--bg);
            color: var(--text);
            border: 2px solid var(--border);
            border-radius: 12px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: white;
            border-color: var(--primary);
            color: var(--primary);
        }

        .disabled-overlay {
            opacity: 0.5;
            pointer-events: none;
        }

        /* RESPONSIVE */
        @media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1.5rem;
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
        }

        .icon { stroke: currentColor; fill: none; stroke-width: 2; }
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
        <a href="${pageContext.request.contextPath}/doctor/dashboard" class="menu-item">
            <svg class="icon" viewBox="0 0 24 24">
                <rect x="3" y="3" width="7" height="7" rx="1"/>
                <rect x="14" y="3" width="7" height="7" rx="1"/>
                <rect x="14" y="14" width="7" height="7" rx="1"/>
                <rect x="3" y="14" width="7" height="7" rx="1"/>
            </svg>
            Tableau de bord
        </a>
        <a href="${pageContext.request.contextPath}/doctor/availability" class="menu-item active">
            <svg class="icon" viewBox="0 0 24 24">
                <circle cx="12" cy="12" r="9"/>
                <path d="M12 7v5l3 2"/>
            </svg>
            Gérer les disponibilités
        </a>
        <a href="${pageContext.request.contextPath}/doctor/appointments" class="menu-item">
            <svg class="icon" viewBox="0 0 24 24">
                <rect x="3" y="4" width="18" height="18" rx="2"/>
                <path d="M16 2v4M8 2v4M3 10h18"/>
            </svg>
            Gérer les rendez-vous
        </a>
    </nav>

    <div class="sidebar-footer">
        <div class="user-profile">
            <div class="user-avatar">DR</div>
            <div class="user-info">
                <h4>Dr. Médecin</h4>
                <p>Médecin</p>
            </div>
        </div>
        <button class="logout-btn" onclick="logout()">
            <svg class="icon" viewBox="0 0 24 24">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                <polyline points="16 17 21 12 16 7"/>
                <line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            Se déconnecter
        </button>
    </div>
</aside>

<!-- MAIN CONTENT -->
<main class="main-content">
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
</main>

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
            window.location.href = '${pageContext.request.contextPath}/auth/logout';
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
