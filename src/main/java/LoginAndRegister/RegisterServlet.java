package LoginAndRegister;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response type
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmpassword");

        // Validate password match
        if (!password.equals(confirmPassword)) {
            out.println("<h3 style='color:red;'>Passwords do not match!</h3>");
            request.getRequestDispatcher("Register.jsp").include(request, response);
            return;
        }

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/cuoi_ki";
        String dbUser = "root";
        String dbPassword = "15022004";

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Insert user into database
            String sql = "INSERT INTO user (email, password) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                out.println("<h3>Registration successful!</h3>");
                out.println("<a href='Login.jsp'><button>Go to Login</button></a>");
            } else {
                out.println("<h3>Registration failed. Please try again.</h3>");
                request.getRequestDispatcher("Register.jsp").include(request, response);
            }

            // Close connection
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>An error occurred: " + e.getMessage() + "</h3>");
        }
    }
}