<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="com.foodiedelight.daoimpl.*"%>

<div class="restaurant-container">
	<div class="label-container">
		<h2>Top restaurants</h2>
		<button class="restaurant-arrow-left">
			<i class='bx bxs-left-arrow-circle'></i>
		</button>
		<button class="restaurant-arrow-right">
			<i class='bx bxs-right-arrow-circle'></i>
		</button>
	</div>
	<div class="card-slider">
		<%
		List<Restaurants> topRestaurants = (List<Restaurants>) request.getAttribute("topRestaurants");
		if (topRestaurants != null && !topRestaurants.isEmpty()) {
			for (Restaurants topRestaurant : topRestaurants) {
				boolean isClosedOrTemporarilyClosed = "Closed".equals(topRestaurant.getStatus())
				|| "Temporarily Closed".equals(topRestaurant.getStatus());
				String name = topRestaurant.getName();
				String restaurantName = name.length() > 32 ? name.substring(0, 28) + "..." : name;
		%>
		<form action="Menus" method="POST">
			<input type="hidden" name="restaurantId"
				value="<%=topRestaurant.getRestaurantID()%>" />
			<div
				class="restaurant-card<%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
				onclick="this.parentNode.submit()">
				<div class="image-container">
					<%
					if (isClosedOrTemporarilyClosed) {
					%>
					<div class="ribbon-2">Closed</div>
					<%
					}
					%>
					<img src="RestaurantImages/<%=topRestaurant.getImageURL()%>"
						alt="<%=topRestaurant.getName()%>"
						class="<%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
						onerror="this.onerror=null; this.src='RestaurantImages/default.png';" />
					<div class="discount-badge"><%=topRestaurant.getDiscounts()%></div>
				</div>
				<h3 class="restaurant-name"><%=restaurantName%></h3>
				<div class="info-container">
					<div class="info-row">
						<div class="rating">
							<span class="rating-star"><img width="20" height="20"
								src="https://img.icons8.com/flat-round/512/star--v1.png"
								alt="star" /></span> <span class="review-count"><%=topRestaurant != null ? String.format("%.1f", topRestaurant.getAverageRating()) : ""%></span>

						</div>
						<div class="delivery-info">
							<img width="20" height="20"
								src="https://img.icons8.com/color/512/deliveryman.png"
								alt="deliveryman" />
							<%=topRestaurant.getETA()%>
							mins
						</div>
					</div>

					<p><%=(topRestaurant.getCuisineTypes().length() > 25 ? topRestaurant.getCuisineTypes().substring(0, 25) + "..."
		: topRestaurant.getCuisineTypes())%></p>

					<p>
						<i class='bx bx-current-location'></i><%=(topRestaurant.getStreet().length() > 20 ? topRestaurant.getStreet().substring(0, 20) + "..."
		: topRestaurant.getStreet())%>,
						<%=(topRestaurant.getCity().length() > 10 ? topRestaurant.getCity().substring(0, 10) + "..."
		: topRestaurant.getCity())%>
					</p>
				</div>
			</div>
		</form>
		<%
		}
		} else {
		%>
		<div class="restaurant-card">
			<div class="image-container">
				<img src="RestaurantImages/default.png" alt="No restaurants found"
					class="grayscale" />
			</div>
			<h3>No Restaurants Found</h3>
			<div class="info-container">
				<div class="info-row">
					<div class="rating">
						<span class="rating-star"><img width="20" height="20"
							src="https://img.icons8.com/flat-round/512/star--v1.png"
							alt="star" /></span> <span class="review-count">0.0</span>
					</div>
					<div class="delivery-info">
						<img width="20" height="20"
							src="https://img.icons8.com/color/512/deliveryman.png"
							alt="deliveryman" /> 0:00 mins
					</div>
				</div>
				<p>Cuisine Types</p>
				<p>
					<i class='bx bx-current-location'></i>Location
				</p>
			</div>
		</div>
		<%
		}
		%>
	</div>
</div>
<hr class="dotted-line">
