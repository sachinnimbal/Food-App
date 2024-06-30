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

@WebServlet("/RestaurantUpdate")
@MultipartConfig
@SuppressWarnings("serial")
public class RestaurantUpdate extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (session != null && session.getAttribute("user") instanceof Users) {
			Users user = (Users) session.getAttribute("user");
			if ("RestaurantOwner".equals(user.getUserRole())) {
				RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
				String idStr = req.getParameter("RestaurantID");
				try {
					int restaurantId = idStr != null && !idStr.trim().isEmpty() ? Integer.parseInt(idStr) : 0;
					if (restaurantId > 0) {
						Restaurants restaurant = restaurantsDaoImpl.getRestaurantById(restaurantId);
						if (restaurant != null) {
							updateRestaurantDetailsFromRequest(restaurant, req);
							restaurantsDaoImpl.updateRestaurant(restaurant);
							session.setAttribute("notification",
									"Your restaurant details were updated successfully. 🎉");
						} else {
							session.setAttribute("notification", "Restaurant not found.");
						}
					} else {
						session.setAttribute("notification", "Invalid Restaurant ID.");
					}
				} catch (NumberFormatException e) {
					session.setAttribute("notification", "Invalid Restaurant ID format.");
				} catch (Exception e) {
					session.setAttribute("notification", "An error occurred. Please try again.");
					e.printStackTrace();
				}
				resp.sendRedirect("RestaurantHome");
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

	private void updateRestaurantDetailsFromRequest(Restaurants restaurant, HttpServletRequest req)
			throws IOException, ServletException {
		restaurant.setName(req.getParameter("nameUpdate"));
		restaurant.setContactInfo(req.getParameter("contactInfoUpdate"));
		restaurant.setETA(req.getParameter("etaUpdate"));
		BigDecimal avgCost = new BigDecimal(
				req.getParameter("averageCostUpdate") != null ? req.getParameter("averageCostUpdate") : "0");
		restaurant.setAverageCost(avgCost);
		restaurant.setCuisineTypes(req.getParameter("cuisineTypesUpdate"));
		restaurant.setDiscounts(req.getParameter("discountsUpdate"));
		restaurant.setStreet(req.getParameter("streetUpdate"));
		restaurant.setCity(req.getParameter("cityNameUpdate"));
		restaurant.setState(req.getParameter("stateUpdate"));
		restaurant.setPinCode(req.getParameter("pinCodeUpdate"));
		restaurant.setType(req.getParameter("typeUpdate"));
		restaurant.setDescription(req.getParameter("descriptionUpdate"));
		restaurant.setOpeningTime(req.getParameter("openTimeUpdate"));
		restaurant.setClosingTime(req.getParameter("closeTimeUpdate"));
		restaurant.setTags(req.getParameter("tagSelectionUpdate"));

//  	This is storing in folder path but not displaying quick
//		Part filePart = req.getPart("imageURL");
//		if (filePart != null && filePart.getSize() > 0) {
//			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//			String projectPath = "/Users/sachinskn/git/repository/sknfoodapp/src/main/webapp/RestaurantImages/";
//			Path imagesDir = Paths.get(projectPath);
//			Files.createDirectories(imagesDir);
//			Path filePath = imagesDir.resolve(fileName);
//			filePart.write(filePath.toString());
//			System.out.println("Image saved to path: " + filePath.toString());
//			restaurant.setImageURL(fileName);
//		} 

		// This is storing in server temp displaying immediately
		Part filePart = req.getPart("imageUpdateURL");
		if (filePart != null && filePart.getSize() > 0) {
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
	}
}
