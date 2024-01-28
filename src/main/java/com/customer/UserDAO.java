package com.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection connection;

    public UserDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to get a user by ID
    public User getUserById(int userId) throws SQLException {
        String query = "SELECT * FROM users WHERE userID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractUserFromResultSet(resultSet);
                }
            }
        }
        return null; // Return null if no user is found
    }

    // Method to get all users
    public List<User> getAllUsers() throws SQLException {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM users";
        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                User user = extractUserFromResultSet(resultSet);
                userList.add(user);
            }
        }
        return userList;
    }
    public boolean updateUser(int userId, String username, String email, String address, String phoneNumber) throws SQLException {
        String query = "UPDATE users SET username = ?, email = ?, address = ?, phoneNumber = ? WHERE userID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, address);
            statement.setString(4, phoneNumber);
            statement.setInt(5, userId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to insert a new user (Implement based on your needs)

    // Method to update a user's information (Implement based on your needs)

    // Method to delete a user
    public boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM users WHERE userID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Helper method to extract user information from ResultSet
    private User extractUserFromResultSet(ResultSet resultSet) throws SQLException {
        int userId = resultSet.getInt("userID");
        String username = resultSet.getString("username");
        String password = resultSet.getString("password");
        String email = resultSet.getString("email");
        String address = resultSet.getString("address");
        String phoneNumber = resultSet.getString("phoneNumber");
        String role = resultSet.getString("role");

        return new User(userId, username, password, email, address, phoneNumber, role);
    }
}
