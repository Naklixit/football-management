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
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cuoi_ki";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "15022004";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        try {
            // Tải driver JDBC MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Kết nối cơ sở dữ liệu
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Kiểm tra email và mật khẩu
                String query = "SELECT * FROM user WHERE email = ? AND password = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Tạo OTP
                    String otp = generateOTP();
                    sendEmail(email, otp);

                    // Lưu OTP vào session
                    request.getSession().setAttribute("otp", otp);
                    request.getSession().setAttribute("email", email);

                    // Điều hướng đến trang OTP
                    response.sendRedirect("VerifyOTP.jsp");
                } else {
                    out.println("<h3>Invalid email or password.</h3>");
                }
            }
        } catch (ClassNotFoundException e) {
            out.println("<h3>Error: JDBC Driver not found!</h3>");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }

    // Phương thức tạo OTP
    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo số ngẫu nhiên 6 chữ số
        return String.valueOf(otp);
    }

    // Phương thức gửi email OTP
    private void sendEmail(String recipient, String otp) throws MessagingException {
        String sender = "ht127392@gmail.com";
        String host = "smtp.gmail.com"; // Sử dụng SMTP server của bạn
        String password = "ugai kgfu tvyh duib";

        Properties properties = System.getProperties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(sender, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(sender));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        message.setSubject("Your OTP Code");
        message.setText("Your OTP code for login is: " + otp);

        Transport.send(message);
    }
}