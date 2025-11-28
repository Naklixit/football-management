<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>
</head>
<body>
<h1>Verify OTP</h1>
<form action="/web/VerifyOTPServlet" method="post">
    <label>Enter OTP: </label>
    <input type="text" name="otp" required><br>
    <input type="submit" value="Verify">
</form>
</body>
</html>