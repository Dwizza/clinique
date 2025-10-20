<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Dashboard Patient - Clinique Digitale</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
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
            color: var(--gray-800);
            line-height: 1.5;
            font-size: 14px;
        }

        /* Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(12px);
            padding: 0.75rem 0;
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 0 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .brand-logo {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-md);
        }

        .brand-name {
            font-size: 1.1rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-profile {
            position: relative;
        }

        .profile-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.4rem 0.75rem;
            background: var(--white);
            border: 1px solid var(--gray-200);
            border-radius: 50px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .profile-btn:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-sm);
        }

        .profile-avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 600;
            font-size: 0.85rem;
        }

        .profile-info {
            text-align: left;
        }

        .profile-name {
            font-weight: 600;
            font-size: 0.85rem;
            color: var(--gray-800);
        }

        .profile-role {
            font-size: 0.7rem;
            color: var(--gray-500);
        }

        .dropdown-menu {
            position: absolute;
            top: calc(100% + 0.5rem);
            right: 0;
            background: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-xl);
            min-width: 220px;
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .dropdown-menu.show {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-header {
            padding: 1rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .dropdown-item {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.75rem 1rem;
            color: var(--gray-700);
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 0.85rem;
        }

        .dropdown-item:hover {
            background: var(--gray-50);
            color: var(--primary);
        }

        .dropdown-item.danger {
            color: var(--danger);
        }

        .dropdown-item.danger:hover {
            background: #fef2f2;
        }

        /* Main Container */
        .container {
            max-width: 1300px;
            margin: 0 auto;
            padding: 1.5rem;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(255,255,255,0.95), rgba(255,255,255,0.9));
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-md);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .hero-content h1 {
            font-size: 1.75rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.25rem;
        }

        .hero-content p {
            font-size: 0.9rem;
            color: var(--gray-600);
        }

        .hero-action .btn-hero {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: var(--white);
            border: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .hero-action .btn-hero:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Card Styles */
        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--shadow-lg);
        }

        .card-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
        }

        .card-icon {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-sm);
        }

        .card-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--gray-800);
        }

        /* Search Box */
        .search-box {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .search-input {
            flex: 1;
            padding: 0.65rem 1rem;
            border: 1px solid var(--gray-200);
            border-radius: 50px;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .btn {
            padding: 0.65rem 1.25rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: var(--white);
            box-shadow: var(--shadow-sm);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-outline {
            background: var(--white);
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }

        .btn-outline:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger), #f87171);
            color: var(--white);
            box-shadow: var(--shadow-sm);
        }

        .btn-sm {
            padding: 0.45rem 0.875rem;
            font-size: 0.8rem;
        }

        /* Doctor Card */
        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .doctor-card {
            background: var(--white);
            border: 1px solid var(--gray-100);
            border-radius: 14px;
            padding: 0;
            margin-bottom: 0;
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
        }

        .doctor-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 70px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            opacity: 0.08;
            transition: all 0.3s ease;
        }

        .doctor-card:hover {
            border-color: var(--primary-light);
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.12);
        }

        .doctor-card:hover::before {
            opacity: 0.12;
            height: 85px;
        }

        .doctor-card-body {
            padding: 1.25rem;
            position: relative;
        }

        .doctor-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            text-align: center;
        }

        .doctor-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 700;
            font-size: 1.5rem;
            flex-shrink: 0;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
            border: 3px solid var(--white);
        }

        .doctor-info {
            width: 100%;
        }

        .doctor-info h3 {
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.2rem;
        }

        .doctor-info p {
            color: var(--gray-500);
            font-size: 0.8rem;
            font-weight: 500;
        }

        .doctor-specialty-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.4rem 0.875rem;
            background: linear-gradient(135deg, rgba(37, 99, 235, 0.08), rgba(139, 92, 246, 0.08));
            border-radius: 50px;
            margin: 0.4rem 0 1rem 0;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--primary);
        }

        .doctor-details {
            display: flex;
            flex-direction: column;
            gap: 0.65rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--gray-50);
            border-radius: 10px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            color: var(--gray-700);
            font-size: 0.8rem;
        }

        .detail-icon {
            color: var(--primary);
            flex-shrink: 0;
            width: 16px;
            height: 16px;
        }

        .detail-item strong {
            color: var(--gray-800);
        }

        .doctor-card .btn-primary {
            width: 100%;
            justify-content: center;
            padding: 0.75rem 1rem;
            font-size: 0.875rem;
        }

        /* Appointment Card */
        .appointment-card {
            background: var(--white);
            border: 1px solid var(--gray-100);
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 0.875rem;
            transition: all 0.3s ease;
        }

        .appointment-card:hover {
            border-color: var(--primary-light);
            box-shadow: var(--shadow-sm);
        }

        .appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.875rem;
        }

        .appointment-date {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-weight: 600;
            color: var(--gray-800);
            font-size: 0.95rem;
        }

        .badge {
            padding: 0.3rem 0.75rem;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .badge-planned {
            background: #dbeafe;
            color: #1e40af;
        }

        .badge-confirmed {
            background: #d1fae5;
            color: #065f46;
        }

        .badge-cancelled {
            background: #fee2e2;
            color: #991b1b;
        }

        .appointment-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 0.65rem;
            margin-bottom: 0.875rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 2.5rem 1rem;
        }

        .empty-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 0.875rem;
            opacity: 0.25;
        }

        .empty-text {
            color: var(--gray-500);
            font-size: 0.9rem;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(6px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background: var(--white);
            border-radius: 18px;
            padding: 1.75rem;
            max-width: 450px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: var(--shadow-xl);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-800);
        }

        .modal-close {
            width: 32px;
            height: 32px;
            border: none;
            background: var(--gray-100);
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .modal-close:hover {
            background: var(--gray-200);
            transform: rotate(90deg);
        }

        /* Form */
        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 0.4rem;
            font-size: 0.85rem;
        }

        .form-control {
            width: 100%;
            padding: 0.7rem 1rem;
            border: 1px solid var(--gray-200);
            border-radius: 10px;
            font-size: 0.875rem;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        /* Alert */
        .alert {
            padding: 0.875rem 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-size: 0.85rem;
        }

        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid var(--success);
        }

        .alert-warning {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid var(--warning);
        }

        /* Scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }

        ::-webkit-scrollbar-track {
            background: var(--gray-100);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gray-400);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--gray-500);
        }

        /* Scrollable List */
        .scrollable-list {
            max-height: 480px;
            overflow-y: auto;
            padding-right: 0.5rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-container {
                padding: 0 1rem;
            }

            .container {
                padding: 1rem;
            }

            .hero {
                padding: 1.25rem;
                text-align: center;
            }

            .hero-content h1 {
                font-size: 1.5rem;
            }

            .card {
                padding: 1.25rem;
            }

            .doctors-grid {
                grid-template-columns: 1fr;
            }

            .appointment-info {
                grid-template-columns: 1fr;
            }

            .search-box {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="#" class="brand">
                <div class="brand-logo">
                    <svg width="28" height="28" fill="none" stroke="white" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <span class="brand-name">Clinique Digitale</span>
            </a>
            <div class="nav-profile">
                <div class="profile-btn" onclick="toggleDropdown()">
                    <div class="profile-avatar">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.name}">
                                ${fn:toUpperCase(fn:substring(sessionScope.user.name, 0, 1))}
                            </c:when>
                            <c:otherwise>?</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="profile-info">
                        <div class="profile-name">${sessionScope.user.name}</div>
                        <div class="profile-role">Patient</div>
                    </div>
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                    </svg>
                </div>
                <div class="dropdown-menu" id="dropdownMenu">
                    <div class="dropdown-header">
                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                            <div class="profile-avatar">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.name}">
                                        ${fn:toUpperCase(fn:substring(sessionScope.user.name, 0, 1))}
                                    </c:when>
                                    <c:otherwise>?</c:otherwise>
                                </c:choose>
                            </div>
                            <div>
                                <div style="font-weight: 600;">${sessionScope.user.name}</div>
                                <div style="font-size: 0.85rem; color: var(--gray-500);">${sessionScope.user.email}</div>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/patient/profile" class="dropdown-item">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                        Mon Profil
                    </a>
                    <a href="${pageContext.request.contextPath}/patient/appointments" class="dropdown-item">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        Mes Rendez-vous
                    </a>
                    <a href="${pageContext.request.contextPath}/patient/history" class="dropdown-item">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Historique
                    </a>
                    <a href="${pageContext.request.contextPath}/patient/settings" class="dropdown-item">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                        </svg>
                        Paramètres
                    </a>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="dropdown-item danger">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                        </svg>
                        Déconnexion
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container">
        <!-- Hero Section -->
        <div class="hero">
            <div class="hero-content">
                <h1>👋 Bonjour, ${sessionScope.user.name}!</h1>
                <p>Bienvenue sur votre espace personnel de santé</p>
            </div>
            <div class="hero-action">
                <button class="btn-hero" onclick="openModal('bookingModal')">
                    <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                        <line x1="12" y1="14" x2="12" y2="18"></line>
                        <line x1="10" y1="16" x2="14" y2="16"></line>
                    </svg>
                    Nouveau Rendez-vous
                </button>
            </div>
        </div>

        <!-- Search Doctors Section -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon">
                    <svg width="28" height="28" fill="none" stroke="white" stroke-width="2" viewBox="0 0 24 24">
                        <circle cx="11" cy="11" r="8"></circle>
                        <path d="m21 21-4.35-4.35"></path>
                    </svg>
                </div>
                <h2 class="card-title">🔍 Rechercher un Médecin</h2>
            </div>

            <form action="${pageContext.request.contextPath}/patient" method="get">
                <div class="search-box">
                    <input type="text" name="search" class="search-input"
                           placeholder="Nom du médecin ou spécialité..."
                           value="${searchTerm}">
                    <button type="submit" class="btn btn-primary">
                        <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <circle cx="11" cy="11" r="8"></circle>
                            <path d="m21 21-4.35-4.35"></path>
                        </svg>
                        Rechercher
                    </button>
                    <c:if test="${not empty searchTerm}">
                        <a href="${pageContext.request.contextPath}/patient" class="btn btn-outline">
                            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <line x1="18" y1="6" x2="6" y2="18"></line>
                                <line x1="6" y1="6" x2="18" y2="18"></line>
                            </svg>
                            Réinitialiser
                        </a>
                    </c:if>
                </div>
            </form>

            <c:if test="${not empty searchTerm}">
                <div class="alert alert-success">
                    <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span>${doctors.size()} résultat(s) pour "${searchTerm}"</span>
                </div>
            </c:if>

            <div class="scrollable-list">
                <c:choose>
                    <c:when test="${empty doctors}">
                        <div class="empty-state">
                            <svg class="empty-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <p class="empty-text">
                                <c:choose>
                                    <c:when test="${not empty searchTerm}">
                                        Aucun médecin trouvé pour "${searchTerm}"
                                    </c:when>
                                    <c:otherwise>
                                        Aucun médecin disponible
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="doctors-grid">
                            <c:forEach var="doctor" items="${doctors}">
                                <div class="doctor-card">
                                    <div class="doctor-card-body">
                                        <div class="doctor-header">
                                            <div class="doctor-avatar">
                                                ${fn:toUpperCase(fn:substring(doctor.user.name, 0, 1))}
                                            </div>
                                            <div class="doctor-info">
                                                <h3>Dr. ${doctor.user.name}</h3>
                                                <p>${doctor.titre != null ? doctor.titre : 'Médecin'}</p>
                                            </div>
                                        </div>
                                        <div class="doctor-specialty-badge">
                                            <svg width="18" height="18" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                                            </svg>
                                            ${doctor.specialite.name}
                                        </div>
                                        <div class="doctor-details">
                                            <div class="detail-item">
                                                <svg class="detail-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                                </svg>
                                                <span><strong>Matricule:</strong> ${doctor.matricule}</span>
                                            </div>
                                            <div class="detail-item">
                                                <svg class="detail-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                                </svg>
                                                <span>${doctor.user.email}</span>
                                            </div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/patient/doctor?id=${doctor.id}" class="btn btn-primary">
                                            <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                                <line x1="3" y1="10" x2="21" y2="10"></line>
                                            </svg>
                                            Voir les disponibilités
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Appointments Section -->
        <div class="card" style="margin-top: 2rem;">
            <div class="card-header">
                <div class="card-icon">
                    <svg width="28" height="28" fill="none" stroke="white" stroke-width="2" viewBox="0 0 24 24">
                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="16" y1="2" x2="16" y2="6"></line>
                        <line x1="8" y1="2" x2="8" y2="6"></line>
                        <line x1="3" y1="10" x2="21" y2="10"></line>
                    </svg>
                </div>
                <h2 class="card-title">📅 Mes Rendez-vous</h2>
            </div>

            <div class="scrollable-list">
                <c:choose>
                    <c:when test="${empty appointments}">
                        <div class="empty-state">
                            <svg class="empty-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <p class="empty-text">Aucun rendez-vous pour le moment</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="appointment" items="${appointments}">
                            <div class="appointment-card">
                                <div class="appointment-header">
                                    <div class="appointment-date">
                                        <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                            <line x1="16" y1="2" x2="16" y2="6"></line>
                                            <line x1="8" y1="2" x2="8" y2="6"></line>
                                            <line x1="3" y1="10" x2="21" y2="10"></line>
                                        </svg>
                                        <fmt:formatDate value="${appointment.date}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <span class="badge badge-${appointment.statut.toString().toLowerCase()}">
                                        ${appointment.statut}
                                    </span>
                                </div>
                                <div class="appointment-info">
                                    <div class="detail-item">
                                        <svg class="detail-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        <fmt:formatDate value="${appointment.hour}" pattern="HH:mm"/>
                                    </div>
                                    <div class="detail-item">
                                        <svg class="detail-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                                        </svg>
                                        Dr. ${appointment.doctor.user.name}
                                    </div>
                                    <div class="detail-item">
                                        <svg class="detail-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                                    </svg>
                                    ${appointment.doctor.specialite.name}
                                </div>
                                <div class="detail-item">
                                    <svg class="detail-icon" width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"/>
                                    </svg>
                                    ${appointment.type}
                                </div>
                            </div>
                            <c:if test="${appointment.statut == 'PLANNED'}">
                                <button class="btn btn-danger btn-sm" onclick="confirmCancel('${appointment.id}', '<fmt:formatDate value="${appointment.date}" pattern="dd/MM/yyyy"/>', '<fmt:formatDate value="${appointment.hour}" pattern="HH:mm"/>')">
                                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <line x1="18" y1="6" x2="6" y2="18"></line>
                                        <line x1="6" y1="6" x2="18" y2="18"></line>
                                    </svg>
                                    Annuler le rendez-vous
                                </button>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Booking Modal -->
    <div id="bookingModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Réserver un Rendez-vous</h3>
                <button class="modal-close" onclick="closeModal('bookingModal')">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/patient/appointments/book" method="post">
                <div class="form-group">
                    <label class="form-label" for="speciality">Spécialité</label>
                    <select class="form-control" id="speciality" name="specialityId" required onchange="loadDoctors(this.value)">
                        <option value="">Choisir une spécialité</option>
                        <c:forEach var="speciality" items="${specialties}">
                            <option value="${speciality.id}">${speciality.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="doctor">Médecin</label>
                    <select class="form-control" id="doctor" name="doctorId" required disabled>
                        <option value="">Choisir d'abord une spécialité</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="date">Date</label>
                    <input type="date" class="form-control" id="date" name="date" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="time">Heure</label>
                    <select class="form-control" id="time" name="time" required>
                        <option value="">Choisir une heure</option>
                        <option value="09:00">09:00</option>
                        <option value="09:30">09:30</option>
                        <option value="10:00">10:00</option>
                        <option value="10:30">10:30</option>
                        <option value="11:00">11:00</option>
                        <option value="11:30">11:30</option>
                        <option value="14:00">14:00</option>
                        <option value="14:30">14:30</option>
                        <option value="15:00">15:00</option>
                        <option value="15:30">15:30</option>
                        <option value="16:00">16:00</option>
                        <option value="16:30">16:30</option>
                        <option value="17:00">17:00</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label" for="type">Type de consultation</label>
                    <select class="form-control" id="type" name="type" required>
                        <option value="">Choisir un type</option>
                        <option value="CONSULTATION">Consultation</option>
                        <option value="CONTROLE">Contrôle</option>
                        <option value="URGENCE">Urgence</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%;">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    Confirmer le rendez-vous
                </button>
            </form>
        </div>
    </div>

    <!-- Cancel Modal -->
    <div id="cancelModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Annuler le Rendez-vous</h3>
                <button class="modal-close" onclick="closeModal('cancelModal')">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>
            <div class="alert alert-warning">
                <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                </svg>
                <span>Êtes-vous sûr de vouloir annuler ce rendez-vous ?</span>
            </div>
            <p style="margin: 1rem 0; color: var(--gray-600);">
                Rendez-vous du <strong id="cancelDate"></strong> à <strong id="cancelTime"></strong>
            </p>
            <form id="cancelForm" method="post">
                <input type="hidden" id="appointmentIdToCancel" name="appointmentId">
                <div style="display: flex; gap: 0.75rem;">
                    <button type="button" class="btn btn-outline" style="flex: 1;" onclick="closeModal('cancelModal')">
                        Annuler
                    </button>
                    <button type="submit" class="btn btn-danger" style="flex: 1;">
                        <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                        </svg>
                        Confirmer
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Modal functions
        function openModal(id) {
            document.getElementById(id).classList.add('show');
        }

        function closeModal(id) {
            document.getElementById(id).classList.remove('show');
        }

        // Dropdown toggle
        function toggleDropdown() {
            document.getElementById('dropdownMenu').classList.toggle('show');
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.nav-profile')) {
                document.getElementById('dropdownMenu').classList.remove('show');
            }
        });

        // Close modal when clicking outside
        window.onclick = function(e) {
            if (e.target.classList.contains('modal')) {
                e.target.classList.remove('show');
            }
        }

        // Load doctors by specialty
        function loadDoctors(specialityId) {
            const doctorSelect = document.getElementById('doctor');
            if (!specialityId) {
                doctorSelect.disabled = true;
                doctorSelect.innerHTML = '<option value="">Choisir d\'abord une spécialité</option>';
                return;
            }
            fetch('${pageContext.request.contextPath}/patient/doctors?specialityId=' + specialityId)
                .then(response => response.json())
                .then(doctors => {
                    doctorSelect.disabled = false;
                    doctorSelect.innerHTML = '<option value="">Choisir un médecin</option>';
                    doctors.forEach(doctor => {
                        const option = document.createElement('option');
                        option.value = doctor.id;
                        option.textContent = 'Dr. ' + doctor.user.name;
                        doctorSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error:', error);
                    doctorSelect.innerHTML = '<option value="">Erreur de chargement</option>';
                });
        }

        // Confirm cancel appointment
        function confirmCancel(id, date, time) {
            document.getElementById('appointmentIdToCancel').value = id;
            document.getElementById('cancelDate').textContent = date;
            document.getElementById('cancelTime').textContent = time;
            document.getElementById('cancelForm').action = '${pageContext.request.contextPath}/patient/appointments/cancel';
            openModal('cancelModal');
        }

        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('date');
            if (dateInput) {
                const today = new Date().toISOString().split('T')[0];
                dateInput.setAttribute('min', today);
            }
        });
    </script>
</body>
</html>
