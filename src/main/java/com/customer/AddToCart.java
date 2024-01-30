package com.customer;

public class AddToCart {
    private String cloudinaryImageUrl;
    private double totalPrice;
    private int quantity;
    private String productName;
    private int productId;
    private String sellerName;

    // Constructors
    public AddToCart(String cloudinaryImageUrl, double totalPrice, int quantity, String productName, int productId) {
        this.cloudinaryImageUrl = cloudinaryImageUrl;
        this.totalPrice = totalPrice;
        this.quantity = quantity;
        this.productName = productName;
        this.productId = productId;
        
    }

   

	// Getters and Setters
    public String getCloudinaryImageUrl() {
        return cloudinaryImageUrl;
    }

    public void setCloudinaryImageUrl(String cloudinaryImageUrl) {
        this.cloudinaryImageUrl = cloudinaryImageUrl;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    // Other methods, if needed
}
