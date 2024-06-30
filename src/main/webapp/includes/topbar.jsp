
<%@page import="com.foodiedelight.model.*"%>

<section class="main">
	<div class="topbar">
		<h1>Foodie Delight</h1>
		<button id="search">
			<i class='bx bx-search-alt'></i>
		</button>
		<%
		Users userID = (Users) session.getAttribute("user");
		boolean isLogged_In = userID != null;
		CartGenerator cartsGenerators = (CartGenerator) session.getAttribute("cartGenerator");
		int cartsItemsCount = 0;
		if (cartsGenerators != null && cartsGenerators.cart != null) {
			cartsItemsCount = cartsGenerators.cart.size();
		}
		if (!isLogged_In) {
		%>
		<button class="login-icon" data-bs-toggle="offcanvas"
			data-bs-target="#loginOffcanvas">
			<i class="bx bxs-user"></i> Login
		</button>
		<%
		}
		%>

		<div class="cart-container">
			<button id="open-cart">
				<i class='bx bxs-cart-alt'></i> <span class="cart-count"><%=cartsItemsCount%></span>
			</button>
		</div>

		<img src="assets/images/user.png" alt="Profile" class="topbar-img">

		<%
		if (isLogged_In) {
		%>
		<div id="popoverMenu" class="popover-menu">
			<ul>
				<li><a href="Out">Logout</a></li>
			</ul>
		</div>
		<%
		}
		%>
	</div>


	<section class="main-container">

		<%
		String notificationMessage = null;
		// Determine where the notification message is coming from (session or request)
		if (request.getAttribute("notification") != null) {
			notificationMessage = (String) request.getAttribute("notification");
		} else if (session.getAttribute("notification") != null) {
			notificationMessage = (String) session.getAttribute("notification");
			session.removeAttribute("notification");
		}

		if (notificationMessage != null) {
			String imageSrc = notificationMessage.contains("successfully") ? "assets/images/check.png"
			: "assets/images/error.png";
		%>
		<figure class="notification">
			<div class="body">
				<img src="<%=imageSrc%>" title="Status" alt="Status" class="icon" />
				<%=notificationMessage%>
			</div>
			<div class="progress"></div>
		</figure>
		<%
		}
		%>