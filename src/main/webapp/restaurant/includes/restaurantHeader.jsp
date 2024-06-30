
<%@page import="com.foodiedelight.model.*"%>

<%
Restaurants restaurant = (Restaurants) request.getAttribute("restaurant");
if (restaurant != null) {
	boolean isClosedOrTemporarilyClosed = "Closed".equals(restaurant.getStatus())
	|| "Temporarily Closed".equals(restaurant.getStatus());
%>
<div class="restaurant-header">

	<div class="header-top">
		<%
		if (isClosedOrTemporarilyClosed) {
		%>
		<div class="ribbon-2">Closed</div>
		<%
		}
		%>
		<img src="RestaurantImages/<%=restaurant.getImageURL()%>"
			alt="<%=restaurant.getName()%>" width="60" height="60"
			class="<%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
			onerror="this.onerror=null; this.src='RestaurantImages/default.png';" />
		<div class="right-end">
			<p>
				<i class="bx bxs-star"></i>
				<%=restaurant.getAverageRating() > 0 ? restaurant.getAverageRating() : "0.0"%>
			</p>
			<form action="StatusUpdate" method="POST">
				<div class="checkbox-wrapper-5 right">
					<div class="check">
						<input type="hidden" name="RestaurantID"
							value="<%=restaurant.getRestaurantID()%>"> <input
							id="check-5" name="status" type="checkbox"
							onchange="this.form.submit();" value="Open"
							<%=restaurant.getStatus().equals("Open") ? "checked" : ""%>>
						<label for="check-5"></label>
					</div>
				</div>
			</form>
			<div class="right mt-5">
				<button type="button"
					onclick="submitForm('RestaurantID', '<%=restaurant.getRestaurantID()%>')"
					class="action-btn">
					<i class="bi bi-pencil-square"></i>
				</button>
			</div>
		</div>
	</div>

	<div class="info-hidden">
		<span><i class="bx bxs-food-menu"></i><%=restaurant.getCuisineTypes()%></span>
		<span><i class="bx bx-current-location"></i> <%=restaurant.getStreet() + ", " + restaurant.getCity() + ", " + restaurant.getState()%></span>
		<span><i class="bx bx-door-open"></i> <%=restaurant.getStatus()%></span>
	</div>
	<hr class="dotted-line">
	<div class="resto-info">
		<button class="delivery-time">
			<img width="26" height="26"
				src="https://img.icons8.com/dusk/512/clock--v1.png" alt="clock" />
			<%=restaurant.getETA()%>
			min
		</button>
		<button class="minimun-price">
			<img width="26" height="26"
				src="https://img.icons8.com/dusk/512/rupee.png" alt="rupee" />
			&#8377;<%=restaurant.getAverageCost()%>
			for two
		</button>
		<button class="type">
			<%
			if ("veg".equalsIgnoreCase(restaurant.getType())) {
			%>
			<img width="26" height="26"
				src="https://img.icons8.com/color/512/bay-leaf.png" alt="bay-leaf" />
			Pure Veg
			<%
			} else if ("non-veg".equalsIgnoreCase(restaurant.getType())) {
			%>
			<img width="26" height="26"
				src="https://img.icons8.com/color/512/non-vegetarian-food-symbol.png"
				alt="non-vegetarian-food-symbol" /> Non Veg
			<%
			} else if ("both".equalsIgnoreCase(restaurant.getType())) {
			%>
			<img width="26" height="26"
				src="https://img.icons8.com/color/512/bay-leaf.png" alt="bay-leaf" />
			<img class="type" width="26" height="26"
				src="https://img.icons8.com/color/512/non-vegetarian-food-symbol.png"
				alt="non-vegetarian-food-symbol" /> Both
			<%
			}
			%>
		</button>
	</div>
</div>
<%
}
%>

