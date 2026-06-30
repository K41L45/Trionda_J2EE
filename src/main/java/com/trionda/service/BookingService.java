package com.trionda.service;

import com.trionda.dao.*;
import com.trionda.factory.PricingStrategyFactory;
import com.trionda.model.*;
import com.trionda.observer.AuditLogObserver;
import com.trionda.observer.BookingObserver;
import com.trionda.observer.SoldOutObserver;
import com.trionda.strategy.PricingStrategy;
import com.trionda.util.DBConnectionManager;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class BookingService {

    private final TicketCategoryDAO categoryDAO;
    private final BookingDAO        bookingDAO;

    public BookingService() {
        this.categoryDAO = new TicketCategoryDAOImpl();
        this.bookingDAO  = new BookingDAOImpl();
    }

    public Booking createBooking(long userId, long categoryId,
                                 int quantity) throws ServiceException {

        if (quantity < 1 || quantity > 4) {
            throw new ServiceException("Ticket quantity must be between 1 and 4.");
        }

        Connection conn = null;
        try {
            conn = DBConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            Optional<TicketCategory> catOpt =
                    new TicketCategoryDAOImpl(conn).findById(categoryId);
            if (catOpt.isEmpty()) {
                throw new ServiceException("Ticket category not found.");
            }
            TicketCategory category = catOpt.get();

            // ✅ Cek kuota — ini yang nge-block beli 4 kalau quota cuma 1
            if (category.getRemainingQuota() < quantity) {
                throw new ServiceException(
                        "Not enough tickets available. "
                                + "Only " + category.getRemainingQuota() + " left.");
            }

            PricingStrategy strategy = PricingStrategyFactory
                    .create(category.getCategoryName());
            BigDecimal totalPrice = strategy.calculatePrice(
                    category.getPrice(), quantity);

            String bookingCode = generateBookingCode();

            Booking booking = new Booking();
            booking.setBookingCode(bookingCode);
            booking.setUserId(userId);
            booking.setCategoryId(categoryId);
            booking.setQuantity(quantity);
            booking.setTotalPrice(totalPrice);
            booking.setStatus("CONFIRMED");

            new BookingDAOImpl(conn).insert(booking);
            booking = new BookingDAOImpl(conn).findByCode(bookingCode);

            new TicketCategoryDAOImpl(conn).decrementQuota(categoryId, quantity);
            category.setRemainingQuota(category.getRemainingQuota() - quantity);

            List<BookingObserver> observers = new ArrayList<>();
            observers.add(new AuditLogObserver(conn));
            observers.add(new SoldOutObserver());

            for (BookingObserver observer : observers) {
                observer.onBookingCreated(booking, category);
            }

            conn.commit();
            return booking;

        } catch (SQLException e) {
            rollback(conn);
            throw new ServiceException("Database error: " + e.getMessage(), e);
        } catch (ServiceException e) {
            rollback(conn);
            throw e;
        } finally {
            closeConn(conn);
        }
    }

    public void cancelBooking(long bookingId, long userId) throws ServiceException {
        Connection conn = null;
        try {
            conn = DBConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            Optional<Booking> bookingOpt =
                    new BookingDAOImpl(conn).findById(bookingId);
            if (bookingOpt.isEmpty()) {
                throw new ServiceException("Booking not found.");
            }
            Booking booking = bookingOpt.get();

            if (booking.getUserId() != userId) {
                throw new ServiceException("Access denied.");
            }

            if ("CANCELLED".equals(booking.getStatus())) {
                throw new ServiceException("This booking has already been cancelled.");
            }

            new BookingDAOImpl(conn).updateStatus(bookingId, "CANCELLED");
            new TicketCategoryDAOImpl(conn)
                    .incrementQuota(booking.getCategoryId(), booking.getQuantity());

            Optional<TicketCategory> catOpt =
                    new TicketCategoryDAOImpl(conn).findById(booking.getCategoryId());
            TicketCategory category = catOpt.orElse(new TicketCategory());
            category.setRemainingQuota(category.getRemainingQuota() + booking.getQuantity());

            booking.setStatus("CANCELLED");

            List<BookingObserver> observers = new ArrayList<>();
            observers.add(new AuditLogObserver(conn));
            observers.add(new SoldOutObserver());

            for (BookingObserver observer : observers) {
                observer.onBookingCancelled(booking, category);
            }

            conn.commit();

        } catch (SQLException e) {
            rollback(conn);
            throw new ServiceException("Database error: " + e.getMessage(), e);
        } catch (ServiceException e) {
            rollback(conn);
            throw e;
        } finally {
            closeConn(conn);
        }
    }

    public List<Booking> getBookingHistory(long userId) throws ServiceException {
        try {
            return bookingDAO.findByUserId(userId);
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve booking history: " + e.getMessage(), e);
        }
    }

    private String generateBookingCode() {
        String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        return "WC26-" + uuid.substring(0, 6);
    }

    private void rollback(Connection conn) {
        if (conn != null) { try { conn.rollback(); } catch (SQLException ignored) {} }
    }

    private void closeConn(Connection conn) {
        if (conn != null) {
            try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {}
        }
    }

    public List<Booking> getBookingHistoryWithDetail(long userId) throws ServiceException {
        try {
            return new BookingDAOImpl().findByUserIdWithDetail(userId);
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve booking history: " + e.getMessage(), e);
        }
    }
}