<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Matches — Trionda</title>
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
        .btn-add-match { background: #e8c84a; color: #080c14; font-family: 'Barlow Condensed', sans-serif; font-size: 0.8rem; font-weight: 800; letter-spacing: 1px; text-transform: uppercase; padding: 8px 20px; border-radius: 3px; text-decoration: none; border: none; transition: background 0.2s; }
        .btn-add-match:hover { background: #f5d75e; color: #080c14; }
        .matches-table { width: 100%; border-collapse: collapse; }
        .matches-table thead th { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: rgba(255,255,255,0.28); padding: 12px 16px; border-bottom: 1px solid rgba(255,255,255,0.07); text-align: left; }
        .matches-table tbody tr { border-bottom: 1px solid rgba(255,255,255,0.05); transition: background 0.15s; }
        .matches-table tbody tr:hover { background: rgba(255,255,255,0.03); }
        .matches-table tbody td { padding: 14px 16px; font-size: 0.85rem; vertical-align: middle; }
        .match-name { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 800; color: #fff; text-transform: uppercase; letter-spacing: 1px; }
        .match-date { font-size: 0.75rem; color: rgba(255,255,255,0.35); margin-top: 2px; }
        .venue-name { font-size: 0.82rem; color: rgba(255,255,255,0.6); }
        .venue-city { font-size: 0.72rem; color: rgba(255,255,255,0.3); }
        .badge-group { background: #e8c84a; color: #080c14; font-family: 'Barlow Condensed', sans-serif; font-size: 0.62rem; font-weight: 800; padding: 2px 8px; border-radius: 2px; letter-spacing: 1px; text-transform: uppercase; }
        .badge-open { background: rgba(39,174,96,0.12); color: #2ecc71; border: 1px solid rgba(39,174,96,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 2px 8px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; }
        .badge-closed { background: rgba(220,53,69,0.12); color: #e55a68; border: 1px solid rgba(220,53,69,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 2px 8px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; }
        .action-wrap { display: flex; gap: 6px; align-items: center; flex-wrap: wrap; }
        .btn-action { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; padding: 5px 12px; border-radius: 3px; text-decoration: none; border: none; cursor: pointer; transition: all 0.2s; white-space: nowrap; }
        .btn-close-match { background: transparent; border: 1px solid rgba(220,53,69,0.4); color: #e55a68; }
        .btn-close-match:hover { background: rgba(220,53,69,0.12); border-color: #e55a68; }
        .btn-open-match { background: transparent; border: 1px solid rgba(39,174,96,0.4); color: #2ecc71; }
        .btn-open-match:hover { background: rgba(39,174,96,0.12); border-color: #2ecc71; }
        .btn-delete-match { background: transparent; border: 1px solid rgba(255,255,255,0.12); color: rgba(255,255,255,0.3); }
        .btn-delete-match:hover { background: rgba(220,53,69,0.1); border-color: rgba(220,53,69,0.4); color: #e55a68; }
        .alert-success-t { background: rgba(39,174,96,0.1); border: 1px solid rgba(39,174,96,0.25); color: #2ecc71; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }
        .alert-danger-t { background: rgba(220,53,69,0.1); border: 1px solid rgba(220,53,69,0.25); color: #e55a68; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }
        .alert-info-t { background: rgba(0,87,217,0.1); border: 1px solid rgba(0,87,217,0.25); color: #5599ff; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }
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
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <div class="page-label">Admin Panel</div>
                <div class="page-title">MANAGE <span>MATCHES</span></div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/matches?action=form" class="btn-add-match">+ Add Match</a>
        </div>
    </div>
</div>

<div class="container py-4">
    <c:if test="${param.created == 'true'}">
        <div class="alert-success-t">✓ Match successfully created.</div>
    </c:if>
    <c:if test="${param.deleted == 'true'}">
        <div class="alert-success-t">✓ Match successfully deleted.</div>
    </c:if>
    <c:if test="${param.toggled == 'close'}">
        <div class="alert-success-t">✓ Match closed successfully.</div>
    </c:if>
    <c:if test="${param.toggled == 'open'}">
        <div class="alert-info-t">✓ Match reopened successfully.</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert-danger-t">✕ ${errorMessage}</div>
    </c:if>

    <table class="matches-table">
        <thead>
        <tr>
            <th>Match</th>
            <th>Venue</th>
            <th>Group</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="m" items="${matches}">
            <tr>
                <td>
                    <div class="match-name">${m.homeTeam} vs ${m.awayTeam}</div>
                    <div class="match-date">${m.matchDate}</div>
                </td>
                <td>
                    <div class="venue-name">${m.venue}</div>
                    <div class="venue-city">${m.hostCity}</div>
                </td>
                <td><span class="badge-group">Group ${m.groupName}</span></td>
                <td>
                    <c:choose>
                        <c:when test="${m.status == 'OPEN'}">
                            <span class="badge-open">● OPEN</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-closed">● CLOSED</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <div class="action-wrap">
                        <c:choose>
                            <c:when test="${m.status == 'OPEN'}">
                                <a href="${pageContext.request.contextPath}/admin/matches?action=close&id=${m.matchId}"
                                   class="btn-action btn-close-match"
                                   onclick="return confirm('Close match ${m.homeTeam} vs ${m.awayTeam}?')">Close</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/admin/matches?action=open&id=${m.matchId}"
                                   class="btn-action btn-open-match"
                                   onclick="return confirm('Reopen match ${m.homeTeam} vs ${m.awayTeam}?')">Reopen</a>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/admin/matches?action=delete&id=${m.matchId}"
                           class="btn-action btn-delete-match"
                           onclick="return confirm('DELETE ${m.homeTeam} vs ${m.awayTeam}? This cannot be undone!')">Delete</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>