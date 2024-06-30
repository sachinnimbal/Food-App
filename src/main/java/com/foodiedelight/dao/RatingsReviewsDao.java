package com.foodiedelight.dao;

import java.util.List;

import com.foodiedelight.model.RatingsReviews;

public interface RatingsReviewsDao {

	void addRatingReview(RatingsReviews ratingReview);

	List<RatingsReviews> getReviewsByRestaurantID(int restaurantID);

	RatingsReviews getReviewByID(int reviewID);

	void updateRatingReview(RatingsReviews ratingReview);

	void deleteRatingReview(int reviewID);

}
