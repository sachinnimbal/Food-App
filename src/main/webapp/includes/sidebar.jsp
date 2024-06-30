<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="com.foodiedelight.daoimpl.*"%>
<%-- <%@ page import="com.foodiedelight.model.Orders, com.foodiedelight.model.PaymentDetails, com.foodiedelight.model.Restaurants, com.foodiedelight.model.Users, com.foodiedelight.model.MenuItems, com.foodiedelight.model.Cuisine, com.foodiedelight.model.CartGenerator, com.foodiedelight.model.Cart"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodie Delight</title>
<link rel="shortcut icon"
	href="https://logo.com/image-cdn/images/kts928pd/production/7ab5def0ab1dad26a90bc35cb7eed9e628f7f201-430x430.png?w=1080&q=72"
	type="image/x-icon">
<link href="assets/css/foodiedelight.css" rel="stylesheet" />
<link href="assets/css/foodiedelight.mob.css" rel="stylesheet" />
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- SweetAlert CDN -->
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
	--t: 10px;
	position: absolute;
	inset: var(--t) calc(-1 * var(--f)) auto auto;
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
	CartGenerator cartGenerator = (CartGenerator) session.getAttribute("cartGenerator");
	int cartItemCount = 0;
	if (cartGenerator != null && cartGenerator.cart != null) {
		cartItemCount = cartGenerator.cart.size(); // Count of unique item IDs
	}
	%>
	<nav class="sidebar close">
		<header>
			<div class="image-text">
				<span class="image"> <img
					src="https://logo.com/image-cdn/images/kts928pd/production/7ab5def0ab1dad26a90bc35cb7eed9e628f7f201-430x430.png?w=1080&q=72"
					alt="Logo">
				</span>

				<div class="text logo-text">
					<%
					if (isLoggedIn && user != null) {
						String displayName = user.getUserName() != null && !user.getUserName().isEmpty() ? user.getUserName() : "Guest";
						String displayRole = user.getUserRole() != null && !user.getUserRole().isEmpty() ? user.getUserRole() : "Visitor";
					%>
					<span class="username"><%=displayName%></span> <span
						class="profession"><%=displayRole%></span>
					<%
					} else {
					%>
					<span class="username">Guest</span> <span class="profession">Visitor</span>
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

					<li class="nav-link"><a href="UserHome" class="tooltip active">
							<i class='bx bxs-dashboard icon'></i> <span class="text nav-text">Dashboard</span>
							<span class="tooltip-text">Dashboard</span>
					</a></li>

					<li class="nav-link"><a href="Restaurants" class="tooltip">
							<i class='bx bx-restaurant icon'></i> <span class="text nav-text">Restaurants</span>
							<span class="tooltip-text">Restaurants</span>
					</a></li>
					<%
					if (isLoggedIn) {
					%>
					<li class="nav-link"><a href="OrderHistory" class="tooltip">
							<i class='bx bx-cart-alt icon'></i> <span class="text nav-text">My
								Orders</span> <span class="tooltip-text">My Orders</span>
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

	<%
	String loginFailedMessage = (String) session.getAttribute("loginFailed");
	if (loginFailedMessage != null) {
		session.removeAttribute("loginFailed");
	%>
	<script>
    Swal.fire({
        icon: 'error',
        text: '<%=loginFailedMessage%>',
        confirmButtonText: 'Try Again'
    }).then((result) => {
        if (result.isConfirmed) {
            const loginOffcanvas = document.getElementById("loginOffcanvas");
            const errorMessage = document.getElementById("errorMessage");
            const errorText = document.querySelector("#errorMessage .error-text");

            if (loginOffcanvas && errorMessage && errorText) {
                errorText.textContent = '<%=loginFailedMessage%>'; 
                errorMessage.classList.remove('hide'); 
                errorMessage.style.display = 'flex'; 
                loginOffcanvas.classList.add("show");
            }
        }
    });
</script>
	<%
	}
	%>