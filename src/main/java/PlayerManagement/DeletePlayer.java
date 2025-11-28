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
 * Servlet implementation class DeletePlayer
 */
public class DeletePlayer extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int playerId = Integer.parseInt(request.getParameter("player_id"));

        // Kết nối CSDL
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004")) {
            // SQL xóa cầu thủ
            String sql = "DELETE FROM Players WHERE player_id = ?";

            // Thực thi câu lệnh xóa
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, playerId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Chuyển hướng về trang quản lý cầu thủ sau khi xóa
        response.sendRedirect("PlayerManagement.jsp");
    }
}