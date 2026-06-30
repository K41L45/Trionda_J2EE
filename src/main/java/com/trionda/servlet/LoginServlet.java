package com.trionda.servlet;

import com.trionda.model.User;
import com.trionda.service.ServiceException;
import com.trionda.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends BaseServlet {

    private final UserService userService = new UserService();

    // GET /login → tampilkan form login
    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user_id") != null) {
            String role = (String) session.getAttribute("role");
            if ("ADMIN".equals(role)) {
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                res.sendRedirect(req.getContextPath() + "/customer/matches");
            }
            return;
        }

        forward(req, res, "auth/login.jsp");
    }

    // POST /login → proses login
    @Override
    protected void processPost(HttpServletRequest req,
                               HttpServletResponse res)
            throws ServletException, IOException {

        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            User user = userService.authenticate(email, password);

            // Buat session baru — simpan data yang sering dipakai
            HttpSession session = req.getSession(true);
            session.setAttribute("user_id",   user.getUserId());
            session.setAttribute("username",  user.getUsername());
            session.setAttribute("role",      user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 menit

            // Redirect berdasarkan role
            if ("ADMIN".equals(user.getRole())) {
                res.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                res.sendRedirect(req.getContextPath() + "/customer/matches");
            }

        } catch (ServiceException e) {
            setError(req, e.getMessage());
            forward(req, res, "auth/login.jsp");
        }
    }
}