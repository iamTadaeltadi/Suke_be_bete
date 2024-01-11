import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.mysql.cj.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.PasswordAuthentication;
import java.util.Properties;

@WebServlet("/SendEmailServlet")
public class SendEmailServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Sender's email credentials
        String fromEmail = "your-email@gmail.com";
        String password = "your-email-password";

        // Recipient's email address
        String toEmail = "recipient-email@example.com";

        // Read form data
        String name = request.getParameter("name");
        String userEmail = request.getParameter("email");
        String messageText = request.getParameter("message");

        // Set mail properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com"); // You can use another SMTP server
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Get the default Session object.
        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(fromEmail));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            // Set Subject: header field
            message.setSubject("Message from Contact Form");

            // Now set the actual message
            String emailContent = "Name: " + name + "\nEmail: " + userEmail + "\nMessage:\n" + messageText;
            message.setText(emailContent);

            // Send message
            Transport.send(message);

            out.println("<h2>Email sent successfully!</h2>");

        } catch (MessagingException mex) {
            mex.printStackTrace();
            out.println("<h2>Error: Unable to send email</h2>");
        }
    }
}
