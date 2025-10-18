<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Gestion des Disponibilités - Clinique Digitale</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* Styles principaux repris de la vue existante pour un front-only accessible publiquement */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --primary: #0EA5E9; --primary-dark: #0284C7; --primary-light: #38BDF8;
            --secondary: #8B5CF6; --accent: #EC4899; --success: #22C55E; --warning: #F97316;
            --error: #EF4444; --info: #06B6D4; --text: #0F172A; --text-light: #64748B;
            --bg: #F8FAFC; --card-bg: #FFFFFF; --border: #E2E8F0;
        }
        body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; min-height: 100vh; background: linear-gradient(135deg, #0EA5E9 0%, #8B5CF6 50%, #EC4899 100%); background-size: 400% 400%; animation: gradientShift 20s ease infinite; overflow-x: hidden; color: var(--text); }
        @keyframes gradientShift { 0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; } }
        .bg-effects{position:fixed;width:100%;height:100%;overflow:hidden;z-index:0;pointer-events:none}
        .floating-shape{position:absolute;border-radius:50%;background:rgba(255,255,255,.08);animation:floatAround 25s infinite ease-in-out}
        .floating-shape:nth-child(1){width:400px;height:400px;top:-200px;left:-100px;animation-delay:0s}
        .floating-shape:nth-child(2){width:300px;height:300px;bottom:-150px;right:-80px;animation-delay:5s}
        .floating-shape:nth-child(3){width:200px;height:200px;top:50%;left:15%;animation-delay:10s}
        .floating-shape:nth-child(4){width:350px;height:350px;bottom:20%;right:10%;animation-delay:15s}
        @keyframes floatAround{0%,100%{transform:translate(0,0) scale(1)}25%{transform:translate(30px,30px) scale(1.1)}50%{transform:translate(-30px,50px) scale(.9)}75%{transform:translate(50px,-30px) scale(1.05)}}
        .header{position:relative;z-index:10;background:rgba(255,255,255,.98);backdrop-filter:blur(24px);box-shadow:0 4px 24px rgba(0,0,0,.08);animation:slideDown .6s ease-out;border-bottom:1px solid var(--border)}
        @keyframes slideDown{from{opacity:0;transform:translateY(-30px)}to{opacity:1;transform:translateY(0)}}
        .nav-container{max-width:1600px;margin:0 auto;padding:1.5rem 2.5rem;display:flex;justify-content:space-between;align-items:center;gap:2rem}
        .logo-section{display:flex;align-items:center;gap:1rem}
        .logo-icon{width:50px;height:50px;background:linear-gradient(135deg,var(--primary),var(--secondary));border-radius:14px;display:flex;align-items:center;justify-content:center;box-shadow:0 8px 20px rgba(14,165,233,.35);font-weight:900;color:white;font-size:1.2rem}
        .logo-text{font-size:1.5rem;font-weight:900;background:linear-gradient(135deg,var(--primary),var(--secondary));-webkit-background-clip:text;-webkit-text-fill-color:transparent}
        .nav-links{display:flex;gap:.5rem;align-items:center}
        .nav-link{padding:.75rem 1.5rem;border-radius:10px;text-decoration:none;color:var(--text);font-weight:600;transition:all .3s ease;font-size:.95rem}
        .nav-link:hover{background:var(--bg);color:var(--primary)}
        .nav-link.active{background:var(--primary);color:#fff}
        .btn-logout{padding:.75rem 1.5rem;background:linear-gradient(135deg,var(--error),#DC2626);color:#fff;border:none;border-radius:10px;font-weight:600;cursor:pointer;transition:all .3s ease;font-size:.95rem}
        .btn-logout:hover{transform:translateY(-2px);box-shadow:0 8px 20px rgba(239,68,68,.4)}
        .main-container{position:relative;z-index:1;max-width:1600px;margin:2rem auto;padding:0 2.5rem 2.5rem}
        .page-header{background:rgba(255,255,255,.98);backdrop-filter:blur(24px);border-radius:20px;padding:2rem;margin-bottom:2rem;box-shadow:0 8px 32px rgba(0,0,0,.08);animation:fadeInUp .6s ease-out;border:1px solid var(--border)}
        @keyframes fadeInUp{from{opacity:0;transform:translateY(30px)}to{opacity:1;transform:translateY(0)}}
        .page-title{font-size:2rem;font-weight:800;background:linear-gradient(135deg,var(--primary),var(--secondary));-webkit-background-clip:text;-webkit-text-fill-color:transparent;margin-bottom:.5rem}
        .page-description{color:var(--text-light);font-size:1rem}
        .availability-container{background:rgba(255,255,255,.98);backdrop-filter:blur(24px);border-radius:20px;padding:2.5rem;box-shadow:0 8px 32px rgba(0,0,0,.08);animation:fadeInUp .8s ease-out;border:1px solid var(--border)}
        .tabs-container{display:flex;gap:1rem;margin-bottom:2rem;border-bottom:2px solid var(--border);padding-bottom:0}
        .tab-button{padding:1rem 2rem;background:transparent;border:none;border-bottom:3px solid transparent;font-size:1.1rem;font-weight:700;color:var(--text-light);cursor:pointer;transition:all .3s ease;display:flex;align-items:center;gap:.75rem;position:relative;bottom:-2px}
        .tab-button:hover{color:var(--primary)}
        .tab-button.active{color:var(--primary);border-bottom-color:var(--primary)}
        .tab-icon{font-size:1.3rem}
        .tab-content{display:none;animation:fadeIn .5s ease-out}
        .tab-content.active{display:block}
        @keyframes fadeIn{from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:translateY(0)}}
        .weekly-mode{background:linear-gradient(135deg, rgba(14,165,233,.08), rgba(139,92,246,.08));border-radius:16px;padding:2rem;margin-bottom:2rem}
        .weekly-header{display:flex;align-items:center;gap:1rem;margin-bottom:1.5rem}
        .weekly-icon{width:60px;height:60px;background:linear-gradient(135deg,var(--primary),var(--secondary));border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:1.8rem;box-shadow:0 8px 24px rgba(14,165,233,.3)}
        .weekly-info h3{font-size:1.5rem;font-weight:800;color:var(--text);margin-bottom:.25rem}
        .weekly-info p{color:var(--text-light);font-size:.95rem}
        .days-selector{display:grid;grid-template-columns:repeat(auto-fit,minmax(120px,1fr));gap:1rem;margin-bottom:2rem}
        .day-checkbox{position:relative}
        .day-checkbox input{position:absolute;opacity:0;width:0;height:0}
        .day-checkbox label{display:flex;flex-direction:column;align-items:center;gap:.5rem;padding:1.25rem 1rem;background:#fff;border:2px solid var(--border);border-radius:14px;cursor:pointer;transition:all .3s ease;font-weight:600;color:var(--text)}
        .day-checkbox input:checked + label{background:linear-gradient(135deg,var(--primary),var(--primary-light));border-color:var(--primary);color:#fff;box-shadow:0 8px 24px rgba(14,165,233,.3);transform:translateY(-4px)}
        .day-initial{width:45px;height:45px;background:var(--bg);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;font-weight:800}
        .day-checkbox input:checked + label .day-initial{background:rgba(255,255,255,.2);color:#fff}
        .week-grid{display:grid;gap:1.5rem}
        .day-card{background:var(--bg);border-radius:16px;padding:1.5rem;border:2px solid var(--border);transition:all .3s ease}
        .day-card:hover{border-color:var(--primary);box-shadow:0 4px 20px rgba(14,165,233,.15)}
        .day-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:1.5rem}
        .day-name{font-size:1.25rem;font-weight:700;color:var(--text);display:flex;align-items:center;gap:.75rem}
        .switch{position:relative;display:inline-block;width:56px;height:32px}
        .switch input{opacity:0;width:0;height:0}
        .slider{position:absolute;cursor:pointer;top:0;left:0;right:0;bottom:0;background:#CBD5E1;transition:.3s;border-radius:9999px}
        .slider:before{position:absolute;content:"";height:24px;width:24px;left:4px;bottom:4px;background:white;transition:.3s;border-radius:50%;box-shadow:0 2px 8px rgba(0,0,0,.2)}
        input:checked + .slider{background:linear-gradient(135deg,var(--primary),var(--primary-light))}
        input:checked + .slider:before{transform:translateX(24px)}
        .time-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:1rem}
        .time-card{background:#fff;border:1px solid var(--border);border-radius:14px;padding:1rem}
        .time-label{font-weight:700;color:var(--text);margin-bottom:.5rem}
        .time-input{width:100%;padding:.75rem 1rem;border:2px solid var(--border);border-radius:12px;font-size:1rem;transition:border-color .2s}
        .time-input:focus{outline:none;border-color:var(--primary);box-shadow:0 0 0 4px rgba(14,165,233,.15)}
        .actions{display:flex;gap:1rem;flex-wrap:wrap;margin-top:1.5rem}
        .btn{padding:.85rem 1.25rem;border-radius:12px;font-size:.95rem;font-weight:700;cursor:pointer;transition:all .2s;border:none;display:inline-flex;align-items:center;gap:.5rem}
        .btn-primary{background:linear-gradient(135deg,var(--primary),var(--primary-light));color:#fff;box-shadow:0 6px 18px rgba(14,165,233,.35)}
        .btn-primary:hover{transform:translateY(-2px)}
        .btn-outline{background:#fff;border:2px solid var(--border);color:var(--text)}
        .btn-outline:hover{border-color:var(--primary);color:var(--primary)}
        .note{font-size:.9rem;color:var(--text-light)}
        .saved-alert{display:none;margin-top:1rem;padding:1rem;border-radius:12px;background:rgba(34,197,94,.1);border:1px solid rgba(34,197,94,.25);color:#166534}
    </style>
</head>
<body>
<div class="bg-effects">
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
</div>
<header class="header">
    <div class="nav-container">
        <div class="logo-section">
            <div class="logo-icon">CD</div>
            <div class="logo-text">Clinique Digitale</div>
        </div>
        <nav class="nav-links">
            <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Accueil</a>
            <a class="nav-link active" href="#">Mes disponibilités</a>
        </nav>
    </div>
</header>
<main class="main-container">
    <div class="page-header">
        <h1 class="page-title">Gestion des disponibilités</h1>
        <p class="page-description">Définissez vos créneaux de disponibilité pour la semaine complète ou jour par jour. Tout est côté front uniquement.</p>
    </div>

    <div class="availability-container">
        <div class="tabs-container">
            <button class="tab-button active" data-tab="weekly"><span class="tab-icon">📅</span> Semaine complète</button>
            <button class="tab-button" data-tab="daily"><span class="tab-icon">🗓️</span> Par jour</button>
        </div>

        <section id="tab-weekly" class="tab-content active">
            <div class="weekly-mode">
                <div class="weekly-header">
                    <div class="weekly-icon">📆</div>
                    <div class="weekly-info">
                        <h3>Appliquer les mêmes horaires à plusieurs jours</h3>
                        <p>Sélectionnez les jours concernés puis définissez une plage horaire. Vous pourrez ajuster chaque jour ensuite.</p>
                    </div>
                </div>

                <div class="days-selector">
                    <div class="day-checkbox"><input id="day-lundi" type="checkbox"/><label for="day-lundi"><div class="day-initial">L</div>Lundi</label></div>
                    <div class="day-checkbox"><input id="day-mardi" type="checkbox"/><label for="day-mardi"><div class="day-initial">M</div>Mardi</label></div>
                    <div class="day-checkbox"><input id="day-mercredi" type="checkbox"/><label for="day-mercredi"><div class="day-initial">M</div>Mercredi</label></div>
                    <div class="day-checkbox"><input id="day-jeudi" type="checkbox"/><label for="day-jeudi"><div class="day-initial">J</div>Jeudi</label></div>
                    <div class="day-checkbox"><input id="day-vendredi" type="checkbox"/><label for="day-vendredi"><div class="day-initial">V</div>Vendredi</label></div>
                    <div class="day-checkbox"><input id="day-samedi" type="checkbox"/><label for="day-samedi"><div class="day-initial">S</div>Samedi</label></div>
                    <div class="day-checkbox"><input id="day-dimanche" type="checkbox"/><label for="day-dimanche"><div class="day-initial">D</div>Dimanche</label></div>
                </div>

                <div class="time-grid">
                    <div class="time-card">
                        <div class="time-label">Heure de début</div>
                        <input id="weekly-start" class="time-input" type="time" value="08:00"/>
                    </div>
                    <div class="time-card">
                        <div class="time-label">Heure de fin</div>
                        <input id="weekly-end" class="time-input" type="time" value="17:00"/>
                    </div>
                </div>

                <div class="actions">
                    <button id="apply-weekly" class="btn btn-primary">Appliquer aux jours sélectionnés</button>
                    <span class="note">Astuce: vous pouvez ensuite personnaliser chaque jour dans l’onglet "Par jour".</span>
                </div>
            </div>
        </section>

        <section id="tab-daily" class="tab-content">
            <div class="week-grid" id="week-grid">
                <!-- Les cartes de jours seront injectées par JS (front-only) -->
            </div>
        </section>

        <div class="actions">
            <button id="save-all" class="btn btn-primary">Sauvegarder (front uniquement)</button>
            <button id="reset-all" class="btn btn-outline">Réinitialiser</button>
        </div>
        <div id="saved-alert" class="saved-alert">Vos disponibilités ont été sauvegardées côté navigateur (localStorage). Aucune sauvegarde serveur.</div>
    </div>
</main>

<script>
    // Front-only: gestion en mémoire + localStorage, aucun appel backend
    const days = [
        { key: 'lundi', label: 'Lundi' },
        { key: 'mardi', label: 'Mardi' },
        { key: 'mercredi', label: 'Mercredi' },
        { key: 'jeudi', label: 'Jeudi' },
        { key: 'vendredi', label: 'Vendredi' },
        { key: 'samedi', label: 'Samedi' },
        { key: 'dimanche', label: 'Dimanche' }
    ];

    const state = JSON.parse(localStorage.getItem('availability') || '{}');

    function renderDayCards() {
        const grid = document.getElementById('week-grid');
        grid.innerHTML = '';
        days.forEach(d => {
            const dayState = state[d.key] || { active: false, start: '08:00', end: '17:00' };
            const card = document.createElement('div');
            card.className = 'day-card';
            card.innerHTML = `
                <div class="day-header">
                    <div class="day-name">${d.label}</div>
                    <label class="switch">
                        <input type="checkbox" ${dayState.active ? 'checked' : ''} data-day="${d.key}" class="toggle-active">
                        <span class="slider"></span>
                    </label>
                </div>
                <div class="time-grid">
                    <div class="time-card">
                        <div class="time-label">Début</div>
                        <input type="time" class="time-input input-start" data-day="${d.key}" value="${dayState.start}" ${dayState.active ? '' : 'disabled'}>
                    </div>
                    <div class="time-card">
                        <div class="time-label">Fin</div>
                        <input type="time" class="time-input input-end" data-day="${d.key}" value="${dayState.end}" ${dayState.active ? '' : 'disabled'}>
                    </div>
                </div>
            `;
            grid.appendChild(card);
        });

        // Bind events for toggles and inputs
        grid.querySelectorAll('.toggle-active').forEach(chk => {
            chk.addEventListener('change', e => {
                const key = e.target.getAttribute('data-day');
                state[key] = state[key] || { start: '08:00', end: '17:00', active: false };
                state[key].active = e.target.checked;
                saveLocal(false);
                renderDayCards();
            });
        });

        grid.querySelectorAll('.input-start').forEach(inp => {
            inp.addEventListener('change', e => {
                const key = e.target.getAttribute('data-day');
                state[key] = state[key] || { start: '08:00', end: '17:00', active: true };
                state[key].start = e.target.value;
                saveLocal(false);
            });
        });

        grid.querySelectorAll('.input-end').forEach(inp => {
            inp.addEventListener('change', e => {
                const key = e.target.getAttribute('data-day');
                state[key] = state[key] || { start: '08:00', end: '17:00', active: true };
                state[key].end = e.target.value;
                saveLocal(false);
            });
        });
    }

    function applyWeekly() {
        const start = document.getElementById('weekly-start').value;
        const end = document.getElementById('weekly-end').value;
        const selected = Array.from(document.querySelectorAll('.days-selector input:checked'))
            .map(i => i.id.replace('day-',''));
        selected.forEach(key => {
            state[key] = { active: true, start, end };
        });
        saveLocal(false);
        renderDayCards();
    }

    function saveLocal(showAlert = true) {
        localStorage.setItem('availability', JSON.stringify(state));
        if (showAlert) {
            const el = document.getElementById('saved-alert');
            el.style.display = 'block';
            setTimeout(() => el.style.display = 'none', 2500);
        }
    }

    function resetAll() {
        Object.keys(state).forEach(k => delete state[k]);
        localStorage.removeItem('availability');
        document.querySelectorAll('.days-selector input').forEach(i => i.checked = false);
        renderDayCards();
    }

    // Tabs
    document.querySelectorAll('.tab-button').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            const tab = btn.dataset.tab;
            document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
            document.getElementById(`tab-${tab}`).classList.add('active');
        });
    });

    document.getElementById('apply-weekly').addEventListener('click', applyWeekly);
    document.getElementById('save-all').addEventListener('click', () => saveLocal(true));
    document.getElementById('reset-all').addEventListener('click', resetAll);

    // Initial render
    renderDayCards();
</script>
</body>
</html>

