
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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class EditTeam
 */
public class EditTeam extends HttpServlet {
    // Hiển thị form chỉnh sửa đội bóng (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int teamId = Integer.parseInt(request.getParameter("team_id"));

        // Kết nối và lấy dữ liệu đội bóng từ cơ sở dữ liệu
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004")) {
            String sql = "SELECT Teams.team_id,team_name,home_stadium,description,season_name FROM Teams INNER JOIN TeamSeason ON Teams.team_id = TeamSeason.team_id INNER JOIN Season ON Season.season_id = TeamSeason.season_id WHERE team_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, teamId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // Lấy thông tin đội bóng và chuyển vào request attribute
                    request.setAttribute("teamId", rs.getInt("team_id"));
                    request.setAttribute("teamName", rs.getString("team_name"));
                    request.setAttribute("homeStadium", rs.getString("home_stadium"));
                    request.setAttribute("seasonName", rs.getString("season_name"));
                    request.setAttribute("description", rs.getString("description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Forward đến trang chỉnh sửa
        request.getRequestDispatcher("EditTeam.jsp").forward(request, response);
    }

    // Cập nhật thông tin đội bóng (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int teamId = Integer.parseInt(request.getParameter("team_id"));
        String teamName = request.getParameter("team_name");
        String homeStadium = request.getParameter("home_stadium");
        String description = request.getParameter("description");
        int seasonId = Integer.parseInt(request.getParameter("season"));

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // Update Teams table
            String updateTeamQuery = "UPDATE Teams SET team_name = ?, home_stadium = ?, description = ? WHERE team_id = ?";
            stmt = conn.prepareStatement(updateTeamQuery);
            stmt.setString(1, teamName);
            stmt.setString(2, homeStadium);
            stmt.setString(3, description);
            stmt.setInt(4, teamId);
            stmt.executeUpdate();

            // Update TeamSeason table
            String updateTeamSeasonQuery = "UPDATE TeamSeason SET season_id = ? WHERE team_id = ?";
            stmt = conn.prepareStatement(updateTeamSeasonQuery);
            stmt.setInt(1, seasonId);
            stmt.setInt(2, teamId);
            stmt.executeUpdate();

            response.sendRedirect("TeamManagement.jsp"); // Redirect back to the teams list page
        } catch (Exception e) {
            e.printStackTrace();
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
