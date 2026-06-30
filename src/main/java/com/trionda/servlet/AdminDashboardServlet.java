package com.trionda.servlet;

import com.trionda.service.AdminService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

public class AdminDashboardServlet extends BaseServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        try {
            Map<String, Object> metrics = adminService.getDashboardMetrics();
            req.setAttribute("metrics", metrics);
            forward(req, res, "admin/dashboard.jsp");
        } catch (ServiceException e) {
            setError(req, e.getMessage());
            forward(req, res, "admin/dashboard.jsp");
        }
    }
}