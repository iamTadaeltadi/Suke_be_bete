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
    padding: 30px 0; /* Adjusted padding */
    position: sticky;
    top: 0;
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

        form {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        width: 400px;
        margin: 30px auto; /* Center the form horizontally */
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
        <div>
        <a href="index.jsp" class="navbar-link"><i class="fas fa-home"></i> Home</a>
            <a href="<%=request.getContextPath()%>/ListOrdersServlet" class="navbar-link">Orders</a>
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
