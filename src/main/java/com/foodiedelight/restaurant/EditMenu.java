package com.foodiedelight.restaurant;

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

@WebServlet("/EditMenu")
@SuppressWarnings("serial")
public class EditMenu extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");
				String itemIdStr = req.getParameter("ItemID");
				int itemId = Integer.parseInt(itemIdStr);

				MenuItemsDaoImpl itemsDaoImpl = new MenuItemsDaoImpl();
				String action = req.getParameter("action");

				if ("edit".equals(action)) {
					MenuItems menuItems = itemsDaoImpl.getMenuItemById(itemId);
					req.setAttribute("menuItems", menuItems);
					req.getRequestDispatcher("restaurant/menu-Edit.jsp").forward(req, resp);
				} else if ("update".equals(action)) {
					String currentStatus = itemsDaoImpl.getStatus(itemId);
					if (currentStatus != null) {
						String newStatus = "Available".equals(currentStatus) ? "Not Available" : "Available";
						itemsDaoImpl.updateStatus(itemId, newStatus);
						session.setAttribute("notification", "Status updated successfully.");
						resp.sendRedirect("RestaurantHome"); 
					}
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
