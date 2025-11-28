<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Trận Đấu</title>
   <style>
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
<link rel="stylesheet" href="css/test.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"></head>
<body>

	<div class="header">
    <!-- Logo -->
			    <div class="logo-container">
			        <a href="FE.jsp">
			            <img src="IMG/logo.png" alt="Logo">
			        </a>
			    </div>
	    
	    <!-- Menu -->
			    <div class="menu">
			        <a href="FE.jsp">HOME</a> 
			        <a href="player.jsp">PLAYERS</a>
			        <a href="team.jsp">TEAM</a>
			        <a href="match.jsp">MATCHES</a>
			        <a href="stats.jsp">STATS</a>
			        
			        
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
        <h2 class="text-center mb-4">Danh Sách Trận Đấu</h2>

        <!-- Form chọn mùa giải -->
        <form action="" method="get" class="p-4 mb-5 border rounded shadow-sm">
            <div class="mb-3">
                <label for="season_id" class="form-label">Chọn Mùa Giải:</label>
                <select id="season_id" name="season_id" class="form-select" required onchange="this.form.submit()">
                    <option value="" disabled selected>-- Chọn Mùa Giải --</option>
                    <% 
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT season_id, season_name FROM Season")) {

                            while (rs.next()) {
                                int seasonId = rs.getInt("season_id");
                                String seasonName = rs.getString("season_name");
                                boolean isSelected = request.getParameter("season_id") != null 
                                                     && Integer.parseInt(request.getParameter("season_id")) == seasonId;
                    %>
                    <option value="<%= seasonId %>" <%= isSelected ? "selected" : "" %>><%= seasonName %></option>
                    <% 
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
        </form>

        <% 
            String seasonIdStr = request.getParameter("season_id");
            if (seasonIdStr == null || seasonIdStr.isEmpty()) {
        %>
            <div class="alert alert-danger">Vui lòng chọn một mùa giải!</div>
        <% } else { 
            int seasonId = Integer.parseInt(seasonIdStr);
        %>

 

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
                </tr>
            </thead>
            <tbody>
                <% 
                    // Lấy danh sách trận đấu
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

	<div class="text-center mt-4">
            <a href="FE.jsp" class="btn btn-secondary">Back Home</a>
        </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
