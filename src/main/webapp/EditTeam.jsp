<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Đội Bóng</title>
    <link rel="stylesheet" type="text/css" href="/web/FE/css/test.css?v=1.0">
    
</head>
<body>
    <h2>Sửa Đội Bóng</h2>

    <%
        // Kết nối CSDL để lấy thông tin đội bóng
        int teamId = Integer.parseInt(request.getParameter("team_id"));
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        String teamName = "";
        String homeStadium = "";
        String description = "";
        int seasonId = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
            stmt = conn.createStatement();
            String query = "SELECT Teams.team_name, Teams.home_stadium, Teams.description, TeamSeason.season_id " +
                           "FROM Teams " +
                           "INNER JOIN TeamSeason ON Teams.team_id = TeamSeason.team_id " +
                           "WHERE Teams.team_id = " + teamId;
            rs = stmt.executeQuery(query);

            if (rs.next()) {
                teamName = rs.getString("team_name");
                homeStadium = rs.getString("home_stadium");
                description = rs.getString("description");
                seasonId = rs.getInt("season_id");
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

    <!-- Form Sửa Đội Bóng -->
    <form action="EditTeam" method="post">
        <input type="hidden" name="team_id" value="<%= teamId %>">
        <label for="team_name">Tên Đội Bóng:</label>
        <input type="text" id="team_name" name="team_name" value="<%= teamName %>" required><br><br>

        <label for="home_stadium">Sân Nhà:</label>
        <input type="text" id="home_stadium" name="home_stadium" value="<%= homeStadium %>"><br><br>

        <label for="description">Mô Tả:</label><br>
        <textarea id="description" name="description" rows="4" cols="50"><%= description %></textarea><br><br>

        <!-- Combobox Mùa Giải -->
        <label for="season">Mùa Giải:</label>
        <select id="season" name="season">
            <% 
                // Kết nối CSDL để lấy danh sách mùa giải
                Connection conn2 = null;
                Statement stmt2 = null;
                ResultSet rs2 = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                    stmt2 = conn2.createStatement();
                    rs2 = stmt2.executeQuery("SELECT season_id, season_name FROM Season");

                    while (rs2.next()) {
                        int seasonIdOption = rs2.getInt("season_id");
                        String seasonName = rs2.getString("season_name");
            %>
            <option value="<%= seasonIdOption %>" <%= (seasonIdOption == seasonId ? "selected" : "") %>><%= seasonName %></option>
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
        </select><br><br>

        <button type="submit">Cập Nhật Đội Bóng</button>
    </form>
</body>
</html>