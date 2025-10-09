<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Clinique Digitale - Accueil</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; background:#f7f9fb; color:#222; }
        h1 { margin-top:0; }
        .grid { display:grid; gap:1.2rem; grid-template-columns:repeat(auto-fit,minmax(280px,1fr)); margin-top:1.5rem; }
        .card { background:#fff; border:1px solid #ddd; border-radius:8px; padding:1rem 1.1rem; box-shadow:0 2px 4px rgba(0,0,0,0.05); }
        .card h2 { font-size:1.1rem; margin:.2rem 0 .8rem; }
        a.btn { display:inline-block; background:#1976d2; color:#fff; text-decoration:none; padding:8px 14px; border-radius:4px; font-size:.9rem; }
        a.btn:hover { background:#145fa9; }
        code { background:#eee; padding:2px 4px; border-radius:4px; font-size:.85rem; }
        ul.inline { list-style:none; padding:0; margin:.4rem 0 0; }
        ul.inline li { margin:.3rem 0; }
        footer { margin-top:2.5rem; font-size:.75rem; color:#666; text-align:center; }
        .todo { color:#b05e00; font-size:.85rem; font-style:italic; }
        .status { font-size:.85rem; margin-top:.5rem; }
        .tag { background:#e1ecf4; color:#0b5079; padding:2px 6px; border-radius:12px; font-size:.65rem; letter-spacing:.5px; }
        .warn { background:#fff8e5; border:1px solid #e7d18a; padding:.6rem .75rem; border-radius:6px; font-size:.8rem; line-height:1.3; }
        .sep { height:1px; background:#ddd; margin:1.5rem 0; }
        .auth-actions { margin: 1.5rem 0; }
        .auth-btn { display: inline-block; padding: 10px 20px; border-radius: 4px; text-align: center; font-size: 0.9rem; margin-right: 10px; }
        .auth-btn.primary { background: #007bff; color: #fff; text-decoration: none; }
        .auth-btn.primary:hover { background: #0056b3; }
        .auth-btn.secondary { background: #6c757d; color: #fff; text-decoration: none; }
        .auth-btn.secondary:hover { background: #5a6268; }
        .small { font-size: 0.8rem; color: #666; margin-top: 5px; display: block; }
    </style>
</head>
<body>
    <h1>Clinique Digitale</h1>
    <p>Point de départ du projet. La configuration PostgreSQL est prête. Tu peux maintenant ajouter progressivement les entités, repository, services et vues.</p>

    <!-- Auth buttons (added) -->
    <div class="auth-actions">
        <a class="auth-btn primary" href="${pageContext.request.contextPath}/auth/login">Se connecter</a>
        <a class="auth-btn secondary" href="${pageContext.request.contextPath}/auth/register">S'inscrire</a>
        <span class="small">(pages de démonstration côté front)</span>
    </div>

    <div class="warn">
        <strong>Note:</strong> Les entités et la logique métier sont encore <em>VIDES</em>. Ajoute <code>@Entity</code> et la configuration JPA avant d'appeler la base depuis le code Java.
    </div>

    <div class="grid">
        <div class="card">
            <h2>Base de données <span class="tag">PostgreSQL</span></h2>
            <ul class="inline">
                <li>Host: <code>localhost</code></li>
                <li>Port: <code>5432</code></li>
                <li>DB: <code>clinique</code></li>
                <li>Utilisateur: <code>root</code></li>
                <li>Mot de passe: <code>root</code></li>
            </ul>
            <a class="btn" href="http://localhost:8081" target="_blank">Ouvrir Adminer</a>
            <div class="status">Statut app serveur: <code><%= application.getServerInfo() %></code></div>
        </div>

        <div class="card">
            <h2>Gestion Patients</h2>
            <p class="todo">TODO: Ajouter l'entité <code>Patient</code>, repository, service et servlet/JSP.</p>
            <ul class="inline">
                <li>1. Définir classe <code>Patient</code></li>
                <li>2. Annoter <code>@Entity</code></li>
                <li>3. Activer <code>hibernate.hbm2ddl.auto=update</code></li>
                <li>4. CRUD repository</li>
                <li>5. Service + validation</li>
                <li>6. Servlet + vues JSP</li>
            </ul>
            <a class="btn" href="#" onclick="alert('Pas encore implémenté');return false;">Accéder (bientôt)</a>
        </div>

        <div class="card">
            <h2>Prochaines étapes</h2>
            <ul class="inline">
                <li>Configurer <code>JPAUtil</code></li>
                <li>Ajouter <code>@Entity</code> + champs</li>
                <li>Repository générique</li>
                <li>Service métier</li>
                <li>Tests JUnit</li>
            </ul>
            <p class="todo">Astuce: Commence par un simple test d'insertion avec un <code>main()</code> ou un test JUnit.</p>
        </div>

        <div class="card">
            <h2>Documentation</h2>
            <ul class="inline">
                <li>README du projet (voir dépôt local)</li>
                <li><a href="https://www.postgresql.org/docs/" target="_blank">Docs PostgreSQL</a></li>
                <li><a href="https://jakarta.ee/specifications/persistence/" target="_blank">Jakarta Persistence</a></li>
                <li><a href="https://hibernate.org/orm/documentation/" target="_blank">Hibernate ORM</a></li>
            </ul>
        </div>
    </div>
    <a href="<%= request.getContextPath() %>/hello">
        <button>conn</button></a>
    <div class="sep"></div>
    <section>
        <h2>Activation JPA (rappel)</h2>
        <ol>
            <li>Dans <code>persistence.xml</code>: passer <code>hibernate.hbm2ddl.auto</code> à <code>update</code></li>
            <li>Ajouter &lt;class&gt;com.cliniquedigitale.cliniquedigitale.entities.Patient&lt;/class&gt;</li>
            <li>Implémenter <code>JPAUtil</code> (EntityManagerFactory)</li>
            <li>Tester avec un insert</li>
        </ol>
        <p class="todo">Tu peux me demander: "bghit ntest insert patient" et je te génère le code.</p>
    </section>

    <footer>
        &copy; <%= java.time.Year.now() %> Clinique Digitale – Structure initiale.
    </footer>
</body>
</html>
