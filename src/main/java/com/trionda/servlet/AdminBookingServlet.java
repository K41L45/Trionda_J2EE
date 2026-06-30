package com.trionda.servlet;

import com.trionda.model.Booking;
import com.trionda.service.AdminService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class AdminBookingServlet extends BaseServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        try {
            List<Booking> bookings = adminService.getAllBookings();
            req.setAttribute("bookings", bookings);
            forward(req, res, "admin/booking_list.jsp");
        } catch (ServiceException e) {
            setError(req, e.getMessage());
            forward(req, res, "admin/booking_list.jsp");
        }
    }
}