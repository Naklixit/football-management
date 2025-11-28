package LoginAndRegister;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class VerifyOTPServlet
 */
public class VerifyOTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userOtp = request.getParameter("otp");
        String sessionOtp = (String) request.getSession().getAttribute("otp");

        if (userOtp != null && userOtp.equals(sessionOtp)) {
        	response.sendRedirect("FE/FE.jsp");
        } else {
            response.getWriter().println("<h3>Invalid OTP. Please try again.</h3>");
            request.getRequestDispatcher("VerifyOTP.jsp").include(request, response);
        }
    }
}
