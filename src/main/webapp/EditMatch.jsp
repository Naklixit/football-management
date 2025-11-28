<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Trận Đấu</title>
<link rel="stylesheet" type="text/css" href="/web/FE/css/test.css?v=1.0">

</head>
<body>
    <h2>Sửa Trận Đấu</h2>

    <form action="EditMatch" method="post">
        <input type="hidden" name="match_id" value="<%= request.getAttribute("matchId") %>">
        <input type="hidden" name="season_id" value="<%= request.getAttribute("seasonId") %>">

        <label for="home_team_id">Đội Chủ Nhà:</label>
        <select id="home_team_id" name="home_team_id" required>
            <% 
                // Fetch teams for the current season
                int seasonId = (int) request.getAttribute("seasonId");
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT t.team_id, t.team_name " +
                         "FROM Teams t INNER JOIN TeamSeason ts ON t.team_id = ts.team_id " +
                         "WHERE ts.season_id = ?")) {

                    stmt.setInt(1, seasonId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            int teamId = rs.getInt("team_id");
                            String teamName = rs.getString("team_name");
                            String selected = teamId == (int) request.getAttribute("homeTeamId") ? "selected" : "";
            %>
            <option value="<%= teamId %>" <%= selected %>><%= teamName %></option>
            <% 
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select>

        <label for="away_team_id">Đội Khách:</label>
        <select id="away_team_id" name="away_team_id" required>
            <% 
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT t.team_id, t.team_name " +
                         "FROM Teams t INNER JOIN TeamSeason ts ON t.team_id = ts.team_id " +
                         "WHERE ts.season_id = ?")) {

                    stmt.setInt(1, seasonId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            int teamId = rs.getInt("team_id");
                            String teamName = rs.getString("team_name");
                            String selected = teamId == (int) request.getAttribute("awayTeamId") ? "selected" : "";
            %>
            <option value="<%= teamId %>" <%= selected %>><%= teamName %></option>
            <% 
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </select>

        <label for="match_date">Ngày Trận Đấu:</label>
        <input type="datetime-local" id="match_date" name="match_date" value="<%= request.getAttribute("matchDate") %>" required>

        <label for="stadium">Sân Vận Động:</label>
        <input type="text" id="stadium" name="stadium" value="<%= request.getAttribute("stadium") %>" required>

        <label for="home_score">Tỷ Số Đội Chủ Nhà:</label>
        <input type="number" id="home_score" name="home_score" value="<%= request.getAttribute("homeScore") %>" min="0">

        <label for="away_score">Tỷ Số Đội Khách:</label>
        <input type="number" id="away_score" name="away_score" value="<%= request.getAttribute("awayScore") %>" min="0">

        <button type="submit">Cập Nhật Trận Đấu</button>
    </form>
</body>
</html>
