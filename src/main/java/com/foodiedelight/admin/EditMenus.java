package com.foodiedelight.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Users;

@WebServlet("/EditMenus")
@SuppressWarnings("serial")
public class EditMenus extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");
				String itemIdStr = req.getParameter("itemId");
				int itemId = Integer.parseInt(itemIdStr);
				MenuItemsDaoImpl itemsDaoImpl = new MenuItemsDaoImpl();
				MenuItems menuItems = itemsDaoImpl.getMenuItemById(itemId);

				req.setAttribute("menuItems", menuItems);
				req.getRequestDispatcher("admin/menuEdit.jsp").forward(req, resp);

			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
