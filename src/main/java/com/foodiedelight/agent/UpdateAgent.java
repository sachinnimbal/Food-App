package com.foodiedelight.agent;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.foodiedelight.daoimpl.AgentsDaoImpl;
import com.foodiedelight.model.Agents;
import com.foodiedelight.model.Users;

@WebServlet("/UpdateAgent")
@SuppressWarnings("serial")
@MultipartConfig
public class UpdateAgent extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "DeliveryPerson".equals(user.getUserRole())) {
				AgentsDaoImpl agentsDaoImpl = new AgentsDaoImpl();
				Agents agent = new Agents();
				addAgent(req, user, agent);
				agentsDaoImpl.addAgent(agent);
				session.setAttribute("notification", "Your details were saved successfully. 🎉");
				resp.sendRedirect("AgentHome");
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

	private void addAgent(HttpServletRequest req, Users user, Agents agent) throws IOException, ServletException {
		agent.setUserID(user.getUserID());
		Part filePart = req.getPart("imageURL");
		String fileName = UUID.randomUUID().toString() + "-"
				+ Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		Path imagesDir = Paths.get(getServletContext().getRealPath("AgentProfile/"));
		Files.createDirectories(imagesDir);
		Path filePath = imagesDir.resolve(fileName);
		filePart.write(filePath.toString());
		agent.setProfileURL(fileName);
		System.out.println("Images directory path: " + imagesDir.toString());
		Files.createDirectories(imagesDir);
		agent.setStatus(req.getParameter("agentStatus"));
	}

}
