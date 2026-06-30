<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Match — Trionda</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: #080c14; color: #f0f0f0; font-family: 'Barlow', sans-serif; min-height: 100vh; }
    .color-bar { height: 3px; background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%); }
    .navbar-admin { background: rgba(8,12,20,0.97); border-bottom: 1px solid rgba(255,255,255,0.07); padding: 10px 0; position: sticky; top: 0; z-index: 1000; }
    .navbar-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
    .logo-ball { height: 32px; width: auto; filter: invert(1) sepia(1) saturate(5) hue-rotate(5deg); }
    .navbar-brand-text { font-family: 'Barlow Condensed', sans-serif; font-size: 1.5rem; font-weight: 800; color: #e8c84a; letter-spacing: 2px; text-transform: uppercase; }
    .admin-badge { background: rgba(232,200,74,0.15); border: 1px solid rgba(232,200,74,0.3); color: #e8c84a; font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 2px 7px; border-radius: 2px; letter-spacing: 2px; text-transform: uppercase; }
    .nav-links { display: flex; align-items: center; gap: 4px; }
    .nav-link-admin { font-family: 'Barlow Condensed', sans-serif; font-size: 0.8rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: rgba(255,255,255,0.45); text-decoration: none; padding: 6px 14px; border-radius: 3px; transition: all 0.2s; }
    .nav-link-admin:hover { color: #fff; background: rgba(255,255,255,0.06); }
    .nav-link-admin.active { color: #e8c84a; }
    .btn-nav-logout { border: 1.5px solid rgba(255,255,255,0.15); color: rgba(255,255,255,0.5); background: transparent; font-family: 'Barlow Condensed', sans-serif; font-size: 0.76rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; padding: 6px 16px; border-radius: 3px; text-decoration: none; transition: all 0.2s; cursor: pointer; }
    .btn-nav-logout:hover { border-color: #fff; color: #fff; }
    .page-header { padding: 28px 0 22px; border-bottom: 1px solid rgba(255,255,255,0.06); background: linear-gradient(135deg, #0f1e35 0%, #080c14 100%); }
    .page-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 600; letter-spacing: 4px; color: rgba(255,255,255,0.28); text-transform: uppercase; margin-bottom: 4px; }
    .page-title { font-family: 'Barlow Condensed', sans-serif; font-size: 2rem; font-weight: 900; color: #fff; text-transform: uppercase; letter-spacing: 1px; }
    .page-title span { color: #e8c84a; }

    /* FORM CARD */
    .form-card { background: #0f1623; border: 1px solid rgba(255,255,255,0.07); border-radius: 12px; padding: 32px; }
    .section-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 700; letter-spacing: 4px; color: #e8c84a; text-transform: uppercase; margin-bottom: 18px; padding-bottom: 10px; border-bottom: 1px solid rgba(232,200,74,0.15); }
    .form-label-custom { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 700; letter-spacing: 2px; color: rgba(255,255,255,0.4); text-transform: uppercase; margin-bottom: 7px; display: block; }

    /* ✅ FIX UTAMA: Override Bootstrap + Chrome autofill — semua state dark */
    .form-input {
      width: 100%;
      background: #1a2235 !important;
      border: 1px solid rgba(255,255,255,0.12) !important;
      border-radius: 6px;
      padding: 10px 14px;
      font-family: 'Barlow', sans-serif;
      font-size: 0.9rem;
      color: #f0f0f0 !important;
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
      -webkit-text-fill-color: #f0f0f0 !important;
      caret-color: #e8c84a;
      appearance: none;
      -webkit-appearance: none;
    }
    /* Chrome autofill override */
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
      box-shadow: 0 0 0 3px rgba(232,200,74,0.1) !important;
      background: #1a2235 !important;
    }
    /* Select dropdown arrow */
    .form-input-select {
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%23e8c84a' d='M1 1l5 5 5-5'/%3E%3C/svg%3E") !important;
      background-repeat: no-repeat !important;
      background-position: right 14px center !important;
      padding-right: 36px !important;
    }
    .form-input option { background: #0f1623 !important; color: #f0f0f0; }

    /* datetime-local fix — icon kalender juga perlu override */
    input[type="datetime-local"]::-webkit-calendar-picker-indicator {
      filter: invert(1) sepia(1) saturate(2) hue-rotate(5deg);
      cursor: pointer;
      opacity: 0.7;
    }
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
      filter: invert(0.8);
    }

    .input-hint { font-size: 0.72rem; color: rgba(255,255,255,0.25); margin-top: 4px; }
    .btn-submit { display: block; width: 100%; background: #e8c84a; color: #080c14; text-align: center; padding: 14px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 1rem; letter-spacing: 1px; text-transform: uppercase; transition: background 0.2s; border: none; cursor: pointer; margin-bottom: 10px; }
    .btn-submit:hover { background: #f5d75e; }
    .btn-back-form { display: block; width: 100%; text-align: center; padding: 12px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 700; font-size: 0.85rem; text-decoration: none; letter-spacing: 1px; text-transform: uppercase; border: 1.5px solid rgba(255,255,255,0.12); color: rgba(255,255,255,0.4); transition: all 0.2s; }
    .btn-back-form:hover { border-color: rgba(255,255,255,0.4); color: rgba(255,255,255,0.8); }
    .alert-danger-t { background: rgba(220,53,69,0.1); border: 1px solid rgba(220,53,69,0.25); color: #e55a68; border-radius: 7px; padding: 11px 14px; font-size: 0.83rem; margin-bottom: 20px; }
    .mb-field { margin-bottom: 18px; }
  </style>
</head>
<body>
<div class="color-bar"></div>
<nav class="navbar-admin">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center">
      <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-logo">
        <img src="${pageContext.request.contextPath}/images/trionda-logo.png" alt="Trionda" class="logo-ball" onerror="this.style.display='none'">
        <span class="navbar-brand-text">TRIONDA</span>
        <span class="admin-badge">ADMIN</span>
      </a>
      <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link-admin">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/matches" class="nav-link-admin active">Matches</a>
        <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link-admin">Bookings</a>
        <a href="#" class="btn-nav-logout"
           onclick="if(confirm('Are you sure you want to log out?')){window.location.href='${pageContext.request.contextPath}/logout';}return false;">Logout</a>
      </div>
    </div>
  </div>
</nav>

<div class="page-header">
  <div class="container">
    <div class="page-label">Admin Panel · Matches</div>
    <div class="page-title">ADD <span>NEW MATCH</span></div>
  </div>
</div>

<div class="container py-4">
  <div class="row justify-content-center">
    <div class="col-md-9 col-lg-8">
      <div class="form-card">

        <c:if test="${not empty errorMessage}">
          <div class="alert-danger-t">✕ ${errorMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/admin/matches" autocomplete="off">

          <div class="section-label">Match Information</div>

          <div class="row g-3 mb-2">
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Home Team</label>
              <input type="text" name="homeTeam" class="form-input"
                     required placeholder="e.g. Brazil" autocomplete="off">
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Away Team</label>
              <input type="text" name="awayTeam" class="form-input"
                     required placeholder="e.g. Argentina" autocomplete="off">
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Match Date &amp; Time</label>
              <input type="datetime-local" name="matchDate" class="form-input" required>
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Group</label>
              <select name="groupName" class="form-input form-input-select" required>
                <option value="A">Group A</option>
                <option value="B">Group B</option>
                <option value="C">Group C</option>
                <option value="D">Group D</option>
                <option value="E">Group E</option>
                <option value="F">Group F</option>
                <option value="G">Group G</option>
                <option value="H">Group H</option>
                <option value="I">Group I</option>
                <option value="J">Group J</option>
                <option value="K">Group K</option>
                <option value="L">Group L</option>
              </select>
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Venue</label>
              <input type="text" name="venue" class="form-input"
                     required placeholder="e.g. MetLife Stadium" autocomplete="off">
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Host City</label>
              <input type="text" name="hostCity" class="form-input"
                     required placeholder="e.g. New York" autocomplete="off">
            </div>
          </div>

          <div class="section-label" style="margin-top:8px;">Ticket Categories</div>

          <div class="row g-3">
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Regular Price ($)</label>
              <input type="number" name="regularPrice" class="form-input"
                     required step="0.01" min="0.01" placeholder="150.00" autocomplete="off">
              <div class="input-hint">Minimum $0.01</div>
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">Regular Quota</label>
              <input type="number" name="regularQuota" class="form-input"
                     required min="1" placeholder="100" autocomplete="off">
              <div class="input-hint">Minimum 1 ticket</div>
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">VIP Price ($)</label>
              <input type="number" name="vipPrice" class="form-input"
                     required step="0.01" min="0.01" placeholder="500.00" autocomplete="off">
              <div class="input-hint">Minimum $0.01</div>
            </div>
            <div class="col-md-6 mb-field">
              <label class="form-label-custom">VIP Quota</label>
              <input type="number" name="vipQuota" class="form-input"
                     required min="1" placeholder="20" autocomplete="off">
              <div class="input-hint">Minimum 1 ticket</div>
            </div>
          </div>

          <button type="submit" class="btn-submit">Create Match →</button>
        </form>

        <a href="${pageContext.request.contextPath}/admin/matches" class="btn-back-form">← Back to Matches</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>