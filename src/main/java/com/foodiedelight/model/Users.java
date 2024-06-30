package com.foodiedelight.model;

import java.time.LocalDateTime;

public class Users {

//	UserID int, Name varchar(255), PhoneNumber varchar(15), UserName varchar(45), Password varchar(255), 
//	UserRole enum('Customer', 'SuperAdmin', 'RestaurantOwner', 'DeliveryPerson'),
//	Status enum('Active', 'Inactive', 'Suspended'), Address varchar(255), Street varchar(255), CityName varchar(255),
//	State varchar(255), PinCode varchar(6),  CreatedAt datetime, LastLogin datetime

	private int userID;
	private String name;
	private String phoneNumber;
	private String userName;
	private String password;
	private String userRole;
	private String status;
	private String address;
	private String street;
	private String cityName;
	private String state;
	private String pinCode;
	private LocalDateTime createdAt;
	private LocalDateTime lastLogin;

	public Users() {
		// TODO Auto-generated constructor stub
	}

	public Users(int userID, String name, String phoneNumber, String userName, String password, String userRole,
			String status, String address, String street, String cityName, String state, String pinCode,
			LocalDateTime createdAt, LocalDateTime lastLogin) {
		super();
		this.userID = userID;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.userName = userName;
		this.password = password;
		this.userRole = userRole;
		this.status = status;
		this.address = address;
		this.street = street;
		this.cityName = cityName;
		this.state = state;
		this.pinCode = pinCode;
		this.createdAt = createdAt;
		this.lastLogin = lastLogin;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
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

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(LocalDateTime lastLogin) {
		this.lastLogin = lastLogin;
	}

}
