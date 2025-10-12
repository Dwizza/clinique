    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
    <!DOCTYPE html>
    <html lang="fr">
    <head>
        <meta charset="UTF-8"/>
        <title>Dashboard Patient - Clinique Digitale</title>
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --primary: #6366F1;
                --primary-dark: #4F46E5;
                --primary-light: #818CF8;
                --secondary: #EC4899;
                --success: #10B981;
                --warning: #F59E0B;
                --error: #EF4444;
                --text: #1F2937;
                --text-light: #6B7280;
                --white: #FFFFFF;
                --bg-overlay: rgba(255, 255, 255, 0.95);
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                min-height: 100vh;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
                background-size: 400% 400%;
                animation: gradientShift 15s ease infinite;
                position: relative;
                overflow-x: hidden;
                color: var(--text);
            }

            @keyframes gradientShift {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            /* Animated background shapes */
            .bg-shapes {
                position: fixed;
                width: 100%;
                height: 100%;
                overflow: hidden;
                z-index: 0;
                pointer-events: none;
            }

            .shape {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.1);
                animation: float 20s infinite ease-in-out;
            }

            .shape:nth-child(1) {
                width: 300px;
                height: 300px;
                top: -150px;
                left: -150px;
                animation-delay: 0s;
            }

            .shape:nth-child(2) {
                width: 200px;
                height: 200px;
                bottom: -100px;
                right: -100px;
                animation-delay: 2s;
            }

            .shape:nth-child(3) {
                width: 150px;
                height: 150px;
                top: 50%;
                left: 10%;
                animation-delay: 4s;
            }

            .shape:nth-child(4) {
                width: 250px;
                height: 250px;
                bottom: 20%;
                left: -125px;
                animation-delay: 6s;
            }

            @keyframes float {
                0%, 100% { transform: translate(0, 0) rotate(0deg); }
                25% { transform: translate(20px, 20px) rotate(90deg); }
                50% { transform: translate(-20px, 40px) rotate(180deg); }
                75% { transform: translate(40px, -20px) rotate(270deg); }
            }

            /* Header */
            .header {
                position: relative;
                z-index: 10;
                background: var(--bg-overlay);
                backdrop-filter: blur(20px);
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                animation: slideDown 0.6s ease-out;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .nav-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 1.25rem 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo-section {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .logo-icon {
                width: 45px;
                height: 45px;
                background: linear-gradient(135deg, var(--primary), var(--primary-light));
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
            }

            .logo-text {
                font-size: 1.5rem;
                font-weight: 800;
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .user-section {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .user-info {
                text-align: right;
            }

            .user-name {
                font-weight: 600;
                color: var(--text);
            }

            .user-role {
                font-size: 0.85rem;
                color: var(--text-light);
            }

            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 12px;
                font-size: 0.95rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                border: none;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
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
                background: linear-gradient(135deg, var(--primary), var(--primary-light));
                color: white;
                box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(99, 102, 241, 0.5);
            }

            .btn-danger {
                background: linear-gradient(135deg, var(--error), #F87171);
                color: white;
                box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
            }

            .btn-success {
                background: linear-gradient(135deg, var(--success), #34D399);
                color: white;
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
            }

            .btn-outline {
                background: white;
                color: var(--text);
                border: 2px solid #E5E7EB;
            }

            .btn-outline:hover {
                background: #F9FAFB;
                border-color: var(--primary);
                color: var(--primary);
            }

            /* Main Container */
            .main-container {
                position: relative;
                z-index: 1;
                max-width: 1400px;
                margin: 2rem auto;
                padding: 0 2rem 2rem;
                animation: fadeInUp 0.8s ease-out 0.2s both;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Welcome Section */
            .welcome-section {
                background: var(--bg-overlay);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
                overflow: hidden;
            }

            .welcome-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary), var(--secondary), var(--primary-light));
                background-size: 200% 100%;
                animation: shimmer 3s infinite;
            }

            @keyframes shimmer {
                0% { background-position: -200% 0; }
                100% { background-position: 200% 0; }
            }

            .welcome-content h1 {
                font-size: 2rem;
                font-weight: 800;
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 0.5rem;
            }

            .welcome-content p {
                color: var(--text-light);
                font-size: 1.1rem;
            }

            /* Dashboard Grid */
            .dashboard-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
                gap: 2rem;
                margin-bottom: 2rem;
            }

            /* Card Styles */
            .card {
                background: var(--bg-overlay);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                padding: 2rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, var(--primary), var(--secondary), var(--primary-light));
                background-size: 200% 100%;
                animation: shimmer 3s infinite;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            }

            .card-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .card-icon {
                width: 60px;
                height: 60px;
                background: linear-gradient(135deg, var(--primary), var(--primary-light));
                border-radius: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
            }

            .card-title {
                font-size: 1.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                display: block;
                font-weight: 600;
                color: var(--text);
                margin-bottom: 0.5rem;
                font-size: 0.95rem;
            }

            .form-input, .form-select {
                width: 100%;
                padding: 0.875rem 1rem;
                border: 2px solid #E5E7EB;
                border-radius: 12px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: white;
                color: var(--text);
                font-family: inherit;
            }

            .form-input:focus, .form-select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            }

            /* Appointments List */
            .appointments-list {
                max-height: 600px;
                overflow-y: auto;
            }

            .appointment-item {
                background: white;
                border-radius: 16px;
                padding: 1.5rem;
                margin-bottom: 1rem;
                border: 2px solid #F3F4F6;
                transition: all 0.3s ease;
                position: relative;
            }

            .appointment-item:hover {
                border-color: var(--primary-light);
                transform: translateX(5px);
                box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
            }

            .appointment-header {
                display: flex;
                justify-content: space-between;
                align-items: start;
                margin-bottom: 1rem;
            }

            .appointment-date {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 600;
                color: var(--text);
                font-size: 1.1rem;
            }

            .appointment-status {
                padding: 0.4rem 0.9rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-planned {
                background: #DBEAFE;
                color: #1E40AF;
            }

            .status-confirmed {
                background: #D1FAE5;
                color: #065F46;
            }

            .status-cancelled {
                background: #FEE2E2;
                color: #991B1B;
            }

            .appointment-info {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 0.75rem;
                margin-bottom: 1rem;
            }

            .info-item {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--text-light);
                font-size: 0.95rem;
            }

            .info-icon {
                width: 20px;
                height: 20px;
                color: var(--primary);
            }

            .appointment-actions {
                display: flex;
                gap: 0.75rem;
                justify-content: flex-end;
            }

            .btn-small {
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
            }

            .empty-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 1.5rem;
                opacity: 0.5;
            }

            .empty-text {
                color: var(--text-light);
                font-size: 1.1rem;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(5px);
                animation: fadeIn 0.3s ease-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            .modal.active {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .modal-content {
                background: white;
                border-radius: 24px;
                padding: 2rem;
                max-width: 500px;
                width: 90%;
                max-height: 90vh;
                overflow-y: auto;
                animation: slideUp 0.3s ease-out;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .modal-title {
                font-size: 1.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, var(--primary), var(--secondary));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .modal-close {
                width: 36px;
                height: 36px;
                border: none;
                background: #F3F4F6;
                border-radius: 50%;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .modal-close:hover {
                background: #E5E7EB;
                transform: rotate(90deg);
            }

            /* Alert Messages */
            .alert {
                padding: 1rem 1.25rem;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                animation: slideDown 0.3s ease-out;
            }

            .alert-success {
                background: #D1FAE5;
                color: #065F46;
                border: 2px solid #10B981;
            }

            .alert-error {
                background: #FEE2E2;
                color: #991B1B;
                border: 2px solid #EF4444;
            }

            .alert-warning {
                background: #FEF3C7;
                color: #92400E;
                border: 2px solid #F59E0B;
            }

            /* Scrollbar */
            ::-webkit-scrollbar {
                width: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #F3F4F6;
                border-radius: 10px;
            }

            ::-webkit-scrollbar-thumb {
                background: var(--primary-light);
                border-radius: 10px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: var(--primary);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .nav-container {
                    flex-direction: column;
                    gap: 1rem;
                }

                .welcome-section {
                    flex-direction: column;
                    text-align: center;
                    gap: 1rem;
                }

                .dashboard-grid {
                    grid-template-columns: 1fr;
                }

                .appointment-info {
                    grid-template-columns: 1fr;
                }

                .welcome-content h1 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Background Shapes -->
        <div class="bg-shapes">
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
            <div class="shape"></div>
        </div>

        <!-- Header -->
        <header class="header">
            <div class="nav-container">
                <div class="logo-section">
                    <div class="logo-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <span class="logo-text">Clinique Digitale</span>
                </div>
                <div class="user-section">
                    <div class="user-info">
                        <div class="user-name">${sessionScope.user.name} </div>
                        <div class="user-role">Patient</div>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                            <polyline points="16 17 21 12 16 7"></polyline>
                            <line x1="21" y1="12" x2="9" y2="12"></line>
                        </svg>
                        Déconnexion
                    </a>
                </div>
            </div>
        </header>

        <!-- Main Container -->
        <div class="main-container">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <h1>👋 Bienvenue, ${sessionScope.user.name}!</h1>
                    <p>Gérez vos rendez-vous médicaux en toute simplicité</p>
                </div>
                <button class="btn btn-primary btn-large" onclick="openBookingModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
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

            <!-- Dashboard Grid -->
            <div class="dashboard-grid">
                <!-- Appointments List Card -->
                <div class="card" style="grid-column: 1 / -1;">
                    <div class="card-header">
                        <div class="card-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2">
                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                <line x1="3" y1="10" x2="21" y2="10"></line>
                            </svg>
                        </div>
                        <h2 class="card-title">Mes Rendez-vous</h2>
                    </div>

                    <div class="appointments-list">
                        <c:choose>
                            <c:when test="${empty appointments}">
                                <div class="empty-state">
                                    <svg class="empty-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h4"></path>
                                    </svg>
                                    <p class="empty-text">Vous n'avez aucun rendez-vous pour le moment.<br>Cliquez sur "Nouveau Rendez-vous" pour en créer un.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="appointment" items="${appointments}">
                                    <div class="appointment-item">
                                        <div class="appointment-header">
                                            <div class="appointment-date">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                    <line x1="16" y1="2" x2="16" y2="6"></line>
                                                    <line x1="8" y1="2" x2="8" y2="6"></line>
                                                    <line x1="3" y1="10" x2="21" y2="10"></line>
                                                </svg>
                                                <fmt:formatDate value="${appointment.date}" pattern="dd/MM/yyyy" />
                                            </div>
                                            <span class="appointment-status status-${appointment.statut.toString().toLowerCase()}">
                                                ${appointment.statut}
                                            </span>
                                        </div>

                                        <div class="appointment-info">
                                            <div class="info-item">
                                                <svg class="info-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                </svg>
                                                <span><fmt:formatDate value="${appointment.hour}" pattern="HH:mm" /></span>
                                            </div>
                                            <div class="info-item">
                                                <svg class="info-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                                </svg>
                                                <span>Dr. ${appointment.doctor.user.nom} ${appointment.doctor.user.prenom}</span>
                                            </div>
                                            <div class="info-item">
                                                <svg class="info-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z" />
                                                </svg>
                                                <span>${appointment.doctor.specialite.nom}</span>
                                            </div>
                                            <div class="info-item">
                                                <svg class="info-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z" />
                                                </svg>
                                                <span>${appointment.type}</span>
                                            </div>
                                        </div>

                                        <c:if test="${appointment.statut == 'PLANNED'}">
                                            <div class="appointment-actions">
                                                <button class="btn btn-danger btn-small" onclick="confirmCancel('${appointment.id}', '<fmt:formatDate value="${appointment.date}" pattern="dd/MM/yyyy" />', '<fmt:formatDate value="${appointment.hour}" pattern="HH:mm" />')">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                        <line x1="18" y1="6" x2="6" y2="18"></line>
                                                        <line x1="6" y1="6" x2="18" y2="18"></line>
                                                    </svg>
                                                    Annuler
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking Modal -->
        <div id="bookingModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Réserver un Rendez-vous</h3>
                    <button class="modal-close" onclick="closeBookingModal()">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                    </button>
                </div>

                <form action="${pageContext.request.contextPath}/patient/appointments/book" method="post">
                    <div class="form-group">
                        <label class="form-label" for="speciality">Spécialité</label>
                        <select class="form-select" id="speciality" name="specialityId" required onchange="loadDoctors(this.value)">
                            <option value="">Choisir une spécialité</option>
                            <c:forEach var="speciality" items="${specialities}">
                                <option value="${speciality.id}">${speciality.nom}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="doctor">Docteur</label>
                        <select class="form-select" id="doctor" name="doctorId" required disabled>
                            <option value="">Choisir d'abord une spécialité</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="date">Date</label>
                        <input type="date" class="form-input" id="date" name="date" required min="${today}">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="time">Heure</label>
                        <select class="form-select" id="time" name="time" required>
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
                        <select class="form-select" id="type" name="type" required>
                            <option value="">Choisir un type</option>
                            <option value="CONSULTATION">Consultation</option>
                            <option value="CONTROLE">Contrôle</option>
                            <option value="URGENCE">Urgence</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                            <polyline points="22 4 12 14.01 9 11.01"></polyline>
                        </svg>
                        Confirmer le Rendez-vous
                    </button>
                </form>
            </div>
        </div>

        <!-- Cancel Confirmation Modal -->
        <div id="cancelModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Annuler le Rendez-vous</h3>
                    <button class="modal-close" onclick="closeCancelModal()">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="18" y1="6" x2="6" y2="18"></line>
                            <line x1="6" y1="6" x2="18" y2="18"></line>
                        </svg>
                    </button>
                </div>

                <div class="alert alert-warning">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                        <line x1="12" y1="9" x2="12" y2="13"></line>
                        <line x1="12" y1="17" x2="12.01" y2="17"></line>
                    </svg>
                    <span>Les annulations doivent être effectuées au moins 12h avant le rendez-vous.</span>
                </div>

                <p style="color: var(--text); margin-bottom: 1.5rem;">
                    Êtes-vous sûr de vouloir annuler votre rendez-vous du <strong id="cancelDate"></strong> à <strong id="cancelTime"></strong> ?
                </p>

                <form id="cancelForm" method="post">
                    <input type="hidden" id="appointmentIdToCancel" name="appointmentId">
                    <div style="display: flex; gap: 1rem;">
                        <button type="button" class="btn btn-outline" style="flex: 1;" onclick="closeCancelModal()">
                            Non, garder
                        </button>
                        <button type="submit" class="btn btn-danger" style="flex: 1;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="18" y1="6" x2="6" y2="18"></line>
                                <line x1="6" y1="6" x2="18" y2="18"></line>
                            </svg>
                            Oui, annuler
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Modal Functions
            function openBookingModal() {
                document.getElementById('bookingModal').classList.add('active');
            }

            function closeBookingModal() {
                document.getElementById('bookingModal').classList.remove('active');
            }

            function confirmCancel(id, date, time) {
                document.getElementById('appointmentIdToCancel').value = id;
                document.getElementById('cancelDate').textContent = date;
                document.getElementById('cancelTime').textContent = time;
                document.getElementById('cancelForm').action = '${pageContext.request.contextPath}/patient/appointments/cancel';
                document.getElementById('cancelModal').classList.add('active');
            }

            function closeCancelModal() {
                document.getElementById('cancelModal').classList.remove('active');
            }

            // Load doctors based on speciality
            function loadDoctors(specialityId) {
                const doctorSelect = document.getElementById('doctor');

                if (!specialityId) {
                    doctorSelect.disabled = true;
                    doctorSelect.innerHTML = '<option value="">Choisir d\'abord une spécialité</option>';
                    return;
                }

                // AJAX call to get doctors by speciality
                fetch('${pageContext.request.contextPath}/patient/doctors?specialityId=' + specialityId)
                    .then(response => response.json())
                    .then(doctors => {
                        doctorSelect.disabled = false;
                        doctorSelect.innerHTML = '<option value="">Choisir un docteur</option>';
                        doctors.forEach(doctor => {
                            const option = document.createElement('option');
                            option.value = doctor.id;
                            option.textContent = 'Dr. ' + doctor.user.nom + ' ' + doctor.user.prenom;
                            doctorSelect.appendChild(option);
                        });
                    })
                    .catch(error => {
                        console.error('Error loading doctors:', error);
                        doctorSelect.innerHTML = '<option value="">Erreur de chargement</option>';
                    });
            }

            // Close modals when clicking outside
            window.onclick = function(event) {
                const bookingModal = document.getElementById('bookingModal');
                const cancelModal = document.getElementById('cancelModal');

                if (event.target === bookingModal) {
                    closeBookingModal();
                }
                if (event.target === cancelModal) {
                    closeCancelModal();
                }
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
