<%@ page import="java.util.List" %>
<%@ page import="com.customer.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Page Title</title>
    
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

        
    </style>

    
</head>
<body>

<!-- Navigation bar -->
<div class="navbar">
    <a href="#" class="active"><i class="fas fa-home"></i> Home</a>
    <a href="#"><i class="fas fa-user"></i> Edit Profile</a>
<a href="<%= request.getContextPath() %>/ListOrdersServlet"><i class="fas fa-shopping-bag"></i> Orders</a>

    <a href="#"><i class="fas fa-phone"></i> Contact Us</a>
</div>


<%
List<Product> products = (List<Product>) session.getAttribute("products");
    if (products != null) {
%>
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
    }
%>

