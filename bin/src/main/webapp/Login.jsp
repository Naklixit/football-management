<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<body>
<form action="/web/LoginServlet" method="post">
   <label>Email </label>
   <input type="email" id="email" name="email" placeholder="Enter your email"><br>
   <label>Password </label>
   <input type="password" id="password" name="password" placeholder="Enter your password"><br>
   <a href="Register.jsp">Don't have any account? Register here!</a><br>
   <a href="ForgotPW.jsp">Forgot password?</a><br>
   <input type="submit" name="submit" value="Login"><br>
   <a href="https://accounts.google.com/o/oauth2/auth?
	scope=email&redirect_uri=http://localhost:8080/web/LoginGoogleServlet&
	response_type=code&client_id=436983108024-khfo2q11hqaggck6odbmgi5f5id1utiq.apps.googleusercontent.com
	&approval_prompt=force" class="google-btn"><i class="fab fa-google"></i> Sign in with Google</a>
</form>
</body>
</html>
