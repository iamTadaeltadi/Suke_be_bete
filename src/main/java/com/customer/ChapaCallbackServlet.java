package com.customer;

import java.awt.PageAttributes.MediaType;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Enumeration;

import org.apache.commons.dbcp2.BasicDataSource;
import org.cloudinary.json.JSONObject;

import com.cloudinary.http44.api.Response;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import okhttp3.Headers;
import okhttp3.OkHttpClient;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;

@WebServlet("/ChapaCallbackServlet")
public class ChapaCallbackServlet extends HttpServlet {
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
        // Extract relevant parameters from the callback
        String txRef = request.getParameter("tx_ref");
//        String status = request.getParameter("status");
//        HttpSession session = request.getSession();

        
//        String quantity = (request.getParameter("quantity"));
        
//        String currency = request.getParameter("currency");productPrice
//        String productId=  request.getParameter("last_name");
        
//        String quantity = (request.getParameter("quantity"));
        
//        int quantity = Integer.parseInt(request.getParameter("amount"))/productPrice;
        
       
            OkHttpClient client = new OkHttpClient().newBuilder().build();
            okhttp3.MediaType mediaType = okhttp3.MediaType.parse("text/plain");
            HttpSession session = request.getSession();
            
            RequestBody body = RequestBody.create( "",mediaType);

            try {
                okhttp3.Request request1 = new okhttp3.Request.Builder()
                    .url("https://api.chapa.co/v1/transaction/verify/" + txRef)
                    .method("GET",null)
                    .addHeader("Authorization", "Bearer CHASECK_TEST-GVwl9lBzRzbg5EZr5WFxWl00pCT7QD2v")
                    .build();
                okhttp3.Response response1 = client.newCall(request1).execute();
                ResponseBody responseBody = response1.body();
//                System.out.println(response1.body().string());
                JSONObject jsonResponse = new JSONObject(responseBody.string());
                
                Integer productId = Integer.parseInt(jsonResponse.getJSONObject("data").getString("last_name"));
                int status = response.getStatus(); 
                Integer quantity = Integer.parseInt(jsonResponse.getJSONObject("data").getJSONObject("customization").getString("title"));
                Integer userId = Integer.parseInt(jsonResponse.getJSONObject("data").getJSONObject("customization").getString("description"));
                System.out.println( status  );
                
                if (status == 200) {
                    System.out.println("Payment was successful");

                    // Retrieve user information from the session or request, as needed
                    
                    session.setAttribute("UserID",userId);
                    session.setAttribute("quantity",quantity);

                    // Check if the combination of user ID and product ID already exists
                   
                        // Process the order
                        int orderId = processOrder(userId, productId, quantity);

                        // Set orderId in the session
                        session.setAttribute("orderId", orderId);

                        session.setAttribute("orderSent", true);

                        // Set success message as a request attribute
                        request.setAttribute("successMessage", "Order processed successfully.");
                    

//                    // Forward the request to the confirm.jsp page
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                } else {
//                     Payment failed or was not successful
//                     Handle failure, e.g., update your database or log the failure
//                     Optionally, you can redirect the user to a failure page
                    response.sendRedirect("failure.jsp");
                }


                
               
                
                

                // Close the response body to avoid resource leaks
                
                
                

                // Handle the response as needed

            } catch (IOException e) {
                e.printStackTrace();
                // Handle the exception according to your application's needs
            }
        
        
        

        
        
        
//       
//      
//        // Placeholder for product ID - Replace with your actual product ID logic
//        
//
//         Perform actions based on payment status
        
    }

    private boolean orderExists(int userId, int productId) {
        Connection connection = null;
        boolean exists = false;

        try {
            connection = dataSource.getConnection();

            // Check if the order exists in the database
            String query = "SELECT COUNT(*) FROM orders WHERE UserID = ? AND product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        int count = resultSet.getInt(1);
                        exists = count > 0;
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

        return exists;
    }

    private int getOrderId(int userId, int productId) {
        Connection connection = null;

        try {
            connection = dataSource.getConnection();

            // Retrieve the order ID from the database
            String query = "SELECT order_id FROM orders WHERE UserID = ? AND product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getInt("order_id");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        } finally {
            // Close the connection in a finally block to ensure it's always closed
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception according to your application's needs
            }
        }

        return -1; // Return a default value or handle accordingly
    }

    private int processOrder(int userId, int productId, int quantity) {
        Connection connection = null;

        try {
            connection = dataSource.getConnection();

            // Insert order into the database
            String query = "INSERT INTO orders (UserID, product_id, quantity, order_date) VALUES (?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setInt(2, productId);
                preparedStatement.setInt(3, quantity);
                preparedStatement.setTimestamp(4, new Timestamp(new Date().getTime()));

                preparedStatement.executeUpdate();

                // Retrieve the generated order ID
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        } finally {
            // Close the connection in a finally block to ensure it's always closed
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception according to your application's needs
            }
        }

        return -1; // Return a default value or handle accordingly
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
