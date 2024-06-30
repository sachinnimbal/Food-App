package com.foodiedelight.model;

import java.time.LocalDateTime;

public class RatingsReviews {

	private int reviewID;
	private int restaurantID;
	private int userID;
	private float rating;
	private String reviewText;
	private LocalDateTime reviewDate;

	public RatingsReviews() {
		// TODO Auto-generated constructor stub
	}

	public RatingsReviews(int reviewID, int restaurantID, int userID, float rating, String reviewText,
			LocalDateTime reviewDate) {
		super();
		this.reviewID = reviewID;
		this.restaurantID = restaurantID;
		this.userID = userID;
		this.rating = rating;
		this.reviewText = reviewText;
		this.reviewDate = reviewDate;
	}

	public int getReviewID() {
		return reviewID;
	}

	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}

	public int getRestaurantID() {
		return restaurantID;
	}

	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public String getReviewText() {
		return reviewText;
	}

	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}

	public LocalDateTime getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(LocalDateTime reviewDate) {
		this.reviewDate = reviewDate;
	}

}
