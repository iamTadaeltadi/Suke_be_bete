package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MessageListServlet")
public class MessageListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("UserID");

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
                String sql = "SELECT  message FROM messages";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    // No parameters to set

                    // Execute the query
                    ResultSet resultSet = preparedStatement.executeQuery();

                    // Process the result set and store messages in a list
                    List<Object[]> messages = new ArrayList<>();
                    while (resultSet.next()) {
                        String email =  "tadael@gmail.com";
                        String messageText = resultSet.getString("message");
                        
                        
                      

                        Object[] message = {email, messageText};
                        messages.add(message);
                    }

                    // Store the list in the session
                    session.setAttribute("MessageList", messages);

                    // Forward to the JSP page for displaying the list
                    request.getRequestDispatcher("messageList.jsp").forward(request, response);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the exception instead of printing the stack trace
            System.out.println(e.getMessage());
            // Handle the exception appropriately or show an error page
        }
    }
}