package PlayerManagement;

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
 * Servlet implementation class AddPlayer
 */
public class AddPlayer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String playerName = request.getParameter("player_name");
        String position = request.getParameter("position");
        int jerseyNumber = Integer.parseInt(request.getParameter("jersey_number"));
        String nationality = request.getParameter("nationality");
        String teamIdParam = request.getParameter("team_id");

        Integer teamId = null;
        if (teamIdParam != null && !teamIdParam.isEmpty()) {
            teamId = Integer.parseInt(teamIdParam); // Có thể null nếu không chọn đội
        }

        // Kết nối cơ sở dữ liệu và thêm cầu thủ
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004")) {
            String sql = "INSERT INTO Players (player_name, position, jersey_number, nationality, team_id) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, playerName);
                stmt.setString(2, position);
                stmt.setInt(3, jerseyNumber);
                stmt.setString(4, nationality);
                if (teamId != null) {
                    stmt.setInt(5, teamId); // Nếu có teamId thì set
                } else {
                    stmt.setNull(5, java.sql.Types.INTEGER); // Nếu không thì set NULL
                }
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Chuyển hướng về trang quản lý cầu thủ
        response.sendRedirect("PlayerManagement.jsp");
    }
}