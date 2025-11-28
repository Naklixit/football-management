package StatsManagement;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.cj.xdevapi.Statement;

/**
 * Servlet implementation class EditStats
 */
public class EditStats extends HttpServlet {
    // Handle GET requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get stat_id from the request parameter
        int statId = Integer.parseInt(request.getParameter("stat_id"));

        // Database connection variables
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // SQL query to retrieve player stats based on stat_id
            String sql = "SELECT * FROM PlayerStats WHERE stat_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, statId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Set attributes to be accessed in the JSP form
                request.setAttribute("statId", rs.getInt("stat_id"));
                request.setAttribute("playerId", rs.getInt("player_id"));
                request.setAttribute("goals", rs.getInt("goals"));
                request.setAttribute("yellowCards", rs.getInt("yellow_cards"));
                request.setAttribute("redCards", rs.getInt("red_cards"));

                // Forward the request to the edit form
                RequestDispatcher dispatcher = request.getRequestDispatcher("EditStats.jsp");
                dispatcher.forward(request, response);
            } else {
                response.getWriter().println("Player stats not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Handle POST requests
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the form
        int statId = Integer.parseInt(request.getParameter("stat_id"));
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

            // Establish connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // SQL query to update player stats
            String sql = "UPDATE PlayerStats SET player_id = ?, goals = ?, yellow_cards = ?, red_cards = ? WHERE stat_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, playerId);
            stmt.setInt(2, goals);
            stmt.setInt(3, yellowCards);
            stmt.setInt(4, redCards);
            stmt.setInt(5, statId);

            // Execute the update
            int rowsAffected = stmt.executeUpdate();

            // Check if update was successful
            if (rowsAffected > 0) {
                // Redirect to player stats management page after successful update
                response.sendRedirect("StatsManagement.jsp");
            } else {
                response.getWriter().println("Failed to update player stats.");
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