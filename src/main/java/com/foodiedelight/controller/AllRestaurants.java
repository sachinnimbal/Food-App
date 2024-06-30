package com.foodiedelight.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Restaurants;

@WebServlet("/Restaurants")
@SuppressWarnings("serial")
public class AllRestaurants extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		RestaurantsDaoImpl restaurantDaoI = new RestaurantsDaoImpl();
		List<Restaurants> allRestaurant = restaurantDaoI.getAllRestaurants();

		req.setAttribute("allRestaurant", allRestaurant);
		req.getRequestDispatcher("allRestaurants.jsp").forward(req, resp);

	}
}
