package com.trionda.dao;

import com.trionda.model.User;
import java.sql.SQLException;
import java.util.Optional;

public interface UserDAO {
    void insert(User user) throws SQLException;
    Optional<User> findByEmail(String email) throws SQLException;
    Optional<User> findById(long userId) throws SQLException;
    long countByRole(String role) throws SQLException;
}