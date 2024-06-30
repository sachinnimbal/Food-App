package com.foodiedelight.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Orders {

	// OrderID, RestaurantID, UserID, OrderDateTime, DeliveryAddress,
	// Subtotal, GST, TotalAmount, Status
	private int orderID;
	private int restaurantID;
	private int userID;
	private LocalDateTime orderDateTime;
	private String deliveryAddress;
	private BigDecimal subtotal;
	private BigDecimal gst;
	private BigDecimal totalAmount;
	private String status;

	public Orders() {
		// TODO Auto-generated constructor stub
	}

	public Orders(int orderID, int restaurantID, int userID, LocalDateTime orderDateTime, String deliveryAddress,
			BigDecimal subtotal, BigDecimal gst, BigDecimal totalAmount, String status) {
		super();
		this.orderID = orderID;
		this.restaurantID = restaurantID;
		this.userID = userID;
		this.orderDateTime = orderDateTime;
		this.deliveryAddress = deliveryAddress;
		this.subtotal = subtotal;
		this.gst = gst;
		this.totalAmount = totalAmount;
		this.status = status;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public LocalDateTime getOrderDateTime() {
		return orderDateTime;
	}

	public void setOrderDateTime(LocalDateTime orderDateTime) {
		this.orderDateTime = orderDateTime;
	}

	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	public BigDecimal getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(BigDecimal subtotal) {
		this.subtotal = subtotal;
	}

	public BigDecimal getGst() {
		return gst;
	}

	public void setGst(BigDecimal gst) {
		this.gst = gst;
	}

	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
