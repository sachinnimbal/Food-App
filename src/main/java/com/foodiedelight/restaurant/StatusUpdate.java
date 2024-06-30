package com.foodiedelight.restaurant;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/StatusUpdate")
@SuppressWarnings("serial")
public class StatusUpdate extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("user") instanceof Users) {
			Users user = (Users) session.getAttribute("user");
			if ("RestaurantOwner".equals(user.getUserRole())) {
				String status = req.getParameter("status");
				String idStr = req.getParameter("RestaurantID");
				try {
					int restaurantId = Integer.parseInt(idStr);
//					String newStatus = "Open".equals(status) ? "Open" : "Closed";
//					RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
//					restaurantsDaoImpl.updateRestaurantStatus(restaurantId, newStatus);
//					if ("Closed".equals(newStatus)) {
//						session.setAttribute("notification", "Your restaurant is now closed successfully.");
//					} else {
//						session.setAttribute("notification", "Your restaurant is open now successfully.");
//					}
					String newStatus = "Accepting".equals(status) ? "Accepting" : "Not Accepting";
					RestaurantsDaoImpl restaurantsDaoImpl = new RestaurantsDaoImpl();
					restaurantsDaoImpl.updateRestaurantOrderStatus(restaurantId, newStatus);
					if ("Not Accepting".equals(newStatus)) {
						session.setAttribute("notification", "Your restaurant is now successfully closed to orders.");
					} else {
						session.setAttribute("notification", "Your restaurant is now successfully open for orders.");
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
}
