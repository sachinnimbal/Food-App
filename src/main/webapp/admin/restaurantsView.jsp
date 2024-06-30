<!-- ===== Side Bar File ===== -->
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>

<!-- ===== Main Conatiner Starts ===== -->
<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="AdminHome">Home</a></li>
		<li aria-current="page">Restaurants View</li>
	</ul>
</nav>


<div class="container-fluid">
	<div class="toggle-buttons">
		<button class="active" onclick="toggleView('grid')">
			<i class='bx bx-grid-alt'></i>
		</button>
		<button onclick="toggleView('table')">
			<i class='bx bx-table'></i>
		</button>
	</div>

	<div class="grid-view view-container active">
		<%@ include file="includes/RestaurantSection.jsp"%>
	</div>

	<div class="table-view view-container">
		<%@ include file="includes/restaurants-table.jsp"%>
	</div>
</div>



<!-- ===== Main Conatiner Ends ===== -->

<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>

<style>
.action-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	background-color: var(--secondary-color);
	color: var(--button-text);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border: none;
	padding: 0 5px 5px 5px;
	border-radius: 4px;
	cursor: pointer;
}

.action-btn:focus {
	border: 2px solid var(--border-color);
}

.text-center {
	text-align: center;
}

.restaurant-main-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 10px;
	width: 100%;
	font-family: "Trebuchet MS", "Lucida Sans Unicode", "Lucida Grande",
		"Lucida Sans", Arial, sans-serif;
}

.restaurant-header-main {
	display: flex;
	flex-direction: column;
	padding: 10px;
	border: 1px solid var(--border-color);
	background-color: transparent;
	box-shadow: rgba(17, 17, 26, 0.05) 0px 1px 0px, rgba(17, 17, 26, 0.1)
		0px 0px 8px;
	font-family: "Trebuchet MS", "Lucida Sans Unicode", "Lucida Grande",
		"Lucida Sans", Arial, sans-serif;
	overflow: hidden;
	transition: background-color 0.3s ease, box-shadow 0.3s ease;
	position: relative;
	overflow: hidden;
}

.toggle-buttons {
	display: flex;
	justify-content: flex-start;
	gap: 10px;
	padding-bottom: 10px;
	justify-content: flex-start;
}

.toggle-buttons button {
	color: white;
	color: #777;
	display: grid;
	align-items: center;
	padding: 10px;
	background: transparent;
	box-shadow: rgba(150, 150, 193, 0.25) 0px 30px 60px -12px inset,
		rgba(255, 255, 255, 0.1) 0px 18px 36px -18px inset;
	background: transparent;
	cursor: pointer;
	transition: background-color 0.3s ease;
	align-items: center;
}

.toggle-buttons button i {
	font-size: 24px;
}

.view-container {
	display: none;
}

.active {
	display: block;
}

.toggle-buttons button.active {
	background-color: #007bff;
	color: white;
}

@media ( max-width : 768px) {
	.restaurant-main-container {
		grid-template-columns: repeat(2, 1fr); /* Switch to 2 columns */
	}
}

/* Adjustments for small screens, e.g., mobile devices */
@media ( max-width : 480px) {
	.restaurant-main-container {
		grid-template-columns: 1fr; /* Switch to 1 column */
	}
}
</style>

