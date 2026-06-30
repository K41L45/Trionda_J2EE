package com.trionda.dao;

import com.trionda.model.AuditLog;
import java.sql.SQLException;
import java.util.List;

public interface AuditLogDAO {
    void insert(AuditLog log) throws SQLException;
    List<AuditLog> findAll() throws SQLException;
    List<AuditLog> findByUserId(long userId) throws SQLException;
}