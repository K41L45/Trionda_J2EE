<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Trionda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            background: #080c14;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Barlow', sans-serif;
            position: relative;
            overflow: hidden;
        }
        body::before {
            content: '';
            position: fixed;
            top: -30%;
            left: 50%;
            transform: translateX(-50%);
            width: 700px;
            height: 700px;
            background: radial-gradient(ellipse, rgba(232,200,74,0.07) 0%, transparent 70%);
            pointer-events: none;
            z-index: 0;
        }
        .color-bar {
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%);
            z-index: 999;
        }
        .register-wrap {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 440px;
            padding: 0 20px;
        }
        .register-card {
            background: #0f1623;
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 14px;
            padding: 40px 36px;
            box-shadow: 0 24px 60px rgba(0,0,0,0.5);
        }
        .brand-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-bottom: 6px;
        }
        .logo-ball { height: 36px; width: auto; filter: invert(1) sepia(1) saturate(5) hue-rotate(5deg); }
        .logo-wc   { height: 42px; width: auto; mix-blend-mode: screen; }
        .brand-text {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 2rem;
            font-weight: 900;
            color: #e8c84a;
            letter-spacing: 3px;
            text-transform: uppercase;
            line-height: 1;
        }
        .brand-sub {
            text-align: center;
            font-size: 0.8rem;
            color: rgba(255,255,255,0.35);
            font-family: 'Barlow', sans-serif;
            letter-spacing: 1px;
            margin-bottom: 32px;
        }
        .form-label-custom {
            display: block;
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.4);
            margin-bottom: 7px;
        }
        /* ✅ FIX: Konsisten dark di semua state termasuk autofill Chrome */
        .form-input {
            width: 100%;
            background: #1a2235 !important;
            border: 1px solid rgba(255,255,255,0.12) !important;
            border-radius: 6px;
            padding: 11px 14px;
            font-family: 'Barlow', sans-serif;
            font-size: 0.9rem;
            color: #f0f0f0 !important;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            margin-bottom: 20px;
            -webkit-text-fill-color: #f0f0f0;
            caret-color: #e8c84a;
        }
        .form-input:-webkit-autofill,
        .form-input:-webkit-autofill:hover,
        .form-input:-webkit-autofill:focus,
        .form-input:-webkit-autofill:active {
            -webkit-box-shadow: 0 0 0 1000px #1a2235 inset !important;
            -webkit-text-fill-color: #f0f0f0 !important;
            border-color: rgba(255,255,255,0.12) !important;
            caret-color: #e8c84a;
        }
        .form-input::placeholder { color: rgba(255,255,255,0.2) !important; }
        .form-input:focus {
            border-color: #e8c84a !important;
            box-shadow: 0 0 0 3px rgba(232,200,74,0.12) !important;
            background: #1a2235 !important;
        }
        .btn-register {
            display: block;
            width: 100%;
            background: #e8c84a;
            color: #080c14;
            text-align: center;
            padding: 13px;
            border-radius: 6px;
            font-family: 'Barlow Condensed', sans-serif;
            font-weight: 800;
            font-size: 1rem;
            letter-spacing: 2px;
            text-transform: uppercase;
            border: none;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-register:hover { background: #f5d75e; }
        .divider {
            border: none;
            border-top: 1px solid rgba(255,255,255,0.07);
            margin: 24px 0 16px;
        }
        .footer-text {
            text-align: center;
            font-size: 0.82rem;
            color: rgba(255,255,255,0.3);
            font-family: 'Barlow', sans-serif;
        }
        .footer-text a {
            color: #e8c84a;
            text-decoration: none;
            font-weight: 600;
        }
        .footer-text a:hover { text-decoration: underline; }
        .alert-danger-custom {
            background: rgba(220,53,69,0.1);
            border: 1px solid rgba(220,53,69,0.25);
            color: #e55a68;
            border-radius: 7px;
            padding: 11px 14px;
            font-size: 0.83rem;
            font-family: 'Barlow', sans-serif;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="color-bar"></div>
<div class="register-wrap">
    <div class="register-card">

        <div class="brand-row">
            <img src="${pageContext.request.contextPath}/images/trionda-logo.png" alt="Trionda" class="logo-ball" onerror="this.style.display='none'">
            <span class="brand-text">TRIONDA</span>
            <img src="${pageContext.request.contextPath}/images/wc2026-logo.avif" alt="WC2026" class="logo-wc" onerror="this.style.display='none'">
        </div>
        <div class="brand-sub">Create your account</div>

        <c:if test="${not empty errorMessage}">
            <div class="alert-danger-custom">✕ ${errorMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/register">
            <label class="form-label-custom">Full Name</label>
            <input type="text" name="username" class="form-input" placeholder="Your full name" required>

            <label class="form-label-custom">Email</label>
            <input type="email" name="email" class="form-input" placeholder="email@example.com" required>

            <label class="form-label-custom">Password</label>
            <input type="password" name="password" class="form-input" placeholder="Min. 4 characters" required minlength="4">

            <button type="submit" class="btn-register">Create Account →</button>
        </form>

        <hr class="divider">
        <p class="footer-text">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Log in here</a>
        </p>
    </div>
</div>
</body>
</html>