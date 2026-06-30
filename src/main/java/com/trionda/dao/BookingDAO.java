package com.trionda.dao;

import com.trionda.model.Booking;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface BookingDAO {
    void insert(Booking booking) throws SQLException;
    Optional<Booking> findById(long bookingId) throws SQLException;
    Booking findByCode(String bookingCode) throws SQLException;
    List<Booking> findByUserId(long userId) throws SQLException;
    List<Booking> findAll() throws SQLException;
    void updateStatus(long bookingId, String status) throws SQLException;
    long countByStatus(String status) throws SQLException;
    BigDecimal sumRevenue() throws SQLException;
}