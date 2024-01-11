package com.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private Connection connection;

    public ProductDAO(Connection connection) {
        this.connection = connection;
    }

    // Get a list of all products from the database
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();

        try {
            String query = "SELECT * FROM products";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query);
                 ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    Product product = new Product();
                    product.setId(resultSet.getInt("product_id"));
                    product.setName(resultSet.getString("name"));
                    product.setDescription(resultSet.getString("description"));
                    product.setPrice(resultSet.getDouble("price"));
//                    product.setCloudinaryImageUrl(resultSet.getString("cloudinary_image_url"));
                    product.setcloudinary_public_id( resultSet.getString("cloudinary_public_id")); // Fix method name
                    product.setCloudinaryImageUrl( resultSet.getString("cloudinary_url"));
                    // Set other product properties as needed setcloudinary_public_id setCloudinaryImageUrl

                    productList.add(product);
                }
               
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return productList;
    }

    // Get a product by its ID
    public Product getProductById(int productId) {
        Product product = null;
        

        try {
            String query = "SELECT * FROM products WHERE product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, productId);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        product = new Product();
                        product.setId(resultSet.getInt("product_id"));
                        product.setName(resultSet.getString("name"));
                        product.setDescription(resultSet.getString("description"));
                        product.setPrice(resultSet.getDouble("price"));
                        product.setCloudinaryImageUrl(resultSet.getString("cloudinary_url"));
                        
                        // Set other product properties as needed
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return product;
    }

    // Delete a product by its ID
    public boolean deleteProduct(int productId) {
        try {
            String query = "DELETE FROM products WHERE product_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, productId);
                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return false;
    }

    // Update/Edit a product
    public boolean updateProduct(Product product) {
        try {
            String query = "UPDATE products SET name=?, description=?, price=?, cloudinary_public_id=?, cloudinary_url=? WHERE product_id=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, product.getName());
                preparedStatement.setString(2, product.getDescription());
                preparedStatement.setDouble(3, product.getPrice());
                preparedStatement.setString(4, product.getcloudinary_public_id()); // Fix method name
                preparedStatement.setString(5, product.getCloudinaryImageUrl());
                preparedStatement.setInt(6, product.getId()); // Assuming the id is an integer, adjust accordingly

                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
        }

        return false;
    }

    public boolean createProduct(Product product) {
        // Existing code
        String query = "INSERT INTO products (name, description, price, cloudinary_public_id, cloudinary_url) " +
                       "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setString(4, product.getcloudinary_public_id());
            preparedStatement.setString(5, product.getCloudinaryImageUrl());

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Retrieve the generated keys (if any)
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        product.setId(generatedKeys.getInt(1)); // Assuming the id is an integer, adjust accordingly
                    }
                }
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception according to your application's needs
            return false;
        }
    }

    
}
