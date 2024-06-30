package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.DeliveryInfo;

public interface DeliveryInfoDao {

	void addDeliveryInfo(DeliveryInfo deliveryInfo);

	DeliveryInfo getDeliveryInfoByID(int deliveryID);

	List<DeliveryInfo> getDeliveriesByOrderID(int orderID);

	void updateDeliveryInfo(DeliveryInfo deliveryInfo);

	void deleteDeliveryInfo(int deliveryID);

	DeliveryInfo getDeliveryInfoByOrderId(int orderId);

}
