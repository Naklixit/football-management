<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">

<style>
 input[type="text"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}
</style>
</head>
<body>
<form action="/web/VerifyOTPServlet" method="post">
        <h1>FORGOT PASSWORD</h1>
        <label for="otp">Enter OTP:</label>
        <input type="text" id="otp" name="otp" placeholder="Enter OTP" required>
        <input type="submit" value="Verify">
    </form>
</body>
</html>