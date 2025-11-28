<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">

</head>
<body>
<form action="/web/ChangePasswordServlet" method="post">
<h1>Change Password</h1>

    <label>New Password: </label>
    <input type="password" name="newPassword" required><br>
    <label>Confirm Password: </label>
    <input type="password" name="confirmPassword" required><br>
    <input type="submit" value="Change Password">
</form>
</body>
</html>