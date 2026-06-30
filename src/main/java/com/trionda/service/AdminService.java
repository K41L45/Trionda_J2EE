package com.trionda.service;

import com.trionda.dao.*;
import com.trionda.factory.TicketFactory;
import com.trionda.model.*;
import com.trionda.util.DBConnectionManager;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminService {

    private final MatchDAO matchDAO;
    private final TicketCategoryDAO categoryDAO;
    private final BookingDAO bookingDAO;
    private final UserDAO userDAO;
    private final AdminActionLogDAO adminLogDAO;

    public AdminService() {
        this.matchDAO    = new MatchDAOImpl();
        this.categoryDAO = new TicketCategoryDAOImpl();
        this.bookingDAO  = new BookingDAOImpl();
        this.userDAO     = new UserDAOImpl();
        this.adminLogDAO = new AdminActionLogDAOImpl();
    }

    public Map<String, Object> getDashboardMetrics() throws ServiceException {
        try {
            Map<String, Object> metrics = new HashMap<>();
            metrics.put("totalUsers",        userDAO.countByRole("CUSTOMER"));
            metrics.put("openMatches",       matchDAO.countByStatus("OPEN"));
            metrics.put("confirmedBookings", bookingDAO.countByStatus("CONFIRMED"));
            BigDecimal revenue = bookingDAO.sumRevenue();
            metrics.put("totalRevenue", revenue != null ? revenue : BigDecimal.ZERO);
            return metrics;
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve dashboard metrics: " + e.getMessage(), e);
        }
    }

    public List<Match> getAllMatches() throws ServiceException {
        try {
            return matchDAO.findAll();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve matches: " + e.getMessage(), e);
        }
    }

    public Match getMatchById(long matchId) throws ServiceException {
        try {
            return matchDAO.findById(matchId)
                    .orElseThrow(() -> new ServiceException("Match not found."));
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve match: " + e.getMessage(), e);
        }
    }

    public List<TicketCategory> getCategoriesByMatchId(long matchId) throws ServiceException {
        try {
            return categoryDAO.findByMatchId(matchId);
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve categories: " + e.getMessage(), e);
        }
    }

    public void createMatch(String homeTeam, String awayTeam,
                            String matchDateStr, String venue,
                            String hostCity, String groupName,
                            BigDecimal regularPrice, int regularQuota,
                            BigDecimal vipPrice, int vipQuota,
                            long adminUserId) throws ServiceException {

        if (homeTeam == null || homeTeam.isBlank())
            throw new ServiceException("Home team name cannot be empty.");
        if (awayTeam == null || awayTeam.isBlank())
            throw new ServiceException("Away team name cannot be empty.");
        if (regularPrice == null || regularPrice.compareTo(BigDecimal.ZERO) <= 0)
            throw new ServiceException("Regular price must be greater than 0.");
        if (vipPrice == null || vipPrice.compareTo(BigDecimal.ZERO) <= 0)
            throw new ServiceException("VIP price must be greater than 0.");
        if (regularQuota <= 0)
            throw new ServiceException("Regular quota must be greater than 0.");
        if (vipQuota <= 0)
            throw new ServiceException("VIP quota must be greater than 0.");

        Connection conn = null;
        try {
            conn = DBConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime matchDate = LocalDateTime.parse(matchDateStr, fmt);

            Match match = new Match();
            match.setHomeTeam(homeTeam);
            match.setAwayTeam(awayTeam);
            match.setMatchDate(matchDate);
            match.setVenue(venue);
            match.setHostCity(hostCity);
            match.setGroupName(groupName);
            match.setStatus("OPEN");

            new MatchDAOImpl(conn).insert(match);
            long matchId = new MatchDAOImpl(conn).getLastInsertId();

            TicketCategory regular = TicketFactory.create("REGULAR", matchId, regularPrice, regularQuota);
            TicketCategory vip     = TicketFactory.create("VIP",     matchId, vipPrice,     vipQuota);

            new TicketCategoryDAOImpl(conn).insert(regular);
            new TicketCategoryDAOImpl(conn).insert(vip);

            AdminActionLog log = new AdminActionLog();
            log.setUserId(adminUserId);
            log.setMatchId(matchId);
            log.setActionType("CREATE_MATCH");
            log.setBeforeVal("none");
            log.setAfterVal(homeTeam + " vs " + awayTeam);
            new AdminActionLogDAOImpl(conn).insert(log);

            conn.commit();

        } catch (SQLException e) {
            rollback(conn);
            throw new ServiceException("Failed to create match: " + e.getMessage(), e);
        } finally {
            closeConn(conn);
        }
    }

    public void closeMatch(long matchId, long adminUserId) throws ServiceException {
        Connection conn = null;
        try {
            conn = DBConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            new MatchDAOImpl(conn).updateStatus(matchId, "CLOSED");

            AdminActionLog log = new AdminActionLog();
            log.setUserId(adminUserId);
            log.setMatchId(matchId);
            log.setActionType("CLOSE_MATCH");
            log.setBeforeVal("status=OPEN");
            log.setAfterVal("status=CLOSED");
            new AdminActionLogDAOImpl(conn).insert(log);

            conn.commit();
        } catch (SQLException e) {
            rollback(conn);
            throw new ServiceException("Failed to close match: " + e.getMessage(), e);
        } finally { closeConn(conn); }
    }

    public void openMatch(long matchId, long adminUserId) throws ServiceException {
        Connection conn = null;
        try {
            conn = DBConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            new MatchDAOImpl(conn).updateStatus(matchId, "OPEN");

            AdminActionLog log = new AdminActionLog();
            log.setUserId(adminUserId);
            log.setMatchId(matchId);
            log.setActionType("OPEN_MATCH");
            log.setBeforeVal("status=CLOSED");
            log.setAfterVal("status=OPEN");
            new AdminActionLogDAOImpl(conn).insert(log);

            conn.commit();
        } catch (SQLException e) {
            rollback(conn);
            throw new ServiceException("Failed to reopen match: " + e.getMessage(), e);
        } finally { closeConn(conn); }
    }

    public void deleteMatch(long matchId, long adminUserId) throws ServiceException {
        Connection conn = null;
        try {
            conn = DBConnectionManager.getInstance().getConnection();
            conn.setAutoCommit(false);

            // 1. Cek apakah ada booking CONFIRMED
            String checkSql = "SELECT COUNT(*) FROM booking b " +
                    "JOIN ticket_category tc ON b.category_id = tc.category_id " +
                    "WHERE tc.match_id = ? AND b.status = 'CONFIRMED'";
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setLong(1, matchId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && rs.getLong(1) > 0) {
                        throw new ServiceException(
                                "Cannot delete: there are confirmed bookings for this match. Cancel them first.");
                    }
                }
            }

            // 2. Ambil nama match untuk log SEBELUM dihapus
            Match match = new MatchDAOImpl(conn).findById(matchId)
                    .orElseThrow(() -> new ServiceException("Match not found."));
            String matchName = match.getHomeTeam() + " vs " + match.getAwayTeam();

            // ✅ FIX: Tulis log DULU sebelum delete — pakai match_id yang masih valid
            AdminActionLog log = new AdminActionLog();
            log.setUserId(adminUserId);
            log.setMatchId(matchId); // masih valid karena belum dihapus
            log.setActionType("DELETE_MATCH");
            log.setBeforeVal(matchName);
            log.setAfterVal("deleted");
            new AdminActionLogDAOImpl(conn).insert(log);

            // 3. Baru hapus semua data terkait (urutan FK)
            // audit_log → booking → admin_action_log → ticket_category → wc_match
            // CATATAN: admin_action_log yang baru saja diinsert ikut terhapus — tidak masalah
            new MatchDAOImpl(conn).delete(matchId);

            conn.commit();

        } catch (SQLException e) {
            rollback(conn);
            throw new ServiceException("Failed to delete match: " + e.getMessage(), e);
        } finally { closeConn(conn); }
    }

    public List<Booking> getAllBookings() throws ServiceException {
        try {
            return bookingDAO.findAll();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve bookings: " + e.getMessage(), e);
        }
    }

    private void rollback(Connection conn) {
        if (conn != null) { try { conn.rollback(); } catch (SQLException ignored) {} }
    }
    private void closeConn(Connection conn) {
        if (conn != null) { try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ignored) {} }
    }
}