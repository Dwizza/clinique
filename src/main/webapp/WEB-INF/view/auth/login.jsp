<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Connexion - Clinique Digitale</title>
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
            --error: #EF4444;
            --error-light: #FEE2E2;
            --text: #1F2937;
            --text-light: #6B7280;
            --white: #FFFFFF;
            --bg-overlay: rgba(255, 255, 255, 0.95);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            position: relative;
            overflow: hidden;
            padding: 1rem;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Animated background shapes */
        .bg-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
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

        .container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 450px;
        }

        .card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 3rem 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25),
                        0 0 0 1px rgba(255, 255, 255, 0.1);
            animation: slideUp 0.6s ease-out;
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

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
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

        .logo {
            text-align: center;
            margin-bottom: 2rem;
            animation: fadeIn 0.8s ease-out 0.2s both;
        }

        .logo-icon {
            width: 70px;
            height: 70px;
            margin: 0 auto 1rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .logo-icon svg {
            width: 36px;
            height: 36px;
            color: white;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        h1 {
            text-align: center;
            font-size: 2rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: fadeIn 0.8s ease-out 0.3s both;
        }

        .subtitle {
            text-align: center;
            color: var(--text-light);
            font-size: 0.95rem;
            margin-bottom: 2rem;
            animation: fadeIn 0.8s ease-out 0.4s both;
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.9rem;
            animation: slideDown 0.4s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #D1FAE5, #A7F3D0);
            border: 1px solid var(--success);
            color: #065F46;
        }

        .alert-error {
            background: linear-gradient(135deg, #FEE2E2, #FECACA);
            border: 1px solid var(--error);
            color: #991B1B;
        }

        .alert-icon {
            width: 20px;
            height: 20px;
            flex-shrink: 0;
        }

        .form-group {
            margin-bottom: 1.5rem;
            animation: fadeIn 0.8s ease-out 0.5s both;
        }

        label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 0.5rem;
            transition: color 0.2s;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            color: var(--text-light);
            transition: color 0.2s;
            pointer-events: none;
        }

        input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 3rem;
            border: 2px solid #E5E7EB;
            border-radius: 12px;
            font-size: 0.95rem;
            font-family: inherit;
            background: white;
            transition: all 0.3s ease;
            outline: none;
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            transform: translateY(-1px);
        }

        input:focus + .input-icon {
            color: var(--primary);
        }

        input::placeholder {
            color: #9CA3AF;
        }

        .error-message {
            color: var(--error);
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: none;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-8px); }
            75% { transform: translateX(8px); }
        }

        .error-message.show {
            display: block;
        }

        .form-actions {
            margin-top: 2rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            animation: fadeIn 0.8s ease-out 0.6s both;
        }

        .btn {
            width: 100%;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
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
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: white;
            box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
            position: relative;
            z-index: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(99, 102, 241, 0.5);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .btn-secondary {
            background: white;
            color: var(--text);
            border: 2px solid #E5E7EB;
        }

        .btn-secondary:hover {
            background: #F9FAFB;
            border-color: var(--primary);
            color: var(--primary);
        }

        .divider {
            text-align: center;
            margin: 1.5rem 0;
            position: relative;
            animation: fadeIn 0.8s ease-out 0.7s both;
        }

        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, #E5E7EB, transparent);
        }

        .divider span {
            background: var(--bg-overlay);
            padding: 0 1rem;
            color: var(--text-light);
            font-size: 0.875rem;
            position: relative;
            z-index: 1;
        }

        .footer {
            text-align: center;
            margin-top: 1.5rem;
            animation: fadeIn 0.8s ease-out 0.8s both;
        }

        .footer p {
            color: var(--text-light);
            font-size: 0.95rem;
        }

        .footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
            position: relative;
        }

        .footer a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s ease;
        }

        .footer a:hover::after {
            width: 100%;
        }

        .footer a:hover {
            color: var(--primary-dark);
        }

        /* Loading animation */
        .btn-primary.loading {
            pointer-events: none;
        }

        .btn-primary.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
            margin-left: 8px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        @media (max-width: 480px) {
            .card {
                padding: 2rem 1.5rem;
            }

            h1 {
                font-size: 1.5rem;
            }

            .logo-icon {
                width: 60px;
                height: 60px;
            }
        }

        /* Additional smooth animations */
        .form-group:nth-child(1) { animation-delay: 0.5s; }
        .form-group:nth-child(2) { animation-delay: 0.6s; }
    </style>
</head>
<body>
<!-- Animated background shapes -->
<div class="bg-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<div class="container">
    <div class="card">
        <div class="logo">
            <div class="logo-icon">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                </svg>
            </div>
        </div>

        <h1>Bienvenue</h1>
        <p class="subtitle">Connectez-vous à votre compte pour continuer</p>

        <% String err = request.getParameter("error"); %>
        <% String emptyField = request.getParameter("empty"); %>
        <% String registered = request.getParameter("registered"); %>


        <% if (registered != null) { %>
            <div class="alert alert-success">
                <svg class="alert-icon" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                </svg>
                <span> Inscription réussie ! </span>
            </div>
        <% } else if (err != null) { %>
            <div class="alert alert-error">
                <svg class="alert-icon" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                </svg>
                <span>Email ou mot de passe incorrect.</span>
            </div>
        <% } %>

        <form id="loginForm" action="<%=request.getContextPath()%>/auth/login" method="post" novalidate>
            <div class="form-group">
                <label for="email">Adresse email</label>
                <div class="input-wrapper">
                    <input id="email" name="email" type="email" placeholder="votre.email@example.com" required autocomplete="email" />
                    <svg class="input-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
                    </svg>
                </div>
                <div id="emailError" class="error-message"></div>
            </div>

            <div class="form-group">
                <label for="password">Mot de passe</label>
                <div class="input-wrapper">
                    <input id="password" name="password" type="password" placeholder="••••••••" required autocomplete="current-password" />
                    <svg class="input-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                </div>
                <div id="passwordError" class="error-message"></div>
            </div>

            <div class="form-actions">
                <button class="btn btn-primary" type="submit" id="submitBtn">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"/>
                    </svg>
                    <span>Se connecter</span>
                </button>
            </div>
        </form>

        <div class="divider">
            <span>OU</span>
        </div>

        <div class="footer">
            <p>Vous n'avez pas de compte ? <a href="<%=request.getContextPath()%>/auth/register">Créer un compte</a></p>
        </div>
    </div>
</div>

<script>
(function() {
    const form = document.getElementById('loginForm');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');
    const submitBtn = document.getElementById('submitBtn');

    function showError(element, message) {
        element.textContent = message;
        element.classList.add('show');
        element.previousElementSibling.querySelector('input').style.borderColor = 'var(--error)';
    }

    function hideError(element) {
        element.classList.remove('show');
        element.previousElementSibling.querySelector('input').style.borderColor = '';
    }

    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validateForm() {
        let isValid = true;

        hideError(emailError);
        hideError(passwordError);

        if (!email.value || !validateEmail(email.value)) {
            showError(emailError, 'Veuillez entrer une adresse email valide.');
            isValid = false;
        }

        if (!password.value || password.value.length < 6) {
            showError(passwordError, 'Le mot de passe doit contenir au moins 6 caractères.');
            isValid = false;
        }

        return isValid;
    }

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        if (validateForm()) {
            submitBtn.classList.add('loading');
            submitBtn.querySelector('span').textContent = 'Connexion...';

            // Submit after a short delay for animation
            setTimeout(() => {
                form.submit();
            }, 500);
        }
    });

    // Real-time validation
    email.addEventListener('blur', function() {
        if (email.value && !validateEmail(email.value)) {
            showError(emailError, 'Adresse email invalide.');
        } else {
            hideError(emailError);
        }
    });

    email.addEventListener('input', function() {
        if (emailError.classList.contains('show')) {
            hideError(emailError);
        }
    });

    password.addEventListener('input', function() {
        if (passwordError.classList.contains('show')) {
            hideError(passwordError);
        }
    });

    // Add floating label effect
    const inputs = document.querySelectorAll('input');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });

        input.addEventListener('blur', function() {
            if (!this.value) {
                this.parentElement.classList.remove('focused');
            }
        });
    });
})();
</script>
</body>
</html>
