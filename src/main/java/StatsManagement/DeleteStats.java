package StatsManagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class DeleteStats
 */
public class DeleteStats extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get stat_id from the request parameter
        int statId = Integer.parseInt(request.getParameter("stat_id"));

        // Database connection variables
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // SQL query to delete player stats
            String sql = "DELETE FROM PlayerStats WHERE stat_id = ?";
            stmt = conn.prepareStatement(sql);
            
            // Set parameters for the prepared statement
            stmt.setInt(1, statId);
            
            // Execute the delete operation
            int rowsAffected = stmt.executeUpdate();
            
            // Check if deletion was successful
            if (rowsAffected > 0) {
                // Redirect to player stats management page after success
                response.sendRedirect("StatsManagement.jsp");
            } else {
                // Handle the case where deletion fails
                response.getWriter().println("Failed to delete player stats. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        } finally {
            // Close database resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}