<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Inscription Patient - Clinique Digitale</title>
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
            overflow-x: hidden;
            overflow-y: auto;
            padding: 2rem 1rem;
            color: var(--text);
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
            max-width: 900px;
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

        .form-section {
            margin-bottom: 2rem;
            animation: fadeIn 0.8s ease-out 0.5s both;
        }

        .form-section-title {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 1.25rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid rgba(99, 102, 241, 0.2);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .form-section-icon {
            width: 24px;
            height: 24px;
            color: var(--primary);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        label {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            transition: color 0.2s;
        }

        .required {
            color: var(--error);
        }

        input, select, textarea {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid #E5E7EB;
            border-radius: 12px;
            font-size: 0.95rem;
            font-family: inherit;
            transition: all 0.3s ease;
            background: white;
            outline: none;
        }

        input:focus, select:focus, textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            transform: translateY(-1px);
        }

        input:hover, select:hover, textarea:hover {
            border-color: var(--primary-light);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .radio-group {
            display: flex;
            gap: 1.5rem;
            padding-top: 0.5rem;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: var(--primary);
        }

        .radio-option label {
            margin: 0;
            cursor: pointer;
            font-weight: 500;
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
            display: flex;
            gap: 1rem;
            margin-top: 2.5rem;
            padding-top: 2rem;
            border-top: 1px solid rgba(229, 231, 235, 0.5);
            animation: fadeIn 0.8s ease-out 0.7s both;
        }

        .btn {
            flex: 1;
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

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

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

            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-actions {
                flex-direction: column;
            }
        }
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
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                </svg>
            </div>
        </div>

        <h1>Créer votre compte</h1>
        <p class="subtitle">Rejoignez notre clinique digitale en quelques étapes simples</p>

        <% String error = request.getParameter("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error">
                <svg class="alert-icon" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                </svg>
                <span>
                    <% if ("validation".equals(error)) { %>
                        Tous les champs obligatoires doivent être remplis correctement.
                    <% } else if ("exists".equals(error)) { %>
                        Un compte avec cet email ou ce CIN existe déjà.
                    <% } else if ("invaliddate".equals(error)) { %>
                        La date de naissance est invalide.
                    <% } else { %>
                        Une erreur s'est produite. Veuillez réessayer.
                    <% } %>
                </span>
            </div>
        <% } %>

        <form id="registerForm" action="<%=request.getContextPath()%>/auth/register" method="post" novalidate>
            <!-- Section Compte -->
            <div class="form-section">
                <h2 class="form-section-title">
                    <svg class="form-section-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    Informations du compte
                </h2>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="firstName">Prénom <span class="required">*</span></label>
                        <input id="firstName" type="text" required placeholder="Entrez votre prénom" />
                    </div>

                    <div class="form-group">
                        <label for="lastName">Nom <span class="required">*</span></label>
                        <input id="lastName" type="text" required placeholder="Entrez votre nom" />
                    </div>

                    <input type="hidden" id="name" name="name" />

                    <div class="form-group full">
                        <label for="email">Email <span class="required">*</span></label>
                        <input id="email" name="email" type="email" required placeholder="votre.email@example.com" />
                        <div id="emailError" class="error-message"></div>
                    </div>

                    <div class="form-group">
                        <label for="password">Mot de passe <span class="required">*</span></label>
                        <input id="password" name="password" type="password" required placeholder="Min. 6 caractères" />
                        <div id="passwordError" class="error-message"></div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Confirmer le mot de passe <span class="required">*</span></label>
                        <input id="confirmPassword" type="password" required placeholder="Confirmez votre mot de passe" />
                        <div id="confirmPasswordError" class="error-message"></div>
                    </div>
                </div>
            </div>

            <!-- Section Informations personnelles -->
            <div class="form-section">
                <h2 class="form-section-title">
                    <svg class="form-section-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2"/>
                    </svg>
                    Informations personnelles
                </h2>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="cin">CIN <span class="required">*</span></label>
                        <input id="cin" name="cin" type="text" required placeholder="Ex: AB123456" />
                        <div id="cinError" class="error-message"></div>
                    </div>

                    <div class="form-group">
                        <label for="naissance">Date de naissance <span class="required">*</span></label>
                        <input id="naissance" name="naissance" type="date" required />
                        <div id="naissanceError" class="error-message"></div>
                    </div>

                    <div class="form-group">
                        <label for="telephone">Téléphone <span class="required">*</span></label>
                        <input id="telephone" name="telephone" type="tel" required placeholder="Ex: 0612345678" />
                        <div id="telephoneError" class="error-message"></div>
                    </div>

                    <div class="form-group">
                        <label>Sexe <span class="required">*</span></label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="homme" name="sexe" value="Homme" required />
                                <label for="homme">Homme</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="femme" name="sexe" value="Femme" required />
                                <label for="femme">Femme</label>
                            </div>
                        </div>
                        <div id="sexeError" class="error-message"></div>
                    </div>

                    <div class="form-group full">
                        <label for="adresse">Adresse</label>
                        <textarea id="adresse" name="adresse" placeholder="Entrez votre adresse complète"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="sang">Groupe sanguin</label>
                        <select id="sang" name="sang">
                            <option value="">Sélectionnez votre groupe sanguin</option>
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
                </div>
            </div>

            <div class="form-actions">
                <button class="btn btn-primary" type="submit">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                    </svg>
                    Créer mon compte
                </button>
                <a class="btn btn-secondary" href="<%=request.getContextPath()%>/auth/login">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                    Annuler
                </a>
            </div>
        </form>

        <div class="footer">
            <p>Vous avez déjà un compte ? <a href="<%=request.getContextPath()%>/auth/login">Se connecter</a></p>
        </div>
    </div>
</div>

<script>
(function() {
    const form = document.getElementById('registerForm');
    const firstName = document.getElementById('firstName');
    const lastName = document.getElementById('lastName');
    const name = document.getElementById('name');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const cin = document.getElementById('cin');
    const naissance = document.getElementById('naissance');
    const telephone = document.getElementById('telephone');
    const sexeRadios = document.getElementsByName('sexe');

    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');
    const confirmPasswordError = document.getElementById('confirmPasswordError');
    const cinError = document.getElementById('cinError');
    const naissanceError = document.getElementById('naissanceError');
    const telephoneError = document.getElementById('telephoneError');
    const sexeError = document.getElementById('sexeError');

    function showError(element, message) {
        element.textContent = message;
        element.classList.add('show');
        const input = element.previousElementSibling;
        if (input && input.tagName !== 'DIV') {
            input.style.borderColor = 'var(--error)';
        }
    }

    function hideError(element) {
        element.classList.remove('show');
        const input = element.previousElementSibling;
        if (input && input.tagName !== 'DIV') {
            input.style.borderColor = '';
        }
    }

    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validateCIN(cin) {
        return cin && cin.length >= 6 && cin.length <= 10;
    }

    function validatePhone(phone) {
        const re = /^[0-9]{10}$/;
        return re.test(phone.replace(/\s/g, ''));
    }

    function validateForm() {
        let isValid = true;

        // Reset errors
        [emailError, passwordError, confirmPasswordError, cinError, naissanceError, telephoneError, sexeError].forEach(hideError);

        // Validate email
        if (!email.value || !validateEmail(email.value)) {
            showError(emailError, 'Veuillez entrer une adresse email valide.');
            isValid = false;
        }

        // Validate password
        if (!password.value || password.value.length < 6) {
            showError(passwordError, 'Le mot de passe doit contenir au moins 6 caractères.');
            isValid = false;
        }

        // Validate password confirmation
        if (password.value !== confirmPassword.value) {
            showError(confirmPasswordError, 'Les mots de passe ne correspondent pas.');
            isValid = false;
        }

        // Validate CIN
        if (!cin.value || !validateCIN(cin.value)) {
            showError(cinError, 'Veuillez entrer un CIN valide (6-10 caractères).');
            isValid = false;
        }

        // Validate date of birth
        if (!naissance.value) {
            showError(naissanceError, 'Veuillez sélectionner votre date de naissance.');
            isValid = false;
        } else {
            const birthDate = new Date(naissance.value);
            const today = new Date();
            const age = today.getFullYear() - birthDate.getFullYear();
            if (age < 1 || age > 120) {
                showError(naissanceError, 'Veuillez entrer une date de naissance valide.');
                isValid = false;
            }
        }

        // Validate phone
        if (!telephone.value || !validatePhone(telephone.value)) {
            showError(telephoneError, 'Veuillez entrer un numéro de téléphone valide (10 chiffres).');
            isValid = false;
        }

        // Validate sexe
        let sexeSelected = false;
        for (let radio of sexeRadios) {
            if (radio.checked) {
                sexeSelected = true;
                break;
            }
        }
        if (!sexeSelected) {
            showError(sexeError, 'Veuillez sélectionner votre sexe.');
            isValid = false;
        }

        return isValid;
    }

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        if (validateForm()) {
            // Concatenate first and last name
            name.value = (firstName.value.trim() + ' ' + lastName.value.trim()).trim();

            if (!name.value) {
                alert('Veuillez entrer votre prénom et nom.');
                return;
            }

            // Submit form
            form.submit();
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

    password.addEventListener('input', function() {
        if (password.value.length > 0 && password.value.length < 6) {
            showError(passwordError, 'Au moins 6 caractères requis.');
        } else {
            hideError(passwordError);
        }
    });

    confirmPassword.addEventListener('input', function() {
        if (confirmPassword.value && password.value !== confirmPassword.value) {
            showError(confirmPasswordError, 'Les mots de passe ne correspondent pas.');
        } else {
            hideError(confirmPasswordError);
        }
    });

    cin.addEventListener('blur', function() {
        if (cin.value && !validateCIN(cin.value)) {
            showError(cinError, 'CIN invalide (6-10 caractères).');
        } else {
            hideError(cinError);
        }
    });

    telephone.addEventListener('blur', function() {
        if (telephone.value && !validatePhone(telephone.value)) {
            showError(telephoneError, 'Numéro de téléphone invalide.');
        } else {
            hideError(telephoneError);
        }
    });
})();
</script>
</body>
</html>
