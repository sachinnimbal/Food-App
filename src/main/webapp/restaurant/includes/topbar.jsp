
<%@page import="com.foodiedelight.model.Users"%>
<section class="main">
	<div class="topbar">
		<h1>Foodie Delight</h1>
		<img src="assets/images/user.png" alt="Profile" class="topbar-img">
		<%
		Users users = (Users) session.getAttribute("user");
		boolean isLogged_In = users != null;
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