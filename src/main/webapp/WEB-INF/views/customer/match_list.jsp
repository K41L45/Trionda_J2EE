<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matches — Trionda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #080c14; color: #f0f0f0; font-family: 'Barlow', sans-serif; min-height: 100vh; }
        .navbar-trionda { background: rgba(8,12,20,0.95); border-bottom: 1px solid rgba(255,255,255,0.07); padding: 10px 0; position: sticky; top: 0; z-index: 1000; }
        .navbar-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-ball { height: 36px; width: auto; filter: invert(1) sepia(1) saturate(5) hue-rotate(5deg); }
        .logo-wc { height: 44px; width: auto; mix-blend-mode: screen; }
        .navbar-brand-text { font-family: 'Barlow Condensed', sans-serif; font-size: 1.8rem; font-weight: 800; color: #e8c84a; letter-spacing: 3px; line-height: 1; text-transform: uppercase; }
        .navbar-right { display: flex; align-items: center; gap: 16px; }
        .nav-user-info { display: flex; flex-direction: column; align-items: flex-end; gap: 1px; }
        .nav-user-label { font-size: 0.65rem; font-weight: 500; color: rgba(255,255,255,0.35); letter-spacing: 1px; text-transform: uppercase; font-family: 'Barlow Condensed', sans-serif; }
        .nav-user-name { font-size: 0.88rem; font-weight: 700; color: #e8c84a; font-family: 'Barlow Condensed', sans-serif; letter-spacing: 1px; text-transform: uppercase; }
        .nav-divider { width: 1px; height: 26px; background: rgba(255,255,255,0.1); }
        .btn-nav { padding: 6px 16px; border-radius: 3px; font-size: 0.76rem; font-weight: 700; text-decoration: none; transition: all 0.2s; letter-spacing: 1px; text-transform: uppercase; font-family: 'Barlow Condensed', sans-serif; cursor: pointer; }
        .btn-nav-booking { background: #e8c84a; color: #080c14; border: none; }
        .btn-nav-booking:hover { background: #f5d75e; color: #080c14; }
        .btn-nav-logout { border: 1.5px solid rgba(255,255,255,0.15); color: rgba(255,255,255,0.5); background: transparent; }
        .btn-nav-logout:hover { border-color: #fff; color: #fff; }
        .hero-wrapper { position: relative; background: #080c14; overflow: hidden; }
        .hero-photo-bg { position: absolute; inset: 0; background-size: cover; background-position: center 60%; background-repeat: no-repeat; z-index: 0; }
        .hero-overlay { position: absolute; inset: 0; background: linear-gradient(to bottom, rgba(8,12,20,0.75) 0%, rgba(8,12,20,0.40) 35%, rgba(8,12,20,0.65) 70%, rgba(8,12,20,0.92) 90%, rgba(8,12,20,1.00) 100%); z-index: 1; }
        .hero-color-bar { position: absolute; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%); z-index: 3; }
        .hero-section { position: relative; min-height: 480px; display: flex; flex-direction: column; justify-content: center; text-align: center; padding: 60px 0 0; background: transparent; z-index: 2; }
        .hero-content { position: relative; z-index: 2; padding-bottom: 28px; }
        .hero-pretext { font-family: 'Barlow Condensed', sans-serif; font-style: italic; font-size: 0.95rem; font-weight: 700; letter-spacing: 4px; color: rgba(255,255,255,0.8); text-transform: uppercase; margin-bottom: 8px; text-shadow: 0 2px 8px rgba(0,0,0,0.8); }
        .hero-title { font-family: 'Barlow Condensed', sans-serif; font-size: 4.2rem; font-weight: 900; line-height: 0.95; color: #fff; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 16px; text-shadow: 0 4px 20px rgba(0,0,0,0.9); }
        .hero-title span { color: #e8c84a; }
        .hero-separator { display: flex; align-items: center; justify-content: center; gap: 10px; margin-bottom: 12px; }
        .hero-sep-line { height: 1px; width: 50px; background: rgba(255,255,255,0.3); }
        .hero-sep-dot { width: 4px; height: 4px; border-radius: 50%; background: #e8c84a; }
        .hero-eyebrow { font-family: 'Barlow Condensed', sans-serif; font-size: 0.72rem; font-weight: 700; letter-spacing: 5px; color: #e8c84a; text-transform: uppercase; margin-bottom: 6px; text-shadow: 0 2px 6px rgba(0,0,0,0.8); }
        .hero-sub { color: rgba(255,255,255,0.65); font-size: 0.88rem; font-family: 'Barlow', sans-serif; margin-bottom: 20px; text-shadow: 0 2px 6px rgba(0,0,0,0.8); }
        .host-bar { display: flex; justify-content: center; align-items: center; gap: 6px; }
        .host-item { display: flex; align-items: center; gap: 6px; font-family: 'Barlow Condensed', sans-serif; font-size: 0.7rem; font-weight: 600; letter-spacing: 2px; text-transform: uppercase; color: rgba(255,255,255,0.6); padding: 4px 10px; }
        .host-flag { width: 18px; height: 12px; object-fit: cover; border-radius: 1px; }
        .host-sep { color: rgba(255,255,255,0.2); font-size: 0.9rem; }
        .group-table-wrap { position: relative; z-index: 2; padding: 16px 0 36px; text-align: center; }
        .group-table-img { max-width: 820px; width: 92%; display: block; margin: 0 auto; border-radius: 12px; box-shadow: 0 6px 32px rgba(0,0,0,0.5); }
        .matches-section { background: #080c14; padding: 28px 0 60px; }
        .section-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 600; letter-spacing: 4px; color: rgba(255,255,255,0.28); text-transform: uppercase; margin-bottom: 4px; }
        .section-title { font-family: 'Barlow Condensed', sans-serif; font-size: 2.1rem; font-weight: 800; color: #fff; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 26px; }
        .section-title span { color: #e8c84a; }
        .match-card { position: relative; border-radius: 10px; overflow: hidden; background: #0f1623; transition: transform 0.3s, box-shadow 0.3s; height: 100%; cursor: pointer; min-height: 300px; }
        .match-card:hover { transform: translateY(-5px); box-shadow: 0 16px 40px rgba(0,0,0,0.6); }
        .card-bg { position: absolute; inset: 0; background-size: cover; background-position: center; opacity: 0.28; transition: opacity 0.3s; }
        .match-card:hover .card-bg { opacity: 0.42; }
        .card-gradient { position: absolute; inset: 0; background: linear-gradient(to bottom, rgba(8,12,20,0.15) 0%, rgba(8,12,20,0.55) 40%, rgba(8,12,20,0.97) 100%); }
        .card-body-inner { position: relative; z-index: 2; padding: 16px; display: flex; flex-direction: column; min-height: 300px; }
        .card-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        .badge-group { background: #e8c84a; color: #080c14; font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 800; padding: 3px 9px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; }
        .badge-open { background: rgba(39,174,96,0.12); color: #2ecc71; border: 1px solid rgba(39,174,96,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 2px 7px; border-radius: 3px; letter-spacing: 1px; }
        .badge-closed { background: rgba(220,53,69,0.12); color: #e55a68; border: 1px solid rgba(220,53,69,0.25); font-family: 'Barlow Condensed', sans-serif; font-size: 0.6rem; font-weight: 700; padding: 2px 7px; border-radius: 3px; letter-spacing: 1px; }
        .teams-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; flex: 1; }
        .team-col { display: flex; flex-direction: column; align-items: center; gap: 7px; flex: 1; }
        .team-flag-img { width: 50px; height: 33px; object-fit: cover; border-radius: 3px; box-shadow: 0 2px 8px rgba(0,0,0,0.7); display: none; }
        .team-flag-ph { width: 50px; height: 33px; background: rgba(255,255,255,0.07); border-radius: 3px; border: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-size: 0.55rem; color: rgba(255,255,255,0.3); }
        .team-name { font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 800; color: #fff; text-align: center; letter-spacing: 1.5px; text-transform: uppercase; line-height: 1.2; }
        .vs-badge { color: rgba(255,255,255,0.5); font-family: 'Barlow Condensed', sans-serif; font-size: 0.85rem; font-weight: 600; letter-spacing: 2px; padding: 0 10px; flex-shrink: 0; text-transform: uppercase; }
        .card-info { border-top: 1px solid rgba(255,255,255,0.08); padding-top: 12px; margin-bottom: 14px; }
        .info-item { display: flex; align-items: center; gap: 8px; font-size: 0.76rem; color: rgba(255,255,255,0.5); margin-bottom: 5px; font-family: 'Barlow', sans-serif; }
        .info-icon { color: #e8c84a; font-size: 0.72rem; width: 14px; text-align: center; flex-shrink: 0; }
        .btn-buy-now { display: block; width: 100%; background: #e8c84a; color: #080c14; text-align: center; padding: 11px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 0.9rem; text-decoration: none; letter-spacing: 1px; text-transform: uppercase; transition: background 0.2s; }
        .btn-buy-now:hover { background: #f5d75e; color: #080c14; }
        .btn-buy-now.disabled { background: rgba(255,255,255,0.08); color: rgba(255,255,255,0.2); cursor: not-allowed; pointer-events: none; }
    </style>
</head>
<body>

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

<div class="hero-wrapper">
    <div class="hero-color-bar"></div>
    <div class="hero-photo-bg" id="heroBg"></div>
    <div class="hero-overlay"></div>
    <section class="hero-section">
        <div class="hero-content container">
            <div class="hero-pretext">Get closer than ever to</div>
            <div class="hero-title">FIFA WORLD CUP <span>2026™</span></div>
            <div class="hero-separator">
                <div class="hero-sep-line"></div>
                <div class="hero-sep-dot"></div>
                <div class="hero-sep-line"></div>
            </div>
            <div class="hero-eyebrow">Official Ticket Booking Simulation</div>
            <div class="hero-sub">Group Stage Matches — Book your seat at the world's biggest stage</div>
            <div class="host-bar">
                <div class="host-item"><img src="https://flagcdn.com/w40/us.png" class="host-flag" alt="USA"><span>USA</span></div>
                <span class="host-sep">·</span>
                <div class="host-item"><img src="https://flagcdn.com/w40/ca.png" class="host-flag" alt="Canada"><span>Canada</span></div>
                <span class="host-sep">·</span>
                <div class="host-item"><img src="https://flagcdn.com/w40/mx.png" class="host-flag" alt="Mexico"><span>Mexico</span></div>
            </div>
        </div>
    </section>
    <div class="group-table-wrap">
        <img src="${pageContext.request.contextPath}/images/groups-table.png" alt="FIFA World Cup 2026 Groups" class="group-table-img" onerror="this.style.display='none'">
    </div>
</div>

<section class="matches-section">
    <div class="container">
        <div class="section-label">Available Matches</div>
        <div class="section-title">GROUP STAGE <span>FIXTURES</span></div>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger mb-4">${errorMessage}</div>
        </c:if>
        <div class="row g-4">
            <c:forEach var="match" items="${matches}" varStatus="loop">
                <div class="col-md-6 col-lg-4">
                    <div class="match-card">
                        <div class="card-bg" id="bg-${loop.index}"></div>
                        <div class="card-gradient"></div>
                        <div class="card-body-inner">
                            <div class="card-top">
                                <span class="badge-group">Group ${match.groupName}</span>
                                <c:choose>
                                    <c:when test="${match.status == 'OPEN'}"><span class="badge-open">● OPEN</span></c:when>
                                    <c:otherwise><span class="badge-closed">● CLOSED</span></c:otherwise>
                                </c:choose>
                            </div>
                            <div class="teams-row">
                                <div class="team-col">
                                    <img id="flag-home-${loop.index}" class="team-flag-img" src="" alt="${match.homeTeam}">
                                    <div id="ph-home-${loop.index}" class="team-flag-ph"></div>
                                    <div class="team-name">${match.homeTeam}</div>
                                </div>
                                <div class="vs-badge">vs</div>
                                <div class="team-col">
                                    <img id="flag-away-${loop.index}" class="team-flag-img" src="" alt="${match.awayTeam}">
                                    <div id="ph-away-${loop.index}" class="team-flag-ph"></div>
                                    <div class="team-name">${match.awayTeam}</div>
                                </div>
                            </div>
                            <div class="card-info">
                                <div class="info-item"><span class="info-icon">📅</span><span class="date-text">${match.matchDate}</span></div>
                                <div class="info-item"><span class="info-icon">🏟️</span><span>${match.venue}</span></div>
                                <div class="info-item"><span class="info-icon">📍</span><span>${match.hostCity}</span></div>
                            </div>
                            <c:choose>
                                <c:when test="${match.status == 'OPEN'}">
                                    <a href="${pageContext.request.contextPath}/customer/matches/detail?id=${match.matchId}" class="btn-buy-now">Buy Now →</a>
                                </c:when>
                                <c:otherwise>
                                    <span class="btn-buy-now disabled">Match Closed</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<script>
    var ctx = '<%= request.getContextPath() %>';
    var heroBg = document.getElementById('heroBg');
    if (heroBg) heroBg.style.backgroundImage = "url('" + ctx + "/images/la-bg.jpg')";

    function formatDate(raw) {
        if (!raw || !raw.includes('T')) return raw;
        var parts = raw.split('T'), d = parts[0].split('-');
        var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        var days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
        var dateObj = new Date(parseInt(d[0]), parseInt(d[1])-1, parseInt(d[2]));
        return days[dateObj.getDay()] + ', ' + months[parseInt(d[1])-1] + ' ' + parseInt(d[2]) + ' at ' + parts[1].substring(0,5);
    }
    document.querySelectorAll('.date-text').forEach(function(el) { el.textContent = formatDate(el.textContent.trim()); });

    const flagMap = {
        "Mexico":"mx","South Africa":"za","Canada":"ca","Bosnia-Herzegovina":"ba","USA":"us","Paraguay":"py","Brazil":"br","Morocco":"ma","Germany":"de","Curacao":"cw","Netherlands":"nl","Japan":"jp","Spain":"es","Cabo Verde":"cv","Belgium":"be","Egypt":"eg","France":"fr","Senegal":"sn","Argentina":"ar","Algeria":"dz","Portugal":"pt","DR Congo":"cd","England":"gb-eng","Croatia":"hr","Haiti":"ht","Uruguay":"uy","Colombia":"co","Ecuador":"ec","Chile":"cl","Switzerland":"ch","Serbia":"rs","Cameroon":"cm","Ghana":"gh","Tunisia":"tn","Australia":"au","South Korea":"kr","Iran":"ir","Saudi Arabia":"sa","Qatar":"qa","Costa Rica":"cr","Honduras":"hn","Jamaica":"jm","Panama":"pa","Bolivia":"bo","Venezuela":"ve","Peru":"pe","United States":"us","Türkiye":"tr","Turkey":"tr","Wales":"gb-wls","Scotland":"gb-sct","Ukraine":"ua","Denmark":"dk","Austria":"at","Poland":"pl","Greece":"gr","Albania":"al","Ivory Coast":"ci","Nigeria":"ng","Mali":"ml","Angola":"ao","Zambia":"zm","Georgia":"ge","New Zealand":"nz","Romania":"ro","Hungary":"hu","Slovakia":"sk","Czech Republic":"cz","Slovenia":"si"
    };
    const stadiums = [ctx+"/images/stadium1.avif",ctx+"/images/stadium2.avif",ctx+"/images/stadium3.avif",ctx+"/images/stadium4.avif",ctx+"/images/stadium5.avif",ctx+"/images/stadium6.avif",ctx+"/images/stadium7.avif",ctx+"/images/stadium8.avif",ctx+"/images/stadium9.avif"];

    document.querySelectorAll('.match-card').forEach(function(card, index) {
        var bg = document.getElementById('bg-' + index);
        if (bg) bg.style.backgroundImage = "url('" + stadiums[index % stadiums.length] + "')";
        function loadFlag(imgId, phId) {
            var img = document.getElementById(imgId), ph = document.getElementById(phId);
            if (!img) return;
            var code = flagMap[img.alt];
            if (code) {
                img.src = 'https://flagcdn.com/w80/' + code + '.png';
                img.onload = function() { img.style.display='block'; if(ph) ph.style.display='none'; };
                img.onerror = function() { img.style.display='none'; if(ph) ph.style.display='flex'; };
            } else { if(ph) { ph.style.display='flex'; ph.textContent=img.alt.charAt(0); } }
        }
        loadFlag('flag-home-'+index, 'ph-home-'+index);
        loadFlag('flag-away-'+index, 'ph-away-'+index);
    });
</script>
</body>
</html>