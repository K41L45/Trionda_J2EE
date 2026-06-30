package com.trionda.servlet;

import com.trionda.facade.BookingFacade;
import com.trionda.service.ServiceException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class BookingCancelServlet extends BaseServlet {

    @Override
    protected void processPost(HttpServletRequest req,
                               HttpServletResponse res)
            throws ServletException, IOException {
        try {
            long bookingId = Long.parseLong(
                    req.getParameter("bookingId"));
            long userId = getSessionUserId(req);

            BookingFacade.cancelBooking(bookingId, userId);

            res.sendRedirect(req.getContextPath()
                    + "/customer/bookings/history?cancelled=true");

        } catch (ServiceException e) {
            res.sendRedirect(req.getContextPath()
                    + "/customer/bookings/history?error="
                    + e.getMessage());
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath()
                    + "/customer/bookings/history");
        }
    }
}