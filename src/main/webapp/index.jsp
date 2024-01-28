<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.customer.Product" %>
<%@ page import="com.customer.ProductDAO" %>

<%
    // Create a database connection (replace "jdbcUrl", "username", and "password" with your actual database information)
    String jdbcUrl = "jdbc:mysql://localhost:3306/ONLINESHOP";
    String username = "tada";
    String password = "tadael";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
        ProductDAO productDAO = new ProductDAO(connection);
        List<Product> products = (List<Product>) session.getAttribute("products");
        


        
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .navbar {
            background-color: #333;
            overflow: hidden;
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-size: 18px;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        .navbar a.active {
            background-color: #4CAF50;
            color: white;
        }
        
        /* Add your additional styles here */
    </style>
</head>
<body>

<!-- Navigation bar -->
<%
if (products != null && !products.isEmpty()) {
%>
    <div class="navbar">
        <a href="#" class="active"><i class="fas fa-home"></i> Home</a>
        <a href="EditProfile.jsp"><i class="fas fa-user"></i> Edit Profile</a>
        <a href="<%= request.getContextPath() %>/ListOrdersServlet"><i class="fas fa-shopping-bag"></i> Orders</a>
        <a href="#"><i class="fas fa-phone"></i> Contact Us</a>
    </div>

    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin: 20px;">
        <%
        for (Product product : products) {
        %>
            <div style="border: 1px solid #ddd; overflow: hidden; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); transition: box-shadow 0.3s;">
                <a href="productDetail.jsp?id=<%= product.getId() %>" style="text-decoration: none; color: inherit; display: block;">
                    <img style="width: 100%; height: auto; display: block;" src="<%= product.getCloudinaryImageUrl() %>" alt="<%= product.getName() %>">
                </a>
                <div style="padding: 15px; text-align: center;">
                    <h3 style="margin-bottom: 5px; color: #333;"><%= product.getName() %></h3>
                    <p style="margin: 0; color: #555;">Description: <%= product.getDescription() %></p>
                    <p style="margin: 0; color: #555;">Price: $<%= product.getPrice() %></p>
                    <!-- Buttons inside the box -->
                    <div style="margin-top: 15px; display: flex; justify-content: space-around;">
                        <!-- Add to Cart Button -->
                        <button style="background-color: #4caf50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                            <i class="fas fa-cart-plus"></i> Add to Cart
                        </button>
                        <!-- Order Button -->
                        <button style="background-color: #3498db; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                            <i class="fas fa-shopping-bag"></i> Order
                        </button>
                    </div>
                </div>
            </div>
        <%
        }
        %>
    </div>
<%
} else {
	
%>
    <div style="text-align: center; margin: 20px;">
        
        <!-- Add any additional message or content for this case -->
    </div>
    <div class="navbar">
        <a href="" class="active"><i class="fas fa-home"></i> Home</a>
        <a href=""><i class="fas fa-phone"></i> Contact Us</a>
        <a href="login.jsp"><i class="fas fa-sign-in-alt"></i>login/up</a>
    </div>
    
    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin: 20px;">
        <%
        ProductDAO allProductDAO = new ProductDAO(connection); 
        List<Product> allProducts = allProductDAO.getAllProducts();

        if (allProducts != null && !allProducts.isEmpty()) {
            for (Product product : allProducts) {
        %>
            <div style="border: 1px solid #ddd; overflow: hidden; background-color: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); transition: box-shadow 0.3s;">
                <a href="" style="text-decoration: none; color: inherit; display: block;">
                    <img style="width: 100%; height: auto; display: block;" src="<%= product.getCloudinaryImageUrl() %>" alt="<%= product.getName() %>">
                </a>
                <div style="padding: 15px; text-align: center;">
                    <h3 style="margin-bottom: 5px; color: #333;"><%= product.getName() %></h3>
                    <p style="margin: 0; color: #555;">Description: <%= product.getDescription() %></p>
                    <p style="margin: 0; color: #555;">Price: $<%= product.getPrice() %></p>
                    <!-- Buttons inside the box -->
                    <div style="margin-top: 15px; display: flex; justify-content: space-around;">
                        <!-- Add to Cart Button -->
                        <a href="login.jsp"><button style="background-color: #4caf50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                            <i class="fas fa-cart-plus"></i> Add to Cart
                        </button>
                        </a>
                        <!-- Order Button -->
                        <a href="login.jsp"><button style="background-color: #3498db; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                            <i class="fas fa-shopping-bag"></i> Order
                        </button>
                        </a>
                    </div>
                </div>
            </div>
        <%
        }
        %>
    </div>
<%
}
}
%>

</body>
</html>

<%
    // Close the database connection
    connection.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Handle the exception according to your application's needs
    }
%>
