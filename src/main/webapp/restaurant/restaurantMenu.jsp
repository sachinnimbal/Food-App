<!-- ===== Side Bar File ===== -->
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>


<!-- ===== Main Conatiner Starts ===== -->
<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="RestaurantHome">Home</a></li>
		<li aria-current="page">Restaurant Menu</li>
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
		<%@ include file="includes/menu-cards.jsp"%>
	</div>

	<div class="table-view view-container">
		<%@ include file="includes/menu-table.jsp"%>	
	</div>
</div>



<!-- ===== Main Conatiner Ends ===== -->

<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>

