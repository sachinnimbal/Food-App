package com.foodiedelight.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/EditUser")
@SuppressWarnings("serial")
public class EditUser extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");
				String userIdStr = req.getParameter("userId");
				int userId = Integer.parseInt(userIdStr);
				UsersDaoImpl usersDao = new UsersDaoImpl();
				Users userById = usersDao.getUserById(userId);

				req.setAttribute("userToEdit", userById);
				req.getRequestDispatcher("admin/userToEdit.jsp").forward(req, resp);

			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
