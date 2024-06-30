package com.foodiedelight.model;

import java.time.LocalDateTime;

public class AgentRatings {

	private int ratingID;
	private int agentID;
	private int userID;
	private float rating;
	private LocalDateTime ratingDate;

	public AgentRatings() {
		// TODO Auto-generated constructor stub
	}

	public AgentRatings(int ratingID, int agentID, int userID, float rating, LocalDateTime ratingDate) {
		super();
		this.ratingID = ratingID;
		this.agentID = agentID;
		this.userID = userID;
		this.rating = rating;
		this.ratingDate = ratingDate;
	}

	public int getRatingID() {
		return ratingID;
	}

	public void setRatingID(int ratingID) {
		this.ratingID = ratingID;
	}

	public int getAgentID() {
		return agentID;
	}

	public void setAgentID(int agentID) {
		this.agentID = agentID;
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

	public LocalDateTime getRatingDate() {
		return ratingDate;
	}

	public void setRatingDate(LocalDateTime ratingDate) {
		this.ratingDate = ratingDate;
	}

}
