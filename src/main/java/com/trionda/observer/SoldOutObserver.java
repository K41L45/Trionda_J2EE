package com.trionda.observer;

import com.trionda.model.Booking;
import com.trionda.model.TicketCategory;

/**
 * OBSERVER: Deteksi jika tiket habis setelah booking.
 * Bisa diextend untuk kirim notifikasi ke admin.
 */
public class SoldOutObserver implements BookingObserver {

    @Override
    public void onBookingCreated(Booking booking,
                                 TicketCategory category) {
        if (category.getRemainingQuota() == 0) {
            System.out.println("[SoldOutObserver] SOLD OUT: "
                    + "category_id=" + category.getCategoryId()
                    + " match_id="   + category.getMatchId());
            // Bisa tambah: kirim email notif ke admin
        }
    }

    @Override
    public void onBookingCancelled(Booking booking,
                                   TicketCategory category) {
        if (category.getRemainingQuota() > 0) {
            System.out.println("[SoldOutObserver] AVAILABLE AGAIN: "
                    + "category_id=" + category.getCategoryId());
        }
    }
}