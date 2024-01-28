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
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        h2 {
            color: #333;
        }

        p.success {
            color: green;
        }

        p.error {
            color: red;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
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
                setTimeout(function() {
                    alertDiv.style.display = "none";
                }, 3000);
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

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
        <label for="userId">User ID:</label>
        <input type="text" id="userId" name="userId" value="<%= userId %>" readonly>

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
