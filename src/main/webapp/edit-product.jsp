<!-- edit-product.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.customer.Product" %>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            width: 50%;
            margin: 0 auto;
        }

        label {
            margin-bottom: 10px;
            color: #333;
        }

        input, textarea, button {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            background-color: #4caf50;
            color: white;
            cursor: pointer;
        }

        .image-preview {
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
            border-radius: 4px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Product</h2>
        
       <form action="EditProductServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
    <label for="productName">Product Name:</label>
    <input type="text" id="productName" name="productName" value="<%= request.getParameter("name") %>" required>
    <label for="productDescription">Description:</label>
    <textarea id="productDescription" name="productDescription" required><%= request.getParameter("description") %></textarea>
    <label for="productPrice">Price:</label>
    <input type="number" id="productPrice" name="productPrice" value="<%= request.getParameter("price") %>" step="0.01" required>
    <label for="file">Update Image:</label>
    <input type="file" id="file" name="file">
    <img class="image-preview" src="<%= request.getParameter("imageUrl") %>" alt="<%= request.getParameter("name") %>" />
    <button type="submit">Update Product</button>
</form>
       
    </div>
</body>
</html>
