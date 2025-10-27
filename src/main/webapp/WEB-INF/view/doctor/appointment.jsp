<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Mes Rendez-vous - Clinique Digitale</title>
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

        .appointments-container {
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

        .filters-bar {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 0.75rem 1.5rem;
            background: white;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--text);
            font-family: inherit;
            font-size: 0.95rem;
        }

        .filter-btn:hover {
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .filter-btn.active {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-color: var(--primary);
            color: white;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
        }

        .appointments-grid {
            display: grid;
            gap: 1.5rem;
        }

        .appointment-card {
            background: white;
            border-radius: 16px;
            padding: 1.75rem;
            border: 2px solid var(--border);
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
        }

        .appointment-card:hover {
            border-color: var(--primary);
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
        }

        .appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.25rem;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .patient-info h3 {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .patient-info p {
            color: var(--text-light);
            font-size: 0.95rem;
            font-weight: 500;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            white-space: nowrap;
        }

        .status-badge.pending {
            background: rgba(249, 158, 11, 0.15);
            color: #F59E0B;
        }

        .status-badge.confirmed {
            background: rgba(16, 185, 129, 0.15);
            color: #10B981;
        }

        .status-badge.cancelled {
            background: rgba(239, 68, 68, 0.15);
            color: #EF4444;
        }

        .appointment-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .detail-icon {
            width: 40px;
            height: 40px;
            background: rgba(99, 102, 241, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .detail-text {
            flex: 1;
        }

        .detail-label {
            font-size: 0.8rem;
            color: var(--text-light);
            margin-bottom: 0.25rem;
            font-weight: 600;
        }

        .detail-value {
            font-weight: 700;
            color: var(--text);
        }

        .appointment-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.75rem 1.25rem;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-family: inherit;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success), #34D399);
            color: white;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger), #DC2626);
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
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

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            color: var(--text);
            margin-bottom: 1rem;
            font-weight: 800;
        }

        .empty-state p {
            color: var(--text-light);
            font-size: 1.1rem;
        }

        @media (max-width: 1024px) {
            .sidebar { transform: translateX(-100%); }
            .main-content { margin-left: 0; }
        }

        @media (max-width: 768px) {
            .main-content { padding: 1.5rem; }
            .topbar { padding: 1.5rem; }
            .appointment-details { grid-template-columns: 1fr; }
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
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="menu-item active">
                <span class="menu-icon">📅</span>
                <span>Rendez-vous</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="menu-item">
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
            <h1>📋 Mes Rendez-vous</h1>
            <p class="topbar-subtitle">Gérez vos rendez-vous avec vos patients</p>
        </div>
    </div>

    <div class="appointments-container">
        <div class="filters-bar">
            <button class="filter-btn active" data-filter="all">Tous</button>
            <button class="filter-btn" data-filter="pending">En attente</button>
            <button class="filter-btn" data-filter="confirmed">Confirmés</button>
            <button class="filter-btn" data-filter="cancelled">Annulés</button>
        </div>

        <div class="appointments-grid" id="appointmentsGrid">
            <!-- Sample appointments -->
            <div class="appointment-card" data-status="pending">
                <div class="appointment-header">
                    <div class="patient-info">
                        <h3>👤 Jean Dupont</h3>
                        <p>jean.dupont@email.com | 06 12 34 56 78</p>
                    </div>
                    <span class="status-badge pending">En attente</span>
                </div>
                <div class="appointment-details">
                    <div class="detail-item">
                        <div class="detail-icon">📅</div>
                        <div class="detail-text">
                            <div class="detail-label">Date</div>
                            <div class="detail-value">25 Octobre 2025</div>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-icon">🕐</div>
                        <div class="detail-text">
                            <div class="detail-label">Heure</div>
                            <div class="detail-value">10:00 - 10:30</div>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-icon">💊</div>
                        <div class="detail-text">
                            <div class="detail-label">Type</div>
                            <div class="detail-value">Consultation générale</div>
                        </div>
                    </div>
                </div>
                <div class="appointment-actions">
                    <button class="btn btn-success">✓ Confirmer</button>
                    <button class="btn btn-danger">✗ Annuler</button>
                    <button class="btn btn-outline">👁 Détails</button>
                </div>
            </div>

            <div class="appointment-card" data-status="confirmed">
                <div class="appointment-header">
                    <div class="patient-info">
                        <h3>👤 Marie Martin</h3>
                        <p>marie.martin@email.com | 06 98 76 54 32</p>
                    </div>
                    <span class="status-badge confirmed">Confirmé</span>
                </div>
                <div class="appointment-details">
                    <div class="detail-item">
                        <div class="detail-icon">📅</div>
                        <div class="detail-text">
                            <div class="detail-label">Date</div>
                            <div class="detail-value">26 Octobre 2025</div>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-icon">🕐</div>
                        <div class="detail-text">
                            <div class="detail-label">Heure</div>
                            <div class="detail-value">14:00 - 14:30</div>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-icon">💊</div>
                        <div class="detail-text">
                            <div class="detail-label">Type</div>
                            <div class="detail-value">Suivi médical</div>
                        </div>
                    </div>
                </div>
                <div class="appointment-actions">
                    <button class="btn btn-outline">📝 Ajouter notes</button>
                    <button class="btn btn-danger">✗ Annuler</button>
                </div>
            </div>

            <div class="appointment-card" data-status="cancelled">
                <div class="appointment-header">
                    <div class="patient-info">
                        <h3>👤 Pierre Dubois</h3>
                        <p>pierre.dubois@email.com | 06 55 44 33 22</p>
                    </div>
                    <span class="status-badge cancelled">Annulé</span>
                </div>
                <div class="appointment-details">
                    <div class="detail-item">
                        <div class="detail-icon">📅</div>
                        <div class="detail-text">
                            <div class="detail-label">Date</div>
                            <div class="detail-value">24 Octobre 2025</div>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-icon">🕐</div>
                        <div class="detail-text">
                            <div class="detail-label">Heure</div>
                            <div class="detail-value">09:00 - 09:30</div>
                        </div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-icon">💊</div>
                        <div class="detail-text">
                            <div class="detail-label">Type</div>
                            <div class="detail-value">Consultation urgente</div>
                        </div>
                    </div>
                </div>
                <div class="appointment-actions">
                    <button class="btn btn-outline">👁 Voir détails</button>
                </div>
            </div>
        </div>

        <div class="empty-state" style="display: none;" id="emptyState">
            <div class="empty-state-icon">📭</div>
            <h3>Aucun rendez-vous</h3>
            <p>Vous n'avez aucun rendez-vous correspondant aux filtres sélectionnés.</p>
        </div>
    </div>
</main>

<script>
    const filterBtns = document.querySelectorAll('.filter-btn');
    const appointmentCards = document.querySelectorAll('.appointment-card');
    const emptyState = document.getElementById('emptyState');
    const grid = document.getElementById('appointmentsGrid');

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            filterBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const filter = btn.dataset.filter;
            let visibleCount = 0;

            appointmentCards.forEach(card => {
                if (filter === 'all' || card.dataset.status === filter) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            if (visibleCount === 0) {
                grid.style.display = 'none';
                emptyState.style.display = 'block';
            } else {
                grid.style.display = 'grid';
                emptyState.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>

