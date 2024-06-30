
<%@page import="java.util.List"%>
<%@page import="com.foodiedelight.model.*"%>


<%
List<MenuItems> restaurantGrid = (List<MenuItems>) request.getAttribute("menus");
%>
<div
	class="menu-container-main  <%=restaurantGrid == null || restaurantGrid.isEmpty() ? "no-menu" : ""%>">
	<%
	if (restaurantGrid != null && !restaurantGrid.isEmpty()) {
		for (MenuItems menu : restaurantGrid) {
	%>
	<div class="menu-card">
		<div class="menu-image-container">
			<img src="FoodItems/<%=menu.getPhotoURL()%>"
				alt="<%=menu.getName()%>" class="item-img"
				onerror="this.onerror=null; this.src='FoodItems/default.png';">
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
			<div id="cart-action">
				<form method="POST" action="EditMenu" style="display: inline;">
					<input type="hidden" name="action" value="update"> <input
						type="hidden" name="ItemID" value="<%=menu.getItemID()%>">
					<button type="submit" class="button-25"><%=menu.getStatus()%></button>
				</form>
			</div>
		</div>
		<h4 class="item-name"><%=menu.getName()%></h4>
		<p class="item-price">
			<i class="bx bx-rupee"></i><%=menu.getPrice()%>
		</p>
		<p class="description"><%=menu.getDescription()%></p>

	</div>
	<%
	}
	} else {
	%>
	<form id="menuForm" action="AddMenu" method="POST">
		<div class="menu-card" style="cursor: pointer;" onclick="submitForm()">
			<div class="menu-image-container">
				<img src="FoodItems/default.png" alt="Item Image" class="item-img"
					onerror="this.onerror=null; this.src='FoodItems/default.png';"
					style="object-fit: cover;">
			</div>
			<h4 class="item-name">No Item Available</h4>
			<h5>Click Here to Add Items</h5>
		</div>
	</form>
	<script>
		function submitForm() {
			document.getElementById('menuForm').submit();
		}
	</script>

	<%
	}
	%>
</div>

<style>
#cart-action {
	position: absolute;
	bottom: 10px;
	left: 50%;
	transform: translateX(-50%);
	display: flex;
	align-items: center;
	justify-content: center;
	border-radius: 5px;
	padding: 5px 10px;
	z-index: 100;
	with: 100%;
	height: 30px;
	box-shadow: 0.6px 0.6px 5px 0.1px var(--text-color);
}
</style>