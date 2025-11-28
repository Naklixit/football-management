<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Cầu Thủ</title>
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
        <h2 class="text-center mb-4">Quản Lý Cầu Thủ</h2>

        <!-- Form Thêm Cầu Thủ -->
        <form action="/web/AddPlayer" method="post">
            <div class="mb-3">
                <label for="player_name" class="form-label">Tên Cầu Thủ:</label>
                <input type="text" id="player_name" name="player_name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="position" class="form-label">Vị Trí:</label>
                <input type="text" id="position" name="position" class="form-control">
            </div>

            <div class="mb-3">
                <label for="jersey_number" class="form-label">Số Áo:</label>
                <input type="number" id="jersey_number" name="jersey_number" class="form-control">
            </div>

            <div class="mb-3">
                <label for="nationality" class="form-label">Quốc Tịch:</label>
                <input type="text" id="nationality" name="nationality" class="form-control">
            </div>

            <div class="mb-3">
                <label for="team_id" class="form-label">Đội Bóng:</label>
                <select id="team_id" name="team_id" class="form-select">
                    <% 
                        // Kết nối CSDL để lấy danh sách đội bóng
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT team_id, team_name FROM Teams");

                            while (rs.next()) {
                                int teamId = rs.getInt("team_id");
                                String teamName = rs.getString("team_name");
                    %>
                    <option value="<%= teamId %>"><%= teamName %></option>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Thêm Cầu Thủ</button>
        </form>

        <h3 class="mt-5">Danh Sách Cầu Thủ</h3>

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
                        <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Kết nối CSDL và lấy thông tin cầu thủ
                        Connection conn2 = null;
                        Statement stmt2 = null;
                        ResultSet rs2 = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            stmt2 = conn2.createStatement();
                            rs2 = stmt2.executeQuery("SELECT p.player_id, p.player_name, p.position, p.jersey_number, p.nationality, t.team_name " +
                                                     "FROM Players p INNER JOIN Teams t ON p.team_id = t.team_id");

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
                        <td>
                            <!-- Nút Sửa và Xóa -->
                            <a href="EditPlayer?player_id=<%= playerId %>" class="btn btn-warning btn-sm">Sửa</a>
                            <a href="DeletePlayer?player_id=<%= playerId %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?')" class="btn btn-danger btn-sm">Xóa</a>
                        </td>
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

    <!-- Thêm liên kết tới Bootstrap JS (nếu cần) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
