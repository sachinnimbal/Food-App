package com.foodiedelight.controller;

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

import com.foodiedelight.daoimpl.AgentRatingsDaoImpl;
import com.foodiedelight.daoimpl.AgentsDaoImpl;
import com.foodiedelight.daoimpl.DeliveryInfoDaoImpl;
import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.OrderItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.PaymentDetailsDaoImpl;
import com.foodiedelight.daoimpl.RatingsReviewsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.AgentRatings;
import com.foodiedelight.model.Agents;
import com.foodiedelight.model.DeliveryInfo;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.RatingsReviews;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/OrderHistory")
@SuppressWarnings("serial")
public class OrderHistory extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "Customer".equals(user.getUserRole())) {
				OrdersDaoImpl ordersDao = new OrdersDaoImpl();
				OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
				MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();
				PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
				RestaurantsDaoImpl restaurantsDao = new RestaurantsDaoImpl();
				UsersDaoImpl userDao = new UsersDaoImpl();
				DeliveryInfoDaoImpl deliveryInfoDao = new DeliveryInfoDaoImpl();
				RatingsReviewsDaoImpl ratingsReviewsDaoImpl = new RatingsReviewsDaoImpl();
				AgentRatingsDaoImpl agentRatingsDaoImpl = new AgentRatingsDaoImpl();
				AgentsDaoImpl agentsDaoImpl = new AgentsDaoImpl();

				List<Orders> ordersList = ordersDao.getOrdersByUserId(user.getUserID());
				Map<Integer, List<OrderItems>> orderItemsMap = new HashMap<>();
				Map<Integer, MenuItems> menuItemsMap = new HashMap<>();
				Map<Integer, PaymentDetails> paymentDetailsMap = new HashMap<>();
				Map<Integer, Users> userMap = new HashMap<>();
				Map<Integer, Restaurants> restaurantMap = new HashMap<>();
				Map<Integer, DeliveryInfo> deliveryInfoMap = new HashMap<>();
				Map<Integer, Users> deliveryPersonnelMap = new HashMap<>();
				Map<Integer, RatingsReviews> ratingsMap = new HashMap<>();
				Map<Integer, Agents> agentMap = new HashMap<>();
				HashMap<Integer, AgentRatings> agentRatingsMap = new HashMap<>();

				for (Orders order : ordersList) {
					List<OrderItems> orderItems = orderItemsDao.getOrderItemsByOrderId(order.getOrderID());
					orderItemsMap.put(order.getOrderID(), orderItems);

					for (OrderItems item : orderItems) {
						MenuItems menuItem = menuItemsDao.getMenuItemById(item.getItemID());
						if (menuItem != null) {
							menuItemsMap.put(item.getItemID(), menuItem);
						}
					}

					PaymentDetails paymentDetails = paymentDetailsDao.getPaymentDetailsByOrderId(order.getOrderID());
					if (paymentDetails != null) {
						paymentDetailsMap.put(order.getOrderID(), paymentDetails);
					}

					Users customer = userDao.getUserById(order.getUserID());
					if (customer != null) {
						userMap.put(order.getUserID(), customer);
					}

					Restaurants restaurant = restaurantsDao.getRestaurantById(order.getRestaurantID());
					if (restaurant != null) {
						restaurantMap.put(restaurant.getRestaurantID(), restaurant);
						List<RatingsReviews> ratings = ratingsReviewsDaoImpl
								.getReviewsByRestaurantAndUserId(restaurant.getRestaurantID(), user.getUserID());
						if (!ratings.isEmpty()) {
							ratingsMap.put(restaurant.getRestaurantID(), ratings.get(0));
						}
					}

					DeliveryInfo deliveryInfo = deliveryInfoDao.getDeliveryInfoByOrderId(order.getOrderID());
					if (deliveryInfo != null) {
						deliveryInfoMap.put(order.getOrderID(), deliveryInfo);
						int deliveryPersonnelId = deliveryInfo.getDeliveryPersonnelID();
						if (!deliveryPersonnelMap.containsKey(deliveryPersonnelId)) {
							Users deliveryPersonnel = userDao.getUserById(deliveryPersonnelId);
							if (deliveryPersonnel != null) {
								deliveryPersonnelMap.put(deliveryPersonnelId, deliveryPersonnel);
							}
						}
						Agents agent = agentsDaoImpl.getAgentByUserId(deliveryPersonnelId);
						if (!agentMap.containsKey(deliveryPersonnelId)) {
							if (agent != null) {
								agentMap.put(deliveryPersonnelId, agent);
							}
						}
						List<AgentRatings> agentRatings = agentRatingsDaoImpl
								.getRatingsByAgentAndUserId(agent.getAgentID(), user.getUserID());
						if (!agentRatings.isEmpty()) {
							agentRatingsMap.put(agent.getAgentID(), agentRatings.get(0));
						}
					}

				}

				req.setAttribute("orders", ordersList);
				req.setAttribute("orderItemsMap", orderItemsMap);
				req.setAttribute("menuItemsMap", menuItemsMap);
				req.setAttribute("paymentDetailsMap", paymentDetailsMap);
				req.setAttribute("userMap", userMap);
				req.setAttribute("restaurantMap", restaurantMap);
				req.setAttribute("deliveryInfoMap", deliveryInfoMap);
				req.setAttribute("deliveryPersonnelMap", deliveryPersonnelMap);
				req.setAttribute("ratingsMap", ratingsMap);
				req.setAttribute("agentMap", agentMap);
				req.setAttribute("agentRatingsMap", agentRatingsMap);

				req.getRequestDispatcher("orderHistory.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
