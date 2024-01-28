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
System.out.println(userId);
Connection connection = null;
int quan = 4;
UUID uuid = UUID.randomUUID();

long timestamp = System.currentTimeMillis();

// Format timestamp as yyyyMMddHHmmss
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
String formattedTimestamp = dateFormat.format(new Date(timestamp));

// Generate a random 2-digit number
Random random = new Random();
int randomValue = random.nextInt(90) + 10;
String x = formattedTimestamp + randomValue;
/* String y = x.substring(0, 6);
String result  =  x;
System.out.println(result); */

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
    <!-- Include your CSS stylesheets, fonts, or other dependencies here -->

    <!-- Add Font Awesome CDN for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
        integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script>
    var quantity = <%= quan %>;
    var price = <%= product.getPrice() %>;

    document.addEventListener("DOMContentLoaded", function() {
        // Initial quantity value
        var quantityElement = document.getElementById("quantity");
        var o = document.getElementById("xxx");
        var title = document.getElementById("title");
        var amount = document.getElementById("amount");
        
        
        var quantity = 1; // Set initial quantity value
        

        // Update quantity function
        function updateQuantity() {
        	document.getElementById("title").value = quantity
            quantityElement.innerText = quantity;
        	document.getElementById("amount").value = quantity * price;
        	
        	
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
</head>
<body>
    <div style="text-align: center; margin: 20px;">
        <h2><%= product.getName() %></h2>
        <img src="<%= product.getCloudinaryImageUrl() %>" alt="<%= product.getName() %>" style="max-width: 100%; height: auto;">
        <p>Description: <%= product.getDescription() %></p>
        <p>Price: $<%= product.getPrice() %></p>

        <!-- Quantity control with Font Awesome icons -->
        <div style="display: flex; align-items: center; justify-content: center; margin-bottom: 20px;">
            <button id="minus" style="background-color: #3498db; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                <i class="fas fa-minus"></i>
            </button>
            <span id="quantity" style="margin: 0 10px; font-size: 1.2em;"><%= quan %> s</span> <!-- You can dynamically set the quantity here -->
            <button id="plus" style="background-color: #4caf50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        <!-- Add to Cart and Order buttons or any other details you want to display -->
        <button style="background-color: #4caf50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
            <i class="fas fa-cart-plus"></i> Add to Cart
        </button>

        <!-- <a id="orderButton" href="PaymentServlet" style="text-decoration: none; color: inherit;">
            <button style="background-color: #3498db; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                <i class="fas fa-shopping-bag"></i> Order
            </button>
        </a> -->
        <a>
        <form method="POST" action="PaymentServlet">
            <!-- Your other payment form fields -->
            <input type="hidden" name="public_key" value="CHAPUBK_TEST-JXbHnk3UEBr5nxaP2u4M6OHlXUFsN4s6" />
            <input type="hidden" name="tx_ref" value="<%= x %>" />
            <input id = "amount" type="hidden" name="amount" value="<%=  quan%> " />
            <input type="hidden" name="currency" value="ETB" />
            <input type="hidden" name="email" value="<%= (String) session.getAttribute("email")  %>" />
            <input type="hidden" name="first_name" value="<%= (String) session.getAttribute("username") %>" />
            <input type="hidden" name="last_name" value="<%=product.getId()%>" />
            <input id= "title" type="hidden" name="title" value="1" />
            <input type="hidden" name="description" value="<%=userId %>" />
            <input type="hidden" name="logo" value="https://chapa.link/asset/images/chapa_swirl.svg" />
            <input type="hidden" name="return_url" value="http://localhost:8080/Online-Shoping/index.jsp" />
            <input type="hidden" name="meta[title]" value="test" />
            
      
<%--             <input type="hidden" id="productId" name="productId" value="<%= quan %>" /><!--  -->
 --%>            <!-- Add other necessary hidden fields -->

            <!-- Add the callback URL -->
            <input  id="xxx" type="hidden" name="callback_url" value="http://localhost:8080/Online-Shoping/ChapaCallbackServlet?tx_ref=<%=  x%>" />
            
            <button type="submit"><i class="fas fa-shopping-bag"></i> Order</button>
        </form>
        
    </div>
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
