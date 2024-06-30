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

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/MenuAdd")
@SuppressWarnings("serial")
@MultipartConfig
public class AddMenuItems extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				int userID = user.getUserID();
				RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
				Restaurants restaurant = restaurantsDaoImpl.getRestaurantByOwnerId(userID);
				if (restaurant != null) {
					System.out.println("Current User Restaurant ID: " + restaurant.getRestaurantID());
					int restaurantID = restaurant.getRestaurantID();
					MenuItemsDaoImpl menuItems = new MenuItemsDaoImpl();
					menuItems.addMenuItem(createMenuItemFromRequest(req, restaurantID));
					session.setAttribute("notification", "Your restaurant menu item were saved successfully. 🎉");
					resp.sendRedirect("AddMenu");
				} else {
					System.out.println("No restaurant found for the current user.");
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

	private MenuItems createMenuItemFromRequest(HttpServletRequest req, int restaurantID)
			throws IOException, ServletException {
		MenuItems menuItem = new MenuItems();
		menuItem.setRestaurantID(restaurantID);
		menuItem.setName(req.getParameter("itemName"));
		menuItem.setDescription(req.getParameter("itemDescription"));
		menuItem.setPrice(new BigDecimal(req.getParameter("itemPrice")));
		menuItem.setStatus(req.getParameter("itemStatus"));
		menuItem.setType(req.getParameter("itemType"));

		Part filePart = req.getPart("photoURL");
		String fileName = UUID.randomUUID().toString() + "-"
				+ Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		Path imagesDir = Paths.get(getServletContext().getRealPath("FoodItems/"));
		Files.createDirectories(imagesDir);
		Path filePath = imagesDir.resolve(fileName);
		filePart.write(filePath.toString());
		menuItem.setPhotoURL(fileName);
		System.out.println("Images directory path: " + imagesDir.toString());
		Files.createDirectories(imagesDir);

		return menuItem;
	}

}
