package com.trionda.decorator;

import com.trionda.model.Booking;
import com.trionda.service.BookingService;
import com.trionda.service.ServiceException;

import java.util.List;

/**
 * DECORATOR PATTERN — Abstract base decorator.
 *
 * Membungkus BookingService dan mendelegasikan semua method
 * ke objek yang dibungkus. Subclass tinggal override method
 * yang ingin ditambahkan behavior-nya.
 */
public abstract class BookingServiceDecorator {

    protected final BookingService wrapped;

    public BookingServiceDecorator(BookingService wrapped) {
        this.wrapped = wrapped;
    }

    public Booking createBooking(long userId, long categoryId,
                                 int quantity) throws ServiceException {
        return wrapped.createBooking(userId, categoryId, quantity);
    }

    public void cancelBooking(long bookingId,
                              long userId) throws ServiceException {
        wrapped.cancelBooking(bookingId, userId);
    }

    public List<Booking> getBookingHistory(
            long userId) throws ServiceException {
        return wrapped.getBookingHistory(userId);
    }
}