<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Dashboard Admin - Clinique Digitale</title>
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
            --info: #3B82F6;
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
            max-width: 1600px;
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
            text-transform: uppercase;
            font-weight: 600;
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

        .btn-success {
            background: linear-gradient(135deg, var(--success), #34D399);
            color: white;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--error), #F87171);
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
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

        .btn-small {
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
        }

        /* Main Container */
        .main-container {
            position: relative;
            z-index: 1;
            max-width: 1600px;
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

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
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

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .stat-icon.primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
        }

        .stat-icon.success {
            background: linear-gradient(135deg, var(--success), #34D399);
        }

        .stat-icon.error {
            background: linear-gradient(135deg, var(--error), #F87171);
        }

        .stat-icon.warning {
            background: linear-gradient(135deg, var(--warning), #FBBF24);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: var(--text-light);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .stat-change {
            font-size: 0.85rem;
            font-weight: 600;
            padding: 0.25rem 0.5rem;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .stat-change.positive {
            background: #D1FAE5;
            color: #065F46;
        }

        .stat-change.negative {
            background: #FEE2E2;
            color: #991B1B;
        }

        /* Action Cards */
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .action-card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .action-card::before {
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

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .action-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
        }

        .action-card h3 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .action-card p {
            color: var(--text-light);
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        /* Card */
        .card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
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

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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
            max-width: 600px;
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

        /* Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-input, .form-select, .form-textarea {
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

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-input:focus, .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: #F9FAFB;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text);
            border-bottom: 2px solid #E5E7EB;
        }

        .table td {
            padding: 1rem;
            border-bottom: 1px solid #F3F4F6;
        }

        .table tr:hover {
            background: #F9FAFB;
        }

        .badge {
            display: inline-block;
            padding: 0.375rem 0.75rem;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-admin {
            background: #DBEAFE;
            color: #1E40AF;
        }

        .badge-doctor {
            background: #D1FAE5;
            color: #065F46;
        }

        .badge-staff {
            background: #FEF3C7;
            color: #92400E;
        }

        .badge-patient {
            background: #E0E7FF;
            color: #3730A3;
        }

        /* Tabs */
        .tabs {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            border-bottom: 2px solid #E5E7EB;
        }

        .tab {
            padding: 0.75rem 1.5rem;
            border: none;
            background: none;
            color: var(--text-light);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border-bottom: 2px solid transparent;
            margin-bottom: -2px;
        }

        .tab.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
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

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .action-grid {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: 1fr;
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
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                    </svg>
                </div>
                <span class="logo-text">Clinique Digitale</span>
            </div>
            <div class="user-section">
                <div class="user-info">
                    <div class="user-name">${sessionScope.user.name}</div>
                    <div class="user-role">Administrateur</div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline">
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
                <h1>🎯 Tableau de Bord Administrateur</h1>
                <p>Gérez votre clinique en toute simplicité</p>
            </div>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">${totalAppointments}</div>
                        <div class="stat-label">Rendez-vous Total</div>
                    </div>
                    <div class="stat-icon primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                            <line x1="16" y1="2" x2="16" y2="6"></line>
                            <line x1="8" y1="2" x2="8" y2="6"></line>
                            <line x1="3" y1="10" x2="21" y2="10"></line>
                        </svg>
                    </div>
                </div>
                <c:if test="${not empty appointmentsGrowth}">
                    <span class="stat-change ${appointmentsGrowth >= 0 ? 'positive' : 'negative'}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <c:choose>
                                <c:when test="${appointmentsGrowth >= 0}">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                                </c:when>
                                <c:otherwise>
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M13 17h8m0 0V9m0 8l-8-8-4 4-6-6" />
                                </c:otherwise>
                            </c:choose>
                        </svg>
                        ${appointmentsGrowth}% ce mois
                    </span>
                </c:if>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">${totalUsers}</div>
                        <div class="stat-label">Utilisateurs</div>
                    </div>
                    <div class="stat-icon success">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">${totalDoctors}</div>
                        <div class="stat-label">Docteurs</div>
                    </div>
                    <div class="stat-icon primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M5.121 17.804A13.937 13.937 0 0112 16c2.5 0 4.847.655 6.879 1.804M15 10a3 3 0 11-6 0 3 3 0 016 0zm6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div>
                        <div class="stat-value">
                            <fmt:formatNumber value="${cancellationRate}" maxFractionDigits="1" />%
                        </div>
                        <div class="stat-label">Taux d'Annulation</div>
                    </div>
                    <div class="stat-icon ${cancellationRate > 20 ? 'error' : 'warning'}">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Cards -->
        <div class="action-grid">
            <div class="action-card" onclick="openUserModal('DOCTOR')">
                <div class="action-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                    </svg>
                </div>
                <h3>Créer un Docteur</h3>
                <p>Ajouter un nouveau médecin à la clinique</p>
            </div>

            <div class="action-card" onclick="openUserModal('STAFF')">
                <div class="action-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                    </svg>
                </div>
                <h3>Créer un Staff</h3>
                <p>Ajouter un membre du personnel</p>
            </div>

            <div class="action-card" onclick="openUserModal('PATIENT')">
                <div class="action-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                    </svg>
                </div>
                <h3>Créer un Patient</h3>
                <p>Enregistrer un nouveau patient</p>
            </div>

            <div class="action-card" onclick="openDepartmentModal()">
                <div class="action-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                    </svg>
                </div>
                <h3>Gérer Départements</h3>
                <p>Créer et gérer les départements</p>
            </div>

            <!-- New: Manage Specialties -->
            <div class="action-card" onclick="openSpecialtyModal()">
                <div class="action-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2">
                        <path d="M12 22s8-4 8-10a8 8 0 1 0-16 0c0 6 8 10 8 10z" />
                        <path d="M12 8v4l2 2" />
                    </svg>
                </div>
                <h3>Gérer Spécialités</h3>
                <p>Créer et lister les spécialités par département</p>
            </div>
        </div>

        <!-- Management Section -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Gestion des Utilisateurs</h2>
            </div>

            <div class="tabs">
                <button class="tab active" onclick="switchTab('all')">Tous</button>
                <button class="tab" onclick="switchTab('doctors')">Docteurs</button>
                <button class="tab" onclick="switchTab('staff')">Staff</button>
                <button class="tab" onclick="switchTab('patients')">Patients</button>
            </div>

            <div id="tab-all" class="tab-content active">
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Rôle</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.name}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge badge-${user.role.toString().toLowerCase()}">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.actif}">
                                                <span style="color: var(--success);">● Actif</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--error);">● Inactif</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-primary btn-small" onclick="editUser('${user.id}')">
                                            Modifier
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="tab-doctors" class="tab-content">
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Spécialité</th>
                                <th>Matricule</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="doctor" items="${doctors}">
                                <tr>
                                    <td>${doctor.user.name}</td>
                                    <td>${doctor.user.email}</td>
                                    <td>${doctor.specialite.name}</td>
                                    <td>${doctor.matricule}</td>
                                    <td>
                                        <button class="btn btn-primary btn-small" onclick="editUser('${doctor.user.id}')">
                                            Modifier
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="tab-staff" class="tab-content">
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="staff" items="${staffList}">
                                <tr>
                                    <td>${staff.name}</td>
                                    <td>${staff.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${staff.actif}">
                                                <span style="color: var(--success);">● Actif</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: var(--error);">● Inactif</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button class="btn btn-primary btn-small" onclick="editUser('${staff.id}')">
                                            Modifier
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="tab-patients" class="tab-content">
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>CIN</th>
                                <th>Téléphone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="patient" items="${patients}">
                                <tr>
                                    <td>${patient.user.name}</td>
                                    <td>${patient.user.email}</td>
                                    <td>${patient.cin}</td>
                                    <td>${patient.telephone}</td>
                                    <td>
                                        <button class="btn btn-primary btn-small" onclick="editUser('${patient.user.id}')">
                                            Modifier
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Create User Modal -->
    <div id="userModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="userModalTitle">Créer un Utilisateur</h3>
                <button class="modal-close" onclick="closeUserModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>

            <form action="${pageContext.request.contextPath}/admin/users/create" method="post" id="userForm">
                <input type="hidden" name="role" id="userRole">

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="name">Nom Complet</label>
                        <input type="text" class="form-input" id="name" name="name" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email</label>
                        <input type="email" class="form-input" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Mot de Passe</label>
                        <input type="password" class="form-input" id="password" name="password" required>
                    </div>

                    <div class="form-group" id="confirmPasswordGroup">
                        <label class="form-label" for="confirmPassword">Confirmer</label>
                        <input type="password" class="form-input" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <!-- Doctor specific fields -->
                <div id="doctorFields" style="display: none;">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="matricule">Matricule</label>
                            <input type="text" class="form-input" id="matricule" name="matricule">
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="titre">Titre</label>
                            <select class="form-select" id="titre" name="titre">
                                <option value="">Choisir un titre</option>
                                <option value="Dr">Dr</option>
                                <option value="Pr">Pr</option>
                                <option value="Dr/Pr">Dr/Pr</option>
                            </select>
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label" for="specialityId">Spécialité</label>
                            <select class="form-select" id="specialityId" name="specialityId">
                                <option value="">Choisir une spécialité</option>
                                <c:forEach var="speciality" items="${specialities}">
                                    <option value="${speciality.id}">${speciality.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Patient specific fields -->
                <div id="patientFields" style="display: none;">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="cin">CIN</label>
                            <input type="text" class="form-input" id="cin" name="cin">
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="telephone">Téléphone</label>
                            <input type="tel" class="form-input" id="telephone" name="telephone">
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="naissance">Date de Naissance</label>
                            <input type="date" class="form-input" id="naissance" name="naissance">
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="sexe">Sexe</label>
                            <select class="form-select" id="sexe" name="sexe">
                                <option value="">Choisir</option>
                                <option value="M">Homme</option>
                                <option value="F">Femme</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="sang">Groupe Sanguin</label>
                            <select class="form-select" id="sang" name="sang">
                                <option value="">Choisir</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                            </select>
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label" for="adresse">Adresse</label>
                            <input type="text" class="form-input" id="adresse" name="adresse">
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                    Créer le Compte
                </button>
            </form>
        </div>
    </div>

    <!-- Department Modal -->
    <div id="departmentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="departmentModalTitle">Gérer les Départements</h3>
                <button class="modal-close" onclick="closeDepartmentModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>

            <form id="departmentForm" action="${pageContext.request.contextPath}/admin/department/create" method="post">
                <input type="hidden" id="deptId" name="id" />
                <div class="form-group">
                    <label class="form-label" for="deptName">Nom du Département</label>
                    <input type="text" class="form-input" id="deptName" name="name" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="deptDescription">Description</label>
                    <textarea class="form-textarea" id="deptDescription" name="description" rows="3"></textarea>
                </div>

                <button id="departmentSubmitBtn" type="submit" class="btn btn-success" style="width: 100%;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    Créer le Département
                </button>
            </form>

            <hr style="margin: 2rem 0; border: none; border-top: 2px solid #E5E7EB;">

            <h4 style="margin-bottom: 1rem; color: var(--text);">Départements Existants</h4>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dept" items="${departments}">
                            <tr>
                                <td>${dept.name}</td>
                                <td>${dept.description}</td>
                                <td>
                                    <button type="button" class="btn btn-primary btn-small"
                                            onclick="editDepartment(this, '${dept.id}')"
                                            data-name="${dept.name}"
                                            data-description="${dept.description}"
                                            title="Modifier" aria-label="Modifier">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <path d="M12 20h9" />
                                            <path d="M16.5 3.5a2.121 2.121 0 1 1 3 3L7 19l-4 1 1-4 12.5-12.5z" />
                                        </svg>
                                    </button>
                                    <button type="button" class="btn btn-danger btn-small" style="margin-left: .5rem;"
                                            onclick="confirmDeleteDepartment('${dept.id}')"
                                            title="Supprimer" aria-label="Supprimer">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <polyline points="3 6 5 6 21 6" />
                                            <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
                                            <path d="M10 11v6" />
                                            <path d="M14 11v6" />
                                            <path d="M9 6V4a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2" />
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Hidden delete form for departments -->
    <form id="deleteDepartmentForm" action="${pageContext.request.contextPath}/admin/department/delete" method="post" style="display:none;">
        <input type="hidden" name="id" id="deleteDeptId" />
    </form>

    <!-- Specialty Modal -->
    <div id="specialtyModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Gérer les Spécialités</h3>
                <button class="modal-close" onclick="closeSpecialtyModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="18" y1="6" x2="6" y2="18"></line>
                        <line x1="6" y1="6" x2="18" y2="18"></line>
                    </svg>
                </button>
            </div>

            <form id="specialtyForm" action="${pageContext.request.contextPath}/admin/specialty/create" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="specName">Nom de la Spécialité</label>
                        <input type="text" class="form-input" id="specName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="specDepartment">Département</label>
                        <select class="form-select" id="specDepartment" name="departmentId" required>
                            <option value="">Choisir un département</option>
                            <c:forEach var="dept" items="${departments}">
                                <option value="${dept.id}">${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group full-width">
                        <label class="form-label" for="specDesc">Description</label>
                        <textarea class="form-textarea" id="specDesc" name="description" rows="3"></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-success" style="width:100%;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    Créer la Spécialité
                </button>
            </form>

            <hr style="margin: 2rem 0; border: none; border-top: 2px solid #E5E7EB;">

            <h4 style="margin-bottom: 1rem; color: var(--text);">Spécialités Existantes</h4>
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Département</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sp" items="${specialities}">
                            <tr>
                                <td>${sp.name}</td>
                                <td>${sp.department.name}</td>
                                <td>${sp.description}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
         // Tab switching
         function switchTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });

            // Show selected tab
            if (tabName === 'all') {
                document.getElementById('tab-all').classList.add('active');
            } else if (tabName === 'doctors') {
                document.getElementById('tab-doctors').classList.add('active');
            } else if (tabName === 'staff') {
                document.getElementById('tab-staff').classList.add('active');
            } else if (tabName === 'patients') {
                document.getElementById('tab-patients').classList.add('active');
            }

            // Activate button
            event.target.classList.add('active');
        }

        // User Modal
        function openUserModal(role) {
            document.getElementById('userRole').value = role;

            let title = 'Créer un ';
            if (role === 'DOCTOR') {
                title += 'Docteur';
                document.getElementById('doctorFields').style.display = 'block';
                document.getElementById('patientFields').style.display = 'none';
            } else if (role === 'STAFF') {
                title += 'Staff';
                document.getElementById('doctorFields').style.display = 'none';
                document.getElementById('patientFields').style.display = 'none';
            } else if (role === 'PATIENT') {
                title += 'Patient';
                document.getElementById('doctorFields').style.display = 'none';
                document.getElementById('patientFields').style.display = 'block';
            }

            document.getElementById('userModalTitle').textContent = title;
            document.getElementById('userModal').classList.add('active');
        }

        function closeUserModal() {
            document.getElementById('userModal').classList.remove('active');
            document.getElementById('userForm').reset();
        }

        // Department Modal
        function openDepartmentModal() {
            const form = document.getElementById('departmentForm');
            form.action = '${pageContext.request.contextPath}/admin/department/create';
            document.getElementById('deptId').value = '';
            document.getElementById('deptName').value = '';
            document.getElementById('deptDescription').value = '';
            document.getElementById('departmentModalTitle').textContent = 'Créer un Département';
            const btn = document.getElementById('departmentSubmitBtn');
            btn.classList.remove('btn-primary');
            btn.classList.add('btn-success');
            btn.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="12" y1="5" x2="12" y2="19"></line>
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                </svg>
                Créer le Département`;
            document.getElementById('departmentModal').classList.add('active');
        }

        function closeDepartmentModal() {
             document.getElementById('departmentModal').classList.remove('active');
         }

         // Specialty Modal
         function openSpecialtyModal(){
            document.getElementById('specialtyForm').reset();
            document.getElementById('specialtyModal').classList.add('active');
        }

        function closeSpecialtyModal(){
            document.getElementById('specialtyModal').classList.remove('active');
        }

        // Edit functions (to be implemented)
        function editUser(userId) {
            // TODO: Load user data and open modal in edit mode
            console.log('Edit user:', userId);
        }

        function editDepartment(btn, deptId) {
             // Passer le modal en mode édition en lisant les data-attributes du bouton
              const form = document.getElementById('departmentForm');
              form.action = '${pageContext.request.contextPath}/admin/department/edit';
              document.getElementById('deptId').value = deptId;
              document.getElementById('deptName').value = btn.dataset.name || '';
              document.getElementById('deptDescription').value = btn.dataset.description || '';
              document.getElementById('departmentModalTitle').textContent = 'Modifier le Département';
             const submitBtn = document.getElementById('departmentSubmitBtn');
             submitBtn.classList.remove('btn-success');
             submitBtn.classList.add('btn-primary');
             submitBtn.innerHTML = `
                 <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                     <path d="M12 20h9" />
                     <path d="M16.5 3.5a2.121 2.121 0 1 1 3 3L7 19l-4 1 1-4 12.5-12.5z" />
                 </svg>
                 Mettre à jour`;
              document.getElementById('departmentModal').classList.add('active');
          }

        function confirmDeleteDepartment(deptId) {
            if (confirm('Voulez-vous vraiment supprimer ce département ?')) {
                document.getElementById('deleteDeptId').value = deptId;
                document.getElementById('deleteDepartmentForm').submit();
            }
        }

        // Close modals when clicking outside
        window.onclick = function(event) {
            const userModal = document.getElementById('userModal');
            const deptModal = document.getElementById('departmentModal');

            if (event.target === userModal) {
                closeUserModal();
            }
            if (event.target === deptModal) {
                closeDepartmentModal();
            }
        }

        // Form validation
        document.getElementById('userForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas!');
                return false;
            }
        });
    </script>
</body>
</html>

