
package TeamManagement;

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
 * Servlet implementation class DeleteTeam
 */
public class DeleteTeam extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int teamId = Integer.parseInt(request.getParameter("team_id"));

        // JDBC Connection
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004")) {
            // SQL query to delete the team
            String sql = "DELETE FROM Teams WHERE team_id = ?";

            // Execute the deletion
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, teamId);
                int rowsAffected = stmt.executeUpdate();
                
                // Check if the team was deleted
                if (rowsAffected > 0) {
                    System.out.println("Team deleted successfully.");
                } else {
                    System.out.println("No team found with the provided ID.");
                }
            } catch (SQLException e) {
                // Handle SQL errors during delete operation
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred while deleting the team.");
                return;
            }
        } catch (SQLException e) {
            // Handle database connection errors
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection error.");
            return;
        }

        // Redirect to the team management page after deletion
        response.sendRedirect("TeamManagement.jsp");
    }
}
