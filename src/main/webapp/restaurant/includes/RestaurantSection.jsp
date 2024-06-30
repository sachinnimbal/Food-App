<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>

<%
Restaurants restaurant = (Restaurants) request.getAttribute("restaurant");
if (restaurant != null) {
	boolean isClosedOrTemporarilyClosed = "Closed".equals(restaurant.getStatus())
	|| "Temporarily Closed".equals(restaurant.getStatus());
	boolean isNotAccepting = "Not Accepting".equals(restaurant.getOrderStatus());
	String name = restaurant.getName();
	String restaurantName = name.length() > 35 ? name.substring(0, 32) + "..." : name;
%>
<div class="restaurant-header">
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
	<div class="header-top">
		<img src="RestaurantImages/<%=restaurant.getImageURL()%>"
			alt="<%=restaurant.getName()%>" width="100" height="100"
			class="<%=isClosedOrTemporarilyClosed ? "grayscale" : ""%>"
			onerror="this.onerror=null; this.src='RestaurantImages/default.png';" />
		<div class="right-end">
			<div class="right">
				<p><i class="bx bxs-star"></i><%= restaurant != null ? String.format("%.1f", restaurant.getAverageRating()) : "N/A" %></p>
			</div>
			<%-- <form action="StatusUpdate" method="POST">
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
			</form> --%>
			<form action="StatusUpdate" method="POST">
				<div class="checkbox-wrapper-5 right">
					<div class="check">
						<input type="hidden" name="RestaurantID"
							value="<%=restaurant.getRestaurantID()%>"> <input
							id="check-5" name="status" type="checkbox"
							onchange="this.form.submit();" value="Accepting"
							<%=restaurant.getOrderStatus().equals("Accepting") ? "checked" : ""%>>
						<label for="check-5"></label>
					</div>
				</div>
			</form>
			<div class="right mt-5">
				<form action="MenuItemList" method="POST">
					<input type="hidden" name="RestaurantID"
						value="<%=restaurant.getRestaurantID()%>">
					<div class="restaurant-view">
						<button class="button-25">View</button>
					</div>
				</form>
			</div>
			<div class="right mt-5">
				<button type="button"
					onclick="submitForm('RestaurantID', '<%=restaurant.getRestaurantID()%>')"
					class="action-btn">
					<i class="bi bi-pencil-square"></i>
				</button>
			</div>
		</div>
	</div>
	<h3><%=restaurantName != null ? restaurantName : ""%></h3>

	<div class="info-hidden">
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
				alt="non-vegetarian-food-symbol" /> Both
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
	<!--<button class="button-87" role="button">Add Item</button>-->
</div>

<%
}
%>

<script>
	function submitForm(parameterName, parameterValue) {
		var form = document.createElement("form");
		form.method = "POST";
		form.action = "EditRestaurant";
		var hiddenField = document.createElement("input");
		hiddenField.type = "hidden";
		hiddenField.name = parameterName;
		hiddenField.value = parameterValue;

		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	}
</script>
