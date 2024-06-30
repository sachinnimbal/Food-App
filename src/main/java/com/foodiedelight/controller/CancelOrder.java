package com.foodiedelight.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.dao.OrdersDao;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/CancelOrder")
@SuppressWarnings("serial")
public class CancelOrder extends HttpServlet {
	private OrdersDao orderDao = new OrdersDaoImpl();

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "Customer".equals(user.getUserRole())) {
				int orderId = Integer.parseInt(req.getParameter("OrderID"));
				boolean updateStatus = orderDao.updateOrderStatus(orderId, "Cancelled");

				if (updateStatus) {
					session.setAttribute("notification", "Order has been cancelled successfully.");
				} else {
					session.setAttribute("notification", "Failed to cancel the order.");
				}

				resp.sendRedirect("OrderHistory");
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}
}
