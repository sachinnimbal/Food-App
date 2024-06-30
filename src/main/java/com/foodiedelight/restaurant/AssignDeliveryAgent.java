package com.foodiedelight.restaurant;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.DeliveryInfoDaoImpl;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.DeliveryInfo;
import com.foodiedelight.model.Users;

@WebServlet("/AssignDeliveryAgent")
@SuppressWarnings("serial")
public class AssignDeliveryAgent extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		resp.setContentType("text/html; charset=UTF-8");
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "RestaurantOwner".equals(user.getUserRole())) {
				try {
					int orderId = Integer.parseInt(req.getParameter("orderID"));
					int deliveryPersonnelId = Integer.parseInt(req.getParameter("deliveryAgentID"));
					UsersDaoImpl userDao = new UsersDaoImpl();
					Users deliveryPerson = userDao.getUserById(deliveryPersonnelId);

					if (deliveryPerson != null) {
						DeliveryInfoDaoImpl deliveryInfoDaoImpl = new DeliveryInfoDaoImpl();
						DeliveryInfo deliveryInfo = new DeliveryInfo();
						deliveryInfo.setOrderID(orderId);
						deliveryInfo.setDeliveryPersonnelID(deliveryPersonnelId);
						deliveryInfo.setStatus("Out For Delivery");
						deliveryInfoDaoImpl.addDeliveryInfo(deliveryInfo);

						session.setAttribute("notification",
								"Order " + orderId + " is successfully assigned to " + deliveryPerson.getName());
						resp.sendRedirect("RestaurantHome");
					} else {
						session.setAttribute("error", "Invalid delivery agent ID.");
						resp.sendRedirect("RestaurantHome");
					}
				} catch (NumberFormatException e) {
					session.setAttribute("error", "Invalid order or agent ID.");
					resp.sendRedirect("RestaurantHome");
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("Login");
		}
	}
}
