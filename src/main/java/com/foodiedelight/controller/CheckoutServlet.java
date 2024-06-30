package com.foodiedelight.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.OrderItemsDaoImpl;
import com.foodiedelight.daoimpl.OrdersDaoImpl;
import com.foodiedelight.daoimpl.PaymentDetailsDaoImpl;
import com.foodiedelight.model.CartGenerator;
import com.foodiedelight.model.OrderItems;
import com.foodiedelight.model.Orders;
import com.foodiedelight.model.PaymentDetails;
import com.foodiedelight.model.Users;
import com.foodiedelight.model.MenuItems;
import com.foodiedelight.daoimpl.MenuItemsDaoImpl;

@WebServlet("/Checkout")
@SuppressWarnings("serial")
public class CheckoutServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");

		int restaurantId = Integer.parseInt(request.getParameter("restaurantID"));
		BigDecimal subtotal = new BigDecimal(request.getParameter("subtotal"));
		BigDecimal gst = new BigDecimal(request.getParameter("gst"));
		BigDecimal totalAmount = new BigDecimal(request.getParameter("grandTotal"));
		String deliveryAddress = request.getParameter("deliveryAddress");

		Orders order = new Orders();
		order.setRestaurantID(restaurantId);
		order.setUserID(user.getUserID());
		order.setOrderDateTime(LocalDateTime.now());
		order.setDeliveryAddress(deliveryAddress);
		order.setSubtotal(subtotal);
		order.setGst(gst);
		order.setTotalAmount(totalAmount);
		order.setStatus("Pending");

		OrdersDaoImpl ordersDao = new OrdersDaoImpl();
		int orderId = ordersDao.addOrder(order);

		List<OrderItems> orderItemsList = new ArrayList<>();
		List<MenuItems> menuItemsList = new ArrayList<>();
		MenuItemsDaoImpl menuItemsDao = new MenuItemsDaoImpl();

		String[] itemIds = request.getParameterValues("itemId[]");
		String[] quantities = request.getParameterValues("itemQuantity[]");
		String[] prices = request.getParameterValues("itemPrice[]");
		String[] totalPrices = request.getParameterValues("itemTotalPrice[]");

		if (itemIds != null) {
			for (int i = 0; i < itemIds.length; i++) {
				OrderItems orderItem = new OrderItems();
				orderItem.setOrderID(orderId);
				orderItem.setItemID(Integer.parseInt(itemIds[i]));
				orderItem.setQuantity(Integer.parseInt(quantities[i]));
				orderItem.setPrice(new BigDecimal(prices[i]));
				orderItem.setItemTotalPrice(new BigDecimal(totalPrices[i]));

				orderItemsList.add(orderItem);
				MenuItems menuItem = menuItemsDao.getMenuItemById(orderItem.getItemID()); // Fetching each menu item
				menuItemsList.add(menuItem); // Adding it to the list
			}
		}

		OrderItemsDaoImpl orderItemsDao = new OrderItemsDaoImpl();
		orderItemsDao.addOrderItems(orderItemsList);

		LocalDateTime transactionDate = LocalDateTime.now();
		PaymentDetails paymentDetail = new PaymentDetails();
		paymentDetail.setOrderID(orderId);
		paymentDetail.setAmount(totalAmount);
		paymentDetail.setPaymentMethod(request.getParameter("paymentMethod"));
		paymentDetail.setStatus("Pending");
		paymentDetail.setTransactionDate(transactionDate);

		PaymentDetailsDaoImpl paymentDetailsDao = new PaymentDetailsDaoImpl();
		paymentDetailsDao.addPaymentDetail(paymentDetail);
		CartGenerator cartGenerator = (CartGenerator) session.getAttribute("cartGenerator");
		if (cartGenerator != null) {
			cartGenerator.clearCart();
			session.setAttribute("notification", "Your order has been successfully placed! 🎉🎊");
		}
		session.setAttribute("order", order);
		session.setAttribute("orderItems", orderItemsList);
		session.setAttribute("menuItemsList", menuItemsList); 

		resp.sendRedirect("orderConfirmation.jsp");
	}
}
