<%@ page import="com.customer.Product" %>
<%@ page import="java.util.List" %>

<%
    // Check if the user has admin privileges
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Admin Page</title>
    <style>
    .navbar {
        background-color: #333;
        overflow: hidden;
    }

    .navbar a {
        float: left;
        display: block;
        color: #f2f2f2;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
    }

    .navbar a:hover {
        background-color: #ddd;
        color: black;
    }

    /* Section styles */
    .section {
        background-color: #f4f4f4;
        padding: 20px;
        margin: 20px 0;
        border-radius: 8px;
    }

    h2.section-title {
        color: #333;
    }
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

        ul {
            list-style-type: none;
            padding: 0;
            margin: 20px 0;
            text-align: center;
        }

        li {
            display: inline-block;
            margin-right: 20px;
        }

        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 15px;
            padding: 15px;
            max-width: 300px;
            width: 100%;
        }

        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }

        .product-details {
            margin-top: 15px;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        .product-description {
            color: #666;
            margin-bottom: 10px;
        }

        .product-price {
            color: #4caf50;
            font-size: 16px;
        }

        .product-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }

        .edit-icon,
        .delete-icon {
            font-size: 24px;
            color: #333;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .edit-icon:hover,
        .delete-icon:hover {
            color: #4caf50;
        }

        /* Style for the Create Product button */
        .create-button {
            text-align: center;
            margin-bottom: 20px;
        }

        .create-button a {
            text-decoration: none;
        }

        .create-button button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .create-button button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>

    <h1>Welcome, Admin!</h1>

    <!-- Create Product button -->
    
    <div class="navbar">
        <a href="#editProfile">Edit Profile</a>
       <a href="ShowOrdersServlet">Orders</a>

        <a href="#complaints">Complaints</a>
        <!-- Add more links as needed -->
    </div>

  

    <!-- Create Product button -->
    <div class="create-button">
        <a href="createProduct.jsp" style="padding:20px">
        
            <button>Create Product</button>
        </a>
    </div>

    

    <div class="product-container">
        <%
            List<Product> products = (List<Product>) session.getAttribute("products");
            if (products != null) {
                for (Product product : products) {
        %>
        <div class="product-card">
            <img class="product-image" src="<%= product.getCloudinaryImageUrl() %>" alt="<%= product.getName() %>" />
            <div class="product-details">
                <div class="product-title"><%= product.getName() %></div>
                <div class="product-description"><%= product.getDescription() %></div>
                <div class="product-price">$<%= product.getPrice() %></div>
            </div>
            <div class="product-actions">
            <a href="edit-product.jsp?id=<%= product.getId() %>&name=<%= product.getName() %>&description=<%= product.getDescription() %>&price=<%= product.getPrice() %>&publicId=<%= product.getcloudinary_public_id() %>&imageUrl=<%= product.getCloudinaryImageUrl() %>"><i class="fas fa-edit edit-icon"></i></a>
            
                
                <a href="DeleteProductServlet?id=<%= product.getId() %>"><i
                        class="fas fa-trash delete-icon"></i></a>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>

    <!-- You can add more content, such as a table to display products -->

    <script>
      
    </script>

</body>

</html>
