package com.trionda.dao;

import com.trionda.model.Match;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface MatchDAO {
    List<Match> findAllOpen() throws SQLException;
    List<Match> findAll() throws SQLException;
    Optional<Match> findById(long matchId) throws SQLException;
    void insert(Match match) throws SQLException;
    void update(Match match) throws SQLException;
    void updateStatus(long matchId, String status) throws SQLException;
    void delete(long matchId) throws SQLException; // ✅ BARU
    long countByStatus(String status) throws SQLException;
    long getLastInsertId() throws SQLException;
}