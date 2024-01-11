package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;

        try {
            // For the sake of the example, let's assume you have a method to get the connection
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false", "tada", "tadael");

            // Create a ProductDAO instance with the connection
            ProductDAO productDAO = new ProductDAO(connection);

            // Get the list of all products
            List<Product> productList = productDAO.getAllProducts();

            // Set the productList as an attribute in the request
            request.setAttribute("products", productList);

            // Forward the request to the products.jsp page
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (SQLException e) {
            // Handle SQL exceptions
            e.printStackTrace(); // Log or handle the exception as needed
        } finally {
            // Close the database connection in a finally block to ensure it's always closed
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace(); // Log or handle the exception as needed
                }
            }
        }
    }
}
