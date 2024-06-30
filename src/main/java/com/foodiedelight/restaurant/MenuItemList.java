package com.foodiedelight.restaurant;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/MenuItemList")
@SuppressWarnings("serial")
public class MenuItemList extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				RestaurantsDaoImpl restaurants = new RestaurantsDaoImpl();
				MenuItemsDaoImpl menus = new MenuItemsDaoImpl();

				String restaurantIdStr = req.getParameter("RestaurantID");
				int restaurantId = Integer.parseInt(restaurantIdStr);

				Restaurants restaurant = restaurants.getRestaurantById(restaurantId);
				List<MenuItems> restaurantMenu = menus.getMenuItemsByRestaurantId(restaurantId);

				req.setAttribute("restaurant", restaurant);
				req.setAttribute("menus", restaurantMenu);

				if (restaurantMenu == null || restaurantMenu.isEmpty()) {
					req.setAttribute("noMenuAlert", "No menus found for this restaurant. Please come back later.");
				}

				RequestDispatcher rd = req.getRequestDispatcher("restaurant/restaurantMenu.jsp");
				rd.forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}

	}

}
