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
    </style>
</head>
<body>
<div class="navbar">
        <a href="EditProfile.jsp">Edit Profile</a>
       <a href="ShowOrdersServlet">Orders</a>

        <a href="<%=request.getContextPath()%>/MessageListServlet">Complaints</a>
        <!-- Add more links as needed -->
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