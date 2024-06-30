package com.foodiedelight.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/AdminHome")
@SuppressWarnings("serial")
public class AdminHome extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");

				RestaurantsDaoImpl restaurantDaoI = new RestaurantsDaoImpl();
				UsersDaoImpl usersDaoImpl = new UsersDaoImpl();
				OrdersDaoImpl ordersDaoImpl = new OrdersDaoImpl();
				MenuItemsDaoImpl menuItemsDaoImpl = new MenuItemsDaoImpl();
				List<Users> allUsers = usersDaoImpl.getAllUsers();
				List<Users> customerRole = usersDaoImpl.getUserByRole("Customer");
				List<Users> restaurantRole = usersDaoImpl.getUserByRole("RestaurantOwner");
				List<Users> agentRole = usersDaoImpl.getUserByRole("DeliveryPerson");
				List<Orders> allOrders = ordersDaoImpl.getAllOrders();
				List<Restaurants> allRestaurant = restaurantDaoI.getAllRestaurants();
				List<MenuItems> allMenuItems = menuItemsDaoImpl.getAllMenuItems();
				int totalRestaurantCount = allRestaurant.size();
				int totalUserCount = allUsers.size();
				int totalOrderCount = allOrders.size();
				int totalCustomerCount = customerRole.size();
				int totalOwnersCount = restaurantRole.size();
				int totalAgentCount = agentRole.size();
				int totalMenuItems = allMenuItems.size();
				int activeUsersCount = usersDaoImpl.countUsersByStatus("Active");
				int inactiveUsersCount = usersDaoImpl.countUsersByStatus("Inactive");
				int suspendedUsersCount = usersDaoImpl.countUsersByStatus("Suspended");
				int totalPending = ordersDaoImpl.countOrdersByStatus("Pending");
				int totalInProgress = ordersDaoImpl.countOrdersByStatus("In Progress");
				int totalCancelled = ordersDaoImpl.countOrdersByStatus("Cancelled");
				int totalDelivered = ordersDaoImpl.countOrdersByStatus("Delivered");

				req.setAttribute("totalRestaurantCount", totalRestaurantCount);
				req.setAttribute("totalUserCount", totalUserCount);
				req.setAttribute("totalOrderCount", totalOrderCount);
				req.setAttribute("totalCustomerCount", totalCustomerCount);
				req.setAttribute("totalOwnersCount", totalOwnersCount);
				req.setAttribute("totalAgentCount", totalAgentCount);
				req.setAttribute("activeUsersCount", activeUsersCount);
				req.setAttribute("inactiveUsersCount", inactiveUsersCount);
				req.setAttribute("suspendedUsersCount", suspendedUsersCount);
				req.setAttribute("totalMenuItems", totalMenuItems);
				req.setAttribute("totalPending", totalPending);
				req.setAttribute("totalInProgress", totalInProgress);
				req.setAttribute("totalCancelled", totalCancelled);
				req.setAttribute("totalDelivered", totalDelivered);
				
				resp.setContentType("text/html; charset=UTF-8");
				req.getRequestDispatcher("admin/index.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
