package com.trionda.service;

import com.trionda.dao.UserDAO;
import com.trionda.dao.UserDAOImpl;
import com.trionda.model.User;

import java.sql.SQLException;
import java.util.Optional;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAOImpl();
    }

    public void register(String username, String email,
                         String password) throws ServiceException {
        if (username == null || username.isBlank()) {
            throw new ServiceException("Username cannot be empty.");
        }
        if (email == null || email.isBlank()) {
            throw new ServiceException("Email cannot be empty.");
        }
        if (password == null || password.length() < 4) {
            throw new ServiceException("Password must be at least 4 characters.");
        }

        try {
            Optional<User> existing = userDAO.findByEmail(email);
            if (existing.isPresent()) {
                throw new ServiceException("This email is already registered.");
            }

            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole("CUSTOMER");

            userDAO.insert(user);

        } catch (SQLException e) {
            throw new ServiceException("Database error: " + e.getMessage(), e);
        }
    }

    public User authenticate(String email,
                             String password) throws ServiceException {
        if (email == null || email.isBlank()) {
            throw new ServiceException("Email cannot be empty.");
        }
        if (password == null || password.isBlank()) {
            throw new ServiceException("Password cannot be empty.");
        }

        try {
            Optional<User> userOpt = userDAO.findByEmail(email);

            if (userOpt.isEmpty()) {
                throw new ServiceException("Incorrect email or password.");
            }

            User user = userOpt.get();

            if (!user.getPassword().equals(password)) {
                throw new ServiceException("Incorrect email or password.");
            }

            return user;

        } catch (SQLException e) {
            throw new ServiceException("Database error: " + e.getMessage(), e);
        }
    }
}