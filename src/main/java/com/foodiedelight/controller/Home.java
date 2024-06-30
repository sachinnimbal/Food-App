package com.foodiedelight.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodiedelight.daoimpl.CuisineDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Cuisine;
import com.foodiedelight.model.Restaurants;

@WebServlet("/UserHome")
@SuppressWarnings("serial")
public class Home extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");

		RestaurantsDaoImpl restaurantDaoI = new RestaurantsDaoImpl();
		CuisineDaoImpl cuisineDaoImpl = new CuisineDaoImpl();
		List<Restaurants> allRestaurant = restaurantDaoI.getAllRestaurants();
		List<Restaurants> topRatedRestaurants = restaurantDaoI.findTopRatedRestaurants();
//		List<Restaurants> restaurantsByType = restaurantDaoI.findRestaurantsByType("Veg");
		List<Cuisine> allCuisines = cuisineDaoImpl.getAllCuisines();

		req.setAttribute("allRestaurant", allRestaurant);

		req.setAttribute("topRestaurants", topRatedRestaurants);

		req.setAttribute("allCuisine", allCuisines);

		req.getRequestDispatcher("index.jsp").forward(req, resp);
	}

}
