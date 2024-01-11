<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Signup Page</title>
</head>
<body>

    <h2>Signup</h2>

    <form action="SignupServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
        <br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>

        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <br>

        <label for="phoneNumber">Phone Number:</label>
        <input type="tel" id="phoneNumber" name="phoneNumber" required>
        <br>

        <!-- Add more fields as needed -->

        <input type="submit" value="Sign Up">
    </form>

</body>
</html>
