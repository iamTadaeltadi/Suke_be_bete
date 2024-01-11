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



import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the product ID from the request
        String productIdParam = request.getParameter("id");

        // Validate product ID
        if (productIdParam == null || !productIdParam.matches("\\d+")) {
            response.getWriter().write("Invalid product ID.");
            return;
        }

        int productId = Integer.parseInt(productIdParam);

        // Create a ProductDAO with your database connection
        try {
            ProductDAO productDAO = new ProductDAO(getConnection());
            boolean productDeleted = productDAO.deleteProduct(productId);

            if (productDeleted) {
                // Get the updated list of products and set it in the session
                List<Product> productList = productDAO.getAllProducts(); // Adjust this method according to your implementation
                HttpSession session = request.getSession();
                session.setAttribute("products", productList);

                // Redirect to the product listing page after successful deletion
                RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle the case where deletion failed (e.g., show an error message)
                response.getWriter().write("Failed to delete product.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Failed to delete product. Please try again later.");
        }
    }
    
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false";
        String username = "tada";
        String password = "tadael";
        return DriverManager.getConnection(url, username, password);
    }

    // ... (rest of the code remains the same)
}

    // Helper method to get a database connection
    

