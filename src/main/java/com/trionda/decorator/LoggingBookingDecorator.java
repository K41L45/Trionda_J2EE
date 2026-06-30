package com.trionda.decorator;

import com.trionda.model.Booking;
import com.trionda.service.BookingService;
import com.trionda.service.ServiceException;

import java.util.List;

/**
 * DECORATOR: Tambahkan logging ke setiap operasi BookingService.
 * BookingService asli tidak diubah sama sekali.
 *
 * Sebelum dan sesudah setiap operasi, decorator mencatat log
 * ke console (bisa diganti ke file/database nanti).
 */
public class LoggingBookingDecorator extends BookingServiceDecorator {

    public LoggingBookingDecorator(BookingService wrapped) {
        super(wrapped);
    }

    @Override
    public Booking createBooking(long userId, long categoryId,
                                 int quantity) throws ServiceException {
        System.out.println("[LOG] createBooking START — userId="
                + userId + " categoryId=" + categoryId
                + " quantity=" + quantity);
        try {
            Booking result = super.createBooking(
                    userId, categoryId, quantity);
            System.out.println("[LOG] createBooking SUCCESS — bookingCode="
                    + result.getBookingCode());
            return result;
        } catch (ServiceException e) {
            System.out.println("[LOG] createBooking FAILED — "
                    + e.getMessage());
            throw e;
        }
    }

    @Override
    public void cancelBooking(long bookingId,
                              long userId) throws ServiceException {
        System.out.println("[LOG] cancelBooking START — bookingId="
                + bookingId + " userId=" + userId);
        try {
            super.cancelBooking(bookingId, userId);
            System.out.println("[LOG] cancelBooking SUCCESS");
        } catch (ServiceException e) {
            System.out.println("[LOG] cancelBooking FAILED — "
                    + e.getMessage());
            throw e;
        }
    }

    @Override
    public List<Booking> getBookingHistory(
            long userId) throws ServiceException {
        System.out.println("[LOG] getBookingHistory — userId=" + userId);
        return super.getBookingHistory(userId);
    }
}