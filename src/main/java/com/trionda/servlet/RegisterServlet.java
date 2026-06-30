package com.trionda.servlet;

import com.trionda.service.ServiceException;
import com.trionda.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends BaseServlet {

    private final UserService userService = new UserService();

    // GET /register → tampilkan form register
    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        forward(req, res, "auth/register.jsp");
    }

    // POST /register → proses register
    @Override
    protected void processPost(HttpServletRequest req,
                               HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String email    = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            userService.register(username, email, password);

            // Register sukses → redirect ke login dengan pesan
            res.sendRedirect(req.getContextPath()
                    + "/login?registered=true");

        } catch (ServiceException e) {
            setError(req, e.getMessage());
            forward(req, res, "auth/register.jsp");
        }
    }
}