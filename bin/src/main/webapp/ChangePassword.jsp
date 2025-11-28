<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
</head>
<body>
<h1>Change Password</h1>
<form action="/web/ChangePasswordServlet" method="post">
    <label>New Password: </label>
    <input type="password" name="newPassword" required><br>
    <label>Confirm Password: </label>
    <input type="password" name="confirmPassword" required><br>
    <input type="submit" value="Change Password">
</form>
</body>
</html>