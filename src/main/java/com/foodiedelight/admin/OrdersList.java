package com.foodiedelight.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.OrderItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.PaymentDetailsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/OrdersList")
@SuppressWarnings("serial")
public class OrdersList extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				try {
					int restaurantID = Integer.parseInt(req.getParameter("RestaurantID"));
					RestaurantsDaoImpl restaurantsDao = new RestaurantsDaoImpl();
					Restaurants restaurant = restaurantsDao.getRestaurantById(restaurantID);

					if (restaurant != null) {
						OrdersDaoImpl ordersDao = new OrdersDaoImpl();
						OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
						MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();
						PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
						UsersDaoImpl userDao = new UsersDaoImpl();

						List<Orders> ordersList = ordersDao.getOrdersByRestaurantId(restaurantID);
						Map<Integer, List<OrderItems>> orderItemsMap = new HashMap<>();
						Map<Integer, MenuItems> menuItemsMap = new HashMap<>();
						Map<Integer, PaymentDetails> paymentDetailsMap = new HashMap<>();
						Map<Integer, Users> userMap = new HashMap<>();

						for (Orders order : ordersList) {
							List<OrderItems> orderItems = orderItemsDao.getOrderItemsByOrderId(order.getOrderID());
							orderItemsMap.put(order.getOrderID(), orderItems);
							orderItems.forEach(item -> menuItemsMap.put(item.getItemID(),
									menuItemsDao.getMenuItemById(item.getItemID())));
							PaymentDetails paymentDetails = paymentDetailsDao
									.getPaymentDetailsByOrderId(order.getOrderID());
							if (paymentDetails != null) {
								paymentDetailsMap.put(order.getOrderID(), paymentDetails);
							}
							Users customer = userDao.getUserById(order.getUserID());
							if (customer != null) {
								userMap.put(order.getUserID(), customer);
							}
						}

						req.setAttribute("orders", ordersList);
						req.setAttribute("orderItemsMap", orderItemsMap);
						req.setAttribute("menuItemsMap", menuItemsMap);
						req.setAttribute("paymentDetailsMap", paymentDetailsMap);
						req.setAttribute("userMap", userMap);
						req.setAttribute("restaurant", restaurant);

						req.getRequestDispatcher("admin/restaurantOrders.jsp").forward(req, resp);
					} else {
						System.out.println("No restaurant found for the provided ID.");
						resp.sendRedirect("AdminHome");
					}
				} catch (NumberFormatException e) {
					System.out.println("Invalid restaurant ID provided.");
					resp.sendRedirect("AdminHome");
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
