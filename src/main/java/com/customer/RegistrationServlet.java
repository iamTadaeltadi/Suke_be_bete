package com.customer;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("name");
        String email = request.getParameter("email");
        String plainPassword = request.getParameter("pass");
        String mobile_No = request.getParameter("contact");
        String role = request.getParameter("role");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false", "tada", "tadael");

            // Check if the user with the provided email already exists
            if (userExists(con, email)) {
                request.setAttribute("status", "failed");
                request.setAttribute("message", "User with this email already exists");
                dispatcher = request.getRequestDispatcher("registration.jsp");
            } else {
                // Hash the password using BCrypt
                String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());

                // Prepare the SQL statement for inserting user data
                PreparedStatement pst = con.prepareStatement("INSERT INTO users(Username, Password, Email, PhoneNumber, role) VALUES(?, ?, ?, ?,?)");

                // Set parameters for the SQL statement
                pst.setString(1, username);
                pst.setString(2, hashedPassword); // Store the hashed password
                pst.setString(3, email);
                pst.setString(4, mobile_No);
                if (role != null) {
                	pst.setString(5, role);
                	
                }
                else {
                	pst.setString(5, "user");
                	
                }

                // Execute the SQL statement
                int rowsAffected = pst.executeUpdate();
                dispatcher = request.getRequestDispatcher("registration.jsp");

                // Check if the insertion was successful
                if (rowsAffected > 0) {
                    request.setAttribute("status", "success");
                } else {
                    request.setAttribute("status", "failed");
                    request.setAttribute("message", "can't registerd try again");
                }

                // Close resources
                pst.close();
            }

            dispatcher.forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            // Handle exceptions
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private boolean userExists(Connection con, String email) throws SQLException {
        // Check if the user with the provided email already exists in the database
        try (PreparedStatement checkUser = con.prepareStatement("SELECT COUNT(*) FROM users WHERE Email = ?")) {
            checkUser.setString(1, email);
            try (ResultSet rs = checkUser.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }
}
