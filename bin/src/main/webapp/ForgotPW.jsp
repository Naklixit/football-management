<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
</head>
<body>
<h1>Verify OTP</h1>
<form action="/web/ForgotPWServlet" method="post">
    <label>Enter your email: </label>
    <input type="email" name="email" required><br>
    <input type="submit" value="Confirm">
</form>
</body>
</html>