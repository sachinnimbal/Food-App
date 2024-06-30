package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.OrderItems;

public interface OrderItemsDao {

    void addOrderItem(OrderItems orderItem);

    List<OrderItems> getOrderItemsByOrderId(int orderId);

    void updateOrderItem(OrderItems orderItem);

    void deleteOrderItem(int orderItemId);

    OrderItems getOrderItemById(int orderItemId);

	void addOrderItems(List<OrderItems> orderItemsList);

}
