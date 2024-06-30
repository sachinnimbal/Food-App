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

@WebServlet("/AddAgent")
@SuppressWarnings("serial")
public class AddAgent extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "DeliveryPerson".equals(user.getUserRole())) {
				req.setAttribute("hideAlert", true);
				AgentsDaoImpl agentsDaoImpl = new AgentsDaoImpl();
				if (!agentsDaoImpl.agentNeedsUpdate(user.getUserID())) {
					resp.sendRedirect("AgentHome");
				} else {
					req.getRequestDispatcher("agent/addAgent.jsp").forward(req, resp);
				}
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
