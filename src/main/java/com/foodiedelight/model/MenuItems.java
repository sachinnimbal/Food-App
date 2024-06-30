package com.foodiedelight.model;

import java.math.BigDecimal;

public class MenuItems {
	
// ItemID int AUTO_INCREMENT, RestaurantID int, Name varchar(255), Description text, 
//	Price decimal(10,2), PhotoURL varchar(255), Status enum('Available', 'Not Available'), 
//	Type enum('Veg', 'Non-Veg')


	private int itemID;
	private int restaurantID;
	private String name;
	private String description;
	private BigDecimal price;
	private String photoURL;
	private String status;
	private String type;

	public MenuItems() {
		// TODO Auto-generated constructor stub
	}

	public MenuItems(int itemID, int restaurantID, String name, String description, BigDecimal price, String photoURL,
			String status, String type) {
		super();
		this.itemID = itemID;
		this.restaurantID = restaurantID;
		this.name = name;
		this.description = description;
		this.price = price;
		this.photoURL = photoURL;
		this.status = status;
		this.type = type;
	}

	public int getItemID() {
		return itemID;
	}

	public void setItemID(int itemID) {
		this.itemID = itemID;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getPhotoURL() {
		return photoURL;
	}

	public void setPhotoURL(String photoURL) {
		this.photoURL = photoURL;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}