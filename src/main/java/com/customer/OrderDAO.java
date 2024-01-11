package com.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private Connection connection;

    public OrderDAO(Connection connection) {
        this.connection = connection;
    }

    // Get an OrderDTO by its ID
    public Order getOrderDTOById(int orderId) {
        Order orderDTO = null;

        try {
            String query = "SELECT * FROM orders WHERE order_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, orderId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        orderDTO = new Order();
                        orderDTO.setOrderId(resultSet.getInt("order_id"));
                        orderDTO.setUserId(resultSet.getInt("user_id"));
                        orderDTO.setProductId(resultSet.getInt("product_id"));
                        orderDTO.setQuantity(resultSet.getInt("quantity"));
                        // Set other order details as needed
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return orderDTO;
    }

    // Get a list of all OrderDTOs from the database
    public List<Order> getAllOrderDTOs() {
        List<Order> orderDTOList = new ArrayList<>();

        try {
            String query = "SELECT * FROM orders";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                 ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    Order orderDTO = new Order();
                    orderDTO.setOrderId(resultSet.getInt("order_id"));
                    orderDTO.setUserId(resultSet.getInt("UserID"));
                    orderDTO.setProductId(resultSet.getInt("product_id"));
                    orderDTO.setQuantity(resultSet.getInt("quantity"));
//                    orderDTO.Get(resultSet.getDate("order_date"));
                    // Set other order details as needed

                    orderDTOList.add(orderDTO);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return orderDTOList;
    }

    // Update/Edit an OrderDTO
    public boolean updateOrderDTO(Order orderDTO) {
        try {
            String query = "UPDATE orders SET user_id=?, product_id=?, quantity=? WHERE order_id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, orderDTO.getUserId());
                preparedStatement.setInt(2, orderDTO.getProductId());
                preparedStatement.setInt(3, orderDTO.getQuantity());
                preparedStatement.setInt(4, orderDTO.getOrderId());

                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return false;
    }

    // Delete an OrderDTO by its ID
    public boolean deleteOrderDTO(int orderId) {
        try {
            String query = "DELETE FROM orders WHERE order_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, orderId);
                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return false;
    }

    // Create a new OrderDTO
    public boolean createOrderDTO(Order orderDTO) {
        try {
            String query = "INSERT INTO orders (user_id, product_id, quantity) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, orderDTO.getUserId());
                preparedStatement.setInt(2, orderDTO.getProductId());
                preparedStatement.setInt(3, orderDTO.getQuantity());

                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return false;
    }

    // Close the connection (if needed)
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }
    }
}

CREATE TABLE messages (     message_id INT PRIMARY KEY AUTO_INCREMENT,     UserId INT,     message TEXT NOT NULL,     message_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,     FOREIGN KEY (UserID) REFERENCES users(UserID) );
id (INT, Primary Key), name (VARCHAR), age (INT), gender (VARCHAR), email (VARCHAR), phone (VARCHAR)



CREATE TABLE Patients(id INT Primary Key, name VARCHAR, age INT, gender VARCHAR, email VARCHAR, phone VARCHAR)


CREATE TABLE Patients (
		id INT Primary Key AUTO_INCREMENT,
		name varchar(255),
		age INT,
		gender varchar(255),
		email varchar(255),
		phone varchar(255)
	);




