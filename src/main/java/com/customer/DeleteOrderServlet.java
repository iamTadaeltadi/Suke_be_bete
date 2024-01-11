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
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;

@WebServlet("/DeleteOrderServlet")
public class DeleteOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve order ID from the request parameters
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        // JDBC URL, username, and password of MySQL server
        String jdbcUrl = "jdbc:mysql://localhost:3306/ONLINESHOP";
        String username = "tada";
        String password = "tadael";
       
        try {
            // Establish the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
                // Create an instance of OrderDAO with the connection
                OrderDAO orderDAO = new OrderDAO(connection);

                // Delete the order
                boolean isDeleted = orderDAO.deleteOrderDTO(orderId);

                if (isDeleted) {
                    // Fetch the updated list of orders
                    List<Order> updatedOrders = orderDAO.getAllOrderDTOs();

                    // Set the updated list of orders as a session attribute
                    request.getSession().setAttribute("orders", updatedOrders);

                    // Redirect back to the order details page
                    response.sendRedirect("listOrders.jsp");
                } else {
                    // Handle the case where deletion failed
                    // You can redirect to an error page or handle it in another way
                    response.sendRedirect(request.getContextPath() + "/error.jsp");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
            // You can redirect to an error page or handle it in another way
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
