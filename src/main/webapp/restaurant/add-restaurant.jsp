<!-- Side Bar File -->
<%@ include file="includes/sidebar.jsp"%>

<!-- Top Bar File -->
<%@ include file="includes/topbar.jsp"%>

<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="RestaurantHome">Home</a></li>
		<li aria-current="page">Add Restaurant Details</li>
	</ul>
</nav>

<%@ include file="includes/restaurant-form.jsp"%>


<!-- Footer Main File -->
<%@ include file="includes/footer-main.jsp"%>

<style>
.header-top {
	display: flex;
	align-items: center;
	justify-content: space-between;
	width: 100%;
}

.page-header {
	display: flex;
	flex-direction: column;
	padding: 10px;
	background-color: transparent;
	position: -webkit-sticky;
	position: sticky;
	top: 0;
	max-width: 100%;
	z-index: 1000;
	overflow: hidden;
	transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

.image-file::-webkit-file-upload-button {
	visibility: hidden;
}
.image-file::before {
  content: 'Choose Cover';
  display: inline-block;
  background: linear-gradient(top, #f9f9f9, #e3e3e3);
  outline: none;
  white-space: nowrap;
  -webkit-user-select: none;
  cursor: pointer;
}
.image-file:active::before {
  background: -webkit-linear-gradient(top, #e3e3e3, #f9f9f9);
}
</style>