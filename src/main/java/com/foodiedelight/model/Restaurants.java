package com.foodiedelight.model;

import java.math.BigDecimal;

public class Restaurants {

//	RestaurantID int, OwnerID int, Name varchar(255), ContactInfo varchar(255), AverageRating float,
//	ETA varchar(50), AverageCost Decimal(10,2), CuisineTypes varchar(255), Status enum('Active', 'Inactive',
//	'Temporarily Closed'), Discounts varchar(45), Street varchar(255), CityName varchar(255),
//	State varchar(255), PinCode varchar(6), Type enum('Veg', 'Non-Veg', 'Both'), ImageURL varchar(255), Description text
//	OpeningTime , ClosingTime, Tags

	private int restaurantID;
	private int ownerID;
	private String name;
	private String contactInfo;
	private float averageRating;
	private String ETA;
	private BigDecimal averageCost;
	private String cuisineTypes;
	private String status;
	private String orderStatus;
	private String discounts;
	private String street;
	private String city;
	private String state;
	private String pinCode;
	private String type;
	private String imageURL;
	private String description;
	private String openingTime;
	private String closingTime;
	private String Tags;

	public Restaurants() {
		// TODO Auto-generated constructor stub
	}

	public Restaurants(int restaurantID, int ownerID, String name, String contactInfo, float averageRating, String eTA,
			BigDecimal averageCost, String cuisineTypes, String status, String discounts, String street, String city,
			String state, String pinCode, String type, String imageURL, String description, String openingTime,
			String closingTime, String tags) {
		super();
		this.restaurantID = restaurantID;
		this.ownerID = ownerID;
		this.name = name;
		this.contactInfo = contactInfo;
		this.averageRating = averageRating;
		ETA = eTA;
		this.averageCost = averageCost;
		this.cuisineTypes = cuisineTypes;
		this.status = status;
		this.discounts = discounts;
		this.street = street;
		this.city = city;
		this.state = state;
		this.pinCode = pinCode;
		this.type = type;
		this.imageURL = imageURL;
		this.description = description;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		Tags = tags;
	}

	public Restaurants(int restaurantID, int ownerID, String name, String contactInfo, float averageRating, String eTA,
			BigDecimal averageCost, String cuisineTypes, String status, String orderStatus, String discounts,
			String street, String city, String state, String pinCode, String type, String imageURL, String description,
			String openingTime, String closingTime, String tags) {
		super();
		this.restaurantID = restaurantID;
		this.ownerID = ownerID;
		this.name = name;
		this.contactInfo = contactInfo;
		this.averageRating = averageRating;
		ETA = eTA;
		this.averageCost = averageCost;
		this.cuisineTypes = cuisineTypes;
		this.status = status;
		this.orderStatus = orderStatus;
		this.discounts = discounts;
		this.street = street;
		this.city = city;
		this.state = state;
		this.pinCode = pinCode;
		this.type = type;
		this.imageURL = imageURL;
		this.description = description;
		this.openingTime = openingTime;
		this.closingTime = closingTime;
		Tags = tags;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public int getOwnerID() {
		return ownerID;
	}

	public void setOwnerID(int ownerID) {
		this.ownerID = ownerID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}

	public float getAverageRating() {
		return averageRating;
	}

	public void setAverageRating(float averageRating) {
		this.averageRating = averageRating;
	}

	public String getETA() {
		return ETA;
	}

	public void setETA(String eTA) {
		ETA = eTA;
	}

	public BigDecimal getAverageCost() {
		return averageCost;
	}

	public void setAverageCost(BigDecimal averageCost) {
		this.averageCost = averageCost;
	}

	public String getCuisineTypes() {
		return cuisineTypes;
	}

	public void setCuisineTypes(String cuisineTypes) {
		this.cuisineTypes = cuisineTypes;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getDiscounts() {
		return discounts;
	}

	public void setDiscounts(String discounts) {
		this.discounts = discounts;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOpeningTime() {
		return openingTime;
	}

	public void setOpeningTime(String openingTime) {
		this.openingTime = openingTime;
	}

	public String getClosingTime() {
		return closingTime;
	}

	public void setClosingTime(String closingTime) {
		this.closingTime = closingTime;
	}

	public String getTags() {
		return Tags;
	}

	public void setTags(String tags) {
		Tags = tags;
	}

}
