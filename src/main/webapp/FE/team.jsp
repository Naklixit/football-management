<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Đội Bóng</title>
<link rel="stylesheet" href="css/test.css">
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
        <h3 class="text-center mb-4">Danh Sách Đội Bóng</h3>

        <!-- Form chọn mùa giải (submit tự động khi chọn) -->
        <form action="team.jsp" method="get" class="mb-4 p-3 border rounded shadow-sm">
            <div class="mb-3">
                <label for="season" class="form-label">Chọn Mùa Giải:</label>
                <select id="season" name="season" class="form-select" onchange="this.form.submit()" required>
                    <option value="" disabled selected>-- Chọn Mùa Giải --</option>
                    <% 
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT season_id, season_name FROM Season")) {

                            while (rs.next()) {
                                int seasonId = rs.getInt("season_id");
                                String seasonName = rs.getString("season_name");
                                String selected = "";
                                if (request.getParameter("season") != null && 
                                    request.getParameter("season").equals(String.valueOf(seasonId))) {
                                    selected = "selected";
                                }
                    %>
                    <option value="<%= seasonId %>" <%= selected %>><%= seasonName %></option>
                    <% 
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </select>
            </div>
        </form>

        <!-- Hiển thị mùa giải đã chọn -->
        <% 
            String selectedSeason = request.getParameter("season");
            if (selectedSeason != null) {
                // Lấy tên mùa giải đã chọn
                String seasonName = "";
                try {
                    Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                    Statement stmt2 = conn2.createStatement();
                    ResultSet rs2 = stmt2.executeQuery("SELECT season_name FROM Season WHERE season_id = " + selectedSeason);
                    
                    if (rs2.next()) {
                        seasonName = rs2.getString("season_name");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
        %>
            <p class="text-center">Mùa giải đã chọn: <strong><%= seasonName %></strong></p>
        <% 
            }
        %>

        <!-- Bảng Hiển Thị Danh Sách Đội Bóng -->
        <div class="table-responsive">
            <table class="table table-bordered table-striped text-center">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên Đội Bóng</th>
                        <th>Sân Nhà</th>
                        <th>Mùa Giải</th>
                        <th>Mô Tả</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection conn3 = null;
                        Statement stmt3 = null;
                        ResultSet rs3 = null;
                        String seasonFilter = request.getParameter("season"); // Lấy mùa giải từ GET request
                        String query = "SELECT Teams.team_id, team_name, home_stadium, description, season_name " +
                                       "FROM Teams " +
                                       "INNER JOIN TeamSeason ON Teams.team_id = TeamSeason.team_id " +
                                       "INNER JOIN Season ON Season.season_id = TeamSeason.season_id";
                        if (seasonFilter != null) {
                            query += " WHERE Season.season_id = " + seasonFilter; // Thêm điều kiện lọc theo mùa giải
                        }

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn3 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            stmt3 = conn3.createStatement();
                            rs3 = stmt3.executeQuery(query);

                            while (rs3.next()) {
                                int teamId = rs3.getInt("team_id");
                                String teamName = rs3.getString("team_name");
                                String homeStadium = rs3.getString("home_stadium");
                                String seasonName = rs3.getString("season_name");
                                String description = rs3.getString("description");
                    %>
                    <tr>
                        <td><%= teamId %></td>
                        <td><%= teamName %></td>
                        <td><%= homeStadium %></td>
                        <td><%= seasonName %></td>
                        <td><%= description %></td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs3 != null) rs3.close();
                                if (stmt3 != null) stmt3.close();
                                if (conn3 != null) conn3.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="text-center mt-4">
            <a href="FE.jsp" class="btn btn-secondary">Back Home</a>
        </div>
        
    </div>
</body>
</html>
