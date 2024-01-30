package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.activation.DataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/ONLINESHOP";
    private static final String DB_USER = "tada";
    private static final String DB_PASSWORD = "tadael";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get the product ID from the form submission
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        

        // Fetch the product details based on the product ID (you may need to modify this based on your data access logic)
        ProductDAO productDAO;
		try {
			productDAO = new ProductDAO(getConnection());
			
			 Product product = productDAO.getProductById(productId);
			 List<AddToCart> cart = (List<AddToCart>) session.getAttribute("cart");
			 String ProductName =  product.getName();
		        if (cart == null) {
		            cart = new ArrayList<>();
		        }

		        // Create a new AddToCart instance and add it to the cart
		        AddToCart cartItem = new AddToCart(product.getCloudinaryImageUrl(), product.getPrice(), quantity,ProductName,productId);
		        cart.add(cartItem);

		        // Update the cart in the session
		        session.setAttribute("cart", cart);

		        // Redirect back to the product list page or any other appropriate page
		        response.sendRedirect("index.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       

        // Get the existing cart from the session or create a new one if it doesn't exist
       
    }

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}