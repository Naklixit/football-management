<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thống Kê Cầu Thủ</title>
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
        <h2 class="text-center">Quản lý Thống Kê Cầu Thủ</h2>

        <!-- Form Thêm Thống Kê Cầu Thủ -->
        <form action="/web/AddStats" method="post" class="mb-4">
            <div class="mb-3">
                <label for="player" class="form-label">Cầu Thủ:</label>
                <select id="player" name="player_id" class="form-select" required>
                    <% 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT player_id, player_name FROM Players");

                            while (rs.next()) {
                                int playerId = rs.getInt("player_id");
                                String playerName = rs.getString("player_name");
                    %>
                    <option value="<%= playerId %>"><%= playerName %></option>
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

            <div class="mb-3">
                <label for="goals" class="form-label">Số Bàn Thắng:</label>
                <input type="number" id="goals" name="goals" value="0" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="yellow_cards" class="form-label">Thẻ Vàng:</label>
                <input type="number" id="yellow_cards" name="yellow_cards" value="0" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="red_cards" class="form-label">Thẻ Đỏ:</label>
                <input type="number" id="red_cards" name="red_cards" value="0" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary">Thêm Thống Kê</button>
        </form>

        <h3 class="text-center">Danh Sách Thống Kê Cầu Thủ</h3>

        <!-- Bảng Hiển Thị Danh Sách Thống Kê Cầu Thủ -->
        <table class="table table-bordered table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID Cầu Thủ</th>
                    <th>Tên Cầu Thủ</th>
                    <th>Số Bàn Thắng</th>
                    <th>Thẻ Vàng</th>
                    <th>Thẻ Đỏ</th>
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
                        rs2 = stmt2.executeQuery("SELECT ps.stat_id, p.player_name, ps.goals, ps.yellow_cards, ps.red_cards FROM PlayerStats ps INNER JOIN Players p ON ps.player_id = p.player_id");

                        while (rs2.next()) {
                            int statId = rs2.getInt("stat_id");
                            String playerName = rs2.getString("player_name");
                            int goals = rs2.getInt("goals");
                            int yellowCards = rs2.getInt("yellow_cards");
                            int redCards = rs2.getInt("red_cards");
                %>
                <tr>
                    <td><%= statId %></td>
                    <td><%= playerName %></td>
                    <td><%= goals %></td>
                    <td><%= yellowCards %></td>
                    <td><%= redCards %></td>
                    <td>
                        <a href="EditStats?stat_id=<%= statId %>" class="btn btn-warning btn-sm">Sửa</a>
                        <a href="DeleteStats?stat_id=<%= statId %>" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
