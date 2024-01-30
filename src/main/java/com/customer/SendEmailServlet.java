package com.customer;

import java.io.IOException;
import java.lang.System.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Extract form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("UserId");
    

        // Validate form data (add more validation as needed)

        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/ONLINESHOP";
        String dbUser = "tada";
        String dbPassword = "tadael";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                // Create a prepared statement
//            	System.out.println("sasads");
            	
                String sql = "INSERT INTO messages ( UserId, message, message_date) VALUES (?, ?, CURRENT_TIMESTAMP)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    // Set parameters
                	System.out.println("sasads");
                	if ( userId != null) {
                		 preparedStatement.setInt(1, userId);
                		 preparedStatement.setString(2, message);
                		
                		
                	}
                	else {
                		preparedStatement.setString(1, null);
                    preparedStatement.setString(2, message);

                    // Execute the update
                    preparedStatement.executeUpdate();
                	}
                    
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
        	  System.out.println(e.getMessage());
            // Log the exception instead of printing the stack trace
           
            // Handle the exception appropriately or show an error page
        }

        // Redirect to a confirmation page or display a success message
        try {
            // Sleep for 2 seconds (2000 milliseconds)
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            // Handle the InterruptedException if necessary
            e.printStackTrace();
        }

        response.sendRedirect("index.jsp");
    }
}
