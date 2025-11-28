package LoginAndRegister;

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

/**
 * Servlet implementation class ChangePasswordServlet
 */
public class ChangePasswordServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cuoi_ki";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "15022004";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        if (newPassword.equals(confirmPassword)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    String query = "UPDATE user SET password = ? WHERE email = ?";
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, newPassword);
                    stmt.setString(2, email);
                    int rowsUpdated = stmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<h3>Password changed successfully!</h3>");
                       // response.sendRedirect("index.jsp");
                    } else {
                        out.println("<h3>Error updating password. Please try again.</h3>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        } else {
            out.println("<h3>Passwords do not match. Please try again.</h3>");
            request.getRequestDispatcher("ChangePassword.jsp").include(request, response);
        }
    }
}
