package com.customer;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


@WebServlet("/createProductServlet")
@MultipartConfig
public class CreateProductServlet extends HttpServlet {
    private static final HikariDataSource dataSource;
//    private static final Cloudinary cloudinary;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false");
        config.setUsername("tada");
        config.setPassword("tadael");
        config.setMaximumPoolSize(10);  // Adjust the maximum pool size based on your requirements

        dataSource = new HikariDataSource(config);

        // Cloudinary configuration
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Part filePart = request.getPart("file");

            // Extract other product details from the request
            String name = request.getParameter("productName");
            String description = request.getParameter("productDescription");
            double price;

            try {
                price = Double.parseDouble(request.getParameter("productPrice"));
            } catch (NumberFormatException e) {
                throw new ServletException("Invalid product price format.", e);
            }

            // Save the file on the server
            String serverFilePath = "/Online-Shoping/src/main/webapp/assets/uploadedImages/" + filePart.getSubmittedFileName();
            Files.copy(filePart.getInputStream(), Paths.get(serverFilePath).toAbsolutePath(), StandardCopyOption.REPLACE_EXISTING);

            // Use Cloudinary Java SDK to upload the file to Cloudinary
            Map<String, Object> uploadResult = CloudinaryConfig.cloudinary.uploader()
                    .upload(serverFilePath, ObjectUtils.emptyMap());
            // Extract Cloudinary details
            String publicId = (String) uploadResult.get("public_id");
            String cloudinaryUrl = (String) uploadResult.get("url");

            // Create a Product object with all details
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setcloudinary_public_id(publicId);
            product.setCloudinaryImageUrl(cloudinaryUrl);

            try (Connection connection = getConnection()) {
                // Create a ProductDAO with your database connection
                ProductDAO productDAO = new ProductDAO(connection);

                // Insert the product into the database
                boolean productCreated = productDAO.createProduct(product);

                if (productCreated) {
                    // Retrieve the list of all products
                    List<Product> allProducts = productDAO.getAllProducts();

                    // Set the list of all products in the session
                    HttpSession session = request.getSession();
                    session.setAttribute("products", allProducts);

                    // Redirect back to the admin page
                    response.sendRedirect("admin.jsp");
                } else {
                    response.getWriter().write("Failed to create product.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("File upload failed.");
        }
    }

    // Helper method to get a database connection using HikariCP
    private Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}