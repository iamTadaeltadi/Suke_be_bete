package com.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/UpdateOrderServlet")
public class UpdateOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the form
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // JDBC URL, username, and password of MySQL server
        String jdbcUrl = "jdbc:mysql://your_mysql_server:3306/ONLINESHOP";
        String username = "tada";
        String password = "tadael";

        try {
            // Establish the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
                // Create an instance of OrderDAO with the connection
                OrderDAO orderDAO = new OrderDAO(connection);

                // Get the existing order from the database
                Order existingOrder = orderDAO.getOrderDTOById(orderId);

                if (existingOrder != null) {
                    // Update the order details
                    existingOrder.setUserId(userId);
                    existingOrder.setProductId(productId);
                    existingOrder.setQuantity(quantity);

                    // Update the order in the database
                    boolean isUpdated = orderDAO.updateOrderDTO(existingOrder);

                    if (isUpdated) {
                        // If the update is successful, set a success message as a request attribute
                        request.setAttribute("successMessage", "Order updated successfully.");
                    } else {
                        // If the update fails, set an error message as a request attribute
                        request.setAttribute("errorMessage", "Failed to update the order.");
                    }
                } else {
                    // If the order does not exist, set an error message as a request attribute
                    request.setAttribute("errorMessage", "Order not found.");
                }

                // Redirect back to the order details page
                response.sendRedirect(request.getContextPath() + "/success.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
            // You can redirect to an error page or handle it in another way
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
