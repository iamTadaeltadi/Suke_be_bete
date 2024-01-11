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

import com.cloudinary.utils.ObjectUtils;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/EditProductServlet")
@MultipartConfig
public class EditProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/ONLINESHOP?useSSL=false");
        config.setUsername("tada");
        config.setPassword("tadael");
        config.setMaximumPoolSize(10);

        dataSource = new HikariDataSource(config);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("productName");
        String description = request.getParameter("productDescription");
        double price = Double.parseDouble(request.getParameter("productPrice"));

        Part filePart = request.getPart("file");

        try (Connection connection = dataSource.getConnection()) {
            ProductDAO productDAO = new ProductDAO(connection);
            Product product = productDAO.getProductById(productId);

            // Delete the old image from Cloudinary
            deleteImageFromCloudinary(product.getcloudinary_public_id());

            // Update product details
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);

            // Handle file upload for the new image
            if (filePart != null && filePart.getSize() > 0) {
                // Save the file on the server
                String serverFilePath = "/Users/tadaelshewaregagebre/eclipse-workspace/Online-Shoping/src/main/webapp/assets/uploadedImages/"
                        + filePart.getSubmittedFileName();
                Files.copy(filePart.getInputStream(), Paths.get(serverFilePath), StandardCopyOption.REPLACE_EXISTING);

                // Use Cloudinary Java SDK to upload the new image to Cloudinary
                Map<String, Object> uploadResult = CloudinaryConfig.cloudinary.uploader()
                        .upload(serverFilePath, ObjectUtils.emptyMap());

                // Extract Cloudinary details for the new image
                String publicId = (String) uploadResult.get("public_id");
                String cloudinaryUrl = (String) uploadResult.get("url");

                // Set the new image details
                product.setcloudinary_public_id(publicId);
                product.setCloudinaryImageUrl(cloudinaryUrl);
            }

            // Update product in the database
            productDAO.updateProduct(product);

            // Retrieve the updated list of all products
            List<Product> allProducts = productDAO.getAllProducts();

            // Set the list of all products in the session
            HttpSession session = request.getSession();
            session.setAttribute("products", allProducts);

            // Redirect back to the admin page
            response.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception
            response.sendRedirect("errorPage.jsp");
        }
    }

    // Helper method to delete an image from Cloudinary
    private void deleteImageFromCloudinary(String publicId) {
        try {
            if (publicId != null) {
                CloudinaryConfig.cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
            }
        } catch (IOException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log the error)
        }
    }
}