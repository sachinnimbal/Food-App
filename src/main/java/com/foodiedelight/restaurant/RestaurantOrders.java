package com.foodiedelight.restaurant;

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

import com.foodiedelight.daoimpl.DeliveryInfoDaoImpl;
import com.foodiedelight.daoimpl.MenuItemsDaoImpl;
import com.foodiedelight.daoimpl.OrderItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.PaymentDetailsDaoImpl;
import com.foodiedelight.daoimpl.RestaurantsDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.DeliveryInfo;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.Restaurants;
import com.foodiedelight.model.Users;

@WebServlet("/RestaurantOrders")
@SuppressWarnings("serial")
public class RestaurantOrders extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				RestaurantsDaoImpl restaurantsDao = new RestaurantsDaoImpl();
				OrdersDaoImpl ordersDao = new OrdersDaoImpl();
				OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
				MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();
				PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
				UsersDaoImpl userDao = new UsersDaoImpl();
				DeliveryInfoDaoImpl deliveryInfoDao = new DeliveryInfoDaoImpl();

				Restaurants restaurant = restaurantsDao.getRestaurantByOwnerId(user.getUserID());
				if (restaurant != null) {
					int restaurantID = restaurant.getRestaurantID();

					List<Users> deliveryAgents = userDao.getUserByRole("DeliveryPerson");
					req.setAttribute("deliveryAgents", deliveryAgents);
					List<Orders> allOrdersList = ordersDao.getOrdersByRestaurantId(restaurantID);
					Map<Integer, List<OrderItems>> orderItemsMap = new HashMap<>();
					Map<Integer, MenuItems> menuItemsMap = new HashMap<>();
					Map<Integer, PaymentDetails> paymentDetailsMap = new HashMap<>();
					Map<Integer, Users> userMap = new HashMap<>();
					Map<Integer, DeliveryInfo> deliveryInfoMap = new HashMap<>();
					Map<Integer, Users> deliveryPersonnelMap = new HashMap<>();

					for (Orders order : allOrdersList) {
						List<OrderItems> orderItems = orderItemsDao.getOrderItemsByOrderId(order.getOrderID());
						orderItemsMap.put(order.getOrderID(), orderItems);

						for (OrderItems item : orderItems) {
							MenuItems menuItem = menuItemsDao.getMenuItemById(item.getItemID());
							if (menuItem != null) {
								menuItemsMap.put(item.getItemID(), menuItem);
							}
						}

						PaymentDetails paymentDetails = paymentDetailsDao
								.getPaymentDetailsByOrderId(order.getOrderID());
						if (paymentDetails != null) {
							paymentDetailsMap.put(order.getOrderID(), paymentDetails);
						}

						Users customer = userDao.getUserById(order.getUserID());
						if (customer != null) {
							userMap.put(order.getUserID(), customer);
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
						}
					}

					req.setAttribute("orders", allOrdersList);
					req.setAttribute("orderItemsMap", orderItemsMap);
					req.setAttribute("menuItemsMap", menuItemsMap);
					req.setAttribute("paymentDetailsMap", paymentDetailsMap);
					req.setAttribute("userMap", userMap);
					req.setAttribute("restaurant", restaurant);
					req.setAttribute("deliveryInfoMap", deliveryInfoMap);
					req.setAttribute("deliveryPersonnelMap", deliveryPersonnelMap);

					req.getRequestDispatcher("restaurant/order-grid.jsp").forward(req, resp);
				} else {
					System.out.println("No restaurant found for the current user.");
					resp.sendRedirect("RestaurantHome");
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
