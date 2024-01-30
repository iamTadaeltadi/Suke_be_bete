<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Contact Us</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column; 
            align-items: center;
            min-height: 100vh;
        }

        .navbar {
            background-color: #343a40;
            overflow: hidden;
            width: 100%; 
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-size: 18px;
        }

        .navbar a:hover {
            background-color: #495057;
            color: white;
        }

        .navbar a.active {
            background-color: #28a745;
            color: white;
        }

        form {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin-top: 30px; 
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            color: #495057;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #495057;
            font-weight: bold;
        }

        input,
        textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            background-color: #f8f9fa;
            color: #495057;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        .svg-container {
            text-align: center;
            margin-bottom: 20px;
        }

        .svg-image {
            width: 150px; /* Adjust the size as needed */
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="index.jsp"><i class="fas fa-home"></i> Home</a>
        <a href="EditProfile.jsp"><i class="fas fa-user"></i> Edit Profile</a>
        <a href="<%= request.getContextPath() %>/ListOrdersServlet"><i class="fas fa-shopping-bag"></i> Orders</a>
        <a href="#" class="active"><i class="fas fa-phone"></i> Contact Us</a>
    </div>

     <!-- Replace the placeholder SVG code with an external SVG image -->
<div class="svg-container">
    <img class="svg-image" src="/Online-Shoping/src/main/webapp/assets/img/undraw_Contact_us_re_4qqt.png">
</div>


    <form action="SendEmailServlet" method="post">
        <h1>Contact Us</h1> 
        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Your Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="message">Message or any Complain:</label>
        <textarea id="message" name="message" rows="4" required></textarea>

        <input type="submit" value="Send Email">
    </form>
</body>
</html>
