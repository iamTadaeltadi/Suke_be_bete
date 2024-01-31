<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Product</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .btn-green {
            background-color: #28a745;
            color: white;
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
        <a href="admin.jsp" class="navbar-link">Home</a>
            <a href="<%=request.getContextPath()%>/ShowOrdersServlet" class="navbar-link">Orders</a>
            <a href="<%=request.getContextPath()%>/MessageListServlet" class="navbar-link">Complaints</a>
            <a href="createProduct.jsp" class="navbar-link">Create Product</a>
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
    <div class="container">
        <div class="card mb-3">
            <div class="row no-gutters">
                <div class="col-md-6">
                    <!-- Add an image to the side of the form -->
                    <img src="https://img.freepik.com/free-vector/wearable-technology-isometric-composition-swatch_1284-25895.jpg?w=1060&t=st=1706462755~exp=1706463355~hmac=c3610c6eff3838ad748e208c83d71ee44163ea32d6abae57d81e11a25fd79085" class="card-img" alt="Illustration">
                </div>
                <div class="col-md-6">
                    <div class="card-body">
                        <h2 class="card-title">Create Product</h2>
                        <form action="createProductServlet" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="productName">Product Name:</label>
                                <input type="text" class="form-control" id="productName" name="productName" required>
                            </div>
                            <div class="form-group">
                                <label for="productDescription">Product Description:</label>
                                <textarea class="form-control" id="productDescription" name="productDescription" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="productPrice">Product Price:</label>
                                <input type="text" class="form-control" id="productPrice" name="productPrice" required>
                            </div>
                            <div class="form-group">
                                <label for="productImage">Product Image:</label>
                                <input type="file" class="form-control-file" id="productImage" name="file">
                            </div>
                            <button type="submit" class="btn btn-green">Create Product</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Add Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>