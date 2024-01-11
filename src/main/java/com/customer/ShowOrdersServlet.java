package com.customer;



import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ShowOrdersServlet")
public class ShowOrdersServlet extends HttpServlet {
    private static final HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false");
        config.setUsername("tada");
        config.setPassword("tadael");
        config.setMaximumPoolSize(10);  // Adjust the maximum pool size based on your requirements

        dataSource = new HikariDataSource(config);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	HttpSession session = request.getSession();
            // Fetch all orders from the database
            List<Order> orders = getOrderListFromDatabase();

            // Set the orders list as an attrbute in the request
            request.setAttribute("orders", orders);
            session.setAttribute("orders", orders);


            // Forward the request to the P page for displaying orders
            request.getRequestDispatcher("/showOrdersAdmin.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
            response.sendRedirect("errorPage.jsp");
        }
    }

    // Helper method to get a list of orders from the database
    private List<Order> getOrderListFromDatabase() throws SQLException {
        try (Connection connection = getConnection()) {
            OrderDAO orderDAO = new OrderDAO(connection);
            // Assuming OrderDAO has a method like getAllOrders() to retrieve all orders
            return orderDAO.getAllOrderDTOs();
        }
    }

    // Helper method to get a database connection using HikariCP
    private Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
