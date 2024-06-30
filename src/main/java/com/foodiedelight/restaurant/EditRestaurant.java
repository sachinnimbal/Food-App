package com.foodiedelight.restaurant;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/EditRestaurant")
@SuppressWarnings("serial")
public class EditRestaurant extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
				String RestaurantIDStr = req.getParameter("RestaurantID");
				int RestaurantID = Integer.parseInt(RestaurantIDStr);

				Restaurants restaurant = restaurantsDaoImpl.getRestaurantById(RestaurantID);
				
				req.setAttribute("restaurant", restaurant);
				req.getRequestDispatcher("restaurant/edit-restaurant.jsp").forward(req, resp);

			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
