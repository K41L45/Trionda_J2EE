<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Bookings — Trionda</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&family=Source+Code+Pro:wght@400;600&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: #080c14; color: #f0f0f0; font-family: 'Barlow', sans-serif; min-height: 100vh; }
    .color-bar { height: 3px; background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%); }

    /* NAVBAR */
    .navbar-trionda { background: rgba(8,12,20,0.95); border-bottom: 1px solid rgba(255,255,255,0.07); padding: 10px 0; position: sticky; top: 0; z-index: 1000; }
    .navbar-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
    .logo-ball { height: 36px; width: auto; filter: invert(1) sepia(1) saturate(5) hue-rotate(5deg); }
    .logo-wc { height: 44px; width: auto; mix-blend-mode: screen; }
    .navbar-brand-text { font-family: 'Barlow Condensed', sans-serif; font-size: 1.8rem; font-weight: 800; color: #e8c84a; letter-spacing: 3px; line-height: 1; text-transform: uppercase; }
    .navbar-right { display: flex; align-items: center; gap: 16px; }
    .nav-user-info { display: flex; flex-direction: column; align-items: flex-end; gap: 1px; }
    .nav-user-label { font-size: 0.65rem; color: rgba(255,255,255,0.35); letter-spacing: 1px; text-transform: uppercase; font-family: 'Barlow Condensed', sans-serif; }
    .nav-user-name { font-size: 0.88rem; font-weight: 700; color: #e8c84a; font-family: 'Barlow Condensed', sans-serif; letter-spacing: 1px; text-transform: uppercase; }
    .nav-divider { width: 1px; height: 26px; background: rgba(255,255,255,0.1); }
    .btn-nav { padding: 6px 16px; border-radius: 3px; font-size: 0.76rem; font-weight: 700; text-decoration: none; transition: all 0.2s; letter-spacing: 1px; text-transform: uppercase; font-family: 'Barlow Condensed', sans-serif; cursor: pointer; }
    .btn-nav-booking { background: #e8c84a; color: #080c14; border: none; }
    .btn-nav-booking:hover { background: #f5d75e; color: #080c14; }
    .btn-nav-logout { border: 1.5px solid rgba(255,255,255,0.15); color: rgba(255,255,255,0.5); background: transparent; }
    .btn-nav-logout:hover { border-color: #fff; color: #fff; }

    /* PAGE HEADER */
    .page-header { background: linear-gradient(135deg, #0f1e35 0%, #080c14 100%); border-bottom: 1px solid rgba(255,255,255,0.06); padding: 36px 0 28px; }
    .page-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 600; letter-spacing: 4px; color: rgba(255,255,255,0.28); text-transform: uppercase; margin-bottom: 4px; }
    .page-title { font-family: 'Barlow Condensed', sans-serif; font-size: 2.4rem; font-weight: 900; color: #fff; text-transform: uppercase; letter-spacing: 1px; }
    .page-title span { color: #e8c84a; }

    /* ALERTS */
    .alert-success-t { background: rgba(39,174,96,0.1); border: 1px solid rgba(39,174,96,0.25); color: #2ecc71; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }
    .alert-danger-t  { background: rgba(220,53,69,0.1);  border: 1px solid rgba(220,53,69,0.25);  color: #e55a68; border-radius: 8px; padding: 12px 18px; font-size: 0.85rem; margin-bottom: 20px; }

    /* ===== TICKET CARD ===== */
    .ticket-wrap { margin-bottom: 20px; cursor: pointer; }

    .ticket {
      background: #0f1623;
      border: 1px solid rgba(255,255,255,0.08);
      border-radius: 12px;
      overflow: hidden;
      transition: box-shadow 0.3s, border-color 0.3s;
      position: relative;
    }
    .ticket:hover { box-shadow: 0 12px 40px rgba(0,0,0,0.5); border-color: rgba(232,200,74,0.2); }
    .ticket.cancelled { border-color: rgba(220,53,69,0.15); opacity: 0.75; }

    /* Top color accent per status */
    .ticket-accent { height: 3px; }
    .ticket-accent.confirmed { background: linear-gradient(90deg, #e8c84a, #f5d75e); }
    .ticket-accent.cancelled { background: linear-gradient(90deg, #e55a68, #ff7b8a); }

    /* TICKET SUMMARY ROW — selalu terlihat */
    .ticket-summary {
      display: grid;
      grid-template-columns: 1fr auto auto auto;
      align-items: center;
      gap: 16px;
      padding: 18px 22px;
    }
    .ticket-code { font-family: 'Barlow Condensed', sans-serif; font-size: 1.2rem; font-weight: 900; color: #e8c84a; letter-spacing: 3px; }
    .ticket-teams-mini { font-family: 'Barlow Condensed', sans-serif; font-size: 0.78rem; font-weight: 700; color: rgba(255,255,255,0.5); letter-spacing: 1px; text-transform: uppercase; margin-top: 3px; }
    .ticket-qty-price { text-align: right; }
    .ticket-qty { font-family: 'Barlow Condensed', sans-serif; font-size: 0.72rem; color: rgba(255,255,255,0.4); letter-spacing: 1px; text-transform: uppercase; }
    .ticket-price { font-family: 'Barlow Condensed', sans-serif; font-size: 1.3rem; font-weight: 800; color: #e8c84a; }
    .badge-confirmed { background: rgba(39,174,96,0.12); color: #2ecc71; border: 1px solid rgba(39,174,96,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 3px 9px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; white-space: nowrap; }
    .badge-cancelled { background: rgba(220,53,69,0.12); color: #e55a68; border: 1px solid rgba(220,53,69,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 3px 9px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; white-space: nowrap; }
    .chevron { color: rgba(255,255,255,0.25); font-size: 0.9rem; transition: transform 0.3s; flex-shrink: 0; }
    .ticket-wrap.open .chevron { transform: rotate(180deg); }

    /* TICKET DETAIL — expandable */
    .ticket-detail {
      display: none;
      border-top: 1px solid rgba(255,255,255,0.06);
    }
    .ticket-wrap.open .ticket-detail { display: block; }

    /* TICKET BODY — layout visual tiket */
    .ticket-body {
      display: grid;
      grid-template-columns: 1fr auto;
      gap: 0;
    }

    /* LEFT: match info + flags */
    .ticket-left {
      padding: 22px 24px;
      position: relative;
    }
    .ticket-stadium-bg {
      position: absolute;
      inset: 0;
      background-size: cover;
      background-position: center;
      opacity: 0.08;
      border-radius: 0;
    }
    .ticket-left-content { position: relative; z-index: 1; }

    .ticket-group-badge {
      display: inline-block;
      background: #e8c84a;
      color: #080c14;
      font-family: 'Barlow Condensed', sans-serif;
      font-size: 0.6rem;
      font-weight: 800;
      padding: 2px 8px;
      border-radius: 2px;
      letter-spacing: 2px;
      text-transform: uppercase;
      margin-bottom: 14px;
    }

    /* Flags + teams */
    .teams-display { display: flex; align-items: center; gap: 0; margin-bottom: 18px; }
    .team-display { display: flex; flex-direction: column; align-items: center; gap: 8px; flex: 1; }
    .flag-display { width: 60px; height: 40px; object-fit: cover; border-radius: 3px; box-shadow: 0 3px 10px rgba(0,0,0,0.6); display: none; }
    .flag-ph { width: 60px; height: 40px; background: rgba(255,255,255,0.06); border-radius: 3px; border: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 800; color: rgba(255,255,255,0.3); }
    .team-name-display { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 800; color: #fff; text-transform: uppercase; letter-spacing: 1px; text-align: center; line-height: 1.2; }
    .vs-display { font-family: 'Barlow Condensed', sans-serif; font-size: 0.8rem; font-weight: 700; color: rgba(255,255,255,0.2); padding: 0 16px; flex-shrink: 0; padding-bottom: 32px; }

    /* Match meta */
    .ticket-meta { display: flex; flex-direction: column; gap: 5px; }
    .ticket-meta-item { display: flex; align-items: center; gap: 7px; font-size: 0.75rem; color: rgba(255,255,255,0.4); }
    .ticket-meta-icon { color: #e8c84a; font-size: 0.7rem; width: 12px; text-align: center; flex-shrink: 0; }

    /* Category badge */
    .cat-badge-ticket { display: inline-block; margin-top: 12px; background: rgba(232,200,74,0.1); border: 1px solid rgba(232,200,74,0.25); color: #e8c84a; font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 700; padding: 3px 10px; border-radius: 3px; letter-spacing: 2px; text-transform: uppercase; }

    /* RIGHT: barcode + cancel */
    .ticket-right {
      width: 120px;
      flex-shrink: 0;
      border-left: 2px dashed rgba(255,255,255,0.07);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-between;
      padding: 20px 14px;
      background: rgba(255,255,255,0.02);
      position: relative;
    }
    /* Notch circles di perforated border */
    .ticket-right::before,
    .ticket-right::after {
      content: '';
      position: absolute;
      left: -10px;
      width: 18px; height: 18px;
      background: #080c14;
      border-radius: 50%;
    }
    .ticket-right::before { top: -9px; }
    .ticket-right::after  { bottom: -9px; }

    /* Barcode SVG */
    .barcode-wrap { display: flex; flex-direction: column; align-items: center; gap: 6px; }
    .barcode-svg { width: 72px; height: 52px; }
    .barcode-label { font-family: 'Source Code Pro', monospace; font-size: 0.48rem; color: rgba(255,255,255,0.3); letter-spacing: 1px; text-align: center; word-break: break-all; }

    /* Vertical text */
    .ticket-vertical-text {
      font-family: 'Barlow Condensed', sans-serif;
      font-size: 0.6rem;
      font-weight: 700;
      letter-spacing: 3px;
      color: rgba(255,255,255,0.15);
      text-transform: uppercase;
      writing-mode: vertical-rl;
      text-orientation: mixed;
    }

    /* Cancel button */
    .btn-cancel-ticket {
      background: transparent;
      border: 1px solid rgba(220,53,69,0.35);
      color: #e55a68;
      font-family: 'Barlow Condensed', sans-serif;
      font-size: 0.62rem;
      font-weight: 700;
      letter-spacing: 1px;
      text-transform: uppercase;
      padding: 5px 10px;
      border-radius: 3px;
      cursor: pointer;
      transition: all 0.2s;
      width: 100%;
    }
    .btn-cancel-ticket:hover { background: rgba(220,53,69,0.12); border-color: #e55a68; }

    /* EMPTY STATE */
    .empty-state { text-align: center; padding: 80px 0; }
    .empty-icon { font-size: 3.5rem; display: block; margin-bottom: 16px; }
    .empty-title { font-family: 'Barlow Condensed', sans-serif; font-size: 1.4rem; font-weight: 800; color: rgba(255,255,255,0.3); text-transform: uppercase; letter-spacing: 2px; margin-bottom: 20px; }
    .btn-browse { display: inline-block; background: #e8c84a; color: #080c14; padding: 11px 28px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 0.9rem; text-decoration: none; letter-spacing: 1px; text-transform: uppercase; transition: background 0.2s; }
    .btn-browse:hover { background: #f5d75e; color: #080c14; }

    .btn-back { display: inline-flex; align-items: center; gap: 6px; padding: 8px 18px; border-radius: 3px; font-size: 0.76rem; font-weight: 700; text-decoration: none; transition: all 0.2s; letter-spacing: 1px; text-transform: uppercase; font-family: 'Barlow Condensed', sans-serif; border: 1.5px solid rgba(255,255,255,0.15); color: rgba(255,255,255,0.5); }
    .btn-back:hover { border-color: #fff; color: #fff; }

    @media (max-width: 600px) {
      .ticket-summary { grid-template-columns: 1fr auto; }
      .ticket-right { width: 90px; }
      .flag-display, .flag-ph { width: 44px; height: 30px; }
      .team-name-display { font-size: 0.8rem; }
    }
  </style>
</head>
<body>
<div class="color-bar"></div>

<!-- NAVBAR -->
<nav class="navbar-trionda">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center">
      <a href="${pageContext.request.contextPath}/customer/matches" class="navbar-logo">
        <img src="${pageContext.request.contextPath}/images/trionda-logo.png" alt="Trionda" class="logo-ball" onerror="this.style.display='none'">
        <span class="navbar-brand-text">TRIONDA</span>
        <img src="${pageContext.request.contextPath}/images/wc2026-logo.avif" alt="WC2026" class="logo-wc" onerror="this.style.display='none'">
      </a>
      <div class="navbar-right">
        <div class="nav-user-info">
          <span class="nav-user-label">Signed in as</span>
          <span class="nav-user-name">${sessionScope.username}</span>
        </div>
        <div class="nav-divider"></div>
        <a href="${pageContext.request.contextPath}/customer/bookings/history" class="btn-nav btn-nav-booking">My Bookings</a>
        <a href="#" class="btn-nav btn-nav-logout"
           onclick="if(confirm('Are you sure you want to log out?')){window.location.href='${pageContext.request.contextPath}/logout';}return false;">Logout</a>
      </div>
    </div>
  </div>
</nav>

<!-- PAGE HEADER -->
<div class="page-header">
  <div class="container">
    <div class="page-label">Account</div>
    <div class="page-title">MY <span>BOOKINGS</span></div>
  </div>
</div>

<div class="container py-4">

  <c:if test="${param.cancelled == 'true'}">
    <div class="alert-success-t">✓ Booking successfully cancelled.</div>
  </c:if>
  <c:if test="${not empty param.error}">
    <div class="alert-danger-t">✕ ${param.error}</div>
  </c:if>

  <c:choose>
    <c:when test="${empty bookings}">
      <div class="empty-state">
        <span class="empty-icon">🎟️</span>
        <div class="empty-title">No bookings yet</div>
        <a href="${pageContext.request.contextPath}/customer/matches" class="btn-browse">Browse Matches →</a>
      </div>
    </c:when>
    <c:otherwise>
      <c:forEach var="b" items="${bookings}" varStatus="loop">
        <div class="ticket-wrap" id="wrap-${loop.index}" onclick="toggleTicket(${loop.index})">
          <div class="ticket ${b.status == 'CANCELLED' ? 'cancelled' : ''}">
            <div class="ticket-accent ${b.status == 'CONFIRMED' ? 'confirmed' : 'cancelled'}"></div>

            <!-- SUMMARY ROW -->
            <div class="ticket-summary">
              <div>
                <div class="ticket-code">${b.bookingCode}</div>
                <div class="ticket-teams-mini">
                  <c:choose>
                    <c:when test="${not empty b.homeTeam}">${b.homeTeam} vs ${b.awayTeam}</c:when>
                    <c:otherwise>—</c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="ticket-qty-price">
                <div class="ticket-qty">${b.quantity} ticket(s)</div>
                <div class="ticket-price">$${b.totalPrice}</div>
              </div>
              <c:choose>
                <c:when test="${b.status == 'CONFIRMED'}">
                  <span class="badge-confirmed">● Confirmed</span>
                </c:when>
                <c:otherwise>
                  <span class="badge-cancelled">● Cancelled</span>
                </c:otherwise>
              </c:choose>
              <span class="chevron">▼</span>
            </div>

            <!-- DETAIL (expandable) -->
            <div class="ticket-detail" id="detail-${loop.index}">
              <div class="ticket-body">

                <!-- LEFT: visual tiket -->
                <div class="ticket-left">
                  <div class="ticket-stadium-bg" id="stadiumBg-${loop.index}"></div>
                  <div class="ticket-left-content">
                    <c:if test="${not empty b.groupName}">
                      <div class="ticket-group-badge">Group ${b.groupName} · FIFA World Cup 2026™</div>
                    </c:if>

                    <!-- Teams + Flags -->
                    <div class="teams-display">
                      <div class="team-display">
                        <img id="fh-${loop.index}" class="flag-display" src="" alt="${b.homeTeam}">
                        <div id="ph-h-${loop.index}" class="flag-ph">${not empty b.homeTeam ? b.homeTeam.substring(0,1) : '?'}</div>
                        <div class="team-name-display">${b.homeTeam}</div>
                      </div>
                      <div class="vs-display">VS</div>
                      <div class="team-display">
                        <img id="fa-${loop.index}" class="flag-display" src="" alt="${b.awayTeam}">
                        <div id="ph-a-${loop.index}" class="flag-ph">${not empty b.awayTeam ? b.awayTeam.substring(0,1) : '?'}</div>
                        <div class="team-name-display">${b.awayTeam}</div>
                      </div>
                    </div>

                    <!-- Match meta -->
                    <div class="ticket-meta">
                      <c:if test="${not empty b.matchDate}">
                        <div class="ticket-meta-item">
                          <span class="ticket-meta-icon">📅</span>
                          <span class="date-fmt" data-raw="${b.matchDate}">${b.matchDate}</span>
                        </div>
                      </c:if>
                      <c:if test="${not empty b.venue}">
                        <div class="ticket-meta-item">
                          <span class="ticket-meta-icon">🏟️</span>
                          <span>${b.venue}</span>
                        </div>
                      </c:if>
                      <c:if test="${not empty b.hostCity}">
                        <div class="ticket-meta-item">
                          <span class="ticket-meta-icon">📍</span>
                          <span>${b.hostCity}</span>
                        </div>
                      </c:if>
                    </div>

                    <c:if test="${not empty b.categoryName}">
                      <span class="cat-badge-ticket">${b.categoryName} · ${b.quantity} ticket(s)</span>
                    </c:if>
                  </div>
                </div>

                <!-- RIGHT: barcode + cancel -->
                <div class="ticket-right" onclick="event.stopPropagation()">
                  <div class="ticket-vertical-text">FIFA WC 2026</div>

                  <!-- Barcode SVG — generated dari booking code -->
                  <div class="barcode-wrap">
                    <svg class="barcode-svg" id="barcode-${loop.index}" viewBox="0 0 72 52" xmlns="http://www.w3.org/2000/svg">
                      <!-- Bars di-generate via JS -->
                    </svg>
                    <div class="barcode-label">${b.bookingCode}</div>
                  </div>

                  <c:if test="${b.status == 'CONFIRMED'}">
                    <form method="post"
                          action="${pageContext.request.contextPath}/customer/bookings/cancel"
                          onsubmit="return confirm('Cancel booking ${b.bookingCode}?')">
                      <input type="hidden" name="bookingId" value="${b.bookingId}">
                      <button type="submit" class="btn-cancel-ticket">Cancel</button>
                    </form>
                  </c:if>
                </div>

              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>

  <a href="${pageContext.request.contextPath}/customer/matches" class="btn-back mt-3">← Back to Matches</a>
</div>

<script>
  var ctx = '<%= request.getContextPath() %>';

  const flagMap = {"Mexico":"mx","South Africa":"za","Canada":"ca","Bosnia-Herzegovina":"ba","USA":"us","Paraguay":"py","Brazil":"br","Morocco":"ma","Germany":"de","Curacao":"cw","Netherlands":"nl","Japan":"jp","Spain":"es","Cabo Verde":"cv","Belgium":"be","Egypt":"eg","France":"fr","Senegal":"sn","Argentina":"ar","Algeria":"dz","Portugal":"pt","DR Congo":"cd","England":"gb-eng","Croatia":"hr","Haiti":"ht","Uruguay":"uy","Colombia":"co","Ecuador":"ec","Chile":"cl","Switzerland":"ch","Serbia":"rs","Cameroon":"cm","Ghana":"gh","Tunisia":"tn","Australia":"au","South Korea":"kr","Iran":"ir","Saudi Arabia":"sa","Qatar":"qa","Costa Rica":"cr","Honduras":"hn","Jamaica":"jm","Panama":"pa","Bolivia":"bo","Venezuela":"ve","Peru":"pe","United States":"us","Türkiye":"tr","Turkey":"tr","Wales":"gb-wls","Scotland":"gb-sct","Ukraine":"ua","Denmark":"dk","Austria":"at","Poland":"pl","Greece":"gr","Albania":"al","Ivory Coast":"ci","Nigeria":"ng","Mali":"ml","Angola":"ao","Zambia":"zm","Georgia":"ge","New Zealand":"nz","Romania":"ro","Hungary":"hu","Slovakia":"sk","Czech Republic":"cz","Slovenia":"si"};

  const stadiums = [ctx+"/images/stadium1.avif",ctx+"/images/stadium2.avif",ctx+"/images/stadium3.avif",ctx+"/images/stadium4.avif",ctx+"/images/stadium5.avif",ctx+"/images/stadium6.avif",ctx+"/images/stadium7.avif",ctx+"/images/stadium8.avif",ctx+"/images/stadium9.avif"];

  // Format date
  function formatDate(raw) {
    if (!raw || !raw.includes('T')) return raw;
    var parts = raw.split('T'), d = parts[0].split('-');
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    var dateObj = new Date(parseInt(d[0]), parseInt(d[1])-1, parseInt(d[2]));
    return days[dateObj.getDay()] + ', ' + parseInt(d[2]) + ' ' + months[parseInt(d[1])-1] + ' ' + d[0] + ' · ' + parts[1].substring(0,5);
  }
  document.querySelectorAll('.date-fmt').forEach(function(el) {
    el.textContent = formatDate(el.dataset.raw);
  });

  // Load flag helper
  function loadFlag(imgId, phId, name) {
    if (!name) return;
    var img = document.getElementById(imgId), ph = document.getElementById(phId);
    if (!img) return;
    var code = flagMap[name];
    if (code) {
      img.src = 'https://flagcdn.com/w80/' + code + '.png';
      img.onload  = function() { img.style.display='block'; if(ph) ph.style.display='none'; };
      img.onerror = function() { img.style.display='none';  if(ph) ph.style.display='flex'; };
    }
  }

  // Generate simple barcode SVG dari string
  function generateBarcode(svgId, code) {
    var svg = document.getElementById(svgId);
    if (!svg) return;
    var str = code.replace(/[^A-Z0-9]/g, '');
    var bars = [];
    for (var i = 0; i < str.length; i++) {
      var v = str.charCodeAt(i);
      bars.push((v & 1) ? 3 : 2);
      bars.push((v & 2) ? 3 : 1);
      bars.push((v & 4) ? 2 : 1);
    }
    // Tambah beberapa bar dekoratif
    bars.push(3,1,3,1,2,3,1,2,3,1);
    var totalW = bars.reduce(function(a,b){return a+b;}, 0);
    var scale  = 72 / totalW;
    var html   = '';
    var x      = 0;
    for (var j = 0; j < bars.length; j++) {
      var w = bars[j] * scale;
      if (j % 2 === 0) {
        var h = (j % 6 === 0) ? 52 : (j % 4 === 0) ? 44 : 38;
        html += '<rect x="' + x.toFixed(2) + '" y="' + (52-h) + '" width="' + w.toFixed(2) + '" height="' + h + '" fill="rgba(232,200,74,0.85)"/>';
      }
      x += w;
    }
    svg.innerHTML = html;
  }

  // Toggle expand tiket
  var loadedFlags = {};
  function toggleTicket(idx) {
    var wrap = document.getElementById('wrap-' + idx);
    var isOpen = wrap.classList.contains('open');
    // Tutup semua dulu
    document.querySelectorAll('.ticket-wrap').forEach(function(w) { w.classList.remove('open'); });
    if (!isOpen) {
      wrap.classList.add('open');
      // Lazy load flags + stadium bg + barcode hanya saat expand
      if (!loadedFlags[idx]) {
        loadedFlags[idx] = true;
        var fhEl = document.getElementById('fh-' + idx);
        var faEl = document.getElementById('fa-' + idx);
        if (fhEl) loadFlag('fh-'+idx, 'ph-h-'+idx, fhEl.alt);
        if (faEl) loadFlag('fa-'+idx, 'ph-a-'+idx, faEl.alt);
        // Stadium background
        var stadBg = document.getElementById('stadiumBg-' + idx);
        if (stadBg) stadBg.style.backgroundImage = "url('" + stadiums[idx % stadiums.length] + "')";
        // Barcode
        var codeEl = wrap.querySelector('.ticket-code');
        if (codeEl) generateBarcode('barcode-' + idx, codeEl.textContent.trim());
      }
    }
  }
</script>
</body>
</html>