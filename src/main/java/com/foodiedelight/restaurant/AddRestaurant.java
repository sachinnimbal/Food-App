package com.foodiedelight.restaurant;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/AddRestaurant")
@SuppressWarnings("serial")
public class AddRestaurant extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				req.setAttribute("hideAlert", true);
				RestaurantsDaoImpl restaurantsDao = new RestaurantsDaoImpl();
				if (!restaurantsDao.restaurantNeedsUpdate(user.getUserID())) {
					resp.sendRedirect("RestaurantHome");
				} else {
					req.getRequestDispatcher("restaurant/add-restaurant.jsp").forward(req, resp);
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
