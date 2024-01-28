package com.customer;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {String publicKey = request.getParameter("public_key");
            String txRef = request.getParameter("tx_ref");
            String amount = request.getParameter("amount");
            String currency = request.getParameter("currency");
            String email = request.getParameter("email");
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String logo = request.getParameter("logo");
            String callbackUrl = request.getParameter("callback_url");
            String returnUrl = request.getParameter("return_url");
            String metaTitle = request.getParameter("meta[title]");

            // Construct the request to Chapa API
            String apiUrl = "https://api.chapa.co/v1/hosted/pay";
            String requestBody = "public_key=" + publicKey +
                    "&tx_ref=" + txRef +
                    "&amount=" + amount +
                    "&currency=" + currency +
                    "&email=" + email +
                    "&first_name=" + firstName +
                    "&last_name=" + lastName +
                    "&title=" + title +
                    "&description=" + description +
                    "&logo=" + logo +
                    "&callback_url=" + callbackUrl +
                    "&return_url=" + returnUrl +
                    "&meta[title]=" + metaTitle;

            // Make the API call using HttpClient
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest httpRequest = HttpRequest.newBuilder()
                    .uri(URI.create(apiUrl))
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();
            
            try {
                HttpResponse<String> apiResponse = client.send(httpRequest, HttpResponse.BodyHandlers.ofString());

                // Check if the response is a redirect
                if (apiResponse.statusCode() == 302) {
                    String redirectUrl = apiResponse.headers().firstValue("Location").orElse("");
                    // Redirect the user to the Chapa payment page
                    response.sendRedirect(redirectUrl);
                } else {
                    // Handle other status codes or responses
                    PrintWriter out = response.getWriter();
                    out.println("API Response: " + apiResponse.body());
                    // Optionally, you can handle other cases here
                }
            } catch (IOException | InterruptedException e) {
                // Handle exceptions (add proper error handling)
                e.printStackTrace();
            }

    }
}
