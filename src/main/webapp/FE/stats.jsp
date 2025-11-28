<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Thống Kê Cầu Thủ</title>
    <link rel="stylesheet" type="text/css" href="/web/FE/css/test.css?v=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        
        .stats-table th {
            text-align: center;
            background-color: #343a40;
            color: #fff;
        }

        .stats-table td {
            text-align: center;
            vertical-align: middle;
        }

        .stats-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .stats-table tr:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>

    <div class="header">
            <a href="FE.jsp">
                <img src="IMG/logo.png" alt="Logo" >
            </a>
            <div class="menu">
                <a href="FE.jsp" >HOME</a>
                <a href="player.jsp" >PLAYERS</a>
                <a href="team.jsp" >TEAM</a>
                <a href="match.jsp" >MATCHES</a>
			    <a href="stats.jsp">STATS</a>
                
                <div class="dropdown">
                    <button class="dropdown-btn">ADMIN</button>
                    <div class="dropdown-content">
                        <a href="/web/TeamManagement.jsp">TEAM</a>
                        <a href="/web/PlayerManagement.jsp">PLAYERS</a>
                        <a href="/web/ChooseSeason.jsp">MATCH</a>
                        <a href="/web/StatsManagement.jsp">STATS</a>
                    </div>
                </div>
            </div>
    </div>

    <h2 class="text-center mb-4">Danh Sách Thống Kê Cầu Thủ</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-striped stats-table">
            <thead class="table-dark">
                <tr>
                    <th>ID Cầu Thủ</th>
                    <th>Tên Cầu Thủ</th>
                    <th>Số Bàn Thắng</th>
                    <th>Thẻ Vàng</th>
                    <th>Thẻ Đỏ</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT ps.stat_id, p.player_name, ps.goals, ps.yellow_cards, ps.red_cards FROM PlayerStats ps INNER JOIN Players p ON ps.player_id = p.player_id");

                        while (rs.next()) {
                            int statId = rs.getInt("stat_id");
                            String playerName = rs.getString("player_name");
                            int goals = rs.getInt("goals");
                            int yellowCards = rs.getInt("yellow_cards");
                            int redCards = rs.getInt("red_cards");
                %>
                <tr>
                    <td><%= statId %></td>
                    <td><%= playerName %></td>
                    <td><%= goals %></td>
                    <td><%= yellowCards %></td>
                    <td><%= redCards %></td>
                </tr>
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
            </tbody>
        </table>
    </div>

    <div class="text-center mt-4">
        <a href="FE.jsp" class="btn btn-secondary">Back Home</a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
