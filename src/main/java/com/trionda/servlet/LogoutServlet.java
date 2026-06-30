package com.trionda.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LogoutServlet extends BaseServlet {

    // GET /logout → hancurkan session dan redirect ke login
    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = getSession(req);
        if (session != null) {
            session.invalidate(); // ← hancurkan semua data session
        }
        res.sendRedirect(req.getContextPath() + "/login");
    }
}