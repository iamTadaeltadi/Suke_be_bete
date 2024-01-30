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
    String role = (String) session.getAttribute("role");
    

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
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
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
        
        /* Add your additional styles here */
    </style>
</head>
<body>

<!-- Navigation bar -->
<%
if (products != null && !products.isEmpty()) {
%>


<div class="navbar">
        <div>
        <a href="index.jsp" class="navbar-link"><i class="fas fa-home"></i> Home</a>
            <a href="<%=request.getContextPath()%>/ListOrdersServlet" class="navbar-link">Orders</a>
            <a href="<%=request.getContextPath()%>/MessageListServlet" class="navbar-link">Complaints</a>
             <a class="navbar-link" href="contactUs.jsp"><i class="fas fa-phone"></i> Contact Us</a>
             <a  class="navbar-link" href ="AddToCart.jsp?id=<%=session.getAttribute("UserID")%>"><i class="fas fa-shopping-cart"></i>  </a>
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
                        <form method="post" action="AddToCartServlet">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        <input type="hidden" name="quantity" value="<%= 1%>">
       <button type="submit" style="background: rgb(11, 9, 47);
        background: linear-gradient(90deg, rgba(11, 9, 47, 1) 0%, rgba(55, 107, 62, 1) 100%, rgba(43, 33, 218, 1) 100%, rgba(10, 78, 92, 1) 100%, rgba(47, 159, 63, 1) 100%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(255, 0, 0, 1) 100%);
        color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background 0.3s;">
        <i class="fas fa-cart-plus"></i> Add to Cart
    </button>

    <!-- Order Button -->
    <button style="background: rgb(11, 9, 47);
        background: linear-gradient(90deg, rgba(11, 9, 47, 1) 0%, rgba(55, 107, 62, 1) 100%, rgba(43, 33, 218, 1) 100%, rgba(10, 78, 92, 1) 100%, rgba(47, 159, 63, 1) 100%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(23, 156, 14, 1) 100%);
        color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background 0.3s;">
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
        <div>
        <a href="index.jsp" class="navbar-link"><i class="fas fa-home"></i> Home</a>
         <a  class="navbar-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i>login/up</a>
             <a class="navbar-link" href="contactUs.jsp"><i class="fas fa-phone"></i> Contact Us</a>
        </div>
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
