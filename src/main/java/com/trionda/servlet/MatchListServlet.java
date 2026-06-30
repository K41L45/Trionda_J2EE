package com.trionda.servlet;

import com.trionda.model.Match;
import com.trionda.service.MatchService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class MatchListServlet extends BaseServlet {

    private final MatchService matchService = new MatchService();

    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        try {
            List<Match> matches = matchService.findAllOpen();
            req.setAttribute("matches", matches);
            forward(req, res, "customer/match_list.jsp");
        } catch (ServiceException e) {
            setError(req, e.getMessage());
            forward(req, res, "customer/match_list.jsp");
        }
    }
}