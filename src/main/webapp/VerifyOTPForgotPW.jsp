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
<form action="/web/VerifyOTPServletForgotPW" method="post">
<h1>Verify OTP</h1>

	<h3>Opt code has been sent, please enter here</h3>
    <label>Enter OTP: </label>
    <input type="text" name="otp"  placeholder="Enter OTP" required><br>
    <input type="submit" value="Verify">
</form>
</body>
</html>