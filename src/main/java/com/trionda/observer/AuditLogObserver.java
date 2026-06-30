package com.trionda.observer;

import com.trionda.dao.AuditLogDAO;
import com.trionda.dao.AuditLogDAOImpl;
import com.trionda.model.AuditLog;
import com.trionda.model.Booking;
import com.trionda.model.TicketCategory;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * OBSERVER: Catat setiap perubahan booking ke audit_log.
 * Dipanggil otomatis saat booking dibuat atau dibatalkan.
 */
public class AuditLogObserver implements BookingObserver {

    private final AuditLogDAO auditLogDAO;
    private final Connection  conn; // ← pakai koneksi yang sama (1 transaksi)

    public AuditLogObserver(Connection conn) {
        this.conn        = conn;
        this.auditLogDAO = new AuditLogDAOImpl(conn);
    }

    @Override
    public void onBookingCreated(Booking booking,
                                 TicketCategory category) {
        try {
            AuditLog log = new AuditLog();
            log.setUserId(booking.getUserId());
            log.setBookingId(booking.getBookingId());
            log.setActionType("BOOKING_CREATED");
            log.setBeforeState("quota=" + (category.getRemainingQuota()
                    + booking.getQuantity()));
            log.setAfterState("quota=" + category.getRemainingQuota()
                    + ", booking=" + booking.getBookingCode());
            auditLogDAO.insert(log);
        } catch (SQLException e) {
            System.err.println("AuditLogObserver error: " + e.getMessage());
        }
    }

    @Override
    public void onBookingCancelled(Booking booking,
                                   TicketCategory category) {
        try {
            AuditLog log = new AuditLog();
            log.setUserId(booking.getUserId());
            log.setBookingId(booking.getBookingId());
            log.setActionType("BOOKING_CANCELLED");
            log.setBeforeState("status=CONFIRMED, quota="
                    + (category.getRemainingQuota()
                    - booking.getQuantity()));
            log.setAfterState("status=CANCELLED, quota="
                    + category.getRemainingQuota());
            auditLogDAO.insert(log);
        } catch (SQLException e) {
            System.err.println("AuditLogObserver error: " + e.getMessage());
        }
    }
}