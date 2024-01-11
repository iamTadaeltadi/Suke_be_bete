package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ListOrdersServlet")
public class ListOrdersServlet extends HttpServlet {
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
        List<Order> orders = getOrders();
        HttpSession session = request.getSession();
        session.setAttribute("orders", orders);
        System.out.print(orders);

        // Forward to the JSP page
        request.getRequestDispatcher("listOrders.jsp").forward(request, response);    }

    private List<Order> getOrders() {
        List<Order> orders = new ArrayList<>();
        Connection connection = null;

        try {
            connection = dataSource.getConnection();

            String query = "SELECT * FROM orders";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Order order = new Order();
                        order.setOrderId(resultSet.getInt("order_id"));
                        order.setUserId(resultSet.getInt("UserID"));
                        order.setProductId(resultSet.getInt("product_id"));
                        order.setQuantity(resultSet.getInt("quantity"));

                        orders.add(order);
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

        return orders;
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
