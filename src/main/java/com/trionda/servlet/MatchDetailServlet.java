package com.trionda.servlet;

import com.trionda.model.Match;
import com.trionda.model.TicketCategory;
import com.trionda.service.MatchService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class MatchDetailServlet extends BaseServlet {

    private final MatchService matchService = new MatchService();

    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        try {
            String matchIdParam = req.getParameter("id");
            if (matchIdParam == null || matchIdParam.isBlank()) {
                res.sendRedirect(req.getContextPath() + "/customer/matches");
                return;
            }

            long matchId = Long.parseLong(matchIdParam);
            Match match  = matchService.findById(matchId);
            List<TicketCategory> categories =
                    matchService.findCategoriesByMatchId(matchId);

            req.setAttribute("match",      match);
            req.setAttribute("categories", categories);
            forward(req, res, "customer/match_detail.jsp");

        } catch (ServiceException | NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/customer/matches");
        }
    }
}