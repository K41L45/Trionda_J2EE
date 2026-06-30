<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — Trionda</title>
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
        .page-header { padding: 36px 0 28px; border-bottom: 1px solid rgba(255,255,255,0.06); background: linear-gradient(135deg, #0f1e35 0%, #080c14 100%); }
        .page-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 600; letter-spacing: 4px; color: rgba(255,255,255,0.28); text-transform: uppercase; margin-bottom: 4px; }
        .page-title { font-family: 'Barlow Condensed', sans-serif; font-size: 2.4rem; font-weight: 900; color: #fff; text-transform: uppercase; letter-spacing: 1px; }
        .page-title span { color: #e8c84a; }
        .page-sub { font-size: 0.85rem; color: rgba(255,255,255,0.35); margin-top: 4px; }
        .metric-card { background: #0f1623; border: 1px solid rgba(255,255,255,0.07); border-radius: 10px; padding: 24px; transition: border-color 0.2s, box-shadow 0.2s; }
        .metric-card:hover { border-color: rgba(232,200,74,0.2); box-shadow: 0 8px 24px rgba(0,0,0,0.4); }
        .metric-icon { font-size: 1.6rem; margin-bottom: 12px; display: block; }
        .metric-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 600; letter-spacing: 3px; color: rgba(255,255,255,0.3); text-transform: uppercase; margin-bottom: 6px; }
        .metric-value { font-family: 'Barlow Condensed', sans-serif; font-size: 2.8rem; font-weight: 900; color: #e8c84a; line-height: 1; }
        .metric-card.revenue .metric-value { font-size: 2.2rem; }
        .alert-danger-t { background: rgba(220,53,69,0.1); border: 1px solid rgba(220,53,69,0.25); color: #e55a68; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link-admin active">Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/matches" class="nav-link-admin">Matches</a>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link-admin">Bookings</a>
                <a href="#" class="btn-nav-logout"
                   onclick="if(confirm('Are you sure you want to log out?')){window.location.href='${pageContext.request.contextPath}/logout';}return false;">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <div class="page-label">Admin Panel</div>
        <div class="page-title">ADMIN <span>DASHBOARD</span></div>
        <div class="page-sub">Welcome back, ${sessionScope.username}</div>
    </div>
</div>

<div class="container py-4">
    <c:if test="${not empty errorMessage}">
        <div class="alert-danger-t">✕ ${errorMessage}</div>
    </c:if>
    <div class="row g-4">
        <div class="col-md-3">
            <div class="metric-card">
                <span class="metric-icon">👥</span>
                <div class="metric-label">Total Customers</div>
                <div class="metric-value">${metrics.totalUsers}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="metric-card">
                <span class="metric-icon">🏆</span>
                <div class="metric-label">Open Matches</div>
                <div class="metric-value">${metrics.openMatches}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="metric-card">
                <span class="metric-icon">🎫</span>
                <div class="metric-label">Confirmed Bookings</div>
                <div class="metric-value">${metrics.confirmedBookings}</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="metric-card revenue">
                <span class="metric-icon">💰</span>
                <div class="metric-label">Total Revenue</div>
                <div class="metric-value">$${metrics.totalRevenue}</div>
            </div>
        </div>
    </div>
</div>
</body>
</html>