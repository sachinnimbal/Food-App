package com.foodiedelight.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Restaurants;

@WebServlet("/RestaurantServlet")
@SuppressWarnings("serial")
public class RestaurantServlet extends HttpServlet {

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html; charset=UTF-8");

		RestaurantsDaoImpl restaurantDaoI = new RestaurantsDaoImpl();
		String sort = req.getParameter("sort");
		List<Restaurants> allRestaurant = restaurantDaoI.getAllRestaurants();

		if ("highToLow".equals(sort)) {
		    Collections.sort(allRestaurant, (r1, r2) -> r2.getAverageCost().compareTo(r1.getAverageCost()));
		} else {
		    Collections.sort(allRestaurant, (r1, r2) -> r1.getAverageCost().compareTo(r2.getAverageCost()));
		}

		req.setAttribute("allRestaurant", allRestaurant);

		RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
		rd.forward(req, resp);

	}

}
