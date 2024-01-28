package com.customer;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/EmailServlet")
public class EmailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String id = request.getParameter("id");
//        String to = request.getParameter("emailReceiver");
//        String from = request.getParameter("emailSender");
        String subject = request.getParameter("subject");
        String body = request.getParameter("message");
//        String password = request.getParameter("password");

        String status = Mail.sendMail("123", "tadaelshew@gmail.com", "tadaelshewaregagebre30@gmail.com", subject, body, true, "lalibela");

        request.setAttribute("message", status);
        request.getRequestDispatcher("/confirmation.jsp").forward(request, response);
    }
}
