package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.AgentRatings;

public interface AgentRatingsDao {

	void addAgentRating(AgentRatings agentRatings);

	List<AgentRatings> getRatingByAgentID(int agentID);

	AgentRatings getAgentRatingByID(int ratingID);

	void updateAgentRating(AgentRatings agentRatings);

	void deleteAgentRating(int reviewID);

}
