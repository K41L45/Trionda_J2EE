package com.trionda.dao;

import com.trionda.model.AuditLog;
import com.trionda.util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuditLogDAOImpl implements AuditLogDAO {

    private final Connection externalConn;

    // Constructor default — buat koneksi sendiri
    public AuditLogDAOImpl() {
        this.externalConn = null;
    }

    // Constructor dengan koneksi dari luar (untuk transaksi)
    public AuditLogDAOImpl(Connection conn) {
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
    public void insert(AuditLog log) throws SQLException {
        String sql = "INSERT INTO audit_log " +
                "(user_id, booking_id, action_type, " +
                "before_state, after_state) " +
                "VALUES (?, ?, ?, ?, ?)";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, log.getUserId());
            ps.setLong(2, log.getBookingId());
            ps.setString(3, log.getActionType());
            ps.setString(4, log.getBeforeState());
            ps.setString(5, log.getAfterState());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public List<AuditLog> findAll() throws SQLException {
        String sql = "SELECT * FROM audit_log ORDER BY changed_at DESC";
        List<AuditLog> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public List<AuditLog> findByUserId(long userId) throws SQLException {
        String sql = "SELECT * FROM audit_log WHERE user_id = ? " +
                "ORDER BY changed_at DESC";
        List<AuditLog> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
            if (!isExternalConn()) conn.close();
        }
        return list;
    }

    private AuditLog mapRow(ResultSet rs) throws SQLException {
        AuditLog log = new AuditLog();
        log.setLogId(rs.getLong("log_id"));
        log.setUserId(rs.getLong("user_id"));
        log.setBookingId(rs.getLong("booking_id"));
        log.setActionType(rs.getString("action_type"));
        log.setBeforeState(rs.getString("before_state"));
        log.setAfterState(rs.getString("after_state"));
        log.setChangedAt(rs.getTimestamp("changed_at").toLocalDateTime());
        return log;
    }
}