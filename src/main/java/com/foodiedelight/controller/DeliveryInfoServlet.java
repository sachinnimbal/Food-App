package com.foodiedelight.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.foodiedelight.daoimpl.UsersDaoImpl;
import com.foodiedelight.model.Users;

@WebServlet("/saveDeliveryInfo")
@SuppressWarnings("serial")
public class DeliveryInfoServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String address = req.getParameter("Address");
		String street = req.getParameter("Street");
		String cityName = req.getParameter("CityName");
		String state = req.getParameter("State");
		String pinCode = req.getParameter("PinCode");

		Users user = (Users) req.getSession().getAttribute("user");

		boolean isAddingNewAddress = (user.getAddress() == null || user.getAddress().isEmpty())
				&& (user.getStreet() == null || user.getStreet().isEmpty())
				&& (user.getCityName() == null || user.getCityName().isEmpty())
				&& (user.getState() == null || user.getState().isEmpty())
				&& (user.getPinCode() == null || user.getPinCode().isEmpty());

		user.setAddress(address);
		user.setStreet(street);
		user.setCityName(cityName);
		user.setState(state);
		user.setPinCode(pinCode);

		UsersDaoImpl userDao = new UsersDaoImpl();
		userDao.updateDeliveryInfo(user);

		if (isAddingNewAddress) {
			req.getSession().setAttribute("notification", "Address added successfully. 🎉");
		} else {
			req.getSession().setAttribute("notification", "Address updated successfully. 🎉");
		}

		req.getRequestDispatcher("CartPage").forward(req, resp);
	}
}
