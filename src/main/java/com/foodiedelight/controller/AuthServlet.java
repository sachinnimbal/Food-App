package com.foodiedelight.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.SecurityUtils;
import com.foodiedelight.model.Users;

@WebServlet("/AuthServlet")
@SuppressWarnings("serial")
public class AuthServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		UsersDaoImpl userDaoImpl = new UsersDaoImpl();
		Users validUser = userDaoImpl.validUser(username);

		HttpSession session = req.getSession();

		boolean redirected = false;

		if (validUser != null) {
			try {
				String hashedInputPassword = SecurityUtils.hashPassword(password);
				String storedPassword = validUser.getPassword();

				if (hashedInputPassword.equals(storedPassword)) {
					// Passwords match, check user status
					String status = validUser.getStatus();
					switch (status) {
					case "Active":
						session.setAttribute("user", validUser);
						Cookie lastLoginCookie = new Cookie("lastLogin", System.currentTimeMillis() + "");
						lastLoginCookie.setMaxAge(24 * 60 * 60);
						resp.addCookie(lastLoginCookie);
						session.setAttribute("notification",
								"Welcome, " + username + "! Your account has been successfully logged in. 🎉");
						redirected = redirectToHome(resp, validUser.getUserRole());
						break;
					case "Inactive":
						session.setAttribute("loginFailed", "Your account has been inactive. Please contact support.");
						resp.sendRedirect("UserHome");
						redirected = true;
						break;
					case "Suspended":
						session.setAttribute("loginFailed", "Your account has been suspended. Please contact support.");
						resp.sendRedirect("UserHome");
						redirected = true;
						break;
					default:
						session.setAttribute("loginFailed", "Unexpected status. Please contact support.");
						resp.sendRedirect("UserHome");
						redirected = true;
						break;
					}
				} else {
					session.setAttribute("loginFailed", "Invalid username or password. Please try again.");
					resp.sendRedirect("UserHome");
					redirected = true;
				}
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
				session.setAttribute("loginFailed", "An error occurred. Please try again.");
				resp.sendRedirect("UserHome");
				redirected = true;
			}
		} else {
			session.setAttribute("loginFailed", "Invalid username or password. Please try again.");
			resp.sendRedirect("UserHome");
			redirected = true;
		}

		if (!redirected) {
			resp.sendRedirect("UserHome");
		}
	}

	private boolean redirectToHome(HttpServletResponse resp, String userRole) throws IOException {
		switch (userRole) {
		case "Customer":
			resp.sendRedirect("UserHome");
			return true;
		case "RestaurantOwner":
			resp.sendRedirect("RestaurantHome");
			return true;
		case "DeliveryPerson":
			resp.sendRedirect("AgentHome");
			return true;
		case "SuperAdmin":
			resp.sendRedirect("AdminHome");
			return true;
		default:
			resp.sendRedirect("UserHome");
			return true;
		}
	}
}
