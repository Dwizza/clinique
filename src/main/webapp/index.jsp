<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8"/>
    <title>Clinique Digitale - Votre santé, notre priorité</title>
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
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
            animation: gradientShift 20s ease infinite;
            position: relative;
            overflow-x: hidden;
            color: var(--text);
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Animated background particles */
        .bg-particles {
            position: fixed;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.15);
            animation: float-particle 25s infinite ease-in-out;
        }

        .particle:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 20%;
            animation-delay: 0s;
            animation-duration: 20s;
        }

        .particle:nth-child(2) {
            width: 60px;
            height: 60px;
            top: 60%;
            left: 80%;
            animation-delay: 2s;
            animation-duration: 25s;
        }

        .particle:nth-child(3) {
            width: 100px;
            height: 100px;
            top: 80%;
            left: 10%;
            animation-delay: 4s;
            animation-duration: 30s;
        }

        .particle:nth-child(4) {
            width: 70px;
            height: 70px;
            top: 30%;
            left: 70%;
            animation-delay: 6s;
            animation-duration: 22s;
        }

        .particle:nth-child(5) {
            width: 90px;
            height: 90px;
            top: 50%;
            left: 40%;
            animation-delay: 8s;
            animation-duration: 28s;
        }

        @keyframes float-particle {
            0%, 100% {
                transform: translate(0, 0) rotate(0deg) scale(1);
                opacity: 0.3;
            }
            25% {
                transform: translate(30px, -30px) rotate(90deg) scale(1.2);
                opacity: 0.5;
            }
            50% {
                transform: translate(-30px, 30px) rotate(180deg) scale(0.8);
                opacity: 0.3;
            }
            75% {
                transform: translate(20px, 20px) rotate(270deg) scale(1.1);
                opacity: 0.6;
            }
        }

        /* Modern Header */
        .header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: var(--bg-overlay);
            backdrop-filter: blur(25px);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            animation: slideDown 0.8s cubic-bezier(0.4, 0, 0.2, 1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-100%);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 1rem;
            cursor: pointer;
            transition: transform 0.3s ease;
        }

        .logo-section:hover {
            transform: scale(1.05);
        }

        .logo-icon {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.5);
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

        .logo-icon svg {
            width: 28px;
            height: 28px;
            color: white;
            position: relative;
            z-index: 1;
        }

        .logo-text {
            font-size: 1.75rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .nav-menu {
            display: flex;
            gap: 2.5rem;
            align-items: center;
            list-style: none;
        }

        .nav-link {
            color: var(--text);
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            position: relative;
            transition: color 0.3s ease;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 2px;
            transition: width 0.3s ease;
        }

        .nav-link:hover {
            color: var(--primary);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .nav-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.875rem 2rem;
            border-radius: 14px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
            z-index: 1;
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
            z-index: -1;
        }

        .btn:hover::before {
            width: 400px;
            height: 400px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: white;
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.5);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.6);
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
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        /* Hero Section Ultra Moderne */
        .hero {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 0 auto;
            padding: 6rem 2.5rem 4rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }

        .hero-content {
            animation: fadeInLeft 1s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-60px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1.25rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 50px;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .badge-dot {
            width: 8px;
            height: 8px;
            background: var(--success);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(1.3); }
        }

        .badge-text {
            color: var(--text);
            font-weight: 600;
            font-size: 0.9rem;
        }

        .hero h1 {
            font-size: 4rem;
            font-weight: 900;
            color: white;
            text-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
            margin-bottom: 1.5rem;
            line-height: 1.1;
            letter-spacing: -2px;
        }

        .hero h1 .gradient-text {
            background: linear-gradient(135deg, #FFF 0%, var(--primary-light) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            font-size: 1.35rem;
            color: rgba(255, 255, 255, 0.95);
            margin-bottom: 2.5rem;
            line-height: 1.7;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .hero-actions {
            display: flex;
            gap: 1.25rem;
            flex-wrap: wrap;
        }

        .btn-large {
            padding: 1.25rem 2.5rem;
            font-size: 1.15rem;
        }

        .hero-visual {
            position: relative;
            animation: fadeInRight 1s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(60px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .hero-cards {
            position: relative;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .hero-card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
            animation: float 6s ease-in-out infinite;
        }

        .hero-card:nth-child(1) { animation-delay: 0s; }
        .hero-card:nth-child(2) { animation-delay: 1s; }
        .hero-card:nth-child(3) { animation-delay: 2s; }
        .hero-card:nth-child(4) { animation-delay: 3s; }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .hero-card:hover {
            transform: translateY(-10px) scale(1.05);
        }

        .hero-card-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .hero-card-icon svg {
            width: 24px;
            height: 24px;
            color: white;
        }

        .hero-card h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .hero-card p {
            font-size: 0.9rem;
            color: var(--text-light);
            text-shadow: none;
            margin: 0;
        }

        /* Stats Section */
        .stats {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 4rem auto;
            padding: 0 2.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        }

        .stat-card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease-out both;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 900;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-light);
            font-size: 1rem;
            font-weight: 600;
        }

        /* Services Section */
        .services {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 6rem auto;
            padding: 0 2.5rem;
        }

        .section-header {
            text-align: center;
            margin-bottom: 4rem;
            animation: fadeInUp 0.8s ease-out;
        }

        .section-badge {
            display: inline-block;
            padding: 0.5rem 1.5rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .section-title {
            font-size: 3rem;
            font-weight: 900;
            color: white;
            text-shadow: 0 4px 30px rgba(0, 0, 0, 0.3);
            margin-bottom: 1rem;
        }

        .section-subtitle {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.9);
            max-width: 700px;
            margin: 0 auto;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2.5rem;
        }

        .service-card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 2.5rem;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out both;
        }

        .service-card:nth-child(1) { animation-delay: 0.2s; }
        .service-card:nth-child(2) { animation-delay: 0.3s; }
        .service-card:nth-child(3) { animation-delay: 0.4s; }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--secondary), var(--primary-light));
            background-size: 200% 100%;
            animation: shimmer 4s infinite;
        }

        @keyframes shimmer {
            0% { background-position: -200% 0; }
            100% { background-position: 200% 0; }
        }

        .service-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.25);
        }

        .service-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.4);
        }

        .service-icon svg {
            width: 35px;
            height: 35px;
            color: white;
        }

        .service-card h3 {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text);
            margin-bottom: 1rem;
        }

        .service-card p {
            color: var(--text-light);
            line-height: 1.7;
            margin-bottom: 1.5rem;
            font-size: 1.05rem;
        }

        .service-link {
            color: var(--primary);
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
        }

        .service-link:hover {
            gap: 1rem;
            color: var(--primary-dark);
        }

        /* Testimonials Section */
        .testimonials {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 6rem auto;
            padding: 0 2.5rem;
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            margin-top: 3rem;
        }

        .testimonial-card {
            background: var(--bg-overlay);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease-out both;
        }

        .testimonial-card:nth-child(1) { animation-delay: 0.2s; }
        .testimonial-card:nth-child(2) { animation-delay: 0.3s; }
        .testimonial-card:nth-child(3) { animation-delay: 0.4s; }

        .testimonial-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
        }

        .testimonial-rating {
            display: flex;
            gap: 0.25rem;
            margin-bottom: 1rem;
        }

        .star {
            color: #FCD34D;
            font-size: 1.2rem;
        }

        .testimonial-text {
            color: var(--text);
            line-height: 1.7;
            margin-bottom: 1.5rem;
            font-style: italic;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .author-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .author-info h4 {
            font-weight: 700;
            color: var(--text);
            margin-bottom: 0.25rem;
        }

        .author-info p {
            font-size: 0.9rem;
            color: var(--text-light);
        }

        /* CTA Section */
        .cta-section {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 6rem auto;
            padding: 0 2.5rem;
        }

        .cta-card {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 30px;
            padding: 4rem 3rem;
            text-align: center;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.3);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out;
        }

        .cta-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .cta-card h2 {
            font-size: 3rem;
            font-weight: 900;
            color: white;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .cta-card p {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.95);
            margin-bottom: 2.5rem;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
            z-index: 1;
        }

        .cta-actions {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            position: relative;
            z-index: 1;
        }

        .btn-white {
            background: white;
            color: var(--primary);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .btn-white:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.3);
        }

        /* Footer */
        .footer {
            position: relative;
            z-index: 1;
            background: rgba(17, 24, 39, 0.95);
            backdrop-filter: blur(20px);
            color: rgba(255, 255, 255, 0.9);
            padding: 3rem 2.5rem;
            margin-top: 6rem;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 3rem;
        }

        .footer-brand h3 {
            font-size: 1.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary-light), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .footer-brand p {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .footer-section h4 {
            font-weight: 700;
            margin-bottom: 1rem;
            color: white;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 0.75rem;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary-light);
        }

        .footer-bottom {
            max-width: 1400px;
            margin: 2rem auto 0;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .hero {
                grid-template-columns: 1fr;
                gap: 3rem;
            }

            .services-grid,
            .testimonials-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .footer-content {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 768px) {
            .nav-menu {
                display: none;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 2rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .hero-cards {
                grid-template-columns: 1fr;
            }

            .footer-content {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Animated background particles -->
    <div class="bg-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <!-- Modern Header -->
    <header class="header">
        <div class="nav-container">
            <div class="logo-section">
                <div class="logo-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                    </svg>
                </div>
                <span class="logo-text">Clinique Digitale</span>
            </div>

            <ul class="nav-menu">
                <li><a href="#accueil" class="nav-link">Accueil</a></li>
                <li><a href="#services" class="nav-link">Services</a></li>
                <li><a href="#temoignages" class="nav-link">Témoignages</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>

            <div class="nav-actions">
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/auth/login">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"/>
                    </svg>
                    Connexion
                </a>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/auth/register">
                    <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                    </svg>
                    S'inscrire
                </a>
            </div>
        </div>
    </header>

    <!-- Hero Section Ultra Moderne -->
    <section class="hero" id="accueil">
        <div class="hero-content">
            <div class="hero-badge">
                <span class="badge-dot"></span>
                <span class="badge-text">Plateforme de santé digitale n°1 au Maroc</span>
            </div>

            <h1>
                Votre santé,<br>
                <span class="gradient-text">notre priorité</span>
            </h1>

            <p>
                Gérez votre santé en toute simplicité avec notre plateforme digitale moderne.
                Prenez rendez-vous, consultez vos dossiers médicaux et communiquez avec votre médecin en ligne.
            </p>

            <div class="hero-actions">
                <a class="btn btn-primary btn-large" href="${pageContext.request.contextPath}/auth/register">
                    <svg width="22" height="22" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                    </svg>
                    Commencer gratuitement
                </a>
                <a class="btn btn-secondary btn-large" href="#services">
                    <svg width="22" height="22" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    Voir la démo
                </a>
            </div>
        </div>

        <div class="hero-visual">
            <div class="hero-cards">
                <div class="hero-card">
                    <div class="hero-card-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                    </div>
                    <h3>Rendez-vous 24/7</h3>
                    <p>Réservez à tout moment</p>
                </div>

                <div class="hero-card">
                    <div class="hero-card-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                        </svg>
                    </div>
                    <h3>Sécurisé & Privé</h3>
                    <p>Données 100% protégées</p>
                </div>

                <div class="hero-card">
                    <div class="hero-card-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
                        </svg>
                    </div>
                    <h3>Médecins Experts</h3>
                    <p>Plus de 150 spécialistes</p>
                </div>

                <div class="hero-card">
                    <div class="hero-card-icon">
                        <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                        </svg>
                    </div>
                    <h3>Réponse Rapide</h3>
                    <p>Support instantané</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">15K+</div>
                <div class="stat-label">Patients satisfaits</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">150+</div>
                <div class="stat-label">Médecins spécialistes</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">25K+</div>
                <div class="stat-label">Consultations réalisées</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">98%</div>
                <div class="stat-label">Taux de satisfaction</div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="services" id="services">
        <div class="section-header">
            <span class="section-badge">NOS SERVICES</span>
            <h2 class="section-title">Une plateforme complète pour votre santé</h2>
            <p class="section-subtitle">Profitez d'une expérience médicale digitale unique avec nos services innovants</p>
        </div>

        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                </div>
                <h3>Prise de rendez-vous</h3>
                <p>Réservez vos consultations en ligne 24h/24, 7j/7. Choisissez votre médecin, votre créneau horaire et recevez une confirmation instantanée.</p>
                <a class="service-link" href="${pageContext.request.contextPath}/auth/register">
                    Réserver maintenant
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                </a>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
                <h3>Dossier médical digital</h3>
                <p>Accédez à l'historique complet de vos consultations, prescriptions et résultats d'examens en toute sécurité depuis votre espace personnel.</p>
                <a class="service-link" href="${pageContext.request.contextPath}/auth/login">
                    Voir mes dossiers
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                </a>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8h2a2 2 0 012 2v6a2 2 0 01-2 2h-2v4l-4-4H9a1.994 1.994 0 01-1.414-.586m0 0L11 14h4a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2v4l.586-.586z"/>
                    </svg>
                </div>
                <h3>Téléconsultation</h3>
                <p>Consultez votre médecin à distance via notre plateforme de visioconférence sécurisée. Idéal pour les suivis et consultations simples.</p>
                <a class="service-link" href="${pageContext.request.contextPath}/auth/register">
                    Commencer
                    <svg width="16" height="16" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                    </svg>
                </a>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials" id="temoignages">
        <div class="section-header">
            <span class="section-badge">TÉMOIGNAGES</span>
            <h2 class="section-title">Ce que disent nos patients</h2>
            <p class="section-subtitle">Des milliers de patients satisfaits nous font confiance chaque jour</p>
        </div>

        <div class="testimonials-grid">
            <div class="testimonial-card">
                <div class="testimonial-rating">
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                </div>
                <p class="testimonial-text">
                    "Excellent service ! La prise de rendez-vous est super simple et rapide.
                    J'ai pu consulter un spécialiste en moins de 48h. Je recommande vivement !"
                </p>
                <div class="testimonial-author">
                    <div class="author-avatar">AM</div>
                    <div class="author-info">
                        <h4>Amal Mansouri</h4>
                        <p>Patiente depuis 2 ans</p>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <div class="testimonial-rating">
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                </div>
                <p class="testimonial-text">
                    "La plateforme est très bien conçue et facile à utiliser.
                    J'apprécie particulièrement l'accès à mon dossier médical en ligne. Très pratique !"
                </p>
                <div class="testimonial-author">
                    <div class="author-avatar">YB</div>
                    <div class="author-info">
                        <h4>Youssef Benali</h4>
                        <p>Patient depuis 1 an</p>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <div class="testimonial-rating">
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                    <span class="star">★</span>
                </div>
                <p class="testimonial-text">
                    "Service impeccable et équipe médicale très professionnelle.
                    La téléconsultation m'a fait gagner beaucoup de temps. Merci !"
                </p>
                <div class="testimonial-author">
                    <div class="author-avatar">SE</div>
                    <div class="author-info">
                        <h4>Sanaa El Idrissi</h4>
                        <p>Patiente depuis 3 ans</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <div class="cta-card">
            <h2>Prêt à prendre soin de votre santé ?</h2>
            <p>
                Rejoignez des milliers de patients satisfaits et profitez d'une expérience médicale moderne et personnalisée.
                L'inscription est gratuite et ne prend que quelques minutes.
            </p>
            <div class="cta-actions">
                <a class="btn btn-white btn-large" href="${pageContext.request.contextPath}/auth/register">
                    <svg width="22" height="22" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                    </svg>
                    Créer mon compte gratuitement
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer" id="contact">
        <div class="footer-content">
            <div class="footer-brand">
                <h3>Clinique Digitale</h3>
                <p>
                    Votre plateforme de santé digitale de confiance.
                    Nous révolutionnons l'accès aux soins de santé au Maroc.
                </p>
            </div>

            <div class="footer-section">
                <h4>Services</h4>
                <ul class="footer-links">
                    <li><a href="#services">Prise de rendez-vous</a></li>
                    <li><a href="#services">Dossier médical</a></li>
                    <li><a href="#services">Téléconsultation</a></li>
                    <li><a href="#services">Urgences</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h4>Informations</h4>
                <ul class="footer-links">
                    <li><a href="#temoignages">Témoignages</a></li>
                    <li><a href="#services">À propos</a></li>
                    <li><a href="#contact">Contact</a></li>
                    <li><a href="#services">FAQ</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h4>Légal</h4>
                <ul class="footer-links">
                    <li><a href="#">Mentions légales</a></li>
                    <li><a href="#">Confidentialité</a></li>
                    <li><a href="#">CGU</a></li>
                    <li><a href="#">Cookies</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; <%= java.time.Year.now() %> Clinique Digitale. Tous droits réservés. Votre santé, notre priorité.</p>
        </div>
    </footer>
</body>
</html>
