<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Season</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Select a Season</h1>
        <form action="MatchManagement.jsp" method="POST" class="shadow p-4 rounded bg-light">
            <div class="mb-3">
                <label for="season" class="form-label">Choose a season:</label>
                <select name="season_id" id="season" class="form-select" required>
                    <option value="" disabled selected>-- Select a season --</option>
                    <%
                        // Kết nối cơ sở dữ liệu để lấy danh sách các season
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/cuoi_ki", "root", "15022004");
                            java.sql.Statement stmt = conn.createStatement();
                            java.sql.ResultSet rs = stmt.executeQuery("SELECT season_id, season_name FROM Season");

                            while (rs.next()) {
                                int seasonId = rs.getInt("season_id");
                                String seasonName = rs.getString("season_name");
                    %>
                    <option value="<%= seasonId %>"><%= seasonName %></option>
                    <%
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <option disabled>Error loading seasons</option>
                    <%
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Next</button>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
