package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.Orders;

public interface OrdersDao {

	int addOrder(Orders order);

	Orders getOrderById(int orderID);

	List<Orders> getOrdersByUserId(int userID);

	List<Orders> getOrdersByRestaurantId(int userID);

	void updateOrder(Orders order);

	void deleteOrder(int orderID);

	List<Orders> getAllOrders();

	int countOrdersByRestaurantId(int restaurantID);

	boolean updateOrderStatus(int orderId, String status);

	int countOrdersByStatus(int restaurantID, String status);

	int countOrdersByStatus(String status);

	List<Orders> getOrdersByRestaurantAndStatus(int restaurantID, String status);

	List<Orders> getOrdersByStatus(String status);
}
