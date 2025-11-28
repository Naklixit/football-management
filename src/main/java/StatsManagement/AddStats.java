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
 * Servlet implementation class AddStats
 */
public class AddStats extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        int playerId = Integer.parseInt(request.getParameter("player_id"));
        int goals = Integer.parseInt(request.getParameter("goals"));
        int yellowCards = Integer.parseInt(request.getParameter("yellow_cards"));
        int redCards = Integer.parseInt(request.getParameter("red_cards"));

        // Database connection variables
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // SQL query to insert new player stats
            String sql = "INSERT INTO PlayerStats (player_id, goals, yellow_cards, red_cards) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            
            // Set parameters for the prepared statement
            stmt.setInt(1, playerId);
            stmt.setInt(2, goals);
            stmt.setInt(3, yellowCards);
            stmt.setInt(4, redCards);
            
            // Execute the update (insert)
            int rowsAffected = stmt.executeUpdate();
            
            // Check if insertion was successful
            if (rowsAffected > 0) {
                // Redirect to player stats management page after success
                response.sendRedirect("StatsManagement.jsp");
            } else {
                // Handle the case where insertion fails
                response.getWriter().println("Failed to add player stats. Please try again.");
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