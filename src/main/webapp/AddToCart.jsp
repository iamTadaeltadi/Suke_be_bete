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
        .btn {
        padding:10px;
        background-color:green;
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
        
    </style>
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
