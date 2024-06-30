<%@ page
	import="java.util.List, java.util.Map, com.foodiedelight.model.*"%>
<%@ include file="includes/sidebar.jsp"%>
<%@ include file="includes/topbar.jsp"%>

<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="AgentHome">Home</a></li>
		<li aria-current="page">Orders Delivered</li>
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
		<%@ include file="includes/orders-grid.jsp"%>
	</div>

	<div class="table-view view-container">
		<%@ include file="includes/all-orders-table.jsp"%>	
	</div>
</div>


<style>
/* ===== Grid & Table Buttons ===== */
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

@media (max-width: 768px) {
  .restaurant-main-container {
    grid-template-columns: repeat(2, 1fr); /* Switch to 2 columns */
  }
}

/* Adjustments for small screens, e.g., mobile devices */
@media (max-width: 480px) {
  .restaurant-main-container {
    grid-template-columns: 1fr; /* Switch to 1 column */
  }
}
/* ===== Grid & Table Buttons ===== */
</style>

<script>
	function toggleView(view) {
		const gridView = document.querySelector('.grid-view');
		const tableView = document.querySelector('.table-view');
		const gridButton = document
				.querySelector('.toggle-buttons button:nth-child(1)');
		const tableButton = document
				.querySelector('.toggle-buttons button:nth-child(2)');

		if (view === 'grid') {
			gridView.classList.add('active');
			tableView.classList.remove('active');
			gridButton.classList.add('active');
			tableButton.classList.remove('active');
		} else {
			tableView.classList.add('active');
			gridView.classList.remove('active');
			tableButton.classList.add('active');
			gridButton.classList.remove('active');
		}
	}
</script>



<%@ include file="includes/footer-main.jsp"%>