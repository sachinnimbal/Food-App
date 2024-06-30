package com.foodiedelight.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/RestaurantsView")
@SuppressWarnings("serial")
public class RestaurantsView extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");
				RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
				List<Restaurants> allRestaurants = restaurantsDaoImpl.getAllRestaurants();
				
				req.setAttribute("restaurantsGrid", allRestaurants);
				req.setAttribute("restaurantsTable", allRestaurants);
				System.out.println("Restaurants fetched: " + (allRestaurants == null ? "None" : allRestaurants.size()));

                resp.setContentType("text/html; charset=UTF-8");
				req.getRequestDispatcher("admin/restaurantsView.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
