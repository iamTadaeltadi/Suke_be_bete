<%@ page import="java.util.List" %>
<%@ page import="com.customer.Product" %>
<%@ page import="com.customer.ProductDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>

<%
// Get the product ID from the request parameter
int productId = Integer.parseInt(request.getParameter("id"));

Connection connection = null;
int quan = 1;

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

    document.addEventListener("DOMContentLoaded", function() {
        // Initial quantity value

        // Elements
        var quantityElement = document.getElementById("quantity");
        var minusButton = document.getElementById("minus");
        var plusButton = document.getElementById("plus");

        // Event listeners
        minusButton.addEventListener("click", function() {
            if (quantity > 1) {
                quantity--;
                updateQuantity();
            }
        });

        plusButton.addEventListener("click", function() {
            quantity++;
            updateQuantity();
        });

        // Function to update quantity in the UI
        function updateQuantity() {
            quantityElement.innerText = quantity;
            // Remove 'int' from the following line to update the global variable
            quan = quantity;
            orderButton.href = "<%= request.getContextPath() %>/OrderServlet?productId=<%= product.getId() %>&quantity=" + quan;
        }
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
            <span id="quantity" style="margin: 0 10px; font-size: 1.2em;"><%= quan %></span> <!-- You can dynamically set the quantity here -->
            <button id="plus" style="background-color: #4caf50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        <!-- Add to Cart and Order buttons or any other details you want to display -->
        <button style="background-color: #4caf50; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
            <i class="fas fa-cart-plus"></i> Add to Cart
        </button>

        <a id="orderButton" href="<%= request.getContextPath() %>/OrderServlet?productId=<%= product.getId() %>&quantity=<%= quan %>" style="text-decoration: none; color: inherit;">
            <button style="background-color: #3498db; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; transition: background-color 0.3s;">
                <i class="fas fa-shopping-bag"></i> Order
            </button>
        </a>

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
