package com.foodiedelight.model;

import java.math.BigDecimal;

public class OrderItems {

	// OrderItemID, OrderID, ItemID, Price, Quantity, ItemTotalPrice, Rating
	private int orderItemID;
	private int orderID;
	private int itemID;
	private BigDecimal price;
	private int quantity;
	private BigDecimal itemTotalPrice;
	private int rating;

	public OrderItems() {
		// TODO Auto-generated constructor stub
	}

	public OrderItems(int orderItemID, int orderID, int itemID, BigDecimal price, int quantity,
			BigDecimal itemTotalPrice) {
		super();
		this.orderItemID = orderItemID;
		this.orderID = orderID;
		this.itemID = itemID;
		this.price = price;
		this.quantity = quantity;
		this.itemTotalPrice = itemTotalPrice;
	}

	public OrderItems(int orderItemID, int orderID, int itemID, BigDecimal price, int quantity,
			BigDecimal itemTotalPrice, int rating) {
		super();
		this.orderItemID = orderItemID;
		this.orderID = orderID;
		this.itemID = itemID;
		this.price = price;
		this.quantity = quantity;
		this.itemTotalPrice = itemTotalPrice;
		this.rating = rating;
	}

	public int getOrderItemID() {
		return orderItemID;
	}

	public void setOrderItemID(int orderItemID) {
		this.orderItemID = orderItemID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getItemID() {
		return itemID;
	}

	public void setItemID(int itemID) {
		this.itemID = itemID;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getItemTotalPrice() {
		return itemTotalPrice;
	}

	public void setItemTotalPrice(BigDecimal itemTotalPrice) {
		this.itemTotalPrice = itemTotalPrice;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

}
