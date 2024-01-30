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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
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
        .create-button a {
            text-decoration: none;
            padding: 10px 20px;
            font-size: 16px;
            background: rgb(2, 0, 36);
            background: linear-gradient(90deg, rgba(2, 0, 36, 1) 26%, rgba(2, 0, 36, 1) 36%, rgba(2, 0, 36, 1) 41%, rgba(2, 0, 36, 1) 43%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(23, 156, 14, 1) 100%, rgba(0, 212, 255, 1) 100%);
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .create-button a:hover {
            background: rgb(11, 9, 47);
            background: linear-gradient(90deg, rgba(11, 9, 47, 1) 0%, rgba(55, 107, 62, 1) 100%, rgba(43, 33, 218, 1) 100%, rgba(10, 78, 92, 1) 100%, rgba(47, 159, 63, 1) 100%, rgba(97, 167, 99, 1) 100%, rgba(114, 198, 110, 1) 100%, rgba(23, 156, 14, 1) 100%);
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
        .logout{
        color:black;
        width:100%;
        border:none;
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
            color: black;
        }

        .create-buttonx {
            background-color: green;
        }

        .create-button a {
            text-decoration: none;
        }

    </style>
</head>

<body>
    <!-- Navbar -->
    <div class="navbar">
        <div>
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
    <h1>Welcome, Admin!</h1>
    <!-- Create Product button -->
    

    <!-- Product Container -->
    <div class="product-container">
        <%
            List<Product> products = (List<Product>) session.getAttribute("products");
            if (products != null ) {
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
                <a href="edit-product.jsp?id=<%= product.getId() %>&name=<%= product.getName() %>&description=<%= product.getDescription() %>&price=<%= product.getPrice() %>&publicId=<%= product.getcloudinary_public_id() %>&imageUrl=<%= product.getCloudinaryImageUrl() %>">
                    <i class="fas fa-edit edit-icon"></i>
                </a>
                <a href="DeleteProductServlet?id=<%= product.getId() %>">
                    <i class="fas fa-trash delete-icon"></i>
                </a>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>

    <script>
        // JavaScript for dropdown functionality
        var dropdownLink = document.getElementById("dropdown-link");
        var dropdownContent = document.getElementById("dropdown-content");

        dropdownLink.addEventListener("click", function (event) {
            event.stopPropagation(); // Prevent the document click event from closing the dropdown
            dropdownContent.style.display = (dropdownContent.style.display === "block") ? "none" : "block";
        });

        // Close the dropdown when clicking outside of it
        document.addEventListener("click", function (event) {
            if (!event.target.matches('.navbar-link-dropdown')) {
                dropdownContent.style.display = "none";
            }
        });
    </script>

</body>

</html>