package MatchManagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class DeleteMatch
 */
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteMatch extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cuoi_ki";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "15022004";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số match_id và season_id từ request
        String matchIdStr = request.getParameter("match_id");
        String seasonIdStr = request.getParameter("season_id");

        // Kiểm tra nếu match_id không hợp lệ hoặc không có season_id
        if (matchIdStr == null || matchIdStr.isEmpty() || seasonIdStr == null || seasonIdStr.isEmpty()) {
            response.sendRedirect("MatchManagement.jsp?error=Không tìm thấy trận đấu hoặc mùa giải cần xóa!");
            return;
        }

        try {
            // Chuyển đổi match_id và season_id từ chuỗi sang số
            int matchId = Integer.parseInt(matchIdStr);
            int seasonId = Integer.parseInt(seasonIdStr);

            // Kết nối cơ sở dữ liệu
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Xóa trận đấu từ bảng Matches
                String sql = "DELETE FROM Matches WHERE match_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, matchId);

                    int rowsDeleted = stmt.executeUpdate();
                    if (rowsDeleted > 0) {
                        // Chuyển hướng lại trang quản lý với thông báo thành công
                        response.sendRedirect("MatchManagement.jsp?season_id=" + seasonId);
                    } else {
                        // Nếu không tìm thấy trận đấu để xóa
                        response.sendRedirect("MatchManagement.jsp?season_id=" + seasonId);
                    }
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("MatchManagement.jsp?error=ID trận đấu không hợp lệ!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("MatchManagement.jsp?error=Lỗi hệ thống, vui lòng thử lại sau!");
        }
    }
}