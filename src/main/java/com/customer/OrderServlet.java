package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;



import org.apache.commons.dbcp2.BasicDataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BasicDataSource dataSource;

    @Override
    public void init() throws ServletException {
        super.init();
        initializeDataSource();
    }

    private void initializeDataSource() {
        dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/ONLINESHOP");
        dataSource.setUsername("tada");
        dataSource.setPassword("tadael");

        // Set additional connection pool properties
        dataSource.setInitialSize(5); // Initial number of connections
        dataSource.setMaxTotal(20); // Maximum number of connections
        dataSource.setMaxIdle(10); // Maximum number of idle connections
        dataSource.setMinIdle(5); // Minimum number of idle connections
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the URL
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Get user ID from session
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("UserID");

        // Get password from the request parameter
        String password = request.getParameter("password");

        // Check if the combination of user ID and product ID already exists
        if (orderExists(userId, productId)) {
        	 int orderId = getOrderId(userId, productId);
             session.setAttribute("orderId", orderId);
             session.setAttribute("quantity", quantity);
        	
            // Set confirmation message as a request attribute
            request.setAttribute("confirmMessage", "Order already exists for the specified user and product. Do you want to update it?");
        } else {
            // Process the order
        	 int orderId = processOrder(userId, productId, quantity);

             // Set orderId in the session
             session.setAttribute("orderId", orderId);
//             session.setAttribute("orderId", orderId);

            session.setAttribute("orderSent", true);

            // Set success message as a request attribute
            request.setAttribute("successMessage", "Order processed successfully.");
        }
        
       

        // Forward the request to the confirm.jsp page
        request.getRequestDispatcher("success.jsp").forward(request, response);
    }


    private boolean orderExists(int userId, int productId) {
        Connection connection = null;
        boolean exists = false;

        try {
            connection = dataSource.getConnection();

            // Check if the order exists in the database
            String query = "SELECT COUNT(*) FROM orders WHERE UserID = ? AND product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        int count = resultSet.getInt(1);
                        exists = count > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        } finally {
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception according to your application's needs
            }
        }

        return exists;
    }


    

    private int getOrderId(int userId, int productId) {
        Connection connection = null;

        try {
            connection = dataSource.getConnection();

            // Retrieve the order ID from the database
            String query = "SELECT order_id FROM orders WHERE UserID = ? AND product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getInt("order_id");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        } finally {
            // Close the connection in a finally block to ensure it's always closed
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception according to your application's needs
            }
        }

        return -1; // Return a default value or handle accordingly
    }

    private int processOrder(int userId, int productId, int quantity) {
        Connection connection = null;

        try {
            connection = dataSource.getConnection();

            // Insert order into the database
            String query = "INSERT INTO orders (UserID, product_id, quantity, order_date) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);
                preparedStatement.setInt(3, quantity);
                preparedStatement.setTimestamp(4, new Timestamp(new Date().getTime()));

                preparedStatement.executeUpdate();

                // Retrieve the generated order ID
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        } finally {
            // Close the connection in a finally block to ensure it's always closed
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception according to your application's needs
            }
        }

        return -1; // Return a default value or handle accordingly
    }
    @Override
    public void destroy() {
        // Close the connection pool when the servlet is destroyed
        if (dataSource != null) {
            try {
                dataSource.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        super.destroy();
    }
}
