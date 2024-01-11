package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewProductsServlet")
public class ViewProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Create a ProductDAO with your database connection
        ProductDAO productDAO;
		try {
			productDAO = new ProductDAO(getConnection());
			List<Product> products = productDAO.getAllProducts();

	        // Set the list of products in request attributes
	        request.setAttribute("products", products);

	        // Forward to the product listing JSP
	        RequestDispatcher dispatcher = request.getRequestDispatcher("product-list.jsp");
	        dispatcher.forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Get all products from the database
        
    }

    // Helper method to get a database connection
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false";
        String username = "tada";
        String password = "tadael";
        return DriverManager.getConnection(url, username, password);
    }
}
