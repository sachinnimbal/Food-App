<%@ include file="includes/sidebar.jsp"%>

<%@ include file="includes/topbar.jsp"%>

<%@ include file="includes/restaurantHeader.jsp"%>

<%
if (request.getAttribute("noMenuAlert") != null || restaurantMenu == null || restaurantMenu.isEmpty()) {
%>
<script>
    Swal.fire({
        icon: 'info',
        title: '',
        text: '<%=request.getAttribute("noMenuAlert")%>',
        allowOutsideClick: false,
        confirmButtonText: 'Go Back'
    }).then((result) => {
        if (result.isConfirmed) {
            history.back();
        }
    });
</script>
<%
} else {
List<MenuItems> sortedLowToHigh = new ArrayList<>(restaurantMenu);
Collections.sort(sortedLowToHigh, Comparator.comparing(MenuItems::getPrice));
List<MenuItems> sortedHighToLow = new ArrayList<>(restaurantMenu);
Collections.sort(sortedHighToLow, Comparator.comparing(MenuItems::getPrice).reversed());
%>

<!-- Vertical Tabs Structure -->
<div class="vertical-tabs-wrapper">
	<%
	String restaurantType = (String) request.getAttribute("restaurantType");
	%>
	<nav class="tab-list">
		<a href="#allItems" class="tab active"
			onclick="showTab('allItems', event)">All Items</a>
		<%
		if ("both".equalsIgnoreCase(restaurantType)) {
		%>
		<a href="#veg" class="tab" onclick="showTab('veg', event)">Veg</a> <a
			href="#nonVeg" class="tab" onclick="showTab('nonVeg', event)">Non-Veg</a>
		<%
		}
		%>
		<a href="#lowToHigh" class="tab" onclick="showTab('lowToHigh', event)">Low
			to High</a> <a href="#highToLow" class="tab"
			onclick="showTab('highToLow', event)">High to Low</a>
	</nav>

	<div class="tab-contents-layout">
		<div class="tab-header">
			<div class="left-side">
				<h1 class="restaurant-name" id="headerTitle">All Items</h1>
			</div>
			<div class="right-side">
				<label> Search: <input type="text" id="search-input"
					placeholder="Search menu items..." onkeyup="searchMenu()">
				</label>
			</div>
		</div>
		<p id="noResults" style="display: none; text-align: center;">Please
			enter a right keyword, no results found.</p>

		<section id="allItems" class="tab-content active">
			<div
				class="menu-container-main  <%=restaurantMenu == null || restaurantMenu.isEmpty() ? "no-menu" : ""%>">
				<%
				for (MenuItems menu : restaurantMenu) {
				%>


				<div class="menu-card">
					<div class="menu-image-container">
						<img src="FoodItems/<%=menu.getPhotoURL()%>"
							alt="<%=menu.getName()%>"
							class="item-img <%=menu.getStatus().equalsIgnoreCase("Not Available") ? "grayscale" : ""%>"
							onerror="this.onerror=null; this.src='FoodItems/default.png';">
						<%
						if (!menu.getStatus().equalsIgnoreCase("Not Available")) {
						%>

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
									name="restaurantName" value="<%=restaurant.getName()%>" /> <input
									type="hidden" name="restaurantLocation"
									value="<%=restaurant.getStreet()%>" /> <input type="hidden"
									name="restaurantImage" value="<%=restaurant.getImageURL()%>" />
								<button type="submit"
									<%=menu.getStatus().equalsIgnoreCase("Not Available") ? "disabled" : ""%>>Add
									to Cart</button>
							</form>
						</div>
						<%
						}
						%>
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
				</div>

				<%
				}
				%>
			</div>
		</section>

		<section id="veg" class="tab-content">
			<div
				class="menu-container-main <%=restaurantMenu == null || restaurantMenu.isEmpty() ? "no-menu" : ""%>">
				<%
				List<MenuItems> vegItems = new ArrayList<>(); 
				for (MenuItems item : restaurantMenu) {
					if ("veg".equalsIgnoreCase(item.getType())) {
						vegItems.add(item);
					}
				}
				Collections.sort(vegItems, Comparator.comparing(MenuItems::getName)); 
				for (MenuItems menu : vegItems) {
				%>


				<div class="menu-card">
					<div class="menu-image-container">
						<img src="FoodItems/<%=menu.getPhotoURL()%>"
							alt="<%=menu.getName()%>"
							class="item-img <%=menu.getStatus().equalsIgnoreCase("Not Available") ? "grayscale" : ""%>"
							onerror="this.onerror=null; this.src='FoodItems/default.png';">
						<%
						if (!menu.getStatus().equalsIgnoreCase("Not Available")) {
						%>

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
									name="restaurantName" value="<%=restaurant.getName()%>" /> <input
									type="hidden" name="restaurantLocation"
									value="<%=restaurant.getStreet()%>" /> <input type="hidden"
									name="restaurantImage" value="<%=restaurant.getImageURL()%>" />
								<button type="submit"
									<%=menu.getStatus().equalsIgnoreCase("Not Available") ? "disabled" : ""%>>Add
									to Cart</button>
							</form>
						</div>
						<%
						}
						%>
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
				</div>

				<%
				}
				%>
			</div>
		</section>


		<section id="nonVeg" class="tab-content">
			<div
				class="menu-container-main <%=restaurantMenu == null || restaurantMenu.isEmpty() ? "no-menu" : ""%>">
				<%
				List<MenuItems> nonVegItems = new ArrayList<>();
				for (MenuItems item : restaurantMenu) {
					if ("non-veg".equalsIgnoreCase(item.getType())) {
						nonVegItems.add(item);
					}
				}
				Collections.sort(nonVegItems, Comparator.comparing(MenuItems::getName)); // Sorting by name as an example
				for (MenuItems menu : nonVegItems) {
				%>

				<div class="menu-card">
					<div class="menu-image-container">
						<img src="FoodItems/<%=menu.getPhotoURL()%>"
							alt="<%=menu.getName()%>"
							class="item-img <%=menu.getStatus().equalsIgnoreCase("Not Available") ? "grayscale" : ""%>"
							onerror="this.onerror=null; this.src='FoodItems/default.png';">
						<%
						if (!menu.getStatus().equalsIgnoreCase("Not Available")) {
						%>

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
									name="restaurantName" value="<%=restaurant.getName()%>" /> <input
									type="hidden" name="restaurantLocation"
									value="<%=restaurant.getStreet()%>" /> <input type="hidden"
									name="restaurantImage" value="<%=restaurant.getImageURL()%>" />
								<button type="submit"
									<%=menu.getStatus().equalsIgnoreCase("Not Available") ? "disabled" : ""%>>Add
									to Cart</button>
							</form>
						</div>
						<%
						}
						%>
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
				</div>

				<%
				}
				%>
			</div>
		</section>


		<section id="lowToHigh" class="tab-content">

			<div
				class="menu-container-main  <%=restaurantMenu == null || restaurantMenu.isEmpty() ? "no-menu" : ""%>">
				<%
				for (MenuItems menu : sortedLowToHigh) {
				%>


				<div class="menu-card">
					<div class="menu-image-container">
						<img src="FoodItems/<%=menu.getPhotoURL()%>"
							alt="<%=menu.getName()%>"
							class="item-img <%=menu.getStatus().equalsIgnoreCase("Not Available") ? "grayscale" : ""%>"
							onerror="this.onerror=null; this.src='FoodItems/default.png';">
						<%
						if (!menu.getStatus().equalsIgnoreCase("Not Available")) {
						%>

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
									name="restaurantName" value="<%=restaurant.getName()%>" /> <input
									type="hidden" name="restaurantLocation"
									value="<%=restaurant.getStreet()%>" /> <input type="hidden"
									name="restaurantImage" value="<%=restaurant.getImageURL()%>" />
								<button type="submit"
									<%=menu.getStatus().equalsIgnoreCase("Not Available") ? "disabled" : ""%>>Add
									to Cart</button>
							</form>
						</div>
						<%
						}
						%>
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
					<%-- <p class="description"><%=menu.getDescription()%></p> --%>
				</div>

				<%
				}
				%>
			</div>
		</section>

		<section id="highToLow" class="tab-content">

			<div
				class="menu-container-main  <%=restaurantMenu == null || restaurantMenu.isEmpty() ? "no-menu" : ""%>">
				<%
				for (MenuItems menu : sortedHighToLow) {
				%>


				<div class="menu-card">
					<div class="menu-image-container">
						<img src="FoodItems/<%=menu.getPhotoURL()%>"
							alt="<%=menu.getName()%>"
							class="item-img <%=menu.getStatus().equalsIgnoreCase("Not Available") ? "grayscale" : ""%>"
							onerror="this.onerror=null; this.src='FoodItems/default.png';">
						<%
						if (!menu.getStatus().equalsIgnoreCase("Not Available")) {
						%>

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
									name="restaurantName" value="<%=restaurant.getName()%>" /> <input
									type="hidden" name="restaurantLocation"
									value="<%=restaurant.getStreet()%>" /> <input type="hidden"
									name="restaurantImage" value="<%=restaurant.getImageURL()%>" />
								<button type="submit"
									<%=menu.getStatus().equalsIgnoreCase("Not Available") ? "disabled" : ""%>>Add
									to Cart</button>
							</form>
						</div>
						<%
						}
						%>
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
				</div>

				<%
				}
				%>
			</div>
		</section>

	</div>
</div>
<%
}
%>


<!-- ===== Main Conatiner Ends ===== -->

<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>
<script>
function showTab(tabId, event) {
    event.preventDefault();
    var tabs = document.querySelectorAll('.tab-content');
    var tabLinks = document.querySelectorAll('.tab');
    var headerTitle = document.getElementById('headerTitle');

    tabs.forEach(tab => tab.style.display = 'none');
    tabLinks.forEach(link => link.classList.remove('active'));

    document.getElementById(tabId).style.display = 'block';
    event.currentTarget.classList.add('active');

    switch (tabId) {
        case 'allItems':
            headerTitle.innerHTML = 'All Items';
            break;
        case 'veg':
            headerTitle.innerHTML = 'Veg';
            break;
        case 'nonVeg':
            headerTitle.innerHTML = 'Non-Veg';
            break;
        case 'lowToHigh':
            headerTitle.innerHTML = 'Low to High';
            break;
        case 'highToLow':
            headerTitle.innerHTML = 'High to Low';
            break;
    }
}

function searchMenu() {
    var input = document.getElementById('search-input').value.toLowerCase();
    var cards = document.querySelectorAll('.menu-card');
    var noResults = document.getElementById('noResults');
    var count = 0;

    cards.forEach(card => {
        var name = card.querySelector('.item-name').innerText.toLowerCase();
        if (name.includes(input)) {
            card.style.display = '';
            count++;
        } else {
            card.style.display = 'none';
        }
    });

    noResults.style.display = (count === 0 ? 'block' : 'none');
}
</script>


<style>
@media screen and (max-width: 767px) {
	.vertical-tabs-wrapper {
		flex-direction: row; /* Use row layout for larger screens */
		height: calc(100vh - 115px); /* Define height relative to viewport */
		overflow: hidden; /* Hide overflow */
	}
	.tab-header {
		/* position: static; */
		max-width: 100%;
		top: 0;
		left: 0;
		right: 0;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		align-items: center;
		background-color: var(--sidebar-color);
		padding: 10px;
		z-index: 250;
		position: relative;
		justify-content: space-between;
	}
	.tab-list {
		flex-basis: 250px;
		display: none;
		height: 100%;
		padding: 10px 0;
		overflow-y: scroll;
		height: 100%;
	}
	.tab-contents-layout {
		flex-basis: auto;
		border-left: 2px dashed var(--border-color);
		/* Add left border back */
		overflow-y: scroll;
		height: 100%; /* Full container height */
	}
	.tab {
		text-align: left; /* Align text to the left on larger screens */
	}
}
</style>