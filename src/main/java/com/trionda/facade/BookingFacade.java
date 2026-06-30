package com.trionda.facade;

import com.trionda.decorator.LoggingBookingDecorator;
import com.trionda.model.Booking;
import com.trionda.service.BookingService;
import com.trionda.service.ServiceException;

import java.util.List;

/**
 * FACADE PATTERN
 *
 * Menyederhanakan akses ke sistem booking yang kompleks.
 * Servlet hanya perlu tahu BookingFacade — tidak perlu tahu
 * ada BookingService, LoggingDecorator, Observer, Strategy
 * yang bekerja di balik layar.
 *
 * Tanpa Facade (kompleks):
 *   BookingService svc = new BookingService();
 *   LoggingBookingDecorator decorated = new LoggingBookingDecorator(svc);
 *   Booking b = decorated.createBooking(userId, categoryId, qty);
 *
 * Dengan Facade (sederhana):
 *   Booking b = BookingFacade.createBooking(userId, categoryId, qty);
 */
public class BookingFacade {

    // Facade menyembunyikan kompleksitas konstruksi
    private static LoggingBookingDecorator buildService() {
        return new LoggingBookingDecorator(new BookingService());
    }

    public static Booking createBooking(long userId,
                                        long categoryId,
                                        int quantity)
            throws ServiceException {
        return buildService().createBooking(userId, categoryId, quantity);
    }

    public static void cancelBooking(long bookingId,
                                     long userId)
            throws ServiceException {
        buildService().cancelBooking(bookingId, userId);
    }

    public static List<Booking> getBookingHistory(
            long userId) throws ServiceException {
        return buildService().getBookingHistory(userId);
    }
}