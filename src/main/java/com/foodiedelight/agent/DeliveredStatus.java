package com.foodiedelight.agent;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.DeliveryInfoDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/DeliveredStatus")
@SuppressWarnings("serial")
public class DeliveredStatus extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "DeliveryPerson".equals(user.getUserRole())) {
				int deliveryID = Integer.parseInt(req.getParameter("deliveryID"));
				String estimatedTime = req.getParameter("estimatedDeliveryTime");
				String statusUpdate = req.getParameter("delivered");
				LocalDateTime deliveredTime = LocalDateTime.now();

				DeliveryInfoDaoImpl deliveryInfoDaoImpl = new DeliveryInfoDaoImpl();
				try {
					if (statusUpdate != null) {
						String status = "Delivered";
						deliveryInfoDaoImpl.updateDeliveredTime(deliveryID, status, deliveredTime);
						session.setAttribute("notification", "Order marked as Delivered successfully. 🎉");
					} else if (estimatedTime != null && !estimatedTime.isEmpty()) {
						// Only update estimated time if the delivered button was not clicked
						deliveryInfoDaoImpl.updateEstimatedDeliveryTime(deliveryID, estimatedTime);
						session.setAttribute("notification", "Estimated Delivery Time updated successfully. 🎉");
					} else {
						session.setAttribute("notification",
								"No updates were made, missing delivery or estimated time.");
					}
				} catch (Exception e) {
					session.setAttribute("error", "Failed to update delivery details: " + e.getMessage());
					e.printStackTrace();
				}

				resp.sendRedirect("AgentHome");
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
