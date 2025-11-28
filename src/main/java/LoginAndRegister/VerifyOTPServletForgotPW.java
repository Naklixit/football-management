package LoginAndRegister;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class VerifyOTPServletForgotPW
 */
public class VerifyOTPServletForgotPW extends HttpServlet {
	  @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        String enteredOTP = request.getParameter("otp");
	        HttpSession session = request.getSession();
	        String generatedOTP = (String) session.getAttribute("otp");
	        String email = (String) session.getAttribute("email");

	        PrintWriter out = response.getWriter();
	        response.setContentType("text/html");

	        if (generatedOTP != null && generatedOTP.equals(enteredOTP)) {
	            // OTP hợp lệ, chuyển hướng đến trang thay đổi mật khẩu
	            session.setAttribute("email", email); // Lưu email để sử dụng ở trang đổi mật khẩu
	            response.sendRedirect("ChangePassword.jsp");
	        } else {
	            // OTP không hợp lệ
	            out.println("<h3>Invalid OTP. Please try again.</h3>");
	            request.getRequestDispatcher("VerifyOTPForgotPW.jsp").include(request, response);
	        }
	    }
	}