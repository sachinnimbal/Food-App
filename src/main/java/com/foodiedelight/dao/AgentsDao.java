package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.Agents;

public interface AgentsDao {

	void addAgent(Agents agent);

	Agents getAgentByUserId(int userID);

	List<Agents> getAllAgents();

	void updateAgent(Agents agent);

	void deleteAgent(int agentId);

	void updateAgentStatus(int agentId, String status);

	boolean agentNeedsUpdate(int userId);
	
}