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

@WebServlet("/editOrder")
public class EditOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve order details from the request parameters
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));

        // JDBC URL, username, and password of MySQL server
        String jdbcUrl = "jdbc:mysql://your_mysql_server:3306/your_database";
        String username = "your_username";
        String password = "your_password";

        try {
            // Establish the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
                // Create an instance of OrderDAO with the connection
                OrderDAO orderDAO = new OrderDAO(connection);
                
                // Fetch and update the order
                Order order = orderDAO.getOrderDTOById(orderId);

                if (order != null) {
                    order.setQuantity(newQuantity);
                    orderDAO.updateOrderDTO(order);
                }

                // Redirect back to the order details page
                response.sendRedirect(request.getContextPath() + "/orderDetails.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }
}
