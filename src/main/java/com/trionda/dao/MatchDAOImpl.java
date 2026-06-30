package com.trionda.dao;

import com.trionda.model.Match;
import com.trionda.util.DBConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class MatchDAOImpl implements MatchDAO {

    private final Connection externalConn;

    public MatchDAOImpl() { this.externalConn = null; }
    public MatchDAOImpl(Connection conn) { this.externalConn = conn; }

    private Connection getConn() throws SQLException {
        return externalConn != null ? externalConn : DBConnectionManager.getInstance().getConnection();
    }
    private boolean isExternalConn() { return externalConn != null; }

    @Override
    public List<Match> findAllOpen() throws SQLException {
        String sql = "SELECT * FROM wc_match WHERE status = 'OPEN' ORDER BY match_date ASC";
        List<Match> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public List<Match> findAll() throws SQLException {
        String sql = "SELECT * FROM wc_match ORDER BY match_date ASC";
        List<Match> list = new ArrayList<>();
        try (Connection conn = getConn();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    @Override
    public Optional<Match> findById(long matchId) throws SQLException {
        String sql = "SELECT * FROM wc_match WHERE match_id = ?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, matchId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(mapRow(rs));
            }
        } finally {
            if (!isExternalConn()) conn.close();
        }
        return Optional.empty();
    }

    @Override
    public void insert(Match match) throws SQLException {
        String sql = "INSERT INTO wc_match (home_team, away_team, match_date, venue, host_city, group_name, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, match.getHomeTeam());
            ps.setString(2, match.getAwayTeam());
            ps.setTimestamp(3, Timestamp.valueOf(match.getMatchDate()));
            ps.setString(4, match.getVenue());
            ps.setString(5, match.getHostCity());
            ps.setString(6, match.getGroupName());
            ps.setString(7, match.getStatus());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public void update(Match match) throws SQLException {
        String sql = "UPDATE wc_match SET home_team=?, away_team=?, match_date=?, venue=?, host_city=?, group_name=?, status=? WHERE match_id=?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, match.getHomeTeam());
            ps.setString(2, match.getAwayTeam());
            ps.setTimestamp(3, Timestamp.valueOf(match.getMatchDate()));
            ps.setString(4, match.getVenue());
            ps.setString(5, match.getHostCity());
            ps.setString(6, match.getGroupName());
            ps.setString(7, match.getStatus());
            ps.setLong(8, match.getMatchId());
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public void updateStatus(long matchId, String status) throws SQLException {
        String sql = "UPDATE wc_match SET status=? WHERE match_id=?";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, matchId);
            ps.executeUpdate();
        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public void delete(long matchId) throws SQLException {
        // ✅ FIX: Urutan hapus ikuti dependency FK
        // 1. audit_log (FK → booking)
        // 2. booking (FK → ticket_category)
        // 3. admin_action_log (FK → wc_match) ← root cause error sebelumnya
        // 4. ticket_category (FK → wc_match)
        // 5. wc_match

        String sqlAudit = "DELETE FROM audit_log WHERE booking_id IN " +
                "(SELECT booking_id FROM booking WHERE category_id IN " +
                "(SELECT category_id FROM ticket_category WHERE match_id = ?))";
        String sqlBook  = "DELETE FROM booking WHERE category_id IN " +
                "(SELECT category_id FROM ticket_category WHERE match_id = ?)";
        String sqlAdmin = "DELETE FROM admin_action_log WHERE match_id = ?";
        String sqlCat   = "DELETE FROM ticket_category WHERE match_id = ?";
        String sqlMatch = "DELETE FROM wc_match WHERE match_id = ?";

        Connection conn = getConn();
        try (PreparedStatement ps1 = conn.prepareStatement(sqlAudit);
             PreparedStatement ps2 = conn.prepareStatement(sqlBook);
             PreparedStatement ps3 = conn.prepareStatement(sqlAdmin);
             PreparedStatement ps4 = conn.prepareStatement(sqlCat);
             PreparedStatement ps5 = conn.prepareStatement(sqlMatch)) {

            ps1.setLong(1, matchId);
            ps1.executeUpdate();

            ps2.setLong(1, matchId);
            ps2.executeUpdate();

            ps3.setLong(1, matchId);
            ps3.executeUpdate();

            ps4.setLong(1, matchId);
            ps4.executeUpdate();

            ps5.setLong(1, matchId);
            ps5.executeUpdate();

        } finally {
            if (!isExternalConn()) conn.close();
        }
    }

    @Override
    public long countByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM wc_match WHERE status = ?";
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
    public long getLastInsertId() throws SQLException {
        String sql = "SELECT LAST_INSERT_ID()";
        Connection conn = getConn();
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getLong(1);
        } finally {
            if (!isExternalConn()) conn.close();
        }
        return 0;
    }

    private Match mapRow(ResultSet rs) throws SQLException {
        Match m = new Match();
        m.setMatchId(rs.getLong("match_id"));
        m.setHomeTeam(rs.getString("home_team"));
        m.setAwayTeam(rs.getString("away_team"));
        m.setMatchDate(rs.getTimestamp("match_date").toLocalDateTime());
        m.setVenue(rs.getString("venue"));
        m.setHostCity(rs.getString("host_city"));
        m.setGroupName(rs.getString("group_name"));
        m.setStatus(rs.getString("status"));
        return m;
    }
}