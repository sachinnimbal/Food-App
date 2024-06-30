package com.foodiedelight.model;

public class Cuisine {

	private int cuisineID;
	private String cuisineName;
	private String cuisineDescription;
	private String cuisineUrl;

	public Cuisine() {
		// TODO Auto-generated constructor stub
	}

	public Cuisine(int cuisineID, String cuisineName, String cuisineDescription, String cuisineUrl) {
		super();
		this.cuisineID = cuisineID;
		this.cuisineName = cuisineName;
		this.cuisineDescription = cuisineDescription;
		this.cuisineUrl = cuisineUrl;
	}

	public int getCuisineID() {
		return cuisineID;
	}

	public void setCuisineID(int cuisineID) {
		this.cuisineID = cuisineID;
	}

	public String getCuisineName() {
		return cuisineName;
	}

	public void setCuisineName(String cuisineName) {
		this.cuisineName = cuisineName;
	}

	public String getCuisineDescription() {
		return cuisineDescription;
	}

	public void setCuisineDescription(String cuisineDescription) {
		this.cuisineDescription = cuisineDescription;
	}

	public String getCuisineUrl() {
		return cuisineUrl;
	}

	public void setCuisineUrl(String cuisineUrl) {
		this.cuisineUrl = cuisineUrl;
	}

}
