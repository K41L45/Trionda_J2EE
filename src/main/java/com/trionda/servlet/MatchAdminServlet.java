package com.trionda.servlet;

import com.trionda.model.Match;
import com.trionda.service.AdminService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

public class MatchAdminServlet extends BaseServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void processGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            if ("form".equals(action)) {
                forward(req, res, "admin/match_form.jsp");
                return;
            }
            if ("close".equals(action)) {
                long matchId = Long.parseLong(req.getParameter("id"));
                adminService.closeMatch(matchId, getSessionUserId(req));
                res.sendRedirect(req.getContextPath() + "/admin/matches?toggled=close");
                return;
            }
            // ✅ BARU: Reopen match
            if ("open".equals(action)) {
                long matchId = Long.parseLong(req.getParameter("id"));
                adminService.openMatch(matchId, getSessionUserId(req));
                res.sendRedirect(req.getContextPath() + "/admin/matches?toggled=open");
                return;
            }
            // ✅ BARU: Delete match
            if ("delete".equals(action)) {
                long matchId = Long.parseLong(req.getParameter("id"));
                adminService.deleteMatch(matchId, getSessionUserId(req));
                res.sendRedirect(req.getContextPath() + "/admin/matches?deleted=true");
                return;
            }

            List<Match> matches = adminService.getAllMatches();
            req.setAttribute("matches", matches);
            forward(req, res, "admin/match_list.jsp");

        } catch (ServiceException | NumberFormatException e) {
            setError(req, e.getMessage());
            try {
                List<Match> matches = adminService.getAllMatches();
                req.setAttribute("matches", matches);
            } catch (ServiceException ex) {
                req.setAttribute("matches", List.of());
            }
            forward(req, res, "admin/match_list.jsp");
        }
    }

    @Override
    protected void processPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            String homeTeam     = req.getParameter("homeTeam");
            String awayTeam     = req.getParameter("awayTeam");
            String matchDate    = req.getParameter("matchDate");
            String venue        = req.getParameter("venue");
            String hostCity     = req.getParameter("hostCity");
            String groupName    = req.getParameter("groupName");
            BigDecimal regPrice = new BigDecimal(req.getParameter("regularPrice"));
            int regQuota        = Integer.parseInt(req.getParameter("regularQuota"));
            BigDecimal vipPrice = new BigDecimal(req.getParameter("vipPrice"));
            int vipQuota        = Integer.parseInt(req.getParameter("vipQuota"));
            long adminId        = getSessionUserId(req);

            adminService.createMatch(homeTeam, awayTeam, matchDate,
                    venue, hostCity, groupName,
                    regPrice, regQuota, vipPrice, vipQuota, adminId);

            res.sendRedirect(req.getContextPath() + "/admin/matches?created=true");

        } catch (ServiceException | NumberFormatException e) {
            setError(req, e.getMessage());
            forward(req, res, "admin/match_form.jsp");
        }
    }
}