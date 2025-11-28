
package PlayerManagement;

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

public class EditPlayer extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int playerId = Integer.parseInt(request.getParameter("player_id"));
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Set up the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // Query to fetch player details
            String query = "SELECT * FROM Players WHERE player_id = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, playerId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Set player details as request attributes to display in the form
                request.setAttribute("player_id", rs.getInt("player_id"));
                request.setAttribute("player_name", rs.getString("player_name"));
                request.setAttribute("position", rs.getString("position"));
                request.setAttribute("jersey_number", rs.getInt("jersey_number"));
                request.setAttribute("nationality", rs.getString("nationality"));
                request.setAttribute("team_id", rs.getInt("team_id"));
                
                // Forward to the edit player form page
                RequestDispatcher dispatcher = request.getRequestDispatcher("EditPlayer.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Player not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int playerId = Integer.parseInt(request.getParameter("player_id"));
        String playerName = request.getParameter("player_name");
        String position = request.getParameter("position");
        int jerseyNumber = Integer.parseInt(request.getParameter("jersey_number"));
        String nationality = request.getParameter("nationality");
        int teamId = Integer.parseInt(request.getParameter("team_id"));

        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            // Set up the database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // Query to update player details
            String updateQuery = "UPDATE Players SET player_name = ?, position = ?, jersey_number = ?, nationality = ?, team_id = ? WHERE player_id = ?";
            stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, playerName);
            stmt.setString(2, position);
            stmt.setInt(3, jerseyNumber);
            stmt.setString(4, nationality);
            stmt.setInt(5, teamId);
            stmt.setInt(6, playerId);
            
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("PlayerManagement.jsp");  // Redirect to the player list page
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update player.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
