package com.foodiedelight.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/UpdateStatus")
@SuppressWarnings("serial")
public class UpdateStatus extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("user") instanceof Users) {
			Users user = (Users) session.getAttribute("user");
			if ("SuperAdmin".equals(user.getUserRole())) {
				String status = req.getParameter("status");
				String idStr = req.getParameter("RestaurantID");
				try {
					int restaurantId = idStr != null && !idStr.trim().isEmpty() ? Integer.parseInt(idStr) : 0;
					if (restaurantId > 0) {
						String newStatus = "Accepting".equals(status) ? "Accepting" : "Not Accepting";
						RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
						restaurantsDaoImpl.updateRestaurantOrderStatus(restaurantId, newStatus);
						if ("Not Accepting".equals(newStatus)) {
							session.setAttribute("notification", "Restaurant is now successfully closed to orders.");
						} else {
							session.setAttribute("notification", "Restaurant is now successfully open for orders.");
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
				resp.sendRedirect("RestaurantsView");
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
