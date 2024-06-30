package com.foodiedelight.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

@WebServlet("/Cuisines")
@SuppressWarnings("serial")
public class ViewCuisines extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");

        CuisineDaoImpl cuisineDaoImpl = new CuisineDaoImpl();
        String cuisineIDStr = req.getParameter("cuisineID");
        int cuisineID;

        try {
            cuisineID = Integer.parseInt(cuisineIDStr);
        } catch (NumberFormatException e) {
            resp.getWriter().println("Invalid cuisine ID.");
            return;
        }

        Cuisine cuisine = cuisineDaoImpl.getCuisineByID(cuisineID);
        if (cuisine == null) {
            resp.getWriter().println("Cuisine ID or cuisine type name is missing or invalid.");
            return;
        }

        String cuisineTypeName = cuisine.getCuisineName();
        boolean isVegCuisine = "Pure Veg".equalsIgnoreCase(cuisineTypeName) || "Veg".equalsIgnoreCase(cuisineTypeName);

        RestaurantsDaoImpl restaurantDaoI = new RestaurantsDaoImpl();
        List<Restaurants> allRestaurants = restaurantDaoI.getAllRestaurants();
        List<Restaurants> matchingRestaurants = new ArrayList<>();

        for (Restaurants restaurant : allRestaurants) {
            boolean matchesCuisineType = Arrays.asList(restaurant.getCuisineTypes().split(",\\s*")).contains(cuisineTypeName);
            boolean matchesTags = Arrays.asList(restaurant.getTags().split(",\\s*")).contains(cuisineTypeName);

            if ((isVegCuisine && "Veg".equalsIgnoreCase(restaurant.getType())) || matchesCuisineType || matchesTags) {
                matchingRestaurants.add(restaurant);
            }
        }

        req.setAttribute("cuisine", cuisine);
        req.setAttribute("restaurants", matchingRestaurants);

        req.getRequestDispatcher("Cuisines.jsp").forward(req, resp);
    }
}
