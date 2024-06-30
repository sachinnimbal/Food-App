package com.foodiedelight.model;

public class Agents {

	private int agentID;
	private int userID;
	private String profileURL;
	private String status;
	private float averageRatings;

	public Agents() {
		// TODO Auto-generated constructor stub
	}

	public Agents(int agentID, int userID, String profileURL, String status) {
		super();
		this.agentID = agentID;
		this.userID = userID;
		this.profileURL = profileURL;
		this.status = status;
	}

	public Agents(int agentID, int userID, String profileURL, String status, float averageRatings) {
		super();
		this.agentID = agentID;
		this.userID = userID;
		this.profileURL = profileURL;
		this.status = status;
		this.averageRatings = averageRatings;
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

	public String getProfileURL() {
		return profileURL;
	}

	public void setProfileURL(String profileURL) {
		this.profileURL = profileURL;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public float getAverageRatings() {
		return averageRatings;
	}

	public void setAverageRatings(float averageRatings) {
		this.averageRatings = averageRatings;
	}

}
