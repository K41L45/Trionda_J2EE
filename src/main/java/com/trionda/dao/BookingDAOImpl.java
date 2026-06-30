package com.trionda.dao;

import com.trionda.model.Booking;
import com.trionda.util.DBConnectionManager;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BookingDAOImpl implements BookingDAO {

    private final Connection externalConn;

    public BookingDAOImpl() {
        this.externalConn = null;
    }

    public BookingDAOImpl(Connection conn) {
        this.externalConn = conn;
    }

    private Connection getConn() throws SQLException {
        return externalConn != null
                ? externalConn
                : DBConnectionManager.getInstance().getConnection();
    }

    private boolean isExternalConn() {
        return externalConn != null;
    }

    @Override
    public void insert(Booking booking) throws SQLException {
        String sql = "INSERT INTO booking (booking_code, user_id, category_id, quantity, total_price, status) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, booking.getBookingCode());
            ps.setLong(2, booking.getUserId());
            ps.setLong(3, booking.getCategoryId());
            ps.setInt(4, booking.getQuantity());
            ps.setBigDecimal(5, booking.getTotalPrice());
            ps.setString(6, booking.getStatus());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public Booking findByCode(String bookingCode) throws SQLException {
        String sql = "SELECT * FROM booking WHERE booking_code = ?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } finally {
            if (!isExternalConn()) conn.close();
        }
        return null;
    }

    @Override
    public Optional<Booking> findById(long bookingId) throws SQLException {
        String sql = "SELECT * FROM booking WHERE booking_id = ?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } finally {
            if (!isExternalConn()) conn.close();
        }
        return Optional.empty();
    }

    @Override
    public List<Booking> findByUserId(long userId) throws SQLException {
        String sql = "SELECT * FROM booking WHERE user_id = ? ORDER BY created_at DESC";
        List<Booking> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    @Override
    public List<Booking> findAll() throws SQLException {
        String sql = "SELECT * FROM booking ORDER BY created_at DESC";
        List<Booking> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public void updateStatus(long bookingId, String status) throws SQLException {
        String sql = "UPDATE booking SET status=? WHERE booking_id=?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, bookingId);
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public long countByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM booking WHERE status = ?";
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return 0;
    }

    @Override
    public BigDecimal sumRevenue() throws SQLException {
        String sql = "SELECT SUM(total_price) FROM booking WHERE status = 'CONFIRMED'";
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        }
        return BigDecimal.ZERO;
    }

    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getLong("booking_id"));
        b.setBookingCode(rs.getString("booking_code"));
        b.setUserId(rs.getLong("user_id"));
        b.setCategoryId(rs.getLong("category_id"));
        b.setQuantity(rs.getInt("quantity"));
        b.setTotalPrice(rs.getBigDecimal("total_price"));
        b.setStatus(rs.getString("status"));
        b.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return b;
    }

    // ✅ JOIN query — ambil booking lengkap dengan data match dan kategori
    public List<Booking> findByUserIdWithDetail(long userId) throws SQLException {
        String sql =
                "SELECT b.*, " +
                        "       m.home_team, m.away_team, m.venue, m.host_city, m.match_date, m.group_name, " +
                        "       tc.category_name " +
                        "FROM booking b " +
                        "JOIN ticket_category tc ON b.category_id = tc.category_id " +
                        "JOIN wc_match m         ON tc.match_id   = m.match_id " +
                        "WHERE b.user_id = ? " +
                        "ORDER BY b.created_at DESC";

        List<Booking> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = mapRow(rs);
                    // Set match detail fields
                    b.setHomeTeam(rs.getString("home_team"));
                    b.setAwayTeam(rs.getString("away_team"));
                    b.setVenue(rs.getString("venue"));
                    b.setHostCity(rs.getString("host_city"));
                    b.setMatchDate(rs.getString("match_date"));
                    b.setGroupName(rs.getString("group_name"));
                    b.setCategoryName(rs.getString("category_name"));
                    list.add(b);
                }
            }
        }
        return list;
    }
}