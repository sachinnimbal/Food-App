package com.foodiedelight.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.AgentRatingsDao;
import com.foodiedelight.model.AgentRatings;
import com.foodiedelight.util.DBConnectionUtil;

public class AgentRatingsDaoImpl implements AgentRatingsDao {

	private Connection connection;
	public static final String INSERT_QUERY = "INSERT INTO `AgentRatings` (`AgentID`, `UserID`, `Rating`, `RatingDate`) VALUES (?, ?, ?, ?)";
	public static final String SELECT_BY_AGENT_ID = "SELECT * FROM `AgentRatings` WHERE `AgentID` = ?";
	public static final String UPDATE_QUERY = "UPDATE `AgentRatings` SET `Rating` = ? WHERE `UserID` = ? AND `AgentID` = ?";
	public static final String SELECT_BY_AGENT_USER_ID = "SELECT * FROM `AgentRatings` WHERE `AgentID` = ? AND `UserID` = ?";
	public static final String FIND_BY_USERID_AGENTID = "SELECT * FROM `AgentRatings` WHERE `AgentID` = ? AND `UserID` = ?";

	public AgentRatingsDaoImpl() {
		connection = DBConnectionUtil.getConnection();
	}

	@Override
	public void addAgentRating(AgentRatings agentRatings) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(INSERT_QUERY);
			preparedStatement.setInt(1, agentRatings.getAgentID());
			preparedStatement.setInt(2, agentRatings.getUserID());
			preparedStatement.setFloat(3, agentRatings.getRating());
			Timestamp currentTimestamp = Timestamp.valueOf(LocalDateTime.now());
			preparedStatement.setTimestamp(4, currentTimestamp);
			int affectedRows = preparedStatement.executeUpdate();
			if (affectedRows == 0) {
				throw new SQLException("Creating agent rating failed, no rows affected.");
			}
			System.out.println("Agent rating added successfully with ID: " + agentRatings.getAgentID());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public List<AgentRatings> getRatingByAgentID(int agentID) {
		List<AgentRatings> reviews = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_AGENT_ID);
			preparedStatement.setInt(1, agentID);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				AgentRatings review = new AgentRatings();
				review.setRatingID(resultSet.getInt("RatingID"));
				review.setAgentID(resultSet.getInt("AgentID"));
				review.setUserID(resultSet.getInt("UserID"));
				review.setRating(resultSet.getFloat("Rating"));
				review.setRatingDate(resultSet.getTimestamp("RatingDate").toLocalDateTime());
				reviews.add(review);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(resultSet);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return reviews;
	}

	@Override
	public AgentRatings getAgentRatingByID(int ratingID) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateAgentRating(AgentRatings agentRatings) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(UPDATE_QUERY);
			statement.setFloat(1, agentRatings.getRating());
			statement.setInt(2, agentRatings.getUserID());
			statement.setInt(3, agentRatings.getAgentID());
			int affectedRows = statement.executeUpdate();
			if (affectedRows == 0) {
				throw new SQLException("Updating rating failed, no rows affected.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(statement);
		}
	}

	@Override
	public void deleteAgentRating(int reviewID) {
		// TODO Auto-generated method stub

	}

	public List<AgentRatings> getRatingsByAgentAndUserId(int agentID, int userID) {
		List<AgentRatings> agentRatings = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_AGENT_USER_ID);
			preparedStatement.setInt(1, agentID);
			preparedStatement.setInt(2, userID);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				AgentRatings review = new AgentRatings();
				review.setRatingID(resultSet.getInt("RatingID"));
				review.setAgentID(resultSet.getInt("AgentID"));
				review.setUserID(resultSet.getInt("UserID"));
				review.setRating(resultSet.getFloat("Rating"));
				review.setRatingDate(resultSet.getTimestamp("RatingDate").toLocalDateTime());
				agentRatings.add(review);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(resultSet);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return agentRatings;
	}

	public AgentRatings findRatingByUserAndAgent(int userID, int agentID) {
		AgentRatings agentRatings = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(FIND_BY_USERID_AGENTID);
			preparedStatement.setInt(1, agentID);
			preparedStatement.setInt(2, userID);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				agentRatings = new AgentRatings();
				agentRatings.setRatingID(resultSet.getInt("RatingID"));
				agentRatings.setAgentID(resultSet.getInt("AgentID"));
				agentRatings.setUserID(resultSet.getInt("UserID"));
				agentRatings.setRating(resultSet.getFloat("Rating"));
				agentRatings.setRatingDate(resultSet.getTimestamp("RatingDate").toLocalDateTime());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(resultSet);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return agentRatings;
	}

    public void closeConnection() {
        DBConnectionUtil.closeConnection(connection);
    }
}


