package com.trionda.dao;

import com.trionda.model.TicketCategory;
import com.trionda.util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TicketCategoryDAOImpl implements TicketCategoryDAO {

    private final Connection externalConn;

    public TicketCategoryDAOImpl() {
        this.externalConn = null;
    }

    public TicketCategoryDAOImpl(Connection conn) {
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
    public List<TicketCategory> findByMatchId(long matchId)
            throws SQLException {
        String sql = "SELECT * FROM ticket_category WHERE match_id = ?";
        List<TicketCategory> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, matchId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    @Override
    public Optional<TicketCategory> findById(long categoryId)
            throws SQLException {
        String sql = "SELECT * FROM ticket_category WHERE category_id = ?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, categoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } finally {
            if (!isExternalConn()) conn.close();
        }
        return Optional.empty();
    }

    @Override
    public void insert(TicketCategory category) throws SQLException {
        String sql = "INSERT INTO ticket_category " +
                "(match_id, category_name, price, " +
                "total_quota, remaining_quota) " +
                "VALUES (?, ?, ?, ?, ?)";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, category.getMatchId());
            ps.setString(2, category.getCategoryName());
            ps.setBigDecimal(3, category.getPrice());
            ps.setInt(4, category.getTotalQuota());
            ps.setInt(5, category.getRemainingQuota());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public void update(TicketCategory category) throws SQLException {
        String sql = "UPDATE ticket_category SET category_name=?, " +
                "price=?, total_quota=?, remaining_quota=? " +
                "WHERE category_id=?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.getCategoryName());
            ps.setBigDecimal(2, category.getPrice());
            ps.setInt(3, category.getTotalQuota());
            ps.setInt(4, category.getRemainingQuota());
            ps.setLong(5, category.getCategoryId());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public void decrementQuota(long categoryId, int quantity)
            throws SQLException {
        String sql = "UPDATE ticket_category " +
                "SET remaining_quota = remaining_quota - ? " +
                "WHERE category_id = ? AND remaining_quota >= ?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setLong(2, categoryId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public void incrementQuota(long categoryId, int quantity)
            throws SQLException {
        String sql = "UPDATE ticket_category " +
                "SET remaining_quota = remaining_quota + ? " +
                "WHERE category_id = ?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setLong(2, categoryId);
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    private TicketCategory mapRow(ResultSet rs) throws SQLException {
        TicketCategory tc = new TicketCategory();
        tc.setCategoryId(rs.getLong("category_id"));
        tc.setMatchId(rs.getLong("match_id"));
        tc.setCategoryName(rs.getString("category_name"));
        tc.setPrice(rs.getBigDecimal("price"));
        tc.setTotalQuota(rs.getInt("total_quota"));
        tc.setRemainingQuota(rs.getInt("remaining_quota"));
        return tc;
    }
}