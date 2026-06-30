<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${match.homeTeam} vs ${match.awayTeam} — Trionda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #080c14; color: #f0f0f0; font-family: 'Barlow', sans-serif; min-height: 100vh; }
        .color-bar { height: 3px; background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%); }
        .navbar-trionda { background: rgba(8,12,20,0.97); border-bottom: 1px solid rgba(255,255,255,0.07); padding: 10px 0; position: sticky; top: 0; z-index: 1000; }
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

        /* MATCH HERO */
        .match-hero { position: relative; background: #0a0f1a; overflow: hidden; padding-bottom: 36px; }
        .hero-stadium-bg { position: absolute; inset: 0; background-size: cover; background-position: center; opacity: 0.15; z-index: 0; }
        .hero-overlay { position: absolute; inset: 0; background: linear-gradient(to bottom, rgba(8,12,20,0.4) 0%, rgba(8,12,20,0.75) 100%); z-index: 1; }
        .hero-back { position: relative; z-index: 2; padding: 14px 0 0; }
        .btn-back-hero { display: inline-flex; align-items: center; gap: 6px; font-family: 'Barlow Condensed', sans-serif; font-size: 0.72rem; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: rgba(255,255,255,0.45); text-decoration: none; transition: color 0.2s; }
        .btn-back-hero:hover { color: #fff; }
        .hero-body { position: relative; z-index: 2; padding: 28px 0 0; text-align: center; }
        .hero-group-badge { display: inline-block; background: #e8c84a; color: #080c14; font-family: 'Barlow Condensed', sans-serif; font-size: 0.7rem; font-weight: 800; padding: 3px 12px; border-radius: 2px; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 24px; }
        .hero-teams-row { display: flex; align-items: center; justify-content: center; margin-bottom: 24px; }
        .hero-team { display: flex; flex-direction: column; align-items: center; gap: 12px; flex: 1; max-width: 280px; }
        .hero-flag { width: 100px; height: 67px; object-fit: cover; border-radius: 4px; box-shadow: 0 6px 24px rgba(0,0,0,0.7); display: none; }
        .hero-flag-ph { width: 100px; height: 67px; background: rgba(255,255,255,0.06); border-radius: 4px; border: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-family: 'Barlow Condensed', sans-serif; font-size: 1.6rem; font-weight: 800; color: rgba(255,255,255,0.3); }
        .hero-team-name { font-family: 'Barlow Condensed', sans-serif; font-size: 2rem; font-weight: 900; color: #fff; text-transform: uppercase; letter-spacing: 2px; line-height: 1; }
        .hero-vs { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 700; color: rgba(255,255,255,0.2); letter-spacing: 3px; padding: 0 32px; padding-bottom: 44px; flex-shrink: 0; }
        .hero-meta-row { display: flex; align-items: center; justify-content: center; gap: 24px; flex-wrap: wrap; }
        .hero-meta-item { display: flex; align-items: center; gap: 7px; font-size: 0.8rem; color: rgba(255,255,255,0.45); font-family: 'Barlow', sans-serif; }
        .hero-meta-icon { color: #e8c84a; }
        .hero-meta-sep { color: rgba(255,255,255,0.12); }

        /* TICKET TAB BAR */
        .ticket-tab-bar { background: #080c14; border-bottom: 1px solid rgba(255,255,255,0.08); position: sticky; top: 65px; z-index: 100; }
        .ticket-tab-bar-inner { display: flex; overflow-x: auto; scrollbar-width: none; }
        .ticket-tab-bar-inner::-webkit-scrollbar { display: none; }
        .ticket-tab { display: flex; align-items: center; gap: 7px; padding: 14px 22px; font-family: 'Barlow Condensed', sans-serif; font-size: 0.8rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: rgba(255,255,255,0.4); border-bottom: 2px solid transparent; white-space: nowrap; transition: color 0.2s, border-color 0.2s; cursor: pointer; text-decoration: none; }
        .ticket-tab:hover { color: rgba(255,255,255,0.75); }
        .ticket-tab.active { color: #e8c84a; border-bottom-color: #e8c84a; }
        .ticket-tab-dot { width: 7px; height: 7px; border-radius: 50%; flex-shrink: 0; }

        /* TICKET PANELS */
        .ticket-section { padding: 36px 0 60px; }
        .ticket-panel { display: none; }
        .ticket-panel.active { display: block; }
        .ticket-layout { display: grid; grid-template-columns: 1fr 1fr; gap: 40px; align-items: start; }

        /* LEFT */
        .ticket-cat-name { font-family: 'Barlow Condensed', sans-serif; font-size: 3rem; font-weight: 900; color: #fff; text-transform: uppercase; line-height: 1; margin-bottom: 20px; }
        .avail-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: rgba(255,255,255,0.3); margin-bottom: 8px; }
        .quota-bar-wrap { background: rgba(255,255,255,0.07); border-radius: 3px; height: 5px; margin-bottom: 8px; overflow: hidden; }
        .quota-bar-fill { height: 100%; background: #e8c84a; border-radius: 3px; }
        .quota-bar-fill.low { background: #e55a68; }
        .quota-ok { font-size: 0.82rem; color: #2ecc71; font-weight: 600; }
        .quota-sold { font-size: 0.82rem; color: #e55a68; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; }

        /* RIGHT — price box */
        .price-box { background: #0f1623; border: 1px solid rgba(255,255,255,0.08); border-radius: 10px; padding: 28px; }
        .price-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: rgba(255,255,255,0.3); margin-bottom: 4px; }
        .price-amount { font-family: 'Barlow Condensed', sans-serif; font-size: 2.8rem; font-weight: 900; color: #e8c84a; line-height: 1; margin-bottom: 2px; }
        .price-per { font-size: 0.75rem; color: rgba(255,255,255,0.3); margin-bottom: 20px; }

        /* ✅ QTY STEPPER — + - dengan limit remainingQuota */
        .qty-stepper-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 700; letter-spacing: 3px; text-transform: uppercase; color: rgba(255,255,255,0.3); margin-bottom: 10px; }
        .qty-stepper { display: flex; align-items: center; gap: 0; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.12); border-radius: 6px; overflow: hidden; margin-bottom: 20px; width: fit-content; }
        .qty-btn { background: transparent; border: none; color: #e8c84a; font-size: 1.4rem; font-weight: 700; width: 44px; height: 44px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: background 0.15s; line-height: 1; font-family: 'Barlow Condensed', sans-serif; }
        .qty-btn:hover:not(:disabled) { background: rgba(232,200,74,0.1); }
        .qty-btn:disabled { color: rgba(255,255,255,0.15); cursor: not-allowed; }
        .qty-num { font-family: 'Barlow Condensed', sans-serif; font-size: 1.3rem; font-weight: 800; color: #fff; min-width: 50px; text-align: center; border-left: 1px solid rgba(255,255,255,0.08); border-right: 1px solid rgba(255,255,255,0.08); padding: 0 8px; line-height: 44px; }

        .match-info-mini { background: rgba(255,255,255,0.04); border: 1px solid rgba(255,255,255,0.06); border-radius: 6px; padding: 12px 16px; margin-bottom: 18px; }
        .match-info-vs { font-family: 'Barlow Condensed', sans-serif; font-size: 0.95rem; font-weight: 800; color: #fff; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 3px; }
        .match-info-sub { font-size: 0.74rem; color: rgba(255,255,255,0.35); }

        .btn-book { display: block; width: 100%; background: #e8c84a; color: #080c14; text-align: center; padding: 14px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 1rem; text-decoration: none; letter-spacing: 1px; text-transform: uppercase; transition: background 0.2s; border: none; cursor: pointer; }
        .btn-book:hover { background: #f5d75e; color: #080c14; }
        .btn-sold-out { display: block; width: 100%; background: rgba(255,255,255,0.05); color: rgba(255,255,255,0.2); text-align: center; padding: 14px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 1rem; letter-spacing: 1px; text-transform: uppercase; border: 1px solid rgba(255,255,255,0.07); cursor: not-allowed; }

        @media (max-width: 768px) { .ticket-layout { grid-template-columns: 1fr; gap: 24px; } .hero-team-name { font-size: 1.4rem; } .hero-flag,.hero-flag-ph { width: 72px; height: 48px; } .ticket-cat-name { font-size: 2rem; } }
    </style>
</head>
<body>
<div class="color-bar"></div>
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

<div class="match-hero">
    <div class="hero-stadium-bg" id="heroBannerBg"></div>
    <div class="hero-overlay"></div>
    <div class="container hero-back">
        <a href="${pageContext.request.contextPath}/customer/matches" class="btn-back-hero">← Back to match list</a>
    </div>
    <div class="container hero-body">
        <div class="hero-group-badge">Group ${match.groupName} · Group Stage</div>
        <div class="hero-teams-row">
            <div class="hero-team">
                <img id="flag-home" class="hero-flag" src="" alt="${match.homeTeam}">
                <div id="ph-home" class="hero-flag-ph">${match.homeTeam.substring(0,1)}</div>
                <div class="hero-team-name">${match.homeTeam}</div>
            </div>
            <div class="hero-vs">VS</div>
            <div class="hero-team">
                <img id="flag-away" class="hero-flag" src="" alt="${match.awayTeam}">
                <div id="ph-away" class="hero-flag-ph">${match.awayTeam.substring(0,1)}</div>
                <div class="hero-team-name">${match.awayTeam}</div>
            </div>
        </div>
        <div class="hero-meta-row">
            <div class="hero-meta-item"><span class="hero-meta-icon">📅</span><span id="matchDateText">${match.matchDate}</span></div>
            <span class="hero-meta-sep">·</span>
            <div class="hero-meta-item"><span class="hero-meta-icon">🏟️</span><span>${match.venue}</span></div>
            <span class="hero-meta-sep">·</span>
            <div class="hero-meta-item"><span class="hero-meta-icon">📍</span><span>${match.hostCity}</span></div>
        </div>
    </div>
</div>

<div class="ticket-tab-bar">
    <div class="container">
        <div class="ticket-tab-bar-inner">
            <c:forEach var="cat" items="${categories}" varStatus="loop">
                <a class="ticket-tab ${loop.first ? 'active' : ''}"
                   onclick="switchTab('tab-${loop.index}', this)">
                    <span class="ticket-tab-dot" style="background:${loop.index==0?'#e8c84a':loop.index==1?'#2ecc71':'#e55a68'}"></span>
                        ${cat.categoryName}
                </a>
            </c:forEach>
        </div>
    </div>
</div>

<div class="ticket-section">
    <div class="container">
        <c:forEach var="cat" items="${categories}" varStatus="loop">
            <div class="ticket-panel ${loop.first ? 'active' : ''}" id="tab-${loop.index}">
                <div class="ticket-layout">
                    <div>
                        <div class="ticket-cat-name">${cat.categoryName}</div>
                        <div class="avail-label">Availability</div>
                        <div class="quota-bar-wrap">
                            <div class="quota-bar-fill ${cat.remainingQuota <= cat.totalQuota * 0.2 ? 'low' : ''}"
                                 style="width:${(cat.remainingQuota/cat.totalQuota)*100}%"></div>
                        </div>
                        <c:choose>
                            <c:when test="${cat.remainingQuota == 0}">
                                <span class="quota-sold">● Sold Out</span>
                            </c:when>
                            <c:otherwise>
                                <span class="quota-ok">${cat.remainingQuota} tickets remaining</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <div class="price-box">
                            <div class="price-label">Price per ticket</div>
                            <div class="price-amount">$${cat.price}</div>
                            <div class="price-per">USD / per person</div>

                            <div class="match-info-mini">
                                <div class="match-info-vs">${match.homeTeam} vs ${match.awayTeam}</div>
                                <div class="match-info-sub">🏟️ ${match.venue} · 📍 ${match.hostCity}</div>
                            </div>

                            <c:choose>
                                <c:when test="${cat.remainingQuota == 0}">
                                    <span class="btn-sold-out">Sold Out</span>
                                </c:when>
                                <c:otherwise>
                                    <%-- ✅ QTY STEPPER dengan max = remainingQuota (max 4) --%>
                                    <div class="qty-stepper-label">Select Quantity</div>
                                    <div class="qty-stepper">
                                        <button type="button" class="qty-btn"
                                                id="btn-minus-${cat.categoryId}"
                                                onclick="changeQty('${cat.categoryId}', -1, ${cat.remainingQuota})"
                                                disabled>−</button>
                                        <span class="qty-num" id="qty-${cat.categoryId}">1</span>
                                        <button type="button" class="qty-btn"
                                                id="btn-plus-${cat.categoryId}"
                                                onclick="changeQty('${cat.categoryId}', 1, ${cat.remainingQuota})"
                                            ${cat.remainingQuota <= 1 ? 'disabled' : ''}>+</button>
                                    </div>
                                    <a id="book-btn-${cat.categoryId}"
                                       href="${pageContext.request.contextPath}/customer/bookings/confirm?categoryId=${cat.categoryId}&matchId=${match.matchId}&qty=1"
                                       class="btn-book">Book Now →</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    var ctx = '<%= request.getContextPath() %>';

    // Format date
    function formatDate(raw) {
        if (!raw || !raw.includes('T')) return raw;
        var parts = raw.split('T'), d = parts[0].split('-');
        var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        var days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
        var dateObj = new Date(parseInt(d[0]), parseInt(d[1])-1, parseInt(d[2]));
        return days[dateObj.getDay()] + ', ' + months[parseInt(d[1])-1] + ' ' + parseInt(d[2]) + ', ' + d[0] + ' · ' + parts[1].substring(0,5);
    }
    var dtEl = document.getElementById('matchDateText');
    if (dtEl) dtEl.textContent = formatDate(dtEl.textContent.trim());

    // Tab switcher
    function switchTab(tabId, el) {
        document.querySelectorAll('.ticket-panel').forEach(function(p) { p.classList.remove('active'); });
        document.querySelectorAll('.ticket-tab').forEach(function(t) { t.classList.remove('active'); });
        document.getElementById(tabId).classList.add('active');
        el.classList.add('active');
    }

    // ✅ QTY STEPPER LOGIC — + tidak bisa melebihi min(remainingQuota, 4), - tidak bisa < 1
    function changeQty(catId, delta, maxQuota) {
        var el = document.getElementById('qty-' + catId);
        var current = parseInt(el.textContent);
        var maxAllowed = Math.min(maxQuota, 4);
        var newVal = current + delta;

        if (newVal < 1 || newVal > maxAllowed) return;

        el.textContent = newVal;

        // Update tombol minus
        document.getElementById('btn-minus-' + catId).disabled = (newVal <= 1);
        // Update tombol plus
        document.getElementById('btn-plus-' + catId).disabled = (newVal >= maxAllowed);

        // Update href link Book Now dengan qty terbaru
        var bookBtn = document.getElementById('book-btn-' + catId);
        if (bookBtn) {
            var href = bookBtn.href;
            bookBtn.href = href.replace(/qty=\d+/, 'qty=' + newVal);
        }
    }

    // Flag map
    const flagMap = {"Mexico":"mx","South Africa":"za","Canada":"ca","Bosnia-Herzegovina":"ba","USA":"us","Paraguay":"py","Brazil":"br","Morocco":"ma","Germany":"de","Curacao":"cw","Netherlands":"nl","Japan":"jp","Spain":"es","Cabo Verde":"cv","Belgium":"be","Egypt":"eg","France":"fr","Senegal":"sn","Argentina":"ar","Algeria":"dz","Portugal":"pt","DR Congo":"cd","England":"gb-eng","Croatia":"hr","Haiti":"ht","Uruguay":"uy","Colombia":"co","Ecuador":"ec","Chile":"cl","Switzerland":"ch","Serbia":"rs","Cameroon":"cm","Ghana":"gh","Tunisia":"tn","Australia":"au","South Korea":"kr","Iran":"ir","Saudi Arabia":"sa","Qatar":"qa","Costa Rica":"cr","Honduras":"hn","Jamaica":"jm","Panama":"pa","Bolivia":"bo","Venezuela":"ve","Peru":"pe","United States":"us","Türkiye":"tr","Turkey":"tr","Wales":"gb-wls","Scotland":"gb-sct","Ukraine":"ua","Denmark":"dk","Austria":"at","Poland":"pl","Greece":"gr","Albania":"al","Ivory Coast":"ci","Nigeria":"ng","Mali":"ml","Angola":"ao","Zambia":"zm","Georgia":"ge","New Zealand":"nz","Romania":"ro","Hungary":"hu","Slovakia":"sk","Czech Republic":"cz","Slovenia":"si"};

    var stadiums = [ctx+"/images/stadium1.avif",ctx+"/images/stadium2.avif",ctx+"/images/stadium3.avif",ctx+"/images/stadium4.avif",ctx+"/images/stadium5.avif",ctx+"/images/stadium6.avif",ctx+"/images/stadium7.avif",ctx+"/images/stadium8.avif",ctx+"/images/stadium9.avif"];
    var heroBanner = document.getElementById('heroBannerBg');
    if (heroBanner) heroBanner.style.backgroundImage = "url('" + stadiums[Math.floor(Math.random()*stadiums.length)] + "')";

    function loadFlag(imgId, phId, name) {
        var img = document.getElementById(imgId), ph = document.getElementById(phId);
        if (!img) return;
        var code = flagMap[name];
        if (code) {
            img.src = 'https://flagcdn.com/w160/' + code + '.png';
            img.onload = function() { img.style.display='block'; if(ph) ph.style.display='none'; };
            img.onerror = function() { img.style.display='none'; if(ph) ph.style.display='flex'; };
        }
    }
    loadFlag('flag-home', 'ph-home', '${match.homeTeam}');
    loadFlag('flag-away', 'ph-away', '${match.awayTeam}');
</script>
</body>
</html>