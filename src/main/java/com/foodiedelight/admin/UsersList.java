package com.foodiedelight.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/UsersList")
@SuppressWarnings("serial")
public class UsersList extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");
				String roleFilter = req.getParameter("Role");
				String statusFilter = req.getParameter("Status");

				UsersDaoImpl usersDaoImpl = new UsersDaoImpl();
				List<Users> filteredUsers = null;

				if (statusFilter != null && !statusFilter.isEmpty()) {
					filteredUsers = usersDaoImpl.getUsersByStatus(statusFilter);
				} else if (roleFilter != null && !roleFilter.isEmpty()) {
					filteredUsers = usersDaoImpl.getUserByRole(roleFilter);
				} else {
					filteredUsers = usersDaoImpl.getAllUsers();
				}

				req.setAttribute("userData", filteredUsers);
				req.getRequestDispatcher("admin/all-users.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
