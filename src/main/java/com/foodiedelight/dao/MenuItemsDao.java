package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.MenuItems;

public interface MenuItemsDao {

	void addMenuItem(MenuItems menuItem);

	MenuItems getMenuItemById(int itemID);

	List<MenuItems> getMenuItemsByRestaurantId(int restaurantID);

	void updateMenuItem(MenuItems menuItem);

	void deleteMenuItem(int itemID);

	List<MenuItems> getAllMenuItems();

	int countMenuItemsByRestaurantId(int restaurantID);

	void updateMenuItemByID(MenuItems menuItems);
	
}