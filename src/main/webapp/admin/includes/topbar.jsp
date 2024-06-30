
<%@page import="com.foodiedelight.model.Users"%>

<section class="main">
	<div class="topbar">
		<h1>Foodie Delight</h1>
		<img src="assets/images/user.png" alt="Profile" class="topbar-img">
		<%
		Users userD = (Users) session.getAttribute("user");
		boolean LoggedIn = userD != null;
		if (LoggedIn) {
		%>
		<div id="popoverMenu" class="popover-menu">
			<ul>
				<li><a href="ViewCuisines">Add Cuisines</a></li>
				<li><a href="Out">Logout</a></li>
			</ul>
		</div>
		<%
		}
		%>
	</div>


	<section class="main-container">
		<%
		String status = request.getParameter("Status");
		String breadcrumbText = "All Users";
		String role = request.getParameter("Role");

		if (status != null && !status.isEmpty()) {
			if ("Active".equals(status)) {
				breadcrumbText = "Active Users";
			} else if ("Inactive".equals(status)) {
				breadcrumbText = "Inactive Users";
			} else if ("Suspended".equals(status)) {
				breadcrumbText = "Suspended Users";
			}
		} else if (role != null && !role.isEmpty()) {
			if ("DeliveryPerson".equals(role)) {
				breadcrumbText = "Delivery Persons";
			} else if ("RestaurantOwner".equals(role)) {
				breadcrumbText = "Restaurant Owners";
			} else if ("Customer".equals(role)) {
				breadcrumbText = "Customers";
			} else if("SuperAdmin".equals(role)){
				breadcrumbText = "Super Admin";				
			}
		}

		String notificationMessage = null;
		// Determine where the notification message is coming from (session or request)
		if (request.getAttribute("notification") != null) {
			notificationMessage = (String) request.getAttribute("notification");
		} else if (session.getAttribute("notification") != null) {
			notificationMessage = (String) session.getAttribute("notification");
			session.removeAttribute("notification"); // Clean up after displaying
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