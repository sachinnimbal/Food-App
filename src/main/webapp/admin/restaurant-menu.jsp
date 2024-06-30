<!-- ===== Side Bar File ===== -->
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>


<!-- ===== Main Conatiner Starts ===== -->
<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="AdminHome">Home</a></li>
		<li><a href="RestaurantsView">Restaurants View</a></li>
		<li aria-current="page">Restaurant Menu</li>
	</ul>
</nav>


<%@ include file="includes/restaurantHeader.jsp"%>


<div class="container-fluid">
	<div class="toggle-buttons mt-5">
		<button class="active" onclick="toggleView('grid')">
			<i class='bx bx-grid-alt'></i>
		</button>
		<button onclick="toggleView('table')">
			<i class='bx bx-table'></i>
		</button>
	</div>

	<div class="grid-view view-container active">
		<%
		Restaurants restaurants = (Restaurants) request.getAttribute("restaurant");
		List<MenuItems> restaurantsMenu = (List<MenuItems>) request.getAttribute("menus");
		if (restaurant != null) {
		%>
		<div
			class="menu-container-main  <%=restaurantsMenu == null || restaurantsMenu.isEmpty() ? "no-menu" : ""%>">
			<%
			if (restaurantsMenu != null && !restaurantsMenu.isEmpty()) {
				for (MenuItems menu : restaurantsMenu) {
			%>
			<div class="menu-card">
				<div class="menu-image-container">
					<img src="FoodItems/<%=menu.getPhotoURL()%>"
						alt="<%=menu.getName()%>" class="item-img"
						onerror="this.onerror=null; this.src='FoodItems/default.png';">
					<div id="cart-action">
						<form action="CartPage" method="post">
							<input type="hidden" name="itemId" value="<%=menu.getItemID()%>" />
							<input type="hidden" name="restaurantId"
								value="<%=menu.getRestaurantID()%>" /> <input type="hidden"
								name="itemName" value="<%=menu.getName()%>" /> <input
								type="hidden" name="itemImage" value="<%=menu.getPhotoURL()%>" />
							<input type="hidden" name="itemPrice"
								value="<%=menu.getPrice()%>" /> <input type="hidden"
								name="quantity" value="1" /> <input type="hidden"
								name="restaurantName" value="<%=restaurants.getName()%>" /> <input
								type="hidden" name="restaurantLocation"
								value="<%=restaurants.getStreet()%>" /> <input type="hidden"
								name="restaurantImage" value="<%=restaurants.getImageURL()%>" />
						</form>
					</div>
					<%
					if (menu.getType().equalsIgnoreCase("veg")) {
					%>
					<img class="type"
						src="https://img.icons8.com/color/512/000000/vegetarian-food-symbol.png"
						alt="vegetarian-food-symbol" />
					<%
					} else if (menu.getType().equalsIgnoreCase("non-veg")) {
					%>
					<img class="type"
						src="https://img.icons8.com/color/512/non-vegetarian-food-symbol.png"
						alt="non-vegetarian-food-symbol" />
					<%
					}
					%>
				</div>
				<h4 class="item-name"><%=menu.getName()%></h4>
				<p class="item-price">
					<i class="bx bx-rupee"></i><%=menu.getPrice()%>
				</p>
				<p class="description"><%=menu.getDescription()%></p>

			</div>
			<%
			}
			%>
		</div>
		<%
}
}
%>
	</div>

	<div class="table-view view-container">
		<%@ include file="includes/menu-table.jsp"%>
	</div>
</div>



<!-- ===== Main Conatiner Ends ===== -->

<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>

