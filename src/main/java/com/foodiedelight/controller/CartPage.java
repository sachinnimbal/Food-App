package com.foodiedelight.controller;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.model.Cart;
import com.foodiedelight.model.CartGenerator;

@WebServlet("/CartPage")
@SuppressWarnings("serial")
public class CartPage extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		CartGenerator cartGenerator = (CartGenerator) session.getAttribute("cartGenerator");
		if (cartGenerator == null) {
			cartGenerator = new CartGenerator();
			session.setAttribute("cartGenerator", cartGenerator);
		}

		String action = req.getParameter("action");

		if (action != null) {
			processAction(req, cartGenerator, action);
		} else {
			addItemToCart(req, cartGenerator);
		}

		session.setAttribute("cartGenerator", cartGenerator);
		req.getRequestDispatcher("cart.jsp").forward(req, resp);
	}

	private void processAction(HttpServletRequest req, CartGenerator cartGenerator, String action) {
		int itemId = Integer.parseInt(req.getParameter("itemId"));

		switch (action) {
		case "increment":
			cartGenerator.UpdateCartItem(itemId, cartGenerator.cart.get(itemId).getQuantity() + 1);
			break;
		case "decrement":
			int newQuantity = cartGenerator.cart.get(itemId).getQuantity() - 1;
			if (newQuantity > 0) {
				cartGenerator.UpdateCartItem(itemId, newQuantity);
			} else {
				cartGenerator.removeCartItem(itemId);
			}
			break;
		case "remove":
			req.getSession().setAttribute("notification", "Item removed successfully.  🎉");
			cartGenerator.removeCartItem(itemId);
			break;
		}
	}

	private void addItemToCart(HttpServletRequest req, CartGenerator cartGenerator) {
		String itemIdParam = req.getParameter("itemId");
		String restaurantIdParam = req.getParameter("restaurantId");
		String itemPriceParam = req.getParameter("itemPrice");
		String quantityParam = req.getParameter("quantity");

		if (itemIdParam != null && restaurantIdParam != null && itemPriceParam != null && quantityParam != null) {
			HttpSession session = req.getSession();
			String currentRestaurantId = (String) session.getAttribute("currentRestaurantId");

			if (currentRestaurantId != null && !currentRestaurantId.equals(restaurantIdParam)) {
				req.getSession().setAttribute("notification", "Your cart was updated with items from the new restaurant successfully. 🎉");
				cartGenerator.clearCart();
				session.removeAttribute("restaurantName");
				session.removeAttribute("restaurantLocation");
				session.removeAttribute("restaurantImage");

			}

			int itemId = Integer.parseInt(itemIdParam);
			int restaurantId = Integer.parseInt(restaurantIdParam);
			String itemName = req.getParameter("itemName");
			String itemImage = req.getParameter("itemImage");
			BigDecimal itemPrice = new BigDecimal(itemPriceParam);
			int quantity = Integer.parseInt(quantityParam);

			Cart cartItem = new Cart(itemId, restaurantId, itemName, itemImage, itemPrice, quantity);
			cartGenerator.addCartItem(cartItem);

			String restaurantName = req.getParameter("restaurantName");
			String restaurantLocation = req.getParameter("restaurantLocation");
			String restaurantImage = req.getParameter("restaurantImage");
			session.setAttribute("restaurantName", restaurantName);
			session.setAttribute("restaurantLocation", restaurantLocation);
			session.setAttribute("restaurantImage", restaurantImage);
			session.setAttribute("currentRestaurantId", restaurantIdParam);
		}
	}

}
