<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking — Trionda</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Condensed:ital,wght@0,400;0,600;0,700;0,800;0,900;1,700;1,800;1,900&family=Barlow:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #080c14; color: #f0f0f0; font-family: 'Barlow', sans-serif; min-height: 100vh; }
        .color-bar { height: 3px; background: linear-gradient(90deg, #0057D9 0%, #0057D9 33.3%, #00A651 33.3%, #00A651 66.6%, #D72638 66.6%, #D72638 100%); }
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

        .page-wrap { min-height: calc(100vh - 65px); display: flex; align-items: center; padding: 40px 0; }
        .confirm-card { background: #0f1623; border: 1px solid rgba(255,255,255,0.07); border-radius: 14px; overflow: hidden; }

        /* Match Hero Mini */
        .match-hero-mini { background: linear-gradient(135deg, #0d1a2e 0%, #0a1020 100%); padding: 24px 28px; border-bottom: 1px solid rgba(255,255,255,0.07); }
        .step-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 600; letter-spacing: 4px; color: rgba(255,255,255,0.28); text-transform: uppercase; margin-bottom: 4px; }
        .page-title { font-family: 'Barlow Condensed', sans-serif; font-size: 1.8rem; font-weight: 900; color: #fff; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 20px; }
        .page-title span { color: #e8c84a; }

        /* Teams row inside card */
        .mini-teams { display: flex; align-items: center; justify-content: center; gap: 0; }
        .mini-team { display: flex; flex-direction: column; align-items: center; gap: 8px; flex: 1; }
        .mini-flag { width: 64px; height: 43px; object-fit: cover; border-radius: 3px; box-shadow: 0 3px 10px rgba(0,0,0,0.6); display: none; }
        .mini-flag-ph { width: 64px; height: 43px; background: rgba(255,255,255,0.06); border-radius: 3px; border: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; font-family: 'Barlow Condensed', sans-serif; font-size: 1rem; font-weight: 800; color: rgba(255,255,255,0.3); }
        .mini-team-name { font-family: 'Barlow Condensed', sans-serif; font-size: 1.1rem; font-weight: 800; color: #fff; text-transform: uppercase; letter-spacing: 1.5px; text-align: center; }
        .mini-vs { font-family: 'Barlow Condensed', sans-serif; font-size: 0.85rem; font-weight: 700; color: rgba(255,255,255,0.2); letter-spacing: 2px; padding: 0 20px; flex-shrink: 0; padding-bottom: 28px; }
        .mini-meta { display: flex; flex-wrap: wrap; justify-content: center; gap: 14px; margin-top: 16px; }
        .mini-meta-item { display: flex; align-items: center; gap: 6px; font-size: 0.76rem; color: rgba(255,255,255,0.4); }
        .mini-meta-icon { color: #e8c84a; font-size: 0.72rem; }

        /* Form area */
        .form-area { padding: 24px 28px; }
        .cat-badge { background: #e8c84a; color: #080c14; font-family: 'Barlow Condensed', sans-serif; font-size: 0.72rem; font-weight: 800; padding: 3px 10px; border-radius: 3px; letter-spacing: 1px; text-transform: uppercase; display: inline-block; }
        .cat-price-sub { font-size: 0.78rem; color: rgba(255,255,255,0.35); margin-left: 8px; }
        .divider { border: none; border-top: 1px solid rgba(255,255,255,0.07); margin: 20px 0; }
        .form-label-custom { font-family: 'Barlow Condensed', sans-serif; font-size: 0.68rem; font-weight: 700; letter-spacing: 2px; color: rgba(255,255,255,0.35); text-transform: uppercase; margin-bottom: 10px; display: block; }

        /* ✅ QTY STEPPER di confirm page */
        .qty-stepper { display: flex; align-items: center; gap: 0; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.12); border-radius: 6px; overflow: hidden; width: fit-content; margin-bottom: 24px; }
        .qty-btn { background: transparent; border: none; color: #e8c84a; font-size: 1.4rem; font-weight: 700; width: 48px; height: 48px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: background 0.15s; line-height: 1; }
        .qty-btn:hover:not(:disabled) { background: rgba(232,200,74,0.1); }
        .qty-btn:disabled { color: rgba(255,255,255,0.15); cursor: not-allowed; }
        .qty-num { font-family: 'Barlow Condensed', sans-serif; font-size: 1.4rem; font-weight: 800; color: #fff; min-width: 60px; text-align: center; border-left: 1px solid rgba(255,255,255,0.08); border-right: 1px solid rgba(255,255,255,0.08); line-height: 48px; }

        .total-box { background: rgba(232,200,74,0.06); border: 1px solid rgba(232,200,74,0.18); border-radius: 8px; padding: 18px 20px; text-align: center; margin-bottom: 20px; }
        .total-label { font-family: 'Barlow Condensed', sans-serif; font-size: 0.65rem; font-weight: 600; letter-spacing: 4px; color: rgba(255,255,255,0.3); text-transform: uppercase; margin-bottom: 6px; }
        .total-price { font-family: 'Barlow Condensed', sans-serif; font-size: 2.6rem; font-weight: 900; color: #e8c84a; line-height: 1; }
        .btn-confirm { display: block; width: 100%; background: #e8c84a; color: #080c14; text-align: center; padding: 14px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 800; font-size: 1rem; letter-spacing: 1px; text-transform: uppercase; transition: background 0.2s; border: none; cursor: pointer; margin-bottom: 10px; }
        .btn-confirm:hover { background: #f5d75e; }
        .btn-back { display: block; width: 100%; text-align: center; padding: 12px; border-radius: 5px; font-family: 'Barlow Condensed', sans-serif; font-weight: 700; font-size: 0.85rem; letter-spacing: 1px; text-transform: uppercase; text-decoration: none; border: 1.5px solid rgba(255,255,255,0.12); color: rgba(255,255,255,0.4); transition: all 0.2s; }
        .btn-back:hover { border-color: rgba(255,255,255,0.4); color: rgba(255,255,255,0.8); }
        .alert-danger-custom { background: rgba(220,53,69,0.1); border: 1px solid rgba(220,53,69,0.25); color: #e55a68; border-radius: 7px; padding: 11px 14px; font-size: 0.83rem; margin-bottom: 16px; }
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

<div class="page-wrap">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7 col-lg-6">
                <div class="confirm-card">

                    <!-- Match Hero Mini -->
                    <div class="match-hero-mini">
                        <div class="step-label">Step 2 of 2</div>
                        <div class="page-title">CONFIRM <span>BOOKING</span></div>
                        <div class="mini-teams">
                            <div class="mini-team">
                                <img id="flag-home" class="mini-flag" src="" alt="${match.homeTeam}">
                                <div id="ph-home" class="mini-flag-ph">${match.homeTeam.substring(0,1)}</div>
                                <div class="mini-team-name">${match.homeTeam}</div>
                            </div>
                            <div class="mini-vs">VS</div>
                            <div class="mini-team">
                                <img id="flag-away" class="mini-flag" src="" alt="${match.awayTeam}">
                                <div id="ph-away" class="mini-flag-ph">${match.awayTeam.substring(0,1)}</div>
                                <div class="mini-team-name">${match.awayTeam}</div>
                            </div>
                        </div>
                        <div class="mini-meta">
                            <div class="mini-meta-item"><span class="mini-meta-icon">📅</span><span id="matchDateText">${match.matchDate}</span></div>
                            <div class="mini-meta-item"><span class="mini-meta-icon">🏟️</span><span>${match.venue}, ${match.hostCity}</span></div>
                        </div>
                    </div>

                    <!-- Form Area -->
                    <div class="form-area">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert-danger-custom">✕ ${errorMessage}</div>
                        </c:if>

                        <div class="mb-4">
                            <span class="cat-badge">${category.categoryName}</span>
                            <span class="cat-price-sub">$${category.price} per ticket</span>
                        </div>

                        <hr class="divider">

                        <form method="post" action="${pageContext.request.contextPath}/customer/bookings/confirm">
                            <input type="hidden" name="categoryId" value="${category.categoryId}">
                            <input type="hidden" name="quantity" id="hiddenQty" value="${param.qty != null ? param.qty : 1}">

                            <label class="form-label-custom">Number of Tickets</label>
                            <%-- ✅ Stepper dengan max = min(remainingQuota, 4) --%>
                            <div class="qty-stepper">
                                <button type="button" class="qty-btn" id="btn-minus"
                                        onclick="changeQty(-1)"
                                ${(param.qty != null ? param.qty : 1) <= 1 ? 'disabled' : ''}>−</button>
                                <span class="qty-num" id="qtyDisplay">${param.qty != null ? param.qty : 1}</span>
                                <button type="button" class="qty-btn" id="btn-plus"
                                        onclick="changeQty(1)"
                                ${(param.qty != null ? param.qty : 1) >= (category.remainingQuota < 4 ? category.remainingQuota : 4) ? 'disabled' : ''}>+</button>
                            </div>

                            <div class="total-box">
                                <div class="total-label">Total Price</div>
                                <div class="total-price" id="totalPrice">$${category.price * (param.qty != null ? param.qty : 1)}</div>
                            </div>

                            <button type="submit" class="btn-confirm">Confirm Booking →</button>
                        </form>

                        <a href="${pageContext.request.contextPath}/customer/matches/detail?id=${match.matchId}" class="btn-back">← Back to Match Detail</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const basePrice = ${category.price};
    const maxAllowed = Math.min(${category.remainingQuota}, 4);
    let qty = parseInt(document.getElementById('qtyDisplay').textContent) || 1;

    function changeQty(delta) {
        var newVal = qty + delta;
        if (newVal < 1 || newVal > maxAllowed) return;
        qty = newVal;
        document.getElementById('qtyDisplay').textContent = qty;
        document.getElementById('hiddenQty').value = qty;
        document.getElementById('totalPrice').textContent = '$' + (basePrice * qty).toFixed(2);
        document.getElementById('btn-minus').disabled = (qty <= 1);
        document.getElementById('btn-plus').disabled = (qty >= maxAllowed);
    }

    // Format date
    function formatDate(raw) {
        if (!raw || !raw.includes('T')) return raw;
        var parts = raw.split('T'), d = parts[0].split('-');
        var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        var days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
        var dateObj = new Date(parseInt(d[0]), parseInt(d[1])-1, parseInt(d[2]));
        return days[dateObj.getDay()] + ', ' + months[parseInt(d[1])-1] + ' ' + parseInt(d[2]) + ', ' + d[0];
    }
    var dtEl = document.getElementById('matchDateText');
    if (dtEl) dtEl.textContent = formatDate(dtEl.textContent.trim());

    // Flags
    const flagMap = {"Mexico":"mx","South Africa":"za","Canada":"ca","Bosnia-Herzegovina":"ba","USA":"us","Paraguay":"py","Brazil":"br","Morocco":"ma","Germany":"de","Curacao":"cw","Netherlands":"nl","Japan":"jp","Spain":"es","Cabo Verde":"cv","Belgium":"be","Egypt":"eg","France":"fr","Senegal":"sn","Argentina":"ar","Algeria":"dz","Portugal":"pt","DR Congo":"cd","England":"gb-eng","Croatia":"hr","Haiti":"ht","Uruguay":"uy","Colombia":"co","Ecuador":"ec","Chile":"cl","Switzerland":"ch","Serbia":"rs","Cameroon":"cm","Ghana":"gh","Tunisia":"tn","Australia":"au","South Korea":"kr","Iran":"ir","Saudi Arabia":"sa","Qatar":"qa","Costa Rica":"cr","Honduras":"hn","Jamaica":"jm","Panama":"pa","Bolivia":"bo","Venezuela":"ve","Peru":"pe","United States":"us","Türkiye":"tr","Turkey":"tr","Wales":"gb-wls","Scotland":"gb-sct","Ukraine":"ua","Denmark":"dk","Austria":"at","Poland":"pl","Greece":"gr","Albania":"al","Ivory Coast":"ci","Nigeria":"ng","Mali":"ml","Angola":"ao","Zambia":"zm","Georgia":"ge","New Zealand":"nz","Romania":"ro","Hungary":"hu","Slovakia":"sk","Czech Republic":"cz","Slovenia":"si"};
    function loadFlag(imgId, phId, name) {
        var img = document.getElementById(imgId), ph = document.getElementById(phId);
        if (!img) return;
        var code = flagMap[name];
        if (code) {
            img.src = 'https://flagcdn.com/w80/' + code + '.png';
            img.onload = function() { img.style.display='block'; if(ph) ph.style.display='none'; };
            img.onerror = function() { img.style.display='none'; if(ph) ph.style.display='flex'; };
        }
    }
    loadFlag('flag-home', 'ph-home', '${match.homeTeam}');
    loadFlag('flag-away', 'ph-away', '${match.awayTeam}');
</script>
</body>
</html>