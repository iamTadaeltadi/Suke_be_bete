package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	Cookie myCookie = new Cookie("myCookieName", "cookieValue");
    	myCookie.setSecure(true); // Set the Secure attribute
    	response.addCookie(myCookie);
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        RequestDispatcher dispatcher = null;
        Connection con = null;
        
        List<Product> productDTOs = new ArrayList<>();
        HttpSession session = request.getSession();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ONLINESHOP?allowPublicKeyRetrieval=true&useSSL=false"
            		+ "", "tada", "tadael");

            try (PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE Email = ?")) {
                pst.setString(1, email);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        String hashedPasswordFromDB = rs.getString("Password");

                        // Check if the entered password matches the hashed password from the database
                        if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
                            String name = rs.getString("Username");
                            String role = rs.getString("role");
                            int UserID = Integer.parseInt(rs.getString("UserID"));
                            session.setAttribute("username", name);
                            session.setAttribute("UserID", UserID);
                            session.setAttribute("email", email);
                            
                            request.setAttribute("status", "success");

                            if ("user".equals(role)) {
                                dispatcher = request.getRequestDispatcher("index.jsp");
                                session.setAttribute("role", "user");

                                
                            } else {
                                dispatcher = request.getRequestDispatcher("admin.jsp");
                                session.setAttribute("role", "admin");
                            }
//                            productDTOs = 
                            try (Connection connection = getConnection()) {
                                ProductDAO productDAO = new ProductDAO(connection);
                                Product product = new Product();
                                
                               
                                productDTOs = productDAO.getAllProducts();
//                                System.out.println(productDTOs);

                                // Redirect back to the product page or another appropriate page
//                                response.sendRedirect("admin.jsp");
                            } catch (SQLException e) {
                                e.printStackTrace();
                                // Handle the exception
                                response.sendRedirect("errorPage.jsp");
                            }
                            
                            

                            // Set the list of productDTOs in request attributes
                            
                            session.setAttribute("products", productDTOs);
                        } else {
                            request.setAttribute("status", "failed");
                            dispatcher = request.getRequestDispatcher("login.jsp");
                        }
                    } else {
                        System.out.println("User not found");
                        request.setAttribute("status", "failed");
                        dispatcher = request.getRequestDispatcher("login.jsp");
                    }
                }
            }

            dispatcher.forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
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
        
        private Connection getConnection() throws SQLException {
            String url = "jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false";
            String username = "tada";
            String password = "tadael";
            return DriverManager.getConnection(url, username, password);
        }
        
}
