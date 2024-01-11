<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.customer.Order" %>
<%@ page import="com.customer.Product" %>
<%@ page import="com.customer.ProductDAO" %>
<%@ page import="com.customer.User" %>
<%@ page import="com.customer.UserDAO" %>
<%@ page import="com.customer.User" %>

<%@ page import="com.zaxxer.hikari.HikariConfig" %>
<%@ page import="com.zaxxer.hikari.HikariDataSource" %>

<%! 
    private static final HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false");
        config.setUsername("tada");
        config.setPassword("tadael");
        config.setMaximumPoolSize(10);  // Adjust the maximum pool size based on your requirements

        dataSource = new HikariDataSource(config);
    }

    private Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Show Orders</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4caf50;
            color: #fff;
        }

        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>User</th>
                <th>Address</th>
            </tr>
        </thead>
        <tbody>
            <%
            List<Order> orders = (List<Order>) session.getAttribute("orders");

            if ((orders == null || orders.isEmpty()) && (request.getAttribute("orders") == null || ((List<Order>) session.getAttribute("orders")).isEmpty())) {
                response.sendRedirect("admin.jsp");
            } else {
                for (Order order : orders) {
                    try {
                        Connection connection = getConnection();
                        
                        ProductDAO productDAO = new ProductDAO(connection);
                        Product product = productDAO.getProductById(order.getProductId());

                        UserDAO userDAO = new UserDAO(connection);
                        User user = userDAO.getUserById(order.getUserId());

                       

                        connection.close();
            %>
                        <tr>
                            <td><%= order.getOrderId() %></td>
                            <td><%= product.getName() %></td>
                            <td><%= order.getQuantity() %></td>
                            <td><%= product.getPrice() * order.getQuantity() %></td>
                            <td><%= user.getUsername() %></td>
                            <td><%= user.getAddress() %></td>
                        </tr>
            <%
                    } catch (SQLException e) {
                        e.printStackTrace();
                        response.sendRedirect("errorPage.jsp");
                    }
                }
            }
            %>
        </tbody>
    </table>
</body>
</html>
