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
            
        }
 .navbar {
            background: rgb(2, 0, 36);
            background: linear-gradient(90deg, rgba(2, 0, 36, 1) 26%, rgba(2, 0, 36, 1) 36%, rgba(2, 0, 36, 1) 41%, rgba(2, 0, 36, 1) 43%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(23, 156, 14, 1) 100%, rgba(0, 212, 255, 1) 100%);
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 30px 20px;
            position:sticky;
            top:0;s
           
        }

        dropdown {
            position: relative;
        }

        .dropdown-content {
            display: none;
            position: fixed; /* Fixed positioning */
            background-color: #fff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            min-width: 160px;
            z-index: 1;
            border-radius: 4px;
            overflow: hidden;
            border: 1px solid #ddd;
            margin-top: 5px; /* Adjusted top position */
            right: 20px; /* Adjusted right position */
        }

        .dropdown-content a {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: background-color 0.3s ease;
        }

        .dropdown-content a:hover {
            background-color: #f0f0f0;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .navbar-link-dropdown {
            color: #fff;
            text-decoration: none;
            padding: 14px 16px;
            transition: background-color 0.3s ease;
        }

        .navbar-link-dropdown:hover {
            background: rgb(11, 9, 47);
        }

        .navbar-link {
            color: #fff;
            text-decoration: none;
            padding: 14px 16px;
            transition: background-color 0.3s ease;
        }

        .navbar-link:hover {
            background: rgb(11, 9, 47);
            background: linear-gradient(90deg, rgba(11, 9, 47, 1) 0%, rgba(55, 107, 62, 1) 100%, rgba(43, 33, 218, 1) 100%, rgba(10, 78, 92, 1) 100%, rgba(47, 159, 63, 1) 100%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(23, 156, 14, 1) 100%);
        }

        .logout {
            color: #fff;
            text-decoration: none;
            padding: 14px 16px;
            transition: background-color 0.3s ease;
        }

        .logout:hover {
            background: rgb(11, 9, 47);
            background: linear-gradient(90deg, rgba(11, 9, 47, 1) 0%, rgba(55, 107, 62, 1) 100%, rgba(43, 33, 218, 1) 100%, rgba(10, 78, 92, 1) 100%, rgba(47, 159, 63, 1) 100%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(23, 156, 14, 1) 100%);
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
<div class="navbar">
        <div>
        <a href="admin.jsp" class="navbar-link">Home</a>
            <a href="<%=request.getContextPath()%>/ShowOrdersServlet" class="navbar-link">Orders</a>
            <a href="<%=request.getContextPath()%>/MessageListServlet" class="navbar-link">Complaints</a>
            <a href="createProduct.jsp" class="navbar-link">Create Product</a>
        </div>
        <div class="dropdown">
            <a href="#" class="navbar-link-dropdown" id="dropdown-link">
                <!-- Display the username, replace 'USERNAME' with the actual username -->
               <i class="fas fa-user" style :"padding:8px"> </i> <%= session.getAttribute("username") %> <i class="fas fa-caret-down"></i>
            </a>
            <div class="dropdown-content" id="dropdown-content">
                <a href="EditProfile.jsp">Edit Profile</a>
                
                <form action="logoutt" method="post">
    <button type="submit" class="logout">Logout</button>
</form>
            </div>
        </div>
    </div>
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
