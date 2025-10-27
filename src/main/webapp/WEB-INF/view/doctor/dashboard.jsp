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

        /* SIDEBAR CLAIR ET MODERNE */
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

        .logo-content:hover {
            transform: scale(1.02);
        }

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
            position: relative;
            overflow: hidden;
        }

        .logo-icon::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .logo-text {
            font-size: 1.25rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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

        .menu-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 4px;
            height: 100%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            transform: scaleY(0);
            transition: transform 0.3s ease;
            border-radius: 0 4px 4px 0;
        }

        .menu-item:hover {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.08), rgba(236, 72, 153, 0.08));
            color: var(--primary);
            transform: translateX(5px);
        }

        .menu-item:hover::before {
            transform: scaleY(1);
        }

        .menu-item.active {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
            transform: translateX(5px);
        }

        .menu-item.active::before {
            display: none;
        }

        .menu-item svg {
            width: 22px;
            height: 22px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
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
            transition: all 0.3s ease;
        }

        .user-profile:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
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
            flex-shrink: 0;
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
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            justify-content: center;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.08), rgba(248, 113, 113, 0.08));
            border-color: var(--danger);
            color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
        }

        .logout-btn svg {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
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
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.5);
            animation: fadeInDown 0.6s ease-out;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .topbar-left h1 {
            font-size: 2rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .topbar-subtitle {
            color: var(--text-light);
            font-size: 1rem;
            font-weight: 500;
        }

        .btn {
            padding: 1rem 2rem;
            border-radius: 14px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(99, 102, 241, 0.5);
        }

        .btn svg {
            width: 20px;
            height: 20px;
            position: relative;
            z-index: 1;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        /* STATS GRID */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255, 255, 255, 0.5);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out both;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--card-color-1), var(--card-color-2));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.12);
        }

        .stat-card:nth-child(1) { --card-color-1: #6366F1; --card-color-2: #818CF8; }
        .stat-card:nth-child(2) { --card-color-1: #10B981; --card-color-2: #34D399; }
        .stat-card:nth-child(3) { --card-color-1: #EC4899; --card-color-2: #F472B6; }
        .stat-card:nth-child(4) { --card-color-1: #F59E0B; --card-color-2: #FBBF24; }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }

        .stat-icon {
            width: 64px;
            height: 64px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            flex-shrink: 0;
        }

        .stat-icon::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, var(--icon-color-1), var(--icon-color-2));
            opacity: 0.15;
            border-radius: 16px;
        }

        .stat-icon.primary { --icon-color-1: #6366F1; --icon-color-2: #818CF8; }
        .stat-icon.success { --icon-color-1: #10B981; --icon-color-2: #34D399; }
        .stat-icon.warning { --icon-color-1: #F59E0B; --icon-color-2: #FBBF24; }
        .stat-icon.info { --icon-color-1: #EC4899; --icon-color-2: #F472B6; }

        .stat-icon svg {
            width: 32px;
            height: 32px;
            stroke: var(--icon-color-1);
            fill: none;
            stroke-width: 2;
            position: relative;
            z-index: 1;
        }

        .stat-label {
            color: var(--text-light);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.75rem;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--text);
            line-height: 1;
        }

        /* SECTION */
        .section {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.5);
            animation: fadeInUp 0.6s ease-out;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .section-title svg {
            width: 28px;
            height: 28px;
            stroke: var(--primary);
            fill: none;
            stroke-width: 2;
        }

        .appointment-card {
            background: white;
            border-radius: 16px;
            padding: 1.75rem;
            margin-bottom: 1.25rem;
            border: 2px solid var(--border);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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

        .appointment-time {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
        }

        .appointment-time svg {
            width: 18px;
            height: 18px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .btn-sm {
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .btn-sm.primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .btn-sm.primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(99, 102, 241, 0.4);
        }

        .btn-sm svg {
            width: 18px;
            height: 18px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            color: var(--text);
            margin-bottom: 1rem;
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
            .topbar-left h1 { font-size: 1.5rem; }
            .stats-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<!-- SIDEBAR CLAIR -->
<aside class="sidebar">
    <div class="sidebar-logo">
        <div class="logo-content">
            <div class="logo-icon">CD</div>
            <div class="logo-text">Clinique Digitale</div>
        </div>
    </div>

    <nav class="sidebar-menu">
        <div class="menu-section">
            <div class="menu-section-title">Navigation</div>
            <a href="#dashboard" class="menu-item active">
                <svg viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/></svg>
                Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availability" class="menu-item">
                <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>
                Disponibilités
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="menu-item">
                <svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
                Rendez-vous
            </a>
        </div>

        <div class="menu-section">
            <div class="menu-section-title">Patients</div>
            <a href="#patients" class="menu-item">
                <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                Mes patients
            </a>
            <a href="#dossiers" class="menu-item">
                <svg viewBox="0 0 24 24"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"/><path d="M13 2v7h7"/></svg>
                Dossiers médicaux
            </a>
        </div>
    </nav>

    <div class="sidebar-footer">
        <div class="user-profile">
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty sessionScope.user.name}">${sessionScope.user.name.substring(0, 1).toUpperCase()}</c:when>
                    <c:otherwise>D</c:otherwise>
                </c:choose>
            </div>
            <div class="user-info">
                <h4><c:choose><c:when test="${not empty sessionScope.user.name}">${sessionScope.user.name}</c:when><c:otherwise>Dr. Médecin</c:otherwise></c:choose></h4>
                <p>Médecin spécialiste</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn">
            <svg viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            Se déconnecter
        </a>
    </div>
</aside>

<!-- MAIN CONTENT -->
<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Bienvenue Dr. <c:choose><c:when test="${not empty sessionScope.user.name}">${sessionScope.user.name}</c:when><c:otherwise>Médecin</c:otherwise></c:choose> 👋</h1>
            <p class="topbar-subtitle">Gérez vos consultations et suivez vos patients</p>
        </div>
        <div class="topbar-actions">
            <a href="${pageContext.request.contextPath}/doctor/availability" class="btn btn-primary">
                <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>
                Gérer mes disponibilités
            </a>
        </div>
    </div>

    <!-- STATS -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <span class="stat-label">Consultations du jour</span>
                    <div class="stat-value"><c:choose><c:when test="${not empty appointmentsCount}">${appointmentsCount}</c:when><c:otherwise>0</c:otherwise></c:choose></div>
                </div>
                <div class="stat-icon primary">
                    <svg viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <span class="stat-label">Heures disponibles</span>
                    <div class="stat-value"><c:choose><c:when test="${not empty availableHours}">${availableHours}h</c:when><c:otherwise>0h</c:otherwise></c:choose></div>
                </div>
                <div class="stat-icon success">
                    <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <span class="stat-label">Patients actifs</span>
                    <div class="stat-value"><c:choose><c:when test="${not empty patientsCount}">${patientsCount}</c:when><c:otherwise>0</c:otherwise></c:choose></div>
                </div>
                <div class="stat-icon info">
                    <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6"/></svg>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <span class="stat-label">Ce mois</span>
                    <div class="stat-value"><c:choose><c:when test="${not empty monthConsultations}">${monthConsultations}</c:when><c:otherwise>0</c:otherwise></c:choose></div>
                </div>
                <div class="stat-icon warning">
                    <svg viewBox="0 0 24 24"><path d="M3 21h18"/><rect x="5" y="10" width="3" height="8" rx="1"/><rect x="10.5" y="6" width="3" height="12" rx="1"/><rect x="16" y="13" width="3" height="5" rx="1"/></svg>
                </div>
            </div>
        </div>
    </div>

    <!-- APPOINTMENTS -->
    <section class="section">
        <div class="section-header">
            <h2 class="section-title">
                <svg viewBox="0 0 24 24"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
                Mes rendez-vous du jour
            </h2>
        </div>

        <c:choose>
            <c:when test="${empty appointments}">
                <div class="empty-state">
                    <h3>🎉 Aucun rendez-vous prévu</h3>
                    <p>Vous n'avez pas de rendez-vous programmés aujourd'hui. Profitez de votre journée !</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="a" items="${appointments}">
                    <div class="appointment-card">
                        <div class="appointment-header">
                            <div class="patient-info">
                                <h3><c:out value="${a.patient.user.name}"/></h3>
                                <p><c:choose><c:when test="${not empty a.type}">Type: <c:out value="${a.type}"/></c:when><c:otherwise>Consultation générale</c:otherwise></c:choose></p>
                            </div>
                            <div class="appointment-time">
                                <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/></svg>
                                <c:out value="${a.hour}"/>
                            </div>
                        </div>
                        <button class="btn-sm primary">
                            <svg viewBox="0 0 24 24"><path d="M2 12s4-6 10-6 10 6 10 6-4 6-10 6-10-6-10-6z"/><circle cx="12" cy="12" r="2"/></svg>
                            Voir le dossier
                        </button>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </section>
</main>

</body>
</html>
