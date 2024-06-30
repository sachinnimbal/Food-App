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
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.Users;

@WebServlet("/AllOrders")
@SuppressWarnings("serial")
public class AllOrders extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");

				OrdersDaoImpl ordersDao = new OrdersDaoImpl();
				OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
				MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();
				PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
				UsersDaoImpl userDao = new UsersDaoImpl();
				
				String status = req.getParameter("Status");

				List<Orders> ordersList;
				if (status == null || "All".equals(status)) {
					ordersList = ordersDao.getAllOrders(); 
				} else {
					ordersList = ordersDao.getOrdersByStatus(status);
				}

				Map<Integer, List<OrderItems>> orderItemsMap = new HashMap<>();
				Map<Integer, MenuItems> menuItemsMap = new HashMap<>();
				Map<Integer, PaymentDetails> paymentDetailsMap = new HashMap<>();
				Map<Integer, Users> userMap = new HashMap<>();

				for (Orders order : ordersList) {
					List<OrderItems> orderItems = orderItemsDao.getOrderItemsByOrderId(order.getOrderID());
					orderItemsMap.put(order.getOrderID(), orderItems);

					for (OrderItems item : orderItems) {
						MenuItems menuItem = menuItemsDao.getMenuItemById(item.getItemID());
						menuItemsMap.put(item.getItemID(), menuItem);
					}

					PaymentDetails paymentDetails = paymentDetailsDao.getPaymentDetailsByOrderId(order.getOrderID());
					if (paymentDetails != null) {
						paymentDetailsMap.put(order.getOrderID(), paymentDetails);
					}

					Users customer = userDao.getUserById(order.getUserID());
					if (customer != null) {
						userMap.put(order.getUserID(), customer);
					}
				}

				req.setAttribute("allorders", ordersList);
				req.setAttribute("orderItemsMap", orderItemsMap);
				req.setAttribute("menuItemsMap", menuItemsMap);
				req.setAttribute("paymentDetailsMap", paymentDetailsMap);
				req.setAttribute("userMap", userMap);

				req.getRequestDispatcher("admin/allOrders.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
