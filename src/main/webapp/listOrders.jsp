<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.customer.Order" %>
<%@ page import="com.customer.Product" %>
<%@ page import="com.customer.ProductDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .no-orders {
            color: #555;
            margin-top: 20px;
        }
         body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .no-orders {
            color: #555;
            margin-top: 20px;
        }

        .edit-btn, .delete-btn {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .delete-btn {
            background-color: #f44336;
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <h2>patient Details:</h2>

    <%-- Get the list of orders from the session --%>
    <%
        List<Order> orders = (List<Order>) session.getAttribute("orders");

        // Check if orders is not null before iterating over it
        if (orders != null && !orders.isEmpty()) {
            // Establish the database connection
            Connection connection = null;
            ProductDAO productDAO = null;

            try {
                String jdbcUrl = "jdbc:mysql://localhost:3306/ONLINESHOP";
                String username = "tada";
                String password = "tadael";

                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, username, password);

                // Create an instance of ProductDAO with the connection
                productDAO = new ProductDAO(connection);

                // Iterate over the orders and display product details"com.mysql.cj.jdbc.Driver");
        
    %>
                <table>
                    <tr>
                       <th>Product Name</th>
                        <th>Quantity</th>
                    
                        <th>Product Price</th>
                         <th>Action</th>
                    </tr>
                    <% for (Order order : orders) { %>
                        <tr>
                           
                           

                            <%-- Get product details using the product ID --%>
                            <% Product product = productDAO.getProductById(order.getProductId()); %>

                            <%-- Display product details --%>
                            <td><%= product.getName() %></td>
                            <td><%= order.getQuantity() %></td>
                            <td><%= product.getPrice() * order.getQuantity() %></td>
                            <td>
                   <a class="edit-btn" href="EditOrderServlet?orderId=<%= order.getOrderId() %>">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a class="delete-btn" href="<%= request.getContextPath() %>/DeleteOrderServlet?orderId=<%= order.getOrderId() %>">
                              
    
                                    <i class="fas fa-trash-alt"></i> Delete
                                </a>
                </td>
                        </tr>
                    <% } %>
                </table>
    <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the database connection
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } else { // No orders
    %>
            <p class="no-orders">No orders so far.</p>
    <%
        } // end if
       
        
    %>
</body>
</html>
