<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="com.foodiedelight.daoimpl.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodie Delight - Restaurant</title>
<link rel="shortcut icon"
	href="https://logo.com/image-cdn/images/kts928pd/production/7ab5def0ab1dad26a90bc35cb7eed9e628f7f201-430x430.png?w=1080&q=72"
	type="image/x-icon">
<link href="assets/css/foodiedelight.admin.css" rel="stylesheet" />
<link href="assets/css/foodiedelight.mob.css" rel="stylesheet" />
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"
	rel="stylesheet">
<!-- Include SweetAlert CSS and JS from CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="assets/js/foodiedelight.js"></script>
<style>
.grayscale {
	filter: grayscale(100%);
	-webkit-filter: grayscale(100%);
}

.ribbon-2 {
	--f: 10px;
	--r: 15px;
	--t: 0px;
	position: absolute;
	inset: var(--t) 0 auto auto;
	padding: 0 10px var(--f) calc(10px + var(--r));
	clip-path: polygon(0 0, 100% 0, 100% calc(100% - var(--f)),
		calc(100% - var(--f)) 100%, calc(100% - var(--f)) calc(100% - var(--f)),
		0 calc(100% - var(--f)), var(--r) calc(50% - var(--f)/2));
	background: #BD1550;
	z-index: 2;
	color: white;
	box-shadow: 0 calc(-1 * var(--f)) 0 inset #0005;
}
</style>
</head>
<body>

<%
Users user = (Users) session.getAttribute("user");
boolean isLoggedIn = user != null;
Restaurants restaurants = (Restaurants) request.getAttribute("restaurant");
%>
	<nav class="sidebar close side-color">
		<header>
			<div class="image-text">
				<span class="image"> <img
					src="https://logo.com/image-cdn/images/kts928pd/production/7ab5def0ab1dad26a90bc35cb7eed9e628f7f201-430x430.png?w=1080&q=72"
					alt="Logo">
				</span>

				<div class="text logo-text">
					<%
					if (isLoggedIn) {
					%>
					<span class="name"><%=user.getUserName()%></span> <span
						class="profession"><%=user.getUserRole()%></span>
					<%
					}
					%>
				</div>

			</div>
			<i class='bx bx-chevron-right toggle'></i>
		</header>

		<div class="menu-bar">
			<div class="menu">

				<ul class="menu-links">

					<li class="nav-link"><a href="RestaurantHome"
						class="tooltip active"> <i class='bx bxs-dashboard icon'></i>
							<span class="text nav-text">Dashboard</span> <span
							class="tooltip-text">Dashboard</span>
					</a></li>

					<li class="nav-link"><a href="OrderLists" class="tooltip active">
							<i class='bx bx-list-ol icon'></i> <span class="text nav-text">
								Order Lists</span> <span class="tooltip-text">Order Lists</span>
					</a></li>
					
					<li class="nav-link"><a href="RestaurantOrders" class="tooltip active">
							<i class='bx bx-station icon'></i> <span class="text nav-text">
								Live Orders</span> <span class="tooltip-text">Live Orders</span>
					</a></li>

					<li class="nav-link"><a href="AddMenu" class="tooltip active">
							<i class='bx bxs-food-menu icon'></i> <span class="text nav-text">Add
								Items</span> <span class="tooltip-text">Add Items</span>
					</a></li>
					<%
					if (restaurants != null) {
					%>
					<li class="nav-link"><a href="MenuItemList"
						onclick="event.preventDefault(); submitMenuForm('MenuItemList', 'RestaurantID', '<%=restaurants.getRestaurantID()%>');"
						class="tooltip"> <i class="bx bx-food-menu icon"></i> <span
							class="text nav-text">Menu</span> <span class="tooltip-text">Menu
								Items</span>
					</a></li>
					<%
					}
					%>

				</ul>
			</div>

			<div class="bottom-content">
				<%
				if (isLoggedIn) {
				%>
				<ul>
					<li class="nav-link"><a href="Out"> <i
							class='bx bx-power-off icon'></i> <span class="text nav-text">Logout</span>
					</a></li>
				</ul>
				<%
				}
				%>
			</div>
		</div>

	</nav>