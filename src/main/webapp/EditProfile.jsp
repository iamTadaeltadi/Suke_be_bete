<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.customer.User" %>
<%@ page import="com.customer.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Load the JDBC driver (replace "com.mysql.cj.jdbc.Driver" with the actual driver class for your database)
    String jdbcUrl = "jdbc:mysql://localhost:3306/ONLINESHOP";
    String use = "tada";
    String password = "tadael";

    // Establish a database connection
    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, use, password);
        // Set the connection as an attribute in the request
        request.setAttribute("connection", connection);

        // Retrieve the userId from the session
        Integer userId = (Integer) session.getAttribute("UserID");

        UserDAO userDAO = new UserDAO(connection);
        User user = userDAO.getUserById(userId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
            color: #333;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-top: 20px;
        }

        p.success {
            color: #4CAF50;
            text-align: center;
        }

        p.error {
            color: #f44336;
            text-align: center;
        }

        form {
            max-width: 600px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .alert {
            padding: 15px;
            background-color: #f44336;
            color: white;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
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
            background: rgb(2,0,36);
            background: linear-gradient(90deg, rgba(2,0,36,1) 26%, rgba(2,0,36,1) 36%, rgba(2,0,36,1) 41%, rgba(2,0,36,1) 43%, rgba(97,167,99,1) 100%, rgba(114,198,110,1) 100%, rgba(23,156,14,1) 100%, rgba(0,212,255,1) 100%);
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
        }

        .navbar-link {
            color: #fff;
            text-decoration: none;
            padding: 14px 16px;
            transition: background-color 0.3s ease;
        }

        .navbar-link:hover {
        background: rgb(0,36,5);
background: linear-gradient(90deg, rgba(0,36,5,1) 17%, rgba(43,33,218,1) 23%, rgba(2,0,36,1) 23%, rgba(2,0,36,1) 43%, rgba(97,167,99,1) 100%, rgba(114,198,110,1) 100%, rgba(23,156,14,1) 100%, rgba(0,212,255,1) 100%);
           }

        .logout {
            color: #fff;
            text-decoration: none;
            padding: 14px 16px;
            transition: background-color 0.3s ease;
        }

        .logout:hover {
            background-color: rgba(23,156,14,1);
        }
    </style>
    <script>
        function validateForm() {
            var username = document.getElementById("username").value;
            var email = document.getElementById("email").value;
            var address = document.getElementById("address").value;
            var phoneNumber = document.getElementById("phoneNumber").value;

            if (username.trim() === "" || email.trim() === "" || address.trim() === "" || phoneNumber.trim() === "") {
                var alertDiv = document.createElement("div");
                alertDiv.className = "alert";
                alertDiv.innerHTML = "Username, email, address, and phone number are required fields. Please fill them in.";
                document.body.appendChild(alertDiv);
                setTimeout(function () {
                    alertDiv.style.display = "none";
                }, 3000);
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="navbar">
        <div>
            <a href="EditProfile.jsp" class="navbar-link">Edit Profile</a>
            <a href="<%=request.getContextPath()%>/ShowOrdersServlet" class="navbar-link">Orders</a>
            <a href="<%=request.getContextPath()%>/MessageListServlet" class="navbar-link">Complaints</a>
        </div>
        <a href="#" class="logout">
            <!-- Logout icon (you can replace this with your actual icon or image) -->
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>

<h2>Edit Profile</h2>

<%
    // Check if the userId exists in the session
    if (user != null) {
        // Handle form submission
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String phoneNumber = request.getParameter("phoneNumber");

            // Update user information in the database
            boolean updateSuccessful = userDAO.updateUser(userId, username, email, address, phoneNumber);

            if (updateSuccessful) {
                out.println("<p class='success'>Profile updated successfully!</p>");
                // Update the user object in the session with the new information
                user.setUsername(username);
                user.setEmail(email);
                user.setAddress(address);
                user.setPhoneNumber(phoneNumber);
            } else {
                out.println("<p class='error'>Failed to update profile. Please try again.</p>");
            }
        }

        // Retrieve user information using the userId
        String existingUsername = user.getUsername();
        String existingEmail = user.getEmail();
        String existingAddress = user.getAddress();
        String existingPhoneNumber = user.getPhoneNumber();
%>
<form action="" method="post" onsubmit="return validateForm();">
    <!-- Display current user information -->
    

    <label for="username">Username:</label>
    <input type="text" id="username" name="username" value="<%= existingUsername %>" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="<%= existingEmail %>" required>

    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="<%= existingAddress %>">

    <label for="phoneNumber">Phone Number:</label>
    <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= existingPhoneNumber %>">

    <label for="role">Role:</label>
    <input type="text" id="role" name="role" value="<%= user.getRole() %>" readonly>

    <input type="submit" value="Save Changes">
</form>
<%
    } else {
%>
<p class="error">No user information available. Please log in.</p>
<%
    }
%>

</body>
</html>

<%
} catch (SQLException e) {
    e.printStackTrace();
    // Handle database connection error
%>
<p class="error">Failed to establish a database connection. Please try again.</p>
<%
} finally {
    // Close the connection if it is still open
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            // Handle the exception if needed
        }
    }
}
%>
