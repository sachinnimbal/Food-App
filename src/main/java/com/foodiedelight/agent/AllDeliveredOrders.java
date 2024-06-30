package com.foodiedelight.agent;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.AgentsDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/AllDeliveredOrders")
@SuppressWarnings("serial")
public class AllDeliveredOrders extends HttpServlet {

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
					AgentHome.deliveryCheck(req, resp, user);
					req.getRequestDispatcher("agent/allOrders.jsp").forward(req, resp);
				}
			} else {
				System.out.println("No orders received for the delivery agent.");
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
