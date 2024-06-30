package com.foodiedelight.restaurant;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/UpdateOrderStatus")
@SuppressWarnings("serial")
public class UpdateOrderStatus extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("user") instanceof Users) {
			Users user = (Users) session.getAttribute("user");
			if ("RestaurantOwner".equals(user.getUserRole())) {
				String status = req.getParameter("Status");
				int orderId = Integer.parseInt(req.getParameter("orderID"));
				OrdersDaoImpl ordersDao = new OrdersDaoImpl();
				boolean updateSuccess = ordersDao.updateOrderStatus(orderId, status);
				if (updateSuccess) {
					session.setAttribute("notification", "Order status updated successfully. 🎉");
					resp.sendRedirect("RestaurantHome");
				} else {
					session.setAttribute("notification", "Failed to update order status.");
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
