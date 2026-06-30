package com.trionda.servlet;

import com.trionda.model.Booking;
import com.trionda.service.BookingService;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class BookingHistoryServlet extends BaseServlet {

    private final BookingService bookingService = new BookingService();

    @Override
    protected void processGet(HttpServletRequest req,
                              HttpServletResponse res)
            throws ServletException, IOException {
        try {
            long userId = getSessionUserId(req);
            // ✅ Pakai method WITH DETAIL supaya dapat homeTeam, venue, dll
            List<Booking> bookings =
                    bookingService.getBookingHistoryWithDetail(userId);
            req.setAttribute("bookings", bookings);
            forward(req, res, "customer/booking_history.jsp");
        } catch (ServiceException e) {
            setError(req, e.getMessage());
            forward(req, res, "customer/booking_history.jsp");
        }
    }
}