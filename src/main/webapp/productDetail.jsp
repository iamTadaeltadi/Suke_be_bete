<%@ page import="java.util.List" %>
<%@ page import="com.customer.Product" %>
<%@ page import="com.customer.ProductDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // Get the product ID from the request parameter
    int productId = Integer.parseInt(request.getParameter("id"));
    Integer userId = (Integer) session.getAttribute("UserID");
    Connection connection = null;
    int quan = 1;
    UUID uuid = UUID.randomUUID();

    long timestamp = System.currentTimeMillis();

    // Format timestamp as yyyyMMddHHmmss
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
    String formattedTimestamp = dateFormat.format(new Date(timestamp));

    // Generate a random 2-digit number
    Random random = new Random();
    int randomValue = random.nextInt(90) + 10;
    String x = formattedTimestamp + randomValue;

    try {
        // Fetch the product details from the database
        // Provide your MySQL database connection details here
        String jdbcUrl = "jdbc:mysql://localhost:3306/ONLINESHOP";
        String dbUsername = "tada";
        String dbPassword = "tadael";

        connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        ProductDAO productDAO = new ProductDAO(connection);
        Product product = productDAO.getProductById(productId);

        // Check if the product exists
        if (product != null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
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

    <!-- Add Font Awesome CDN for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
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
    
    <div class="container my-4">
    <div class="card shadow-sm">
        <div class="row no-gutters">
            <div class="col-md-6">
                <img class="card-img" src="<%= product.getCloudinaryImageUrl() %>" alt="<%= product.getName() %>">
            </div>
            <div class="col-md-6 bg-white p-3">
                <div class="card-body">
                    <h2 class="card-title text-dark"><%= product.getName() %></h2>
                    <p class="card-text mb-2"><strong>Description:</strong> <%= product.getDescription() %></p>
                    <h4 id ="totalprice"  class="card-text text-success mb-3"><strong>Price:</strong> $<%= product.getPrice()  %></h4>

                    <div class="btn-group" role="group" aria-label="Quantity control">
                        <button type="button" class="btn btn-outline-secondary btn-sm rounded-circle" id="minus" onclick="decreaseQuantity();">
                            <i class="fas fa-minus"></i>
                        </button>
                        <span id="quantity" class="btn btn-light"><%= quan %></span>
                        <button type="button" class="btn btn-outline-secondary btn-sm rounded-circle" id="plus" onclick="increaseQuantity();">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>

                    
                    
                     <form method="post" action="AddToCartServlet">
        <input type="hidden" name="productId" value="<%= product.getId() %>">
        <input type="hidden" id="oo" name="quantity" value="1">
       <button type="submit" class="btn btn-success btn-block">
        <i class="fas fa-cart-plus"></i> Add to Cart
    </button>
    </form>

                        <form method="POST" action="PaymentServlet" class="mt-3">
                           <input type="hidden" name="public_key" value="CHAPUBK_TEST-JXbHnk3UEBr5nxaP2u4M6OHlXUFsN4s6" />
				            <input type="hidden" name="tx_ref" value="<%= x %>" />
				            <input id = "amount" type="hidden" name="amount" value="<%= product.getPrice() %> " />
				            <input type="hidden" name="currency" value="ETB" />
				            <input type="hidden" name="email" value="<%= (String) session.getAttribute("email")  %>" />
				            <input type="hidden" name="first_name" value="<%= (String) session.getAttribute("username") %>" />
				            <input type="hidden" name="last_name" value="<%=product.getId()%>" />
				            <input id= "title" type="hidden" name="title" value="1" />
				            <input type="hidden" name="description" value="<%=userId %>" />
				            <input type="hidden" name="logo" value="https://chapa.link/asset/images/chapa_swirl.svg" />
				            <input type="hidden" name="return_url" value="http://localhost:8080/Online-Shoping/index.jsp" />
				            <input type="hidden" name="meta[title]" value="test" />
				            <input  id="xxx" type="hidden" name="callback_url" value="http://localhost:8080/Online-Shoping/ChapaCallbackServlet?tx_ref=<%=  x%>" />
				                            <!-- Your form fields go here -->
                            <button type="submit" class="btn btn-success btn-block"><i class="fas fa-shopping-bag"></i> Order</button>
                        </form>
				</div>
            </div>
        </div>
    </div>
</div>
<script>
    var quantity = <%= quan %>;
    var price = <%= product.getPrice() %>;

    document.addEventListener("DOMContentLoaded", function() {
        // Initial quantity value
        var quantityElement = document.getElementById("quantity");
        var o = document.getElementById("xxx");
        var title = document.getElementById("title");
        var amount = document.getElementById("amount");
        var min =  document.getElementById("oo");
        
        var totalPrice = document.getElementById("totalprice");
        
        
        
        var quantity = 1; // Set initial quantity value
        

        // Update quantity function
        function updateQuantity() {
        	document.getElementById("title").value = quantity
            quantityElement.innerText = quantity;
        	document.getElementById("amount").value = quantity * price;
        	min.value = quantity;
        	totalPrice.innerText  = <%= product.getPrice() %> *quantity;
        	
        	
          <%--   "<%= request.getContextPath() %>/OrderServlet?productId=<%= product.getId() %>&quantity=" + quan; --%>
          
        }

        // Event listeners
        document.getElementById("minus").addEventListener("click", function() {
            if (quantity > 1) {
                quantity--;
                updateQuantity();
            }
        });

        document.getElementById("plus").addEventListener("click", function() {
            quantity++;
            updateQuantity();
        });

        // Initial update
        updateQuantity();
    });
    </script>

    <!-- Add Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>

    <script>
    
        function decreaseQuantity() {
            let quantity = document.getElementById('quantity').innerText;
            if (quantity > 1) {
                document.getElementById('quantity').innerText = quantity - 1;
            }
        }

        function increaseQuantity() {
            let quantity = document.getElementById('quantity').innerText;
            document.getElementById('quantity').innerText = parseInt(quantity) + 1;
        }
    </script>
</body>
</html>
<%
        } else {
            // Handle the case where the product with the given ID is not found
            response.sendRedirect("errorPage.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle the exception
        response.sendRedirect("errorPage.jsp");
    } finally {
        // Close the connection in a finally block to ensure it's always closed
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
        }
    }
%>

