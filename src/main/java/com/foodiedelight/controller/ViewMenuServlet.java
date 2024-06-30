package com.foodiedelight.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Restaurants;

@WebServlet("/Menus")
@SuppressWarnings("serial")
public class ViewMenuServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");

		RestaurantsDaoImpl restaurantsDao = new RestaurantsDaoImpl();
		MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();

		String restaurantIdStr = req.getParameter("restaurantId");
		int restaurantId = Integer.parseInt(restaurantIdStr);

		Restaurants restaurant = restaurantsDao.getRestaurantById(restaurantId);
		List<MenuItems> restaurantMenu = menuItemsDao.getMenuItemsByRestaurantId(restaurantId);

		req.setAttribute("restaurant", restaurant);
		req.setAttribute("isRestaurantOpen", restaurant.getStatus().equalsIgnoreCase("Open"));

		if (restaurant.getStatus().equalsIgnoreCase("Closed")
				|| restaurant.getStatus().equalsIgnoreCase("Temporarily Closed")) {
			req.setAttribute("noMenuAlert", "This restaurant is currently closed. Please come back later.");
			req.setAttribute("menus", null);
		} else if (restaurant.getOrderStatus().equalsIgnoreCase("Not Accepting")) {
			req.setAttribute("noMenuAlert",
					"This restaurant is currently not accepting any new orders. Please come back later.");
			req.setAttribute("menus", null);
		} else if (restaurantMenu == null || restaurantMenu.isEmpty()) {
			req.setAttribute("noMenuAlert", "No menus found for this restaurant. Please come back later.");
		} else {
			req.setAttribute("menus", restaurantMenu);
		}

		String restaurantType = restaurant.getType();
		req.setAttribute("restaurantType", restaurantType);
		RequestDispatcher rd = req.getRequestDispatcher("restaurant-menu.jsp");
		rd.forward(req, resp);
	}

}
