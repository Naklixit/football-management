package LoginAndRegister;

import jakarta.mail.PasswordAuthentication;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.Session;
import jakarta.mail.Authenticator;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import java.util.Properties;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Random;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

/**
 * Servlet implementation class ForgotPWServlet
 */
public class ForgotPWServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        // Tạo OTP ngẫu nhiên
        String otp = generateOTP();

        try {
            // Gửi OTP qua email
            sendEmail(email, otp);

            // Lưu OTP và email vào session để xác minh sau
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Chuyển hướng đến trang nhập OTP
            response.sendRedirect("VerifyOTPForgotPW.jsp");
        } catch (MessagingException e) {
            e.printStackTrace();
            out.println("<h3>Error sending email: " + e.getMessage() + "</h3>");
        }
    }

    // Phương thức tạo OTP
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo số ngẫu nhiên 6 chữ số
        return String.valueOf(otp);
    }

    // Phương thức gửi email
    private void sendEmail(String recipient, String otp) throws MessagingException {
        String sender = "ht127392@gmail.com";  // Thay bằng email của bạn
        String senderPassword = "ugai kgfu tvyh duib"; // Thay bằng mật khẩu ứng dụng email của bạn
        String host = "smtp.gmail.com";

        // Cấu hình SMTP server
        Properties properties = System.getProperties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // Tạo phiên làm việc SMTP
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(sender, senderPassword);
            }
        });

        // Tạo email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(sender));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        message.setSubject("OTP Verification");
        message.setText("Your OTP code is: " + otp);

        // Gửi email
        Transport.send(message);
    }
}