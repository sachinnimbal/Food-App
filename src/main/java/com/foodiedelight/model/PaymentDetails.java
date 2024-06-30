package com.foodiedelight.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class PaymentDetails {

	private int paymentID;
	private int orderID;
	private BigDecimal amount;
	private String paymentMethod;
	private String status;
	private LocalDateTime transactionDate;

	public PaymentDetails() {
		// TODO Auto-generated constructor stub
	}

	public PaymentDetails(int paymentID, int orderID, BigDecimal amount, String paymentMethod, String status,
			LocalDateTime transactionDate) {
		super();
		this.paymentID = paymentID;
		this.orderID = orderID;
		this.amount = amount;
		this.paymentMethod = paymentMethod;
		this.status = status;
		this.transactionDate = transactionDate;
	}

	public int getPaymentID() {
		return paymentID;
	}

	public void setPaymentID(int paymentID) {
		this.paymentID = paymentID;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public LocalDateTime getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(LocalDateTime transactionDate) {
		this.transactionDate = transactionDate;
	}

}
