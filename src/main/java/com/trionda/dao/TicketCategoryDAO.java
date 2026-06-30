package com.trionda.dao;

import com.trionda.model.TicketCategory;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface TicketCategoryDAO {
    List<TicketCategory> findByMatchId(long matchId) throws SQLException;
    Optional<TicketCategory> findById(long categoryId) throws SQLException;
    void insert(TicketCategory category) throws SQLException;
    void update(TicketCategory category) throws SQLException;
    void decrementQuota(long categoryId, int quantity) throws SQLException;
    void incrementQuota(long categoryId, int quantity) throws SQLException;
}