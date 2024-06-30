<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="com.foodiedelight.daoimpl.*"%>

<div class="label-container">
	<h2>All Restaurants</h2>
</div>


<div class="restaurant-container-main">
	<%
	List<Restaurants> allRestaurants = (List<Restaurants>) request.getAttribute("allRestaurant");
	if (allRestaurants != null && !allRestaurants.isEmpty()) {
		for (Restaurants restaurant : allRestaurants) {
			boolean isClosedOrTemporarilyClosed = "Closed".equals(restaurant.getStatus())
			|| "Temporarily Closed".equals(restaurant.getStatus());
			String name = restaurant.getName();
			String restaurantName = name.length() > 15 ? name.substring(0, 13) + "..." : name;
	%>
	<form action="Menus" method="POST">
		<input type="hidden" name="restaurantId"
			value="<%=restaurant.getRestaurantID()%>" />
		<div
			class="restaurant-card <%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
			onclick="this.parentNode.submit()">
			<div class="image-container">
				<%
				if (isClosedOrTemporarilyClosed) {
				%>
				<div class="ribbon-2">Closed</div>
				<%
				}
				%>
				<img src="RestaurantImages/<%=restaurant.getImageURL()%>"
					alt="<%=restaurant.getName()%>"
					class="<%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
					onerror="this.onerror=null; this.src='RestaurantImages/default.png';" />
				<div class="discount-badge"><%=restaurant.getDiscounts()%></div>
			</div>
			<h3 class="restaurant-name"><%=restaurantName%></h3>
			<div class="info-container">
				<div class="info-row">
					<div class="rating">
						<span class="rating-star"><img width="20" height="20"
							src="https://img.icons8.com/flat-round/512/star--v1.png"
							alt="star" /></span> <span class="review-count"><%= restaurant != null ? String.format("%.1f", restaurant.getAverageRating()) : "" %></span>

					</div>
					<div class="delivery-info">
						<img width="20" height="20"
							src="https://img.icons8.com/color/512/deliveryman.png"
							alt="deliveryman" />
						<%=restaurant.getETA()%>
						mins
					</div>
				</div>
				<p><%=(restaurant.getCuisineTypes().length() > 25 ? restaurant.getCuisineTypes().substring(0, 25) + "..."
		: restaurant.getCuisineTypes())%></p>
				<p>
					<i class='bx bx-current-location'></i><%=(restaurant.getStreet().length() > 10 ? restaurant.getStreet().substring(0, 10) + "..."
		: restaurant.getStreet())%>,
					<%=(restaurant.getCity().length() > 10 ? restaurant.getCity().substring(0, 10) + "..." : restaurant.getCity())%>
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


<script>
function searchRestaurants() {
    var input = document.getElementById("search-input");
    var filter = input.value.toLowerCase();
    var nodes = document.getElementsByClassName('restaurant-card');

    for (i = 0; i < nodes.length; i++) {
        if (nodes[i].textContent.toLowerCase().includes(filter)) {
            nodes[i].style.display = "block";
        } else {
            nodes[i].style.display = "none";
        }
    }
}
</script>
