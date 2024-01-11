<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Product</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }

        .container {
            width: 80%;
            margin: 0 auto;
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
            margin-bottom: 5px;
            color: #333;
        }

        input, textarea, button {
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            background-color: #4caf50;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Product</h2>
        <form action="createProductServlet" method="post" enctype="multipart/form-data">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" required>
            <label for="productDescription">Description:</label>
            <textarea id="productDescription" name="productDescription" required></textarea>
            <label for="productPrice">Price:</label>
            <input type="number" id="productPrice" name="productPrice" step="0.01" required>
            <label for="file">Choose File:</label>
            <input type="file" id="file" name="file" accept="image/*" required>
            <!-- Add other input fields as needed -->
            <button type="submit">Create Product</button>
        </form>
    </div>
</body>
</html>
