package com.foodiedelight.restaurant;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@SuppressWarnings("serial")
@WebServlet("/RestaurantAdd")
@MultipartConfig
public class RestaurantAdd extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				try {
					RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
					Restaurants restaurant = new Restaurants();
					addRestaurant(req, user, restaurant);
					restaurantsDaoImpl.addRestaurant(restaurant);

					session.setAttribute("notification", "Your restaurant details were saved successfully. 🎉");
					resp.sendRedirect("RestaurantHome");
				} catch (NumberFormatException e) {
					handleException("Invalid average cost value.", e, session, resp);
				} catch (Exception e) {
					handleException("An error occurred. Please try again.", e, session, resp);
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

	public void addRestaurant(HttpServletRequest req, Users user, Restaurants restaurant)
			throws IOException, ServletException {
		restaurant.setOwnerID(user.getUserID());
		restaurant.setName(req.getParameter("name"));
		restaurant.setContactInfo(req.getParameter("contactInfo"));
		restaurant.setETA(req.getParameter("eTA"));
		BigDecimal avgCost = new BigDecimal(
				req.getParameter("averageCost") != null ? req.getParameter("averageCost") : "0");
		restaurant.setAverageCost(avgCost);
		restaurant.setCuisineTypes(req.getParameter("cuisineTypes"));
		restaurant.setDiscounts(req.getParameter("discounts"));
		restaurant.setStreet(req.getParameter("street"));
		restaurant.setCity(req.getParameter("cityName"));
		restaurant.setState(req.getParameter("state"));
		restaurant.setPinCode(req.getParameter("pinCode"));
		restaurant.setType(req.getParameter("type"));
		restaurant.setDescription(req.getParameter("description"));
		restaurant.setOpeningTime(req.getParameter("openTime"));
		restaurant.setClosingTime(req.getParameter("closeTime"));
		restaurant.setTags(req.getParameter("tagSelection"));
		
		Part filePart = req.getPart("imageURL");
		String fileName = UUID.randomUUID().toString() + "-"
				+ Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		Path imagesDir = Paths.get(getServletContext().getRealPath("RestaurantImages/"));
		Files.createDirectories(imagesDir);
		Path filePath = imagesDir.resolve(fileName);
		filePart.write(filePath.toString());
		restaurant.setImageURL(fileName);
		System.out.println("Images directory path: " + imagesDir.toString());
		Files.createDirectories(imagesDir);
	}

	private void handleException(String message, Exception e, HttpSession session, HttpServletResponse resp)
			throws IOException {
		e.printStackTrace();
		session.setAttribute("notification", message);
		resp.sendRedirect("AddRestaurant");
	}
}
