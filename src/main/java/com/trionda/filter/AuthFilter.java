package com.trionda.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req = (HttpServletRequest)  request;
        HttpServletResponse res = (HttpServletResponse) response;

        String contextPath = req.getContextPath();
        String requestURI  = req.getRequestURI();
        String path = requestURI.substring(contextPath.length());

        if (path.isEmpty()) path = "/";

        // 1. URL publik → langsung lewat tanpa cek session
        if (path.equals("/")
                || path.equals("/login")
                || path.equals("/register")
                || path.equals("/logout")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/error")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Cek session — sudah login belum?
        HttpSession session = req.getSession(false);
        boolean isLoggedIn  = (session != null
                && session.getAttribute("user_id") != null);

        if (!isLoggedIn) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        // 3. /admin/* → harus role ADMIN
        if (path.startsWith("/admin")) {
            if (!"ADMIN".equals(role)) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN,
                        "Access denied. Admin only.");
                return;
            }
        }

        // 4. Semua cek passed → lanjut ke Servlet tujuan
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}