package LoginAndRegister;

import java.io.IOException;
import jakarta.mail.PasswordAuthentication;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;
import jakarta.mail.Session;
import jakarta.mail.Authenticator;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import java.util.Properties;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Random;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;


import org.apache.http.client.fluent.Request;

import Class.GooglePoJo;
import Class.GoogleUtils;

/**
* Servlet implementation class LoginGoogleServlet
*/
public class LoginGoogleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	* @see HttpServlet#HttpServlet()
	*/
	public LoginGoogleServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	* @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	*/
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String code = request.getParameter("code");
	    System.out.println(code);
	    if (code == null || code.isEmpty()) {
	        RequestDispatcher dis = request.getRequestDispatcher("google.jsp");
	        dis.forward(request, response);
	    } else {
	        String accessToken = GoogleUtils.getToken(code);
	        GooglePoJo googlePojo = GoogleUtils.getUserInfo(accessToken);

	        // Lưu thông tin người dùng vào session nếu cần
	        HttpSession session = request.getSession();
	        session.setAttribute("user", googlePojo);

	        // Chuyển hướng sang trang FE/FE.jsp
	        response.sendRedirect("FE/FE.jsp");
	    }
	}

	/**
	* @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	*/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, 
IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}