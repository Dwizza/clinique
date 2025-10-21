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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

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
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow-x: hidden;
            color: var(--gray-800);
            line-height: 1.5;
            font-size: 14px;
        }

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 280px;
            background: var(--gray-800);
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
            box-shadow: var(--shadow-lg);
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
            background: var(--gray-700);
            color: white;
        }

        .menu-item.active {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            box-shadow: var(--shadow-lg);
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
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            box-shadow: var(--shadow-sm);
        }

        .user-info h4 {
            color: white;
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .user-info p {
            color: var(--gray-400);
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
        }

        .logout-btn:hover {
            background: rgba(239,68,68,0.2);
            color: var(--danger);
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

        .topbar {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .topbar h1 {
            font-size: 1.75rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .topbar-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-outline {
            background: white;
            color: var(--gray-700);
            border: 2px solid var(--gray-200);
        }

        .btn-outline:hover {
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        /* STATS GRID */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 0;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            border: 1px solid rgba(255,255,255,0.5);
            overflow: hidden;
            position: relative;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--card-gradient-1), var(--card-gradient-2));
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .stat-card:nth-child(1) {
            --card-gradient-1: #2563eb;
            --card-gradient-2: #3b82f6;
        }

        .stat-card:nth-child(2) {
            --card-gradient-1: #10b981;
            --card-gradient-2: #34d399;
        }

        .stat-card:nth-child(3) {
            --card-gradient-1: #8b5cf6;
            --card-gradient-2: #a78bfa;
        }

        .stat-card:nth-child(4) {
            --card-gradient-1: #f59e0b;
            --card-gradient-2: #fbbf24;
        }

        .stat-card-inner {
            padding: 1.5rem;
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .stat-content {
            flex: 1;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            flex-shrink: 0;
        }

        .stat-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--icon-gradient-1), var(--icon-gradient-2));
            opacity: 0.1;
            border-radius: 12px;
        }

        .stat-icon.primary {
            --icon-gradient-1: #2563eb;
            --icon-gradient-2: #3b82f6;
        }

        .stat-icon.success {
            --icon-gradient-1: #10b981;
            --icon-gradient-2: #34d399;
        }

        .stat-icon.warning {
            --icon-gradient-1: #f59e0b;
            --icon-gradient-2: #fbbf24;
        }

        .stat-icon.info {
            --icon-gradient-1: #8b5cf6;
            --icon-gradient-2: #a78bfa;
        }

        .stat-icon svg {
            width: 24px;
            height: 24px;
            stroke: var(--icon-gradient-1);
            fill: none;
            stroke-width: 2;
            position: relative;
            z-index: 1;
        }

        .stat-label {
            color: var(--gray-500);
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
            display: block;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--gray-800);
            line-height: 1;
            margin-bottom: 0.25rem;
        }

        .stat-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--gray-100);
        }

        .stat-trend {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.4rem 0.75rem;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .stat-trend.positive {
            background: linear-gradient(135deg, #dcfce7, #d1fae5);
            color: #047857;
        }

        .stat-trend.warning {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #b45309;
        }

        .stat-trend svg {
            width: 12px;
            height: 12px;
        }

        /* SECTIONS */
        .section {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title svg {
            width: 22px;
            height: 22px;
            stroke: var(--primary);
            fill: none;
            stroke-width: 2;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-badge.available {
            background: linear-gradient(135deg, #dcfce7, #d1fae5);
            color: #059669;
        }

        .status-badge.offline {
            background: var(--gray-100);
            color: var(--gray-600);
        }

        .status-badge svg {
            width: 14px;
            height: 14px;
        }

        /* APPOINTMENTS */
        .appointment-card {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1rem;
            border: 2px solid var(--gray-200);
            transition: all 0.3s ease;
        }

        .appointment-card:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .patient-info h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.25rem;
        }

        .patient-info p {
            color: var(--gray-600);
            font-size: 0.875rem;
        }

        .appointment-time {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-sm);
        }

        .appointment-time svg {
            width: 16px;
            height: 16px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .appointment-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--gray-600);
            font-size: 0.875rem;
        }

        .detail-item svg {
            width: 18px;
            height: 18px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .appointment-actions {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-sm.primary {
            background: var(--primary);
            color: white;
        }

        .btn-sm.outline {
            background: white;
            color: var(--gray-700);
            border: 2px solid var(--gray-200);
        }

        .btn-sm:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .btn-sm svg {
            width: 16px;
            height: 16px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        /* TIME SLOTS */
        .availability-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.25rem;
        }

        .time-slot {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 1.25rem;
            border: 2px solid var(--gray-200);
            transition: all 0.3s ease;
        }

        .time-slot:hover {
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .time-slot.active {
            border-color: var(--success);
            background: linear-gradient(135deg, rgba(16,185,129,0.05), rgba(52,211,153,0.05));
        }

        .slot-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .slot-time {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--gray-800);
        }

        .slot-toggle {
            width: 50px;
            height: 26px;
            background: var(--gray-200);
            border-radius: 13px;
            position: relative;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .slot-toggle.on {
            background: var(--success);
        }

        .slot-toggle::after {
            content: '';
            position: absolute;
            top: 3px;
            left: 3px;
            width: 20px;
            height: 20px;
            background: white;
            border-radius: 50%;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .slot-toggle.on::after {
            left: 27px;
        }

        .slot-info {
            color: var(--gray-600);
            font-size: 0.875rem;
            line-height: 1.6;
        }

        /* MODAL */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            backdrop-filter: blur(8px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            max-width: 600px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
            box-shadow: var(--shadow-xl);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .modal-title svg {
            width: 24px;
            height: 24px;
            stroke: var(--primary);
            fill: none;
            stroke-width: 2;
        }

        .close-modal {
            background: none;
            border: none;
            cursor: pointer;
            color: var(--gray-500);
            transition: all 0.3s ease;
            padding: 0.5rem;
            border-radius: 8px;
        }

        .close-modal:hover {
            background: var(--gray-100);
            color: var(--gray-800);
        }

        .close-modal svg {
            width: 20px;
            height: 20px;
            stroke: currentColor;
            fill: none;
            stroke-width: 2;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.85rem;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-family: inherit;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-group input[readonly] {
            background: var(--bg);
            font-weight: 600;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 140px;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99,102,241,0.1);
        }

        .modal-actions {
            display: flex;
            gap: 0.75rem;
            justify-content: flex-end;
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

            .topbar {
                padding: 1.25rem;
            }

            .topbar h1 {
                font-size: 1.5rem;
            }

            .section {
                padding: 1.5rem;
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
        <a href="#dashboard" class="menu-item active">
            <svg class="icon" viewBox="0 0 24 24">
                <rect x="3" y="3" width="7" height="7" rx="1"/>
                <rect x="14" y="3" width="7" height="7" rx="1"/>
                <rect x="14" y="14" width="7" height="7" rx="1"/>
                <rect x="3" y="14" width="7" height="7" rx="1"/>
            </svg>
            Tableau de bord
        </a>
        <a href="${pageContext.request.contextPath}/doctor/availability" class="menu-item">
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
            <div class="user-avatar">${avatarInitials}</div>
            <div class="user-info">
                <h4>${doctorName}</h4>
                <p>Médecin</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <svg class="icon" viewBox="0 0 24 24">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                <polyline points="16 17 21 12 16 7"/>
                <line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            Se déconnecter
        </a>
    </div>
</aside>

<!-- MAIN CONTENT -->
<main class="main-content">
    <div class="topbar">
        <h1>Tableau de bord 👋</h1>
        <div class="topbar-actions">
            <a href="${pageContext.request.contextPath}/doctor/availability" class="btn btn-primary">
                <svg class="icon" viewBox="0 0 24 24" style="width:18px;height:18px;">
                    <circle cx="12" cy="12" r="9"/>
                    <path d="M12 7v5l3 2"/>
                </svg>
                Mes disponibilités
            </a>
        </div>
    </div>

    <!-- STATS -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-card-inner">
                <div class="stat-header">
                    <div class="stat-content">
                        <span class="stat-label">Consultations du jour</span>
                        <div class="stat-value">${appointmentsCount}</div>
                    </div>
                    <div class="stat-icon primary">
                        <svg class="icon" viewBox="0 0 24 24">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                    </div>
                </div>
                <div class="stat-footer">
                    <div class="stat-trend positive">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/>
                        </svg>
                        Aujourd'hui
                    </div>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card-inner">
                <div class="stat-header">
                    <div class="stat-content">
                        <span class="stat-label">Heures disponibles</span>
                        <div class="stat-value">${availableHoursLabel}</div>
                    </div>
                    <div class="stat-icon success">
                        <svg class="icon" viewBox="0 0 24 24">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M12 7v5l3 2"/>
                        </svg>
                    </div>
                </div>
                <div class="stat-footer">
                    <div class="stat-trend positive">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"/>
                        </svg>
                        Planning à jour
                    </div>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card-inner">
                <div class="stat-header">
                    <div class="stat-content">
                        <span class="stat-label">Notes à compléter</span>
                        <div class="stat-value">${notesCount}</div>
                    </div>
                    <div class="stat-icon info">
                        <svg class="icon" viewBox="0 0 24 24">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <path d="M14 2v6h6"/>
                            <path d="M16 13H8"/>
                            <path d="M16 17H8"/>
                            <path d="M10 9H8"/>
                        </svg>
                    </div>
                </div>
                <div class="stat-footer">
                    <div class="stat-trend warning">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"/>
                            <polyline points="12 6 12 12 16 14"/>
                        </svg>
                        À faire
                    </div>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-card-inner">
                <div class="stat-header">
                    <div class="stat-content">
                        <span class="stat-label">Consultations ce mois</span>
                        <div class="stat-value">${monthConsultations}</div>
                    </div>
                    <div class="stat-icon warning">
                        <svg class="icon" viewBox="0 0 24 24">
                            <path d="M3 21h18"/>
                            <rect x="5" y="10" width="3" height="8" rx="1"/>
                            <rect x="10.5" y="6" width="3" height="12" rx="1"/>
                            <rect x="16" y="13" width="3" height="5" rx="1"/>
                        </svg>
                    </div>
                </div>
                <div class="stat-footer">
                    <div class="stat-trend positive">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/>
                            <polyline points="23 6 18 6 18 11"/>
                        </svg>
                        Live
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- AVAILABILITY SECTION -->
    <section class="section">
        <div class="section-header">
            <h2 class="section-title">
                <svg class="icon" viewBox="0 0 24 24">
                    <circle cx="12" cy="12" r="9"/>
                    <path d="M12 7v5l3 2"/>
                </svg>
                Ma disponibilité
            </h2>
            <c:choose>
                <c:when test="${not empty todayAvailabilities}">
                    <span class="status-badge available">
                        <svg viewBox="0 0 16 16">
                            <circle cx="8" cy="8" r="6" fill="currentColor"/>
                        </svg>
                        Disponible
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="status-badge offline">
                        <svg viewBox="0 0 16 16">
                            <circle cx="8" cy="8" r="6" fill="currentColor"/>
                        </svg>
                        Hors ligne
                    </span>
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
                    <div class="slot-info">Aucune disponibilité aujourd'hui</div>
                </div>
            </c:if>
            <c:forEach var="slot" items="${todayAvailabilities}">
                <div class="time-slot active">
                    <div class="slot-header">
                        <span class="slot-time">${slot.heureDebut} - ${slot.heureFin}</span>
                        <div class="slot-toggle on"></div>
                    </div>
                    <div class="slot-info">Créneau • Disponible<br>Cabinet</div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- APPOINTMENTS SECTION -->
    <section class="section">
        <div class="section-header">
            <h2 class="section-title">
                <svg class="icon" viewBox="0 0 24 24">
                    <rect x="3" y="4" width="18" height="18" rx="2"/>
                    <path d="M16 2v4M8 2v4M3 10h18"/>
                </svg>
                Mes rendez-vous du jour
            </h2>
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
                    <div class="appointment-time">
                        <svg class="icon" viewBox="0 0 24 24">
                            <circle cx="12" cy="12" r="9"/>
                            <path d="M12 7v5l3 2"/>
                        </svg>
                        <c:out value="${a.hour}"/>
                    </div>
                </div>
                <div class="appointment-details">
                    <div class="detail-item">
                        <svg class="icon" viewBox="0 0 24 24">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <path d="M14 2v6h6"/>
                        </svg>
                        Statut: <c:out value="${a.statut}"/>
                    </div>
                    <c:if test="${not empty a.patient.telephone}">
                        <div class="detail-item">
                            <svg class="icon" viewBox="0 0 24 24">
                                <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.8 19.8 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.08 4.18 2 2 0 0 1 4.06 2h3a2 2 0 0 1 2 1.72 12.7 12.7 0 0 0 .7 2.79 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.29-1.22a2 2 0 0 1 2.11-.45 12.7 12.7 0 0 0 2.79.7A2 2 0 0 1 22 16.92z"/>
                            </svg>
                            Tél: <c:out value="${a.patient.telephone}"/>
                        </div>
                    </c:if>
                </div>
                <div class="appointment-actions">
                    <button class="btn-sm primary js-note-btn"
                            data-patient="<c:out value='${a.patient.user.name}'/>"
                            data-time="<c:out value='${a.hour}'/>">
                        <svg class="icon" viewBox="0 0 24 24">
                            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                        </svg>
                        Ajouter note
                    </button>
                    <button class="btn-sm outline">
                        <svg class="icon" viewBox="0 0 24 24">
                            <path d="M2 12s4-6 10-6 10 6 10 6-4 6-10 6-10-6-10-6z"/>
                            <circle cx="12" cy="12" r="2"/>
                        </svg>
                        Voir dossier
                    </button>
                </div>
            </div>
        </c:forEach>
    </section>
</main>

<!-- MODAL -->
<div class="modal" id="noteModal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">
                <svg class="icon" viewBox="0 0 24 24">
                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                </svg>
                Ajouter une note
            </h2>
            <button class="close-modal" onclick="closeNoteModal()" aria-label="Fermer">
                <svg class="icon" viewBox="0 0 24 24">
                    <path d="M18 6 6 18M6 6l12 12"/>
                </svg>
            </button>
        </div>
        <div class="form-group">
            <label for="patientName">Patient</label>
            <input type="text" id="patientName" readonly/>
        </div>
        <div class="form-group">
            <label for="appointmentTime">Heure de consultation</label>
            <input type="text" id="appointmentTime" readonly/>
        </div>
        <div class="form-group">
            <label for="noteText">Note</label>
            <textarea id="noteText" placeholder="Écrire une note..."></textarea>
        </div>
        <div class="modal-actions">
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
        document.getElementById('noteText').value = '';
    }

    function saveNote() {
        // TODO: envoyer la note via POST
        closeNoteModal();
    }

    document.addEventListener('DOMContentLoaded', function(){
        var noteButtons = document.querySelectorAll('.js-note-btn');
        noteButtons.forEach(function(btn){
            btn.addEventListener('click', function(){
                openNoteModal(this.getAttribute('data-patient')||'', this.getAttribute('data-time')||'');
            });
        });
    });
</script>
</body>
</html>
