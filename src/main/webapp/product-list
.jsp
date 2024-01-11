<!-- product-list.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.customer.Product" %>
<%@ page import="java.util.List" %>


<html>
<head>
    <title>Product List</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .container {
            width: 80%;
            margin: 0 auto;
        }

        h2 {
            color: #333;
        }

        .product-list {
            display: flex;
            flex-wrap: wrap;
        }

        .product-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            width: 200px;
        }

        .no-products-message {
            color: #888;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Product List</h2>
        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (Product product : products) {
        %>
                    <div class="product-list">
                        <div class="product-item">
                            <h3><%= product.getName() %></h3>
                            <p>Description: <%= product.getDescription() %></p>
                            <p>Price: $<%= product.getPrice() %></p>
                            <!-- Add other product details as needed -->
                        </div>
                    </div>
        <%
                }
            } else {
        %>
                <p class="no-products-message">No products available.</p>
        <%
            }
        %>
    </div>
</body>
</html>
