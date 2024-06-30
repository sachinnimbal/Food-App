package com.foodiedelight.agent;

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

import com.foodiedelight.daoimpl.AgentsDaoImpl;
import com.foodiedelight.daoimpl.DeliveryInfoDaoImpl;
import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.OrderItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.PaymentDetailsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.Agents;
import com.foodiedelight.model.DeliveryInfo;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/AgentHome")
@SuppressWarnings("serial")
public class AgentHome extends HttpServlet {

	private AgentsDaoImpl agentsDaoImpl;

	@Override
	public void init() throws ServletException {
		agentsDaoImpl = new AgentsDaoImpl();
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "DeliveryPerson".equals(user.getUserRole())) {
				boolean needsUpdate = agentsDaoImpl.agentNeedsUpdate(user.getUserID());
				if (needsUpdate) {
					req.setAttribute("alert", "Please update your details immediately.");
					req.getRequestDispatcher("agent/index.jsp").forward(req, resp);
				} else {
					Agents agent = agentsDaoImpl.getAgentByUserId(user.getUserID());
					if (agent != null) {

						deliveryCheck(req, resp, user);
						req.setAttribute("agent", agent);

						req.getRequestDispatcher("agent/index.jsp").forward(req, resp);

					} else {
						
						System.out.println("No agent found for the current user.");
						req.getRequestDispatcher("agent/index.jsp").forward(req, resp);
						
					}
				}
			} else {
				System.out.println("No orders received for the delivery agent.");
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

	public static void deliveryCheck(HttpServletRequest req, HttpServletResponse resp, Users user)
			throws ServletException, IOException {
		OrdersDaoImpl ordersDao = new OrdersDaoImpl();
		OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
		MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();
		PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
		UsersDaoImpl userDao = new UsersDaoImpl();
		DeliveryInfoDaoImpl deliveryInfoDao = new DeliveryInfoDaoImpl();
		RestaurantsDaoImpl restaurantsDao = new RestaurantsDaoImpl();

		List<DeliveryInfo> assignedDeliveries = deliveryInfoDao.getDeliveriesByDeliveryPersonnelID(user.getUserID());
		Map<Integer, List<OrderItems>> orderItemsMap = new HashMap<>();
		Map<Integer, Orders> ordersMap = new HashMap<>();
		Map<Integer, MenuItems> menuItemsMap = new HashMap<>();
		Map<Integer, PaymentDetails> paymentDetailsMap = new HashMap<>();
		Map<Integer, Users> customerMap = new HashMap<>();
		Map<Integer, Restaurants> restaurantMap = new HashMap<>();
		int totalDelivered = 0;
	    int totalOutForDelivery = 0;

		for (DeliveryInfo delivery : assignedDeliveries) {
			List<OrderItems> orderItems = orderItemsDao.getOrderItemsByOrderId(delivery.getOrderID());
			orderItemsMap.put(delivery.getOrderID(), orderItems);
			Orders order = ordersDao.getOrderById(delivery.getOrderID());
			if (order != null) {
				ordersMap.put(delivery.getOrderID(), order);
				if ("Delivered".equals(delivery.getStatus())) {
	                totalDelivered++;
	            } else if ("Out For Delivery".equals(delivery.getStatus())) {
	                totalOutForDelivery++;
	            }
			}

			for (OrderItems item : orderItems) {
				MenuItems menuItem = menuItemsDao.getMenuItemById(item.getItemID());
				if (menuItem != null) {
					menuItemsMap.put(item.getItemID(), menuItem);
				}
			}

			PaymentDetails paymentDetails = paymentDetailsDao.getPaymentDetailsByOrderId(delivery.getOrderID());
			if (paymentDetails != null) {
				paymentDetailsMap.put(delivery.getOrderID(), paymentDetails);
			}

			Users customer = userDao.getUserById(order.getUserID());
			if (customer != null) {
				customerMap.put(customer.getUserID(), customer);
			}

			Restaurants restaurant = restaurantsDao.getRestaurantById(order.getRestaurantID());
			if (restaurant != null) {
				restaurantMap.put(order.getRestaurantID(), restaurant);
			}
		}

		req.setAttribute("assignedDeliveries", assignedDeliveries);
		req.setAttribute("ordersMap", ordersMap);
		req.setAttribute("orderItemsMap", orderItemsMap);
		req.setAttribute("menuItemsMap", menuItemsMap);
		req.setAttribute("paymentDetailsMap", paymentDetailsMap);
		req.setAttribute("customerMap", customerMap);
		req.setAttribute("restaurantMap", restaurantMap);
	    req.setAttribute("totalDelivered", totalDelivered);
	    req.setAttribute("totalOutForDelivery", totalOutForDelivery);
	}

}
