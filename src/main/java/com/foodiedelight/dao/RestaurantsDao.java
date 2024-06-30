package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.Restaurants;

public interface RestaurantsDao {

	void addRestaurant(Restaurants restaurant);

	Restaurants getRestaurantById(int restaurantId);

	List<Restaurants> getAllRestaurants();

	void updateRestaurant(Restaurants restaurant);

	void deleteRestaurant(int restaurantId);

	List<Restaurants> findRestaurantsByStatus(String status);

	List<Restaurants> searchRestaurants(String keyword);

	void updateRestaurantStatus(int restaurantId, String status);

	List<Restaurants> findTopRatedRestaurants();

	List<Restaurants> findRestaurantsByType(String type);

	boolean restaurantNeedsUpdate(int ownerId);

	Restaurants getRestaurantByOwnerId(int ownerId);
}
