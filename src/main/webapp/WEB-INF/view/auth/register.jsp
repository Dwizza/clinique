<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>S'inscrire - Clinique Digitale</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <style>
        :root{--bg:#f4f7fb;--card:#ffffff;--primary:#1976d2;--muted:#6b7280}
        body{margin:0;font-family:Inter,Arial,Helvetica,sans-serif;background:var(--bg);color:#111}
        .center{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px}
        .card{width:100%;max-width:520px;padding:28px;border-radius:12px;background:var(--card);box-shadow:0 6px 18px rgba(22,28,37,0.06)}
        h1{margin:0 0 8px;font-size:20px}
        p.lead{margin:0 0 20px;color:var(--muted)}
        .grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
        .field{margin-bottom:12px}
        label{display:block;font-size:13px;margin-bottom:6px;color:#333}
        input[type="text"],input[type="email"],input[type="password"]{width:100%;padding:10px 12px;border:1px solid #e6edf3;border-radius:8px;font-size:14px}
        .full{grid-column:1 / -1}
        .actions{display:flex;align-items:center;justify-content:space-between;margin-top:8px}
        .btn{background:var(--primary);color:#fff;padding:10px 14px;border-radius:8px;text-decoration:none;border:none;cursor:pointer;font-weight:600}
        .btn.secondary{background:#eef5ff;color:var(--primary);border:1px solid #d7e9ff}
        .error{color:#b00020;font-size:13px;margin-top:6px}
        .meta{margin-top:14px;text-align:center}
        a.link{color:var(--primary);text-decoration:none;font-weight:600}
        @media (max-width:600px){.grid{grid-template-columns:1fr}}
    </style>
</head>
<body>
<div class="center">
    <div class="card">
        <% String err = request.getParameter("error"); %>
        <% if (err != null) { %>
            <div style="background:#fff1f0;border:1px solid #f5c6cb;padding:10px;border-radius:8px;margin-bottom:12px;color:#721c24;">Les informations fournies sont invalides. Vérifie et réessaie.</div>
        <% } %>
        <h1>Créer un compte</h1>
        <p class="lead">Renseigne tes informations pour créer un compte utilisateur.</p>
        <form id="registerForm" action="<%=request.getContextPath()%>/auth/register" method="post" novalidate>
            <div class="grid">
                <div class="field">
                    <label for="firstName">Prénom</label>
                    <input id="firstName" name="firstName" type="text" required />
                </div>
                <div class="field">
                    <label for="lastName">Nom</label>
                    <input id="lastName" name="lastName" type="text" required />
                </div>
                <div class="field full">
                    <label for="email">Email</label>
                    <input id="email" name="email" type="email" placeholder="ton.email@example.com" required />
                    <div id="emailError" class="error" style="display:none"></div>
                </div>
                <div class="field">
                    <label for="password">Mot de passe</label>
                    <input id="password" name="password" type="password" required />
                </div>
                <div class="field">
                    <label for="confirm">Confirmer le mot de passe</label>
                    <input id="confirm" name="confirm" type="password" required />
                    <div id="passwordError" class="error" style="display:none"></div>
                </div>
            </div>
            <div class="actions">
                <button class="btn" type="submit">S'inscrire</button>
                <a class="btn secondary" href="<%=request.getContextPath()%>/" type="button">Annuler</a>
            </div>
            <div class="meta">
                <p>Déjà inscrit ? <a class="link" href="<%=request.getContextPath()%>/auth/login">Se connecter</a></p>
            </div>
        </form>
    </div>
</div>
<script>
(function(){
    const form = document.getElementById('registerForm');
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    const confirm = document.getElementById('confirm');
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');

    function validate(){
        let ok=true; emailError.style.display='none'; passwordError.style.display='none';
        if(!email.value || !/^\S+@\S+\.\S+$/.test(email.value)){
            emailError.textContent='Saisis un email valide.'; emailError.style.display='block'; ok=false;
        }
        if(!password.value || password.value.length<6){
            passwordError.textContent='Le mot de passe doit contenir au moins 6 caractères.'; passwordError.style.display='block'; ok=false;
        } else if(password.value !== confirm.value){
            passwordError.textContent='Les mots de passe ne correspondent pas.'; passwordError.style.display='block'; ok=false;
        }
        return ok;
    }

    form.addEventListener('submit', function(e){ if(!validate()){ e.preventDefault(); } });
})();
</script>
</body>
</html>
