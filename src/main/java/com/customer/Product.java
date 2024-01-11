package com.customer;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String cloudinaryImageUrl;
    private String cloudinary_public_id;// New field for Cloudinary image URL

    // Constructors

    // Default constructor
    public Product() {
    }

    // Parameterized constructor
    public Product(int id, String name, String description, double price, String cloudinaryImageUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.cloudinaryImageUrl = cloudinaryImageUrl;
    }

    // Getters and Setters

    public int getId() {
        return id;
    }
    public String getcloudinary_public_id() {
        return cloudinary_public_id;
    }
    public void setcloudinary_public_id(String  cloudinary_public_id ) {
         this.cloudinary_public_id = cloudinary_public_id;
    }
    

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCloudinaryImageUrl() {
        return cloudinaryImageUrl;
    }

    public void setCloudinaryImageUrl(String cloudinaryImageUrl) {
        this.cloudinaryImageUrl = cloudinaryImageUrl;
    }
}
