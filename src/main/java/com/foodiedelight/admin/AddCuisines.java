package com.foodiedelight.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.CuisineDaoImpl;
import com.foodiedelight.model.Cuisine;
import com.foodiedelight.model.Users;

@WebServlet("/AddCuisines")
@SuppressWarnings("serial")
public class AddCuisines extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			Users user = (Users) session.getAttribute("user");
			if (user != null && "SuperAdmin".equals(user.getUserRole())) {
				resp.setContentType("text/html; charset=UTF-8");

				String cuisineName = req.getParameter("cuisineName");
				String cuisineDescription = req.getParameter("cuisineDescription");
				String cuisineURL = req.getParameter("cuisineURL");

				CuisineDaoImpl cuisineDaoImpl = new CuisineDaoImpl();
				if (cuisineDaoImpl.cuisineExists(cuisineName)) {
					session.setAttribute("notification", "Cuisine name already exists.");
				} else {
					Cuisine newCuisine = new Cuisine();
					newCuisine.setCuisineName(cuisineName);
					newCuisine.setCuisineDescription(cuisineDescription);
					newCuisine.setCuisineUrl(cuisineURL);
					cuisineDaoImpl.addCuisine(newCuisine);
					session.setAttribute("notification", "Cuisine successfully added.🎉");
				}
				req.getRequestDispatcher("admin/cuisinesView.jsp").forward(req, resp);
			} else {
				resp.sendRedirect("UserHome");
			}
		} else {
			resp.sendRedirect("UserHome");
		}
	}

}
