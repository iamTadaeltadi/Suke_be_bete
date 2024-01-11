package com.customer;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

public class CloudinaryConfig {
    public static final String CLOUD_NAME = "dwhpntyvy";
    public static final String API_KEY = "728449158519471";
    public static final String API_SECRET = "maUjDDvimthupDSGs1TKiHEZw0A";

    public static Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", CLOUD_NAME,
            "api_key", API_KEY,
            "api_secret", API_SECRET
    ));
}
