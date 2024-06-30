package com.foodiedelight.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Users;

@WebServlet("/AllMenus")
@SuppressWarnings("serial")
public class AllMenus extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");
				MenuItemsDaoImpl menuItemsDaoImpl = new MenuItemsDaoImpl();
				List<MenuItems> allMenuItems = menuItemsDaoImpl.getAllMenuItems();
				req.setAttribute("allMenuItems", allMenuItems);
				req.getRequestDispatcher("admin/allMenus.jsp").forward(req, resp);

			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}

	}

}
