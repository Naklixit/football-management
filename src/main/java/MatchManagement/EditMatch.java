package MatchManagement;

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

/**
 * Servlet implementation class EditMatch
 */
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class EditMatch extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int matchId = Integer.parseInt(request.getParameter("match_id"));
        int seasonId = Integer.parseInt(request.getParameter("season_id"));

        // Fetch match details from database
        String url = "jdbc:mysql://localhost:3306/cuoi_ki";
        String user = "root";
        String password = "15022004";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT m.match_id, m.home_team_id, m.away_team_id, m.match_date, m.stadium, m.home_score, m.away_score " +
                             "FROM Matches m WHERE m.match_id = ?")) {

            stmt.setInt(1, matchId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    request.setAttribute("matchId", rs.getInt("match_id"));
                    request.setAttribute("homeTeamId", rs.getInt("home_team_id"));
                    request.setAttribute("awayTeamId", rs.getInt("away_team_id"));
                    request.setAttribute("matchDate", rs.getString("match_date"));
                    request.setAttribute("stadium", rs.getString("stadium"));
                    request.setAttribute("homeScore", rs.getInt("home_score"));
                    request.setAttribute("awayScore", rs.getInt("away_score"));
                    request.setAttribute("seasonId", seasonId);

                    // Forward to edit page (JSP)
                    RequestDispatcher dispatcher = request.getRequestDispatcher("EditMatch.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int matchId = Integer.parseInt(request.getParameter("match_id"));
        int homeTeamId = Integer.parseInt(request.getParameter("home_team_id"));
        int awayTeamId = Integer.parseInt(request.getParameter("away_team_id"));
        String matchDate = request.getParameter("match_date");
        String stadium = request.getParameter("stadium");
        int homeScore = Integer.parseInt(request.getParameter("home_score"));
        int awayScore = Integer.parseInt(request.getParameter("away_score"));
        int seasonId = Integer.parseInt(request.getParameter("season_id"));

        // Update match details in database
        String url = "jdbc:mysql://localhost:3306/cuoi_ki";
        String user = "root";
        String password = "15022004";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(
                     "UPDATE Matches SET home_team_id = ?, away_team_id = ?, match_date = ?, stadium = ?, home_score = ?, away_score = ? " +
                             "WHERE match_id = ?")) {

            stmt.setInt(1, homeTeamId);
            stmt.setInt(2, awayTeamId);
            stmt.setString(3, matchDate);
            stmt.setString(4, stadium);
            stmt.setInt(5, homeScore);
            stmt.setInt(6, awayScore);
            stmt.setInt(7, matchId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                // Redirect to the page showing the match details
                response.sendRedirect("MatchManagement.jsp?season_id=" + seasonId);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}