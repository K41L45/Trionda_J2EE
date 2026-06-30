package com.trionda.service;

import com.trionda.dao.MatchDAO;
import com.trionda.dao.MatchDAOImpl;
import com.trionda.dao.TicketCategoryDAO;
import com.trionda.dao.TicketCategoryDAOImpl;
import com.trionda.model.Match;
import com.trionda.model.TicketCategory;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public class MatchService {

    private final MatchDAO matchDAO;
    private final TicketCategoryDAO categoryDAO;

    public MatchService() {
        this.matchDAO    = new MatchDAOImpl();
        this.categoryDAO = new TicketCategoryDAOImpl();
    }

    public List<Match> findAllOpen() throws ServiceException {
        try {
            return matchDAO.findAllOpen();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve matches: " + e.getMessage(), e);
        }
    }

    public List<Match> findAll() throws ServiceException {
        try {
            return matchDAO.findAll();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve matches: " + e.getMessage(), e);
        }
    }

    public Match findById(long matchId) throws ServiceException {
        try {
            Optional<Match> match = matchDAO.findById(matchId);
            if (match.isEmpty()) {
                throw new ServiceException("Match not found.");
            }
            return match.get();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve match: " + e.getMessage(), e);
        }
    }

    public List<TicketCategory> findCategoriesByMatchId(long matchId)
            throws ServiceException {
        try {
            return categoryDAO.findByMatchId(matchId);
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve ticket categories: " + e.getMessage(), e);
        }
    }

    // ✅ BARU: ambil satu category by ID — dipakai BookingServlet setelah POST
    public TicketCategory findCategoryById(long categoryId)
            throws ServiceException {
        try {
            Optional<TicketCategory> cat = categoryDAO.findById(categoryId);
            if (cat.isEmpty()) {
                throw new ServiceException("Ticket category not found.");
            }
            return cat.get();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve ticket category: " + e.getMessage(), e);
        }
    }
}