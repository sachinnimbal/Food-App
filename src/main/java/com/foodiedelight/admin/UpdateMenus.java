package com.foodiedelight.admin;

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
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Users;

@WebServlet("/UpdateMenus")
@MultipartConfig
@SuppressWarnings("serial")
public class UpdateMenus extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		if (session != null && session.getAttribute("user") instanceof Users) {
			Users user = (Users) session.getAttribute("user");
			if ("SuperAdmin".equals(user.getUserRole())) {
				MenuItemsDaoImpl itemsDaoImpl = new MenuItemsDaoImpl();
				String idStr = req.getParameter("itemID");
				try {
					int itemID = idStr != null && !idStr.trim().isEmpty() ? Integer.parseInt(idStr) : 0;
					if (itemID > 0) {
						MenuItems menuItem = itemsDaoImpl.getMenuItemById(itemID);
						if (menuItem != null) {
							updateMenuItemDetailsFromRequest(menuItem, req);
							itemsDaoImpl.updateMenuItem(menuItem);
							session.setAttribute("notification", "Menu item details were updated successfully. 🎉");
						} else {
							session.setAttribute("notification", "Menu item not found.");
						}
					} else {
						session.setAttribute("notification", "Invalid Menu Item ID.");
					}
				} catch (NumberFormatException e) {
					session.setAttribute("notification", "Invalid Menu Item ID format.");
				} catch (Exception e) {
					session.setAttribute("notification", "An error occurred. Please try again.");
					e.printStackTrace();
				}
				resp.sendRedirect("AllMenus");
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

	private void updateMenuItemDetailsFromRequest(MenuItems menuItem, HttpServletRequest req)
			throws IOException, ServletException {
		menuItem.setName(req.getParameter("itemNameUpdate"));
		String description = req.getParameter("itemDescriptionUpdate");
		description = (description == null || description.trim().isEmpty()) ? "" : description;
		menuItem.setDescription(description);

		BigDecimal itemPrice = new BigDecimal(
				req.getParameter("itemPriceUpdate") != null ? req.getParameter("itemPriceUpdate") : "0");
		menuItem.setPrice(itemPrice);
		menuItem.setStatus(req.getParameter("itemStatusUpdate"));
		menuItem.setType(req.getParameter("itemTypeUpdate"));

		Part filePart = req.getPart("photoURLUpdate");
		if (filePart != null && filePart.getSize() > 0) {
			String fileName = UUID.randomUUID().toString() + "-"
					+ Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			Path imagesDir = Paths.get(getServletContext().getRealPath("FoodItems/"));
			Files.createDirectories(imagesDir);
			Path filePath = imagesDir.resolve(fileName);
			filePart.write(filePath.toString());
			menuItem.setPhotoURL(fileName);
		}
	}
}
