package com.foodiedelight.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.SecurityUtils;
import com.foodiedelight.model.Users;

@WebServlet("/RegisterServlet")
@SuppressWarnings("serial")
public class RegisterServlet extends HttpServlet {

	private final UsersDaoImpl usersDao = new UsersDaoImpl();

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String fullname = req.getParameter("fullname");
		String mobile = req.getParameter("mobile");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String hashedInputPassword = null;
		try {
			hashedInputPassword = SecurityUtils.hashPassword(password);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		Users users = new Users();
		HttpSession session = req.getSession();
		// Check if the username already exists
		if (usersDao.usernameExists(username)) {
			session.setAttribute("notification", "Username already exists. Please try another username.");
			resp.sendRedirect("UserHome");
			return;
		}

		users.setName(fullname);
		users.setPhoneNumber(mobile);
		users.setUserName(username);
		users.setPassword(hashedInputPassword);

		boolean register = usersDao.addUser(users);
		if (register) {
			session.setAttribute("registrationSuccess", true);
			session.setAttribute("notification", "Registered successfully ! Please log in to continue. 🎉");
			resp.sendRedirect("UserHome");
		} else {
			session.setAttribute("notification", "Registration failed. Please try again. &#128683;");
			resp.sendRedirect("UserHome");
		}

	}
}
