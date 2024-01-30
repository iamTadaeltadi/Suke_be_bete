<%@ page import="com.customer.AddToCart" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.StringJoiner" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }

        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 15px 0;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        img {
            width: 50px;
            height: 50px;
        }

        p {
            margin-top: 20px;
        }

        a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>
        <h2>Your Shopping Cart</h2>
    </header>

    <%-- Retrieve the cart from the session --%>
   <%
   Integer userId = (Integer) session.getAttribute("UserID");
        List<AddToCart> cart = (List<AddToCart>) session.getAttribute("cart");

        UUID uuid = UUID.randomUUID();
        String x = uuid.toString();
        int totPrice = 0;
        List<Integer> names = new ArrayList<>();
        
        if (cart == null || cart.isEmpty()) {
    %>
            <p>Your cart is empty.</p>
    <%
        } else {
    %>
            <table>
                <tr>
                    <th>Image</th>
                    <th>Total Price</th>
                    <th>Quantity</th>
                    <th>Product Name</th>
                </tr>
                <%
                    for (AddToCart item : cart) {
                        names.add(item.getProductId());
                        totPrice += item.getTotalPrice();
                %>
                        <tr>
                            <td><img src="<%= item.getCloudinaryImageUrl() %>" alt="Product Image"></td>
                            <td>$<%= item.getTotalPrice() %></td>
                            <td><%= item.getQuantity() %></td>
                            <td><%= item.getProductName() %></td>
                        </tr>
                <%
                    }
                %>
            </table>
    <%
        }
StringJoiner joiner = new StringJoiner(",");
        
        for (Integer number : names) {
            joiner.add(String.valueOf(number));
        }

        String xx = joiner.toString();

       
    %>

   <form method="POST" action="PaymentServlet" class="mt-3">
                           <input type="hidden" name="public_key" value="CHAPUBK_TEST-JXbHnk3UEBr5nxaP2u4M6OHlXUFsN4s6" />
				            <input type="hidden" name="tx_ref" value="<%= x %>" />
				            <input id = "amount" type="hidden" name="amount" value="<%= totPrice  %> " />
				            <input type="hidden" name="currency" value="ETB" />
				            <input type="hidden" name="email" value="<%= (String) session.getAttribute("email")  %>" />
				            <input type="hidden" name="first_name" value="<%= (String) session.getAttribute("username") %>" />
				            <input type="hidden" name="last_name" value="<%=  xx%>" />
				            <input id= "title" type="hidden" name="title" value="1" />
				            <input type="hidden" name="description" value="<%= userId%>" />
				            <input type="hidden" name="logo" value="https://chapa.link/asset/images/chapa_swirl.svg" />
				            <input type="hidden" name="return_url" value="http://localhost:8080/Online-Shoping/index.jsp" />
				            <input type="hidden" name="meta[title]" value="test" />
				            <input  id="xxx" type="hidden" name="callback_url" value="http://localhost:8080/Online-Shoping/ChapaCallbackServlet?tx_ref=<%=  x%>" />
				                            <!-- Your form fields go here -->
                            <button type="submit" class="btn btn-success btn-block"><i class="fas fa-shopping-bag"></i> Order</button>
  </form>
</body>
</html>
