package MatchManagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class AddMatch extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cuoi_ki";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "15022004";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ request
        String seasonIdStr = request.getParameter("season_id");
        String homeTeamIdStr = request.getParameter("home_team_id");
        String awayTeamIdStr = request.getParameter("away_team_id");
        String matchDate = request.getParameter("match_date");
        String stadium = request.getParameter("stadium");
        String homeScoreStr = request.getParameter("home_score");
        String awayScoreStr = request.getParameter("away_score");

        // Kiểm tra tính hợp lệ của dữ liệu
        if (seasonIdStr == null || homeTeamIdStr == null || awayTeamIdStr == null || matchDate == null || stadium == null ||
            seasonIdStr.isEmpty() || homeTeamIdStr.isEmpty() || awayTeamIdStr.isEmpty() || matchDate.isEmpty() || stadium.isEmpty()) {
            response.sendRedirect("MatchManagement.jsp?season_id=" + seasonIdStr + "&error=Vui lòng điền đầy đủ thông tin!");
            return;
        }

        try {
            // Chuyển đổi dữ liệu
            int seasonId = Integer.parseInt(seasonIdStr);
            int homeTeamId = Integer.parseInt(homeTeamIdStr);
            int awayTeamId = Integer.parseInt(awayTeamIdStr);
            int homeScore = (homeScoreStr != null && !homeScoreStr.isEmpty()) ? Integer.parseInt(homeScoreStr) : 0;
            int awayScore = (awayScoreStr != null && !awayScoreStr.isEmpty()) ? Integer.parseInt(awayScoreStr) : 0;

            // Kết nối cơ sở dữ liệu
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Kiểm tra nếu đội chủ nhà và đội khách giống nhau
                if (homeTeamId == awayTeamId) {
                    response.sendRedirect("MatchManagement.jsp?season_id=" + seasonId);
                    return;
                }

                // Thêm dữ liệu vào bảng Matches
                String sql = "INSERT INTO Matches (season_id, home_team_id, away_team_id, match_date, stadium, home_score, away_score) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, seasonId);
                    stmt.setInt(2, homeTeamId);
                    stmt.setInt(3, awayTeamId);
                    stmt.setString(4, matchDate);
                    stmt.setString(5, stadium);
                    stmt.setInt(6, homeScore);
                    stmt.setInt(7, awayScore);

                    int rowsInserted = stmt.executeUpdate();
                    if (rowsInserted > 0) {
                        response.sendRedirect("MatchManagement.jsp?season_id=" + seasonId );
                    } else {
                        response.sendRedirect("MatchManagement.jsp?season_id=" + seasonId );
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("MatchManagement.jsp?season_id=" + seasonIdStr);
        }
    }
}
