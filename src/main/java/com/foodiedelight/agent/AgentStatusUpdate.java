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

@WebServlet("/AgentStatusUpdate")
@SuppressWarnings("serial")
public class AgentStatusUpdate extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession(false);

		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "DeliveryPerson".equals(user.getUserRole())) {
				String status = req.getParameter("status");
				String idStr = req.getParameter("agentID");
				try {
					int agentId = Integer.parseInt(idStr);
					String newStatus = "Online".equals(status) ? "Online" : "Offline";
					AgentsDaoImpl agentsDaoImpl = new AgentsDaoImpl();
					agentsDaoImpl.updateAgentStatus(agentId, newStatus);
					if ("Offline".equals(newStatus)) {
						session.setAttribute("notification", "Your account is now offline successfully.");
					} else {
						session.setAttribute("notification", "Your account is online successfully.");
					}
				} catch (NumberFormatException e) {
					session.setAttribute("notification", "Invalid Restaurant ID format.");
				} catch (Exception e) {
					session.setAttribute("notification", "An error occurred. Please try again.");
					e.printStackTrace();
				}
				resp.sendRedirect("AgentHome");

			} else {
				System.out.println("No orders received for the current user.");
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}