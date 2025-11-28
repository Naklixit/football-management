
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Thống Kê Cầu Thủ</title>
    <link rel="stylesheet" type="text/css" href="/web/FE/css/test.css?v=1.0">
    
</head>
<body>
    <h2>Chỉnh Sửa Thống Kê Cầu Thủ</h2>

    <!-- Form Sửa Thống Kê Cầu Thủ -->
    <form action="EditStats" method="post">
        <input type="hidden" name="stat_id" value="<%= request.getAttribute("statId") %>">
        <input type="hidden" name="player_id" value="<%= request.getAttribute("playerId") %>">

        <label for="goals">Số Bàn Thắng:</label>
        <input type="number" id="goals" name="goals" value="<%= request.getAttribute("goals") %>" required><br><br>

        <label for="yellow_cards">Thẻ Vàng:</label>
        <input type="number" id="yellow_cards" name="yellow_cards" value="<%= request.getAttribute("yellowCards") %>" required><br><br>

        <label for="red_cards">Thẻ Đỏ:</label>
        <input type="number" id="red_cards" name="red_cards" value="<%= request.getAttribute("redCards") %>" required><br><br>

        <button type="submit">Cập Nhật Thống Kê</button>
    </form>
</body>
</html>
