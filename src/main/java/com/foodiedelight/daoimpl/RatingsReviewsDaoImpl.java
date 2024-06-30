package com.foodiedelight.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.foodiedelight.dao.RatingsReviewsDao;
import com.foodiedelight.model.RatingsReviews;
import com.foodiedelight.util.DBConnectionUtil;

public class RatingsReviewsDaoImpl implements RatingsReviewsDao {

	private Connection connection;
	public static final String SELECT_BY_RESTO_ID_USER_ID = "SELECT * FROM `RatingsReviews` WHERE `RestaurantID` = ? AND `UserID` = ?";
	public static final String INSERT_QUERY = "INSERT INTO `RatingsReviews` "
			+ "(`RestaurantID`, `UserID`, `Rating`, `ReviewText`, `ReviewDate`) VALUES (?, ?, ?, ?, ?)";
	public static final String SELECT_BY_RESTO_ID = "SELECT * FROM `RatingsReviews` WHERE `RestaurantID` = ?";
	public static final String UPDATE_QUERY = "UPDATE `RatingsReviews` SET `Rating` = ? WHERE `UserID` = ? AND `RestaurantID` = ?";

	public RatingsReviewsDaoImpl() {
		connection = DBConnectionUtil.getConnection();
	}

	@Override
	public void addRatingReview(RatingsReviews ratingReview) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(INSERT_QUERY);
			preparedStatement.setInt(1, ratingReview.getRestaurantID());
			preparedStatement.setInt(2, ratingReview.getUserID());
			preparedStatement.setFloat(3, ratingReview.getRating());
			preparedStatement.setString(4, ratingReview.getReviewText());
			LocalDateTime now = LocalDateTime.now();
			Timestamp currentTimestamp = Timestamp.valueOf(now);
			preparedStatement.setTimestamp(5, currentTimestamp);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
	}

	@Override
	public List<RatingsReviews> getReviewsByRestaurantID(int restaurantID) {
		List<RatingsReviews> reviews = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_RESTO_ID);
			preparedStatement.setInt(1, restaurantID);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				RatingsReviews review = new RatingsReviews();
				review.setReviewID(resultSet.getInt("ReviewID"));
				review.setRestaurantID(resultSet.getInt("RestaurantID"));
				review.setUserID(resultSet.getInt("UserID"));
				review.setRating(resultSet.getFloat("Rating"));
				review.setReviewText(resultSet.getString("ReviewText"));
				review.setReviewDate(resultSet.getTimestamp("ReviewDate").toLocalDateTime());
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
	public RatingsReviews getReviewByID(int reviewID) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateRatingReview(RatingsReviews ratingReview) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(UPDATE_QUERY);
			statement.setFloat(1, ratingReview.getRating());
			statement.setInt(2, ratingReview.getUserID());
			statement.setInt(3, ratingReview.getRestaurantID());
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
	public void deleteRatingReview(int reviewID) {
		// TODO Auto-generated method stub

	}

	public List<RatingsReviews> getReviewsByRestaurantAndUserId(int restaurantID, int userID) {
		List<RatingsReviews> reviews = new ArrayList<>();
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_RESTO_ID_USER_ID);
			preparedStatement.setInt(1, restaurantID);
			preparedStatement.setInt(2, userID);
			resultSet = preparedStatement.executeQuery();
			while (resultSet.next()) {
				RatingsReviews review = new RatingsReviews();
				review.setReviewID(resultSet.getInt("ReviewID"));
				review.setRestaurantID(resultSet.getInt("RestaurantID"));
				review.setUserID(resultSet.getInt("UserID"));
				review.setRating(resultSet.getFloat("Rating"));
				review.setReviewText(resultSet.getString("ReviewText"));
				review.setReviewDate(resultSet.getTimestamp("ReviewDate").toLocalDateTime());
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

	public RatingsReviews findRatingByUserAndRestaurant(int userId, int restaurantId) {
		RatingsReviews review = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			preparedStatement = connection.prepareStatement(SELECT_BY_RESTO_ID_USER_ID);
			preparedStatement.setInt(1, restaurantId);
			preparedStatement.setInt(2, userId);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				review = new RatingsReviews();
				review.setReviewID(resultSet.getInt("ReviewID"));
				review.setRestaurantID(resultSet.getInt("RestaurantID"));
				review.setUserID(resultSet.getInt("UserID"));
				review.setRating(resultSet.getFloat("Rating"));
				review.setReviewText(resultSet.getString("ReviewText"));
				review.setReviewDate(resultSet.getTimestamp("ReviewDate").toLocalDateTime());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.closeResultSet(resultSet);
			DBConnectionUtil.closePreparedStatement(preparedStatement);
		}
		return review;
	}

	public void closeConnection() {
		DBConnectionUtil.closeConnection(connection);
	}

}
