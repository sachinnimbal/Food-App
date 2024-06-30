<%@ page import="java.util.List"%>
<%@ page import="com.foodiedelight.model.MenuItems"%>
<%@ page import="com.foodiedelight.model.Restaurants"%>

<%
Restaurants restaurant = (Restaurants) request.getAttribute("restaurant");
List<MenuItems> restaurantMenu = (List<MenuItems>) request.getAttribute("menus");
if (restaurant != null) {
%>
<div class="restaurant-header">
	<div class="header-top">
		<h3><%=restaurant.getName()%></h3>
		<div class="right-end">
			<p>
				<i class="bx bxs-star"></i>
				<%=restaurant.getAverageRating()%>
			</p>
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
