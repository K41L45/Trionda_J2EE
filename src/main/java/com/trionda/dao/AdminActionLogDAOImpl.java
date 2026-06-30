package com.trionda.dao;

import com.trionda.model.AdminActionLog;
import com.trionda.util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminActionLogDAOImpl implements AdminActionLogDAO {

    private final Connection externalConn;

    public AdminActionLogDAOImpl() { this.externalConn = null; }
    public AdminActionLogDAOImpl(Connection conn) { this.externalConn = conn; }

    private Connection getConn() throws SQLException {
        return externalConn != null ? externalConn : DBConnectionManager.getInstance().getConnection();
    }
    private boolean isExternalConn() { return externalConn != null; }

    @Override
    public void insert(AdminActionLog log) throws SQLException {
        String sql = "INSERT INTO admin_action_log (user_id, match_id, action_type, before_val, after_val) VALUES (?, ?, ?, ?, ?)";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, log.getUserId());
            // ✅ FIX: match_id = 0 berarti NULL (untuk DELETE action setelah match terhapus)
            if (log.getMatchId() == 0) {
                ps.setNull(2, Types.BIGINT);
            } else {
                ps.setLong(2, log.getMatchId());
            }
            ps.setString(3, log.getActionType());
            ps.setString(4, log.getBeforeVal());
            ps.setString(5, log.getAfterVal());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public List<AdminActionLog> findAll() throws SQLException {
        String sql = "SELECT * FROM admin_action_log ORDER BY actioned_at DESC";
        List<AdminActionLog> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public List<AdminActionLog> findByAdminId(long userId) throws SQLException {
        String sql = "SELECT * FROM admin_action_log WHERE user_id = ? ORDER BY actioned_at DESC";
        List<AdminActionLog> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    private AdminActionLog mapRow(ResultSet rs) throws SQLException {
        AdminActionLog log = new AdminActionLog();
        log.setActionId(rs.getLong("action_id"));
        log.setUserId(rs.getLong("user_id"));
        log.setMatchId(rs.getLong("match_id"));
        log.setActionType(rs.getString("action_type"));
        log.setBeforeVal(rs.getString("before_val"));
        log.setAfterVal(rs.getString("after_val"));
        log.setActionedAt(rs.getTimestamp("actioned_at").toLocalDateTime());
        return log;
    }
}