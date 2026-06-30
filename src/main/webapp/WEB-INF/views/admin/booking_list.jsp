<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings — Trionda</title>
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

        /* STATS BAR */
        .stats-bar { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 24px; }
        .stat-chip { background: #0f1623; border: 1px solid rgba(255,255,255,0.07); border-radius: 8px; padding: 12px 18px; display: flex; flex-direction: column; gap: 3px; min-width: 130px; }
        .stat-chip-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.62rem; font-weight: 600; letter-spacing: 3px; color: rgba(255,255,255,0.28); text-transform: uppercase; }
        .stat-chip-val { font-family: 'Barlow Condensed', sans-serif; font-size: 1.6rem; font-weight: 900; color: #e8c84a; line-height: 1; }
        .stat-chip-val.green { color: #2ecc71; }
        .stat-chip-val.red { color: #e55a68; }

        /* SEARCH */
        .search-bar { display: flex; gap: 10px; margin-bottom: 20px; align-items: center; flex-wrap: wrap; }
        .search-input {
            background: #1a2235 !important;
            border: 1px solid rgba(255,255,255,0.1) !important;
            border-radius: 6px;
            padding: 9px 14px;
            font-family: 'Barlow', sans-serif;
            font-size: 0.85rem;
            color: #f0f0f0 !important;
            -webkit-text-fill-color: #f0f0f0 !important;
            outline: none;
            width: 280px;
            transition: border-color 0.2s;
        }
        .search-input:focus { border-color: #e8c84a !important; }
        .search-input::placeholder { color: rgba(255,255,255,0.2) !important; }
        .filter-select {
            background: #1a2235 !important;
            border: 1px solid rgba(255,255,255,0.1) !important;
            border-radius: 6px;
            padding: 9px 14px;
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.5) !important;
            -webkit-text-fill-color: rgba(255,255,255,0.5) !important;
            outline: none;
            cursor: pointer;
        }
        .filter-select:focus { border-color: #e8c84a !important; }
        .filter-select option { background: #0f1623; color: #f0f0f0; }
        .result-count { font-family: 'Barlow Condensed', sans-serif; font-size: 0.72rem; font-weight: 600; letter-spacing: 2px; color: rgba(255,255,255,0.25); text-transform: uppercase; margin-left: auto; }

        /* TABLE */
        .bookings-table { width: 100%; border-collapse: collapse; }
        .bookings-table thead th { font-family: 'Barlow Condensed', sans-serif; font-size: 0.62rem; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: rgba(255,255,255,0.25); padding: 10px 14px; border-bottom: 1px solid rgba(255,255,255,0.07); text-align: left; white-space: nowrap; }
        .bookings-table tbody tr { border-bottom: 1px solid rgba(255,255,255,0.04); transition: background 0.15s; }
        .bookings-table tbody tr:hover { background: rgba(255,255,255,0.03); }
        .bookings-table tbody td { padding: 13px 14px; font-size: 0.83rem; vertical-align: middle; }
        .booking-code-cell { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 900; color: #e8c84a; letter-spacing: 2px; }
        .match-cell-name { font-family: 'Barlow Condensed', sans-serif; font-size: 0.88rem; font-weight: 800; color: #fff; text-transform: uppercase; letter-spacing: 1px; }
        .match-cell-cat { font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: rgba(232,200,74,0.7); margin-top: 2px; }
        .user-cell { font-family: 'Barlow', sans-serif; font-size: 0.82rem; color: rgba(255,255,255,0.6); }
        .qty-cell { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 700; color: #fff; text-align: center; }
        .price-cell { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 800; color: #e8c84a; }
        .date-cell { font-size: 0.75rem; color: rgba(255,255,255,0.35); white-space: nowrap; }
        .badge-confirmed { background: rgba(39,174,96,0.12); color: #2ecc71; border: 1px solid rgba(39,174,96,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 3px 9px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; white-space: nowrap; }
        .badge-cancelled { background: rgba(220,53,69,0.12); color: #e55a68; border: 1px solid rgba(220,53,69,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 3px 9px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; white-space: nowrap; }
        .num-cell { color: rgba(255,255,255,0.2); font-size: 0.75rem; }
        .empty-state { text-align: center; padding: 60px 0; }
        .empty-icon { font-size: 3rem; display: block; margin-bottom: 14px; }
        .empty-title { font-family: 'Barlow Condensed', sans-serif; font-size: 1.2rem; font-weight: 800; color: rgba(255,255,255,0.25); text-transform: uppercase; letter-spacing: 2px; }
        .alert-danger-t { background: rgba(220,53,69,0.1); border: 1px solid rgba(220,53,69,0.25); color: #e55a68; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }
        .booking-row.hidden { display: none; }
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
                <a href="${pageContext.request.contextPath}/admin/matches" class="nav-link-admin">Matches</a>
                <a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link-admin active">Bookings</a>
                <a href="#" class="btn-nav-logout"
                   onclick="if(confirm('Are you sure you want to log out?')){window.location.href='${pageContext.request.contextPath}/logout';}return false;">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <div class="page-label">Admin Panel</div>
        <div class="page-title">ALL <span>BOOKINGS</span></div>
    </div>
</div>

<div class="container py-4">
    <c:if test="${not empty errorMessage}">
        <div class="alert-danger-t">✕ ${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${empty bookings}">
            <div class="empty-state">
                <span class="empty-icon">🎟️</span>
                <div class="empty-title">No bookings found</div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- STATS BAR -->
            <div class="stats-bar">
                <div class="stat-chip">
                    <div class="stat-chip-label">Total</div>
                    <div class="stat-chip-val">${bookings.size()}</div>
                </div>
                <div class="stat-chip">
                    <div class="stat-chip-label">Confirmed</div>
                    <div class="stat-chip-val green" id="countConfirmed">—</div>
                </div>
                <div class="stat-chip">
                    <div class="stat-chip-label">Cancelled</div>
                    <div class="stat-chip-val red" id="countCancelled">—</div>
                </div>
                <div class="stat-chip">
                    <div class="stat-chip-label">Showing</div>
                    <div class="stat-chip-val" id="countShowing">${bookings.size()}</div>
                </div>
            </div>

            <!-- SEARCH + FILTER -->
            <div class="search-bar">
                <input type="text" class="search-input" id="searchInput"
                       placeholder="Search code, match, user..."
                       oninput="filterTable()">
                <select class="filter-select" id="statusFilter" onchange="filterTable()">
                    <option value="">All Status</option>
                    <option value="CONFIRMED">Confirmed</option>
                    <option value="CANCELLED">Cancelled</option>
                </select>
                <span class="result-count" id="resultCount"></span>
            </div>

            <!-- TABLE -->
            <table class="bookings-table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Booking Code</th>
                    <th>Match</th>
                    <th>Customer</th>
                    <th>Qty</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Booked At</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="b" items="${bookings}" varStatus="loop">
                    <tr class="booking-row"
                        data-code="${b.bookingCode}"
                        data-status="${b.status}"
                        data-match="${b.homeTeam} ${b.awayTeam}"
                        data-user="user ${b.userId}">
                        <td class="num-cell">${loop.count}</td>
                        <td><div class="booking-code-cell">${b.bookingCode}</div></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty b.homeTeam}">
                                    <div class="match-cell-name">${b.homeTeam} vs ${b.awayTeam}</div>
                                    <div class="match-cell-cat">${b.categoryName}</div>
                                </c:when>
                                <c:otherwise>
                                    <div style="color:rgba(255,255,255,0.25);font-size:0.75rem;">—</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><div class="user-cell">User #${b.userId}</div></td>
                        <td class="qty-cell">${b.quantity}</td>
                        <td class="price-cell">$${b.totalPrice}</td>
                        <td>
                            <c:choose>
                                <c:when test="${b.status == 'CONFIRMED'}">
                                    <span class="badge-confirmed">● Confirmed</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-cancelled">● Cancelled</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="date-cell">${b.createdAt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<script>
    var rows = document.querySelectorAll('.booking-row');
    var confirmed = 0, cancelled = 0;
    rows.forEach(function(r) {
        if (r.dataset.status === 'CONFIRMED') confirmed++;
        else cancelled++;
    });
    var elC = document.getElementById('countConfirmed');
    var elX = document.getElementById('countCancelled');
    if (elC) elC.textContent = confirmed;
    if (elX) elX.textContent = cancelled;

    function filterTable() {
        var q      = document.getElementById('searchInput').value.toLowerCase();
        var status = document.getElementById('statusFilter').value;
        var shown  = 0;
        rows.forEach(function(r) {
            var code  = (r.dataset.code  || '').toLowerCase();
            var match = (r.dataset.match || '').toLowerCase();
            var user  = (r.dataset.user  || '').toLowerCase();
            var st    = r.dataset.status || '';
            var textOk   = (code.includes(q) || match.includes(q) || user.includes(q));
            var statusOk = (status === '' || st === status);
            if (textOk && statusOk) { r.classList.remove('hidden'); shown++; }
            else { r.classList.add('hidden'); }
        });
        var elShow = document.getElementById('countShowing');
        if (elShow) elShow.textContent = shown;
        var elRes = document.getElementById('resultCount');
        if (elRes) elRes.textContent = shown + ' result' + (shown !== 1 ? 's' : '');
    }
    filterTable();
</script>
</body>
</html>