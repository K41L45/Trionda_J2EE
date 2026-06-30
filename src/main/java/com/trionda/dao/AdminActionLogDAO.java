package com.trionda.dao;

import com.trionda.model.AdminActionLog;
import java.sql.SQLException;
import java.util.List;

public interface AdminActionLogDAO {
    void insert(AdminActionLog log) throws SQLException;
    List<AdminActionLog> findAll() throws SQLException;
    List<AdminActionLog> findByAdminId(long userId) throws SQLException;
}