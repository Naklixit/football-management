package TeamManagement;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Class.Team;
public class AddTeam extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String teamName = request.getParameter("team_name");
        String homeStadium = request.getParameter("home_stadium");
        String description = request.getParameter("description");
        String seasonIdStr = request.getParameter("season"); // Lấy season_id từ request
        int seasonId = Integer.parseInt(seasonIdStr); // Chuyển đổi sang số nguyên

        Connection conn = null;
        PreparedStatement teamStmt = null;
        PreparedStatement teamSeasonStmt = null;
        ResultSet generatedKeys = null;

        try {
            // Kết nối cơ sở dữ liệu
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");

            // Thêm đội bóng vào bảng Teams
            String teamSql = "INSERT INTO Teams (team_name, home_stadium, description) VALUES (?, ?, ?)";
            teamStmt = conn.prepareStatement(teamSql, Statement.RETURN_GENERATED_KEYS);
            teamStmt.setString(1, teamName);
            teamStmt.setString(2, homeStadium);
            teamStmt.setString(3, description);
            teamStmt.executeUpdate();

            // Lấy team_id vừa được tạo
            generatedKeys = teamStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int teamId = generatedKeys.getInt(1);

                // Thêm dữ liệu vào bảng TeamSeason
                String teamSeasonSql = "INSERT INTO TeamSeason (team_id, season_id) VALUES (?, ?)";
                teamSeasonStmt = conn.prepareStatement(teamSeasonSql);
                teamSeasonStmt.setInt(1, teamId);
                teamSeasonStmt.setInt(2, seasonId);
                teamSeasonStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Đóng các tài nguyên
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (teamStmt != null) teamStmt.close();
                if (teamSeasonStmt != null) teamSeasonStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Chuyển hướng về trang quản lý đội bóng
        response.sendRedirect("TeamManagement.jsp");
    }
}