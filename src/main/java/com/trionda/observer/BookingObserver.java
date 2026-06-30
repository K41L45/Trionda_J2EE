package com.trionda.observer;

import com.trionda.model.Booking;
import com.trionda.model.TicketCategory;

/**
 * OBSERVER PATTERN — Interface
 *
 * Setiap kali ada perubahan pada booking (create/cancel),
 * semua observer yang terdaftar akan diberitahu.
 *
 * Subject: BookingService (yang punya state berubah)
 * Observer: AuditLogObserver, SoldOutObserver
 */
public interface BookingObserver {
    void onBookingCreated(Booking booking, TicketCategory category);
    void onBookingCancelled(Booking booking, TicketCategory category);
}