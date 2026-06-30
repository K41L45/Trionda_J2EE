<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed — Trionda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            background: #080c14;
            color: #f0f0f0;
            font-family: 'Barlow', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        .color-bar {
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%);
            z-index: 999;
        }
        .success-card {
            background: #0f1623;
            border: 1px solid rgba(255,255,255,0.07);
            border-radius: 16px;
            max-width: 520px;
            width: 100%;
            overflow: hidden;
            box-shadow: 0 32px 80px rgba(0,0,0,0.6);
        }
        .gold-top-bar {
            height: 4px;
            background: linear-gradient(90deg, #c8a000, #e8c84a, #f5d75e, #e8c84a, #c8a000);
        }

        /* ===== HERO AREA ===== */
        .ticket-icon-area {
            position: relative;
            padding: 40px 0 32px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.06);
            overflow: hidden;
            min-height: 220px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .stadium-bg {
            position: absolute;
            inset: 0;
            background-size: cover;
            background-position: center;
            opacity: 0.13;
            z-index: 0;
        }
        .stadium-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(
                    to bottom,
                    rgba(13,22,35,0.45) 0%,
                    rgba(13,22,35,0.25) 40%,
                    rgba(13,22,35,0.65) 100%
            );
            z-index: 1;
        }
        .gold-glow {
            position: absolute;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            width: 260px; height: 260px;
            background: radial-gradient(circle, rgba(232,200,74,0.14) 0%, transparent 70%);
            z-index: 1;
        }

        /* ✅ Trophy wrap dengan animasi pulse */
        .trophy-wrap {
            position: relative;
            z-index: 2;
            margin-bottom: 20px;
            animation: pulse 3s ease-in-out infinite;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1);    filter: drop-shadow(0 0 10px rgba(232,200,74,0.3)); }
            50%       { transform: scale(1.05); filter: drop-shadow(0 0 28px rgba(232,200,74,0.65)); }
        }
        .wc-logo {
            width: 120px;
            height: auto;
            mix-blend-mode: screen;
        }
        .check-badge {
            position: absolute;
            bottom: 2px;
            right: -6px;
        }

        .success-label {
            position: relative;
            z-index: 2;
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 0.68rem;
            font-weight: 600;
            letter-spacing: 4px;
            color: rgba(255,255,255,0.4);
            text-transform: uppercase;
            margin-bottom: 8px;
        }
        .success-title {
            position: relative;
            z-index: 2;
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 2.2rem;
            font-weight: 900;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .success-title span { color: #e8c84a; }

        /* Booking code */
        .booking-code-section { padding: 24px 28px 0; text-align: center; }
        .code-label {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 0.65rem;
            font-weight: 600;
            letter-spacing: 4px;
            color: rgba(255,255,255,0.28);
            text-transform: uppercase;
            margin-bottom: 10px;
        }
        .booking-code {
            font-family: 'Barlow Condensed', sans-serif;
            font-size: 2rem;
            font-weight: 900;
            color: #e8c84a;
            letter-spacing: 5px;
            background: rgba(232,200,74,0.07);
            border: 1px solid rgba(232,200,74,0.18);
            border-radius: 8px;
            padding: 14px 24px;
            display: inline-block;
        }

        /* Perforated divider */
        .perforated { display: flex; align-items: center; margin: 20px 0 0; }
        .perf-circle-left  { width: 20px; height: 20px; background: #080c14; border-radius: 50%; margin-left: -10px; flex-shrink: 0; }
        .perf-circle-right { width: 20px; height: 20px; background: #080c14; border-radius: 50%; margin-right: -10px; flex-shrink: 0; margin-left: auto; }
        .perf-line { flex: 1; border-top: 2px dashed rgba(255,255,255,0.08); margin: 0 8px; }

        /* Details */
        .details-section { padding: 20px 28px 28px; }
        .detail-teams { display: flex; align-items: center; justify-content: center; margin-bottom: 18px; }
        .detail-team { display: flex; flex-direction: column; align-items: center; gap: 7px; flex: 1; }
        .detail-flag { width: 52px; height: 35px; object-fit: cover; border-radius: 3px; box-shadow: 0 2px 8px rgba(0,0,0,0.6); display: none; }
        .detail-flag-ph { width: 52px; height: 35px; background: rgba(255,255,255,0.06); border-radius: 3px; border: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-family: 'Barlow Condensed', sans-serif; font-size: 0.9rem; font-weight: 800; color: rgba(255,255,255,0.3); }
        .detail-team-name { font-family: 'Barlow Condensed', sans-serif; font-size: 0.9rem; font-weight: 800; color: #fff; text-transform: uppercase; letter-spacing: 1px; text-align: center; }
        .detail-vs { font-family: 'Barlow Condensed', sans-serif; font-size: 0.75rem; font-weight: 700; color: rgba(255,255,255,0.2); padding: 0 16px; flex-shrink: 0; padding-bottom: 28px; }
        .detail-row { display: flex; justify-content: space-between; align-items: center; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.05); font-size: 0.85rem; }
        .detail-row:last-of-type { border-bottom: none; }
        .detail-key { color: rgba(255,255,255,0.35); font-family: 'Barlow', sans-serif; }
        .detail-val { font-family: 'Barlow Condensed', sans-serif; font-weight: 700; color: #fff; letter-spacing: 0.5px; }
        .detail-val.gold  { color: #e8c84a; }
        .detail-val.green { color: #2ecc71; }

        /* Buttons */
        .btn-area { padding: 0 28px 28px; display: flex; flex-direction: column; gap: 10px; }
        .btn-primary-t { display: block; background: #e8c84a; color: #080c14; text-align: center; padding: 13px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 0.95rem; text-decoration: none; letter-spacing: 1px; text-transform: uppercase; transition: background 0.2s; }
        .btn-primary-t:hover { background: #f5d75e; color: #080c14; }
        .btn-secondary-t { display: block; text-align: center; padding: 12px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 700; font-size: 0.85rem; text-decoration: none; letter-spacing: 1px; text-transform: uppercase; border: 1.5px solid rgba(255,255,255,0.12); color: rgba(255,255,255,0.4); transition: all 0.2s; }
        .btn-secondary-t:hover { border-color: rgba(255,255,255,0.4); color: rgba(255,255,255,0.8); }
    </style>
</head>
<body>
<div class="color-bar"></div>

<div class="success-card">
    <div class="gold-top-bar"></div>

    <!-- Hero area -->
    <div class="ticket-icon-area">
        <div class="stadium-bg" id="stadiumBgHero"></div>
        <div class="stadium-overlay"></div>
        <div class="gold-glow"></div>

        <!-- ✅ Logo WC2026 asli + checkmark badge -->
        <div class="trophy-wrap">
            <div style="position:relative; display:inline-block;">
                <img src="${pageContext.request.contextPath}/images/wc2026-logo.avif"
                     alt="FIFA World Cup 2026"
                     class="wc-logo">
                <div class="check-badge">
                    <svg width="30" height="30" viewBox="0 0 30 30" fill="none">
                        <circle cx="15" cy="15" r="14" fill="#0f1623" stroke="#2ecc71" stroke-width="1.5"/>
                        <circle cx="15" cy="15" r="11" fill="#2ecc71"/>
                        <path d="M10 15l4 4 7-7" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                    </svg>
                </div>
            </div>
        </div>

        <div class="success-label">You're going to the World Cup!</div>
        <div class="success-title">BOOKING <span>CONFIRMED</span></div>
    </div>

    <!-- Booking Code -->
    <div class="booking-code-section">
        <div class="code-label">Your Booking Code</div>
        <div class="booking-code">${booking.bookingCode}</div>
    </div>

    <!-- Perforated Divider -->
    <div class="perforated">
        <div class="perf-circle-left"></div>
        <div class="perf-line"></div>
        <div class="perf-circle-right"></div>
    </div>

    <!-- Match Detail + Flags -->
    <div class="details-section">
        <c:if test="${not empty match}">
            <div class="detail-teams">
                <div class="detail-team">
                    <img id="flag-home" class="detail-flag" src="" alt="${match.homeTeam}">
                    <div id="ph-home" class="detail-flag-ph">${match.homeTeam.substring(0,1)}</div>
                    <div class="detail-team-name">${match.homeTeam}</div>
                </div>
                <div class="detail-vs">VS</div>
                <div class="detail-team">
                    <img id="flag-away" class="detail-flag" src="" alt="${match.awayTeam}">
                    <div id="ph-away" class="detail-flag-ph">${match.awayTeam.substring(0,1)}</div>
                    <div class="detail-team-name">${match.awayTeam}</div>
                </div>
            </div>
        </c:if>

        <div class="detail-row">
            <span class="detail-key">Quantity</span>
            <span class="detail-val">${booking.quantity} ticket(s)</span>
        </div>
        <div class="detail-row">
            <span class="detail-key">Total Paid</span>
            <span class="detail-val gold">$${booking.totalPrice}</span>
        </div>
        <div class="detail-row">
            <span class="detail-key">Status</span>
            <span class="detail-val green">● ${booking.status}</span>
        </div>
        <c:if test="${not empty match}">
            <div class="detail-row">
                <span class="detail-key">Venue</span>
                <span class="detail-val">${match.venue}</span>
            </div>
            <div class="detail-row">
                <span class="detail-key">City</span>
                <span class="detail-val">${match.hostCity}</span>
            </div>
        </c:if>
    </div>

    <!-- Buttons -->
    <div class="btn-area">
        <a href="${pageContext.request.contextPath}/customer/bookings/history" class="btn-primary-t">View My Bookings →</a>
        <a href="${pageContext.request.contextPath}/customer/matches" class="btn-secondary-t">← Browse More Matches</a>
    </div>
</div>

<script>
    var ctx = '<%= request.getContextPath() %>';

    // Random stadium background
    var stadiums = [
        ctx+"/images/stadium1.avif", ctx+"/images/stadium2.avif",
        ctx+"/images/stadium3.avif", ctx+"/images/stadium4.avif",
        ctx+"/images/stadium5.avif", ctx+"/images/stadium6.avif",
        ctx+"/images/stadium7.avif", ctx+"/images/stadium8.avif",
        ctx+"/images/stadium9.avif"
    ];
    var heroStadium = document.getElementById('stadiumBgHero');
    if (heroStadium) {
        heroStadium.style.backgroundImage = "url('" + stadiums[Math.floor(Math.random() * stadiums.length)] + "')";
    }

    const flagMap = {
        "Mexico":"mx","South Africa":"za","Canada":"ca","Bosnia-Herzegovina":"ba",
        "USA":"us","Paraguay":"py","Brazil":"br","Morocco":"ma","Germany":"de",
        "Curacao":"cw","Netherlands":"nl","Japan":"jp","Spain":"es","Cabo Verde":"cv",
        "Belgium":"be","Egypt":"eg","France":"fr","Senegal":"sn","Argentina":"ar",
        "Algeria":"dz","Portugal":"pt","DR Congo":"cd","England":"gb-eng","Croatia":"hr",
        "Haiti":"ht","Uruguay":"uy","Colombia":"co","Ecuador":"ec","Chile":"cl",
        "Switzerland":"ch","Serbia":"rs","Cameroon":"cm","Ghana":"gh","Tunisia":"tn",
        "Australia":"au","South Korea":"kr","Iran":"ir","Saudi Arabia":"sa","Qatar":"qa",
        "Costa Rica":"cr","Honduras":"hn","Jamaica":"jm","Panama":"pa","Bolivia":"bo",
        "Venezuela":"ve","Peru":"pe","United States":"us","Türkiye":"tr","Turkey":"tr",
        "Wales":"gb-wls","Scotland":"gb-sct","Ukraine":"ua","Denmark":"dk","Austria":"at",
        "Poland":"pl","Greece":"gr","Albania":"al","Ivory Coast":"ci","Nigeria":"ng",
        "Mali":"ml","Angola":"ao","Zambia":"zm","Georgia":"ge","New Zealand":"nz",
        "Romania":"ro","Hungary":"hu","Slovakia":"sk","Czech Republic":"cz","Slovenia":"si"
    };

    function loadFlag(imgId, phId, name) {
        if (!name) return;
        var img = document.getElementById(imgId);
        var ph  = document.getElementById(phId);
        if (!img) return;
        var code = flagMap[name];
        if (code) {
            img.src = 'https://flagcdn.com/w80/' + code + '.png';
            img.onload  = function() { img.style.display='block'; if(ph) ph.style.display='none'; };
            img.onerror = function() { img.style.display='none';  if(ph) ph.style.display='flex'; };
        }
    }

    loadFlag('flag-home', 'ph-home', '${match.homeTeam}');
    loadFlag('flag-away', 'ph-away', '${match.awayTeam}');
</script>
</body>
</html>