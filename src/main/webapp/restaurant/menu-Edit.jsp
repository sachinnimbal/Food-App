<!-- Side Bar File -->
<%@ include file="includes/sidebar.jsp"%>

<!-- Top Bar File -->
<%@ include file="includes/topbar.jsp"%>

<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="RestaurantHome">Home</a></li>
		<li><a href="#" onclick="goBack(); return false;">Menu Item
				List</a></li>
		<li aria-current="page">Update Menu Details</li>
	</ul>
</nav>


<%@ include file="includes/menu-edit-from.jsp"%>


<!-- Footer Main File -->
<%@ include file="includes/footer-main.jsp"%>

<style>
.invalid {
	border: 2px solid red;
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

.cover-container {
	display: flex;
	gap: 20px;
}
</style>
<script>
	function goBack() {
		window.history.back();
	}
</script>