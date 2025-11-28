<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đội Bóng</title>
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
    

<body class="bg-light">
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
        <h2 class="text-center mb-4">Quản lý Đội Bóng</h2>

        <!-- Form Thêm Đội Bóng -->
        <div class="card shadow p-4 mb-5">
            <form action="AddTeam" method="post">
                <div class="mb-3">
                    <label for="team_name" class="form-label">Tên Đội Bóng:</label>
                    <input type="text" id="team_name" name="team_name" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="home_stadium" class="form-label">Sân Nhà:</label>
                    <input type="text" id="home_stadium" name="home_stadium" class="form-control">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô Tả:</label>
                    <textarea id="description" name="description" class="form-control" rows="4"></textarea>
                </div>

                <div class="mb-3">
                    <label for="season" class="form-label">Mùa Giải:</label>
                    <select id="season" name="season" class="form-select">
                        <% 
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT season_id, season_name FROM Season");

                                while (rs.next()) {
                                    int seasonId = rs.getInt("season_id");
                                    String seasonName = rs.getString("season_name");
                        %>
                        <option value="<%= seasonId %>"><%= seasonName %></option>
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

                <button type="submit" class="btn btn-primary w-100">Thêm Đội Bóng</button>
            </form>
        </div>

        <h3 class="text-center">Danh Sách Đội Bóng</h3>

        <!-- Bảng Hiển Thị Danh Sách Đội Bóng -->
        <table class="table table-bordered table-striped mt-3">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Tên Đội Bóng</th>
                    <th>Sân Nhà</th>
                    <th>Mùa giải</th>
                    <th>Mô tả</th>
                    <th>Thao Tác</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn2 = null;
                    Statement stmt2 = null;
                    ResultSet rs2 = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                        stmt2 = conn2.createStatement();
                        rs2 = stmt2.executeQuery("SELECT Teams.team_id, team_name, home_stadium, description, season_name FROM Teams INNER JOIN TeamSeason ON Teams.team_id = TeamSeason.team_id INNER JOIN Season ON Season.season_id = TeamSeason.season_id");

                        while (rs2.next()) {
                            int teamId = rs2.getInt("team_id");
                            String teamName = rs2.getString("team_name");
                            String homeStadium = rs2.getString("home_stadium");
                            String seasonName = rs2.getString("season_name");
                            String description = rs2.getString("description");
                %>
                <tr>
                    <td><%= teamId %></td>
                    <td><%= teamName %></td>
                    <td><%= homeStadium %></td>
                    <td><%= seasonName %></td>
                    <td><%= description %></td>
                    <td>
                        <a href="EditTeam?team_id=<%= teamId %>" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="DeleteTeam?team_id=<%= teamId %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
