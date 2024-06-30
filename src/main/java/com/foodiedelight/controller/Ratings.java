package com.foodiedelight.controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodiedelight.daoimpl.RatingsReviewsDaoImpl;
import com.foodiedelight.daoimpl.AgentRatingsDaoImpl;
import com.foodiedelight.model.RatingsReviews;
import com.foodiedelight.model.AgentRatings;

@WebServlet("/Ratings")
@SuppressWarnings("serial")
public class Ratings extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		HttpSession session = req.getSession();
		try {
			String userIdStr = req.getParameter("userId");
			String ratingStr = req.getParameter("rating");
			String restaurantIdStr = req.getParameter("restaurantId");
			String agentIdStr = req.getParameter("agentId");

			int userId = Integer.parseInt(userIdStr);
			int rating = Integer.parseInt(ratingStr);

			if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
				int restaurantId = Integer.parseInt(restaurantIdStr);
				handleRestaurantRating(session, userId, restaurantId, rating);
			} else if (agentIdStr != null && !agentIdStr.isEmpty()) {
				int agentId = Integer.parseInt(agentIdStr);
				handleAgentRating(session, userId, agentId, rating);
			}
			resp.sendRedirect("OrderHistory");
		} catch (NumberFormatException e) {
			session.setAttribute("notification", "Invalid input. Numeric values required.");
			resp.sendRedirect("OrderHistory");
		} catch (IllegalArgumentException e) {
			session.setAttribute("notification", e.getMessage());
			resp.sendRedirect("OrderHistory");
		} catch (Exception e) {
			session.setAttribute("notification", "Failed to process your rating. Please try again.");
			resp.sendRedirect("OrderHistory");
		}
	}

	private void handleRestaurantRating(HttpSession session, int userId, int restaurantId, int rating) {
		RatingsReviewsDaoImpl reviewsDao = new RatingsReviewsDaoImpl();
		RatingsReviews existingRating = reviewsDao.findRatingByUserAndRestaurant(userId, restaurantId);
		if (existingRating != null) {
			existingRating.setRating(rating);
			reviewsDao.updateRatingReview(existingRating);
			session.setAttribute("notification", "Thank you! Your restaurant rating has been updated successfully.");
		} else {
			RatingsReviews newRating = new RatingsReviews();
			newRating.setRestaurantID(restaurantId);
			newRating.setUserID(userId);
			newRating.setRating(rating);
			reviewsDao.addRatingReview(newRating);
			session.setAttribute("notification", "Thank you! Your restaurant rating has been recorded successfully.");
		}
	}

	private void handleAgentRating(HttpSession session, int userId, int agentId, int rating) {
		AgentRatingsDaoImpl agentRatingsDao = new AgentRatingsDaoImpl();
		AgentRatings existingRating = agentRatingsDao.findRatingByUserAndAgent(userId, agentId);
		if (existingRating != null) {
			existingRating.setRating(rating);
			agentRatingsDao.updateAgentRating(existingRating);
			session.setAttribute("notification", "Thank you! Your agent rating has been updated successfully.");
		} else {
			AgentRatings newRating = new AgentRatings();
			newRating.setAgentID(agentId);
			newRating.setUserID(userId);
			newRating.setRating(rating);
			agentRatingsDao.addAgentRating(newRating);
			session.setAttribute("notification", "Thank you! Your agent rating has been recorded successfully.");
		}
	}
}
