package com.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp2.BasicDataSource;

@WebServlet("/editOrder")
public class EditOrderServlet extends HttpServlet {
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
        dataSource.setInitialSize(5);
        dataSource.setMaxTotal(20);
        dataSource.setMaxIdle(10);
        dataSource.setMinIdle(5);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve order details from the request parameters
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        try (Connection connection = dataSource.getConnection()) {
            // Create an instance of OrderDAO with the connection
            OrderDAO orderDAO = new OrderDAO(connection);
            
            // Fetch and update the order
            Order order = orderDAO.getOrderDTOById(orderId);

            if (order != null) {
                order.setQuantity(newQuantity);
                orderDAO.updateOrderDTO(order);
            }

            // Redirect back to the order details page
            response.sendRedirect("index.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
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
