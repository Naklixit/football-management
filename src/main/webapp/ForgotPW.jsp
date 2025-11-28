<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">

</head>
<body>
 <form action="/web/ForgotPWServlet" method="post">
        <h1>Verify OTP</h1>
        <label for="email">Enter your email:</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>
        <input type="submit" value="Confirm">
    </form>
</body>
</html>