<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Cầu Thủ</title>
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
        <h3 class="mt-5">Danh Sách Cầu Thủ</h3>

        <!-- Form Lọc Theo Đội Bóng -->
        <form method="get" action="">
            <div class="mb-3">
                <label for="team_filter" class="form-label">Lọc Theo Đội Bóng:</label>
                <select id="team_filter" name="team_id" class="form-select" onchange="this.form.submit()">
                    <option value="">Tất Cả Đội Bóng</option>
                    <% 
                        // Kết nối CSDL để lấy danh sách đội bóng
                        Connection conn1 = null;
                        Statement stmt1 = null;
                        ResultSet rs1 = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            stmt1 = conn1.createStatement();
                            rs1 = stmt1.executeQuery("SELECT team_id, team_name FROM Teams");

                            while (rs1.next()) {
                                int teamId = rs1.getInt("team_id");
                                String teamName = rs1.getString("team_name");
                    %>
                    <option value="<%= teamId %>" <%= request.getParameter("team_id") != null && request.getParameter("team_id").equals(String.valueOf(teamId)) ? "selected" : "" %>><%= teamName %></option>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs1 != null) rs1.close();
                                if (stmt1 != null) stmt1.close();
                                if (conn1 != null) conn1.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select>
            </div>
        </form>

        <!-- Bảng Hiển Thị Danh Sách Cầu Thủ -->
        <div class="table-responsive mt-3">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tên Cầu Thủ</th>
                        <th>Vị Trí</th>
                        <th>Số Áo</th>
                        <th>Quốc Tịch</th>
                        <th>Đội Bóng</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Kết nối CSDL và lấy thông tin cầu thủ, lọc theo đội bóng nếu có
                        Connection conn2 = null;
                        Statement stmt2 = null;
                        ResultSet rs2 = null;
                        String teamIdParam = request.getParameter("team_id");
                        String query = "SELECT p.player_id, p.player_name, p.position, p.jersey_number, p.nationality, t.team_name " +
                                       "FROM Players p INNER JOIN Teams t ON p.team_id = t.team_id";
                        if (teamIdParam != null && !teamIdParam.isEmpty()) {
                            query += " WHERE p.team_id = " + teamIdParam;
                        }
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            stmt2 = conn2.createStatement();
                            rs2 = stmt2.executeQuery(query);

                            while (rs2.next()) {
                                int playerId = rs2.getInt("player_id");
                                String playerName = rs2.getString("player_name");
                                String position = rs2.getString("position");
                                int jerseyNumber = rs2.getInt("jersey_number");
                                String nationality = rs2.getString("nationality");
                                String teamName = rs2.getString("team_name");
                    %>
                    <tr>
                        <td><%= playerId %></td>
                        <td><%= playerName %></td>
                        <td><%= position %></td>
                        <td><%= jerseyNumber %></td>
                        <td><%= nationality %></td>
                        <td><%= teamName != null ? teamName : "Không có đội" %></td>
                        
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs2 != null) rs2.close();
                                if (stmt2 != null) stmt2.close();
                                if (conn2 != null) conn2.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

	<div class="text-center mt-4">
            <a href="FE.jsp" class="btn btn-secondary">Back Home</a>
        </div>
    <!-- Thêm liên kết tới Bootstrap JS (nếu cần) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
