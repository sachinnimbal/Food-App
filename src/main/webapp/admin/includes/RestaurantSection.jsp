<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>

<div class="restaurant-main-container">
	<%
	List<Restaurants> restaurantsGrid = (List<Restaurants>) request.getAttribute("restaurantsGrid");
	for (Restaurants restaurant : restaurantsGrid) {
		boolean isClosedOrTemporarilyClosed = "Closed".equals(restaurant.getStatus())
		|| "Temporarily Closed".equals(restaurant.getStatus());
		boolean isNotAccepting = "Not Accepting".equals(restaurant.getOrderStatus());
		String name = restaurant.getName();
		String restaurantName = name.length() > 35 ? name.substring(0, 32) + "..." : name;
	%>
	<div class="restaurant-header-main">

		<div class="header-top">
			<%
			if (isNotAccepting) {
			%>
			<div class="ribbon-pop">Not Accepting Orders</div>
			<%
			} else {
			%>
			<div class="ribbon-pop">Accepting Orders</div>
			<%
			}
			%>
			<img src="RestaurantImages/<%=restaurant.getImageURL()%>"
				alt="<%=restaurant.getName()%>" width="100" height="100"
				class="<%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
				onerror="this.onerror=null; this.src='RestaurantImages/default.png';" />
			<div class="right-end">
				<div class="right">
					<p><i class="bx bxs-star"></i> <%= restaurant != null ? String.format("%.1f", restaurant.getAverageRating()) : "N/A" %></p>
				</div>
				<form action="UpdateStatus" method="POST">
					<div class="checkbox-wrapper-5 right">
						<div class="check">
							<input type="hidden" name="RestaurantID"
								value="<%=restaurant.getRestaurantID()%>"> <input
								id="check-<%=restaurant.getRestaurantID()%>" name="status"
								type="checkbox" onchange="this.form.submit();" value="Accepting"
								<%=restaurant.getOrderStatus().equals("Accepting") ? "checked" : ""%>>
							<label for="check-<%=restaurant.getRestaurantID()%>"></label>
						</div>
					</div>
				</form>
				<div class="right">
					<button class="button-25"
						onclick="submitForm('RestaurantID', '<%=restaurant.getRestaurantID()%>')">Edit</button>

				</div>
				<form action="ViewMenu" method="POST">
					<input type="hidden" name="RestaurantID"
						value="<%=restaurant.getRestaurantID()%>">
					<div class="restaurant-view">
						<button class="button-25">View Menu</button>
					</div>
				</form>
				<form action="OrdersList" method="POST">
					<input type="hidden" name="RestaurantID"
						value="<%=restaurant.getRestaurantID()%>">
					<div class="restaurant-view">
						<button class="button-25">View Orders</button>
					</div>
				</form>
			</div>
		</div>
		<div class="td-tooltip-container">
			<h3>
				<%=restaurantName%>
			</h3>
			<div class="td-tooltip-text">
				<h3><%=name%></h3>
			</div>
		</div>

		<div class="restaurant-content">

			<span><i class="bx bxs-food-menu"></i><%=restaurant.getCuisineTypes() != null ? restaurant.getCuisineTypes() : ""%></span>
			<span><i class="bx bx-current-location"></i> <%=restaurant.getStreet() != null ? restaurant.getStreet() : ""%>,
				<%=restaurant.getCity() != null ? restaurant.getCity() : ""%>, <%=restaurant.getState() != null ? restaurant.getState() : ""%><%=restaurant.getPinCode() != null ? ", " + restaurant.getPinCode() : ""%></span>
			<span><i class="bx bx-door-open"></i> <%=restaurant.getStatus() != null ? restaurant.getStatus() : ""%></span>
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
					alt="non-vegetarian-food-symbol" />
				<%
				}
				%>

			</button>
		</div>
		<hr class="dotted-line">
		<div class="restaurant-content">

			<span><i class="bx bx-time-five"></i> Open From: <%=restaurant.getOpeningTime() != null ? restaurant.getOpeningTime() : "N/A"%>
				to <%=restaurant.getClosingTime() != null ? restaurant.getClosingTime() : "N/A"%></span>
			<span><i class='bx bxs-discount'></i> Discount: <%=restaurant.getDiscounts() != null ? restaurant.getDiscounts() : "No Discounts"%></span>
			<%
			if (restaurant.getDescription() != null && !restaurant.getDescription().isEmpty()) {
			%>
			<span><i class="bx bx-detail"></i> Description: <%=restaurant.getDescription()%></span>
			<%
			}
			%>

		</div>

	</div>
	<%}%>
</div>

<script>
	function submitForm(parameterName, parameterValue) {
		var form = document.createElement("form");
		form.method = "POST";
		form.action = "EditRestaurants";
		var hiddenField = document.createElement("input");
		hiddenField.type = "hidden";
		hiddenField.name = parameterName;
		hiddenField.value = parameterValue;

		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	}
</script>

<!-- // Admin -->