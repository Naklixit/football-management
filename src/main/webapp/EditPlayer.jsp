<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Thông Tin Cầu Thủ</title>
    <link rel="stylesheet" type="text/css" href="/web/FE/css/test.css?v=1.0">
    
</head>
<body>
    <h2>Sửa Thông Tin Cầu Thủ</h2>
    <form action="EditPlayer" method="post">
        <input type="hidden" name="player_id" value="<%= request.getAttribute("player_id") %>">
        
        <label for="player_name">Tên Cầu Thủ:</label>
        <input type="text" id="player_name" name="player_name" value="<%= request.getAttribute("player_name") %>" required><br><br>

        <label for="position">Vị Trí:</label>
        <input type="text" id="position" name="position" value="<%= request.getAttribute("position") %>"><br><br>

        <label for="jersey_number">Số Áo:</label>
        <input type="number" id="jersey_number" name="jersey_number" value="<%= request.getAttribute("jersey_number") %>"><br><br>

        <label for="nationality">Quốc Tịch:</label>
        <input type="text" id="nationality" name="nationality" value="<%= request.getAttribute("nationality") %>"><br><br>

        <label for="team_id">Đội Bóng:</label>
        <select id="team_id" name="team_id">
            <% 
                // Retrieve teams for the dropdown
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
                        String selected = teamId == Integer.parseInt(request.getAttribute("team_id").toString()) ? "selected" : "";
            %>
            <option value="<%= teamId %>" <%= selected %>><%= teamName %></option>
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
        </select><br><br>

        <button type="submit">Cập Nhật Cầu Thủ</button>
    </form>
</body>
</html>