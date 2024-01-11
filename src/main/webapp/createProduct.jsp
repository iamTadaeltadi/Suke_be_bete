<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Product</title>
</head>
<body>
    <h2>Create Product</h2>
    
    <form action="createProductServlet" method="post" enctype="multipart/form-data">
        <!-- Your existing product fields -->
        <label for="name">Product Name:</label>
        <input type="text" name="productName" required><br>
        <label for="description">Product Description:</label>
        <textarea name="productDescription" required></textarea><br>
        <label for="price">Product Price:</label>
        <input type="text" name="productPrice" required><br>
        <label for="image">Product Image:</label>
        <<input type="file" name="file" />
          <input type="submit" value="Upload" />
        <br>
        <input type="submit" value="Create Product">
    </form>
</body>
</html>
