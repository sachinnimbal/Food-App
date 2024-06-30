package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.PaymentDetails;

public interface PaymentDetailsDao {

	void addPaymentDetail(PaymentDetails paymentDetail);

//	PaymentDetails getPaymentDetailByID(int paymentID);
//
	List<PaymentDetails> getPaymentsByOrderID(int orderID);
//
//	void updatePaymentDetail(PaymentDetails paymentDetail);
//
//	void deletePaymentDetail(int paymentID);

	PaymentDetails getPaymentDetailsByOrderId(int orderID);
}
