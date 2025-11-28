<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Trận Đấu</title>
<link rel="stylesheet" href="FE/css/test.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
    .hero.overlay {
        background-image: url('IMG/header.jpg');
        background-size: cover;
        background-position: center;
        height: 50vh; /* Chiều cao toàn màn hình */
        position: relative; /* Để đặt các phần tử con bên trong */
        margin-bottom: 50px;
    }
    .row{
    	gap:50px;
    }
    
    .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-btn {
            color: white;
            padding: 10px 15px;
            background-color: darkred;
            border: none;
            border-radius: 4px;
            cursor: pointer;
           	font-weight:bold;
        }

        .dropdown-btn:hover {
            background-color: #555;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: darkred;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="header">
    <!-- Logo -->
			    <div class="logo-container">
			        <a href="FE.jsp">
			            <img src="FE/IMG/logo.png" alt="Logo">
			        </a>
			    </div>
	    
	    <!-- Menu -->
			    <div class="menu">
			        <a href="FE/FE.jsp">HOME</a> 
			        <a href="FE/player.jsp">PLAYERS</a>
			        <a href="FE/team.jsp">TEAM</a>
			        <a href="FE/match.jsp">MATCHES</a>
			        <a href="FE/stats.jsp">STATS</a>
			        <div class="dropdown">
		            <button class="dropdown-btn">ADMIN</button>
		            <div class="dropdown-content">
                <a href="/web/TeamManagement.jsp">TEAM </a>
                <a href="/web/PlayerManagement.jsp">PLAYERS </a>
                <a href="/web/ChooseSeason.jsp">MATCH </a>
                <a href="/web/StatsManagement.jsp">STATS </a>
            </div>
        </div>
			    </div>
		</div>   

    <div class="container mt-5">
        <h2 class="text-center mb-4">Quản Lý Trận Đấu</h2>

        <%
            String seasonIdStr = request.getParameter("season_id");
            int seasonId = (seasonIdStr != null && !seasonIdStr.isEmpty()) ? Integer.parseInt(seasonIdStr) : -1;

            if (seasonId == -1) {
        %>
            <div class="alert alert-danger">Vui lòng chọn một mùa giải từ trang trước!</div>
        <% } else { %>

        <!-- Form Thêm Trận Đấu -->
        <form action="AddMatch" method="post" class="p-4 mb-5 border rounded shadow-sm">
            <input type="hidden" name="season_id" value="<%= seasonId %>">
            <div class="mb-3">
                <label for="home_team_id" class="form-label">Đội Chủ Nhà:</label>
                <select id="home_team_id" name="home_team_id" class="form-select" required>
                    <option value="" disabled selected>-- Chọn Đội Chủ Nhà --</option>
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
                    %>
                    <option value="<%= teamId %>"><%= teamName %></option>
                    <% 
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="away_team_id" class="form-label">Đội Khách:</label>
                <select id="away_team_id" name="away_team_id" class="form-select" required>
                    <option value="" disabled selected>-- Chọn Đội Khách --</option>
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
                    %>
                    <option value="<%= teamId %>"><%= teamName %></option>
                    <% 
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="match_date" class="form-label">Ngày Trận Đấu:</label>
                <input type="datetime-local" id="match_date" name="match_date" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="stadium" class="form-label">Sân Vận Động:</label>
                <input type="text" id="stadium" name="stadium" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="home_score" class="form-label">Tỷ Số Đội Chủ Nhà:</label>
                <input type="number" id="home_score" name="home_score" class="form-control" min="0">
            </div>

            <div class="mb-3">
                <label for="away_score" class="form-label">Tỷ Số Đội Khách:</label>
                <input type="number" id="away_score" name="away_score" class="form-control" min="0">
            </div>

            <button type="submit" class="btn btn-primary w-100">Thêm Trận Đấu</button>
        </form>

        <!-- Danh sách các trận đấu -->
        <h3 class="mb-3">Danh Sách Trận Đấu</h3>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Đội Chủ Nhà</th>
                    <th>Đội Khách</th>
                    <th>Ngày</th>
                    <th>Sân Vận Động</th>
                    <th>Tỷ Số</th>
                    <th>Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                         PreparedStatement stmt = conn.prepareStatement(
                             "SELECT m.match_id, t1.team_name AS home_team, t2.team_name AS away_team, " +
                             "m.match_date, m.stadium, m.home_score, m.away_score " +
                             "FROM Matches m " +
                             "JOIN Teams t1 ON m.home_team_id = t1.team_id " +
                             "JOIN Teams t2 ON m.away_team_id = t2.team_id " +
                             "WHERE m.season_id = ?")) {

                        stmt.setInt(1, seasonId);

                        try (ResultSet rs = stmt.executeQuery()) {
                            while (rs.next()) {
                                int matchId = rs.getInt("match_id");
                                String homeTeam = rs.getString("home_team");
                                String awayTeam = rs.getString("away_team");
                                String matchDate = rs.getString("match_date");
                                String stadium = rs.getString("stadium");
                                int homeScore = rs.getInt("home_score");
                                int awayScore = rs.getInt("away_score");
                %>
                <tr>
                    <td><%= matchId %></td>
                    <td><%= homeTeam %></td>
                    <td><%= awayTeam %></td>
                    <td><%= matchDate %></td>
                    <td><%= stadium %></td>
                    <td><%= homeScore %> - <%= awayScore %></td>
                    <td>
                        <a href="EditMatch?match_id=<%= matchId %>&season_id=<%= seasonId %>" class="btn btn-sm btn-warning">Sửa</a>
                        <a href="DeleteMatch?match_id=<%= matchId %>&season_id=<%= seasonId %>" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                    </td>
                </tr>
                <% 
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
        <% } %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
