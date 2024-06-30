package com.foodiedelight.model;

import java.time.LocalDateTime;
import java.time.LocalTime;

public class DeliveryInfo {

//	DeliveryID int, OrderID int, DeliveryPersonnelID int, EstimatedDeliveryTime datetime,
//	Status enum('Out For Delivery','Delivered','Failed')

	private int deliveryID;
	private int orderID;
	private int deliveryPersonnelID;
	private LocalTime estimatedDeliveryTime;
	private String status;
	private LocalDateTime deliverDateTime;

	public DeliveryInfo() {
		// TODO Auto-generated constructor stub
	}

	public DeliveryInfo(int deliveryID, int orderID, int deliveryPersonnelID, LocalTime estimatedDeliveryTime,
			String status) {
		super();
		this.deliveryID = deliveryID;
		this.orderID = orderID;
		this.deliveryPersonnelID = deliveryPersonnelID;
		this.estimatedDeliveryTime = estimatedDeliveryTime;
		this.status = status;
	}

	public DeliveryInfo(int deliveryID, int orderID, int deliveryPersonnelID, LocalTime estimatedDeliveryTime,
			String status, LocalDateTime deliverDateTime) {
		super();
		this.deliveryID = deliveryID;
		this.orderID = orderID;
		this.deliveryPersonnelID = deliveryPersonnelID;
		this.estimatedDeliveryTime = estimatedDeliveryTime;
		this.status = status;
		this.deliverDateTime = deliverDateTime;
	}

	public int getDeliveryID() {
		return deliveryID;
	}

	public void setDeliveryID(int deliveryID) {
		this.deliveryID = deliveryID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getDeliveryPersonnelID() {
		return deliveryPersonnelID;
	}

	public void setDeliveryPersonnelID(int deliveryPersonnelID) {
		this.deliveryPersonnelID = deliveryPersonnelID;
	}

	public LocalTime getEstimatedDeliveryTime() {
		return estimatedDeliveryTime;
	}

	public void setEstimatedDeliveryTime(LocalTime estimatedDeliveryTime) {
		this.estimatedDeliveryTime = estimatedDeliveryTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public LocalDateTime getDeliverDateTime() {
		return deliverDateTime;
	}

	public void setDeliverDateTime(LocalDateTime deliverDateTime) {
		this.deliverDateTime = deliverDateTime;
	}

}