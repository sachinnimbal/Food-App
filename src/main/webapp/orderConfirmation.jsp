<!-- ===== Side Bar File ===== -->
<%@page import="org.apache.el.parser.AstString"%>
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>


<style>
.order-confirm-container {
	display: grid;
	padding: 20px;
	justify-content: center;
	align-items: center;
	box-sizing: border-box;
}

.order-main>.order-header-top {
	display: flex;
	justify-content: center;
	align-items: center;
}

.order-btn {
	display: flex;
	align-items: center;
	justify-content: space-between;
}
/* ===== Cart Item Section ===== */
.cart-item {
	display: flex;
	align-items: center;
	gap: 10px;
	width: 100%;
	border-bottom: 1px dashed var(--border-color);
}

.cart-item-img {
	width: 40px;
	height: 40px;
	object-fit: cover;
}

.cart-item-details {
	flex-grow: 1;
	width: 400px;
}

.cart-item-title {
	font-size: 14px;
	font-weight: 500;
}

.cart-item-price, .cart-item-total {
	font-size: 15px;
	font-weight: 500;
}

.cart-item-total {
	display: flex;
	align-items: center;
}

.order-content {
	max-height: 350px;
	overflow: auto;
}

.progtrckr {
	margin: 0;
	padding: 0;
	width: 100%;
	list-style-type: none;
	display: flex;
	justify-content: space-between;
}

.progtrckr li {
	width: calc(100%/ 3);
	text-align: center;
	line-height: 50px;
	position: relative;
}

.progtrckr li:before {
	content: '';
	position: absolute;
	top: 30px; /* Adjusted for better visual alignment */
	left: 50%;
	transform: translateX(-50%);
	width: 32px;
	height: 32px;
	display: block;
	background-size: cover;
}

.center {
	text-align: center;
	font-size: 2em;
	font-weight: bold;
}

.progtrckr li.progtrckr-todo:before {
	background-image: url('assets/gif/loading.gif');
}

.progtrckr li.progtrckr-done:before {
	background-image: url('assets/images/check.png');
}

.progtrckr li.progtrckr-done, .progtrckr li.progtrckr-todo {
	color: black;
	border-bottom: 4px solid var(--light-color);
}

.progtrckr li.progtrckr-done {
	border-bottom: 4px solid #999900;
}

.progtrckr li.progtrckr-cancelled {
	border-bottom: 4px solid red;
}

.progtrckr li.progtrckr-cancelled:before {
	background-image: url('assets/images/cancelled.png');
}

.animation-ctn {
	text-align: center;
}

.icon--order-success svg polyline {
	animation: checkmark 0.25s ease-in-out 0.7s forwards;
	/* Use 'forwards' to retain the final state */
}

.icon--order-success svg circle {
	animation: checkmark-circle 0.6s ease-in-out forwards;
	/* Use 'forwards' to retain the final state */
}

.icon--order-success svg circle#colored {
	animation: colored-circle 0.6s ease-in-out 0.7s forwards;
	/* Use 'forwards' to retain the final state */
}

@keyframes checkmark { 0% {
	stroke-dashoffset: 100px;
}100%{stroke-dashoffset:0px;}}
@keyframes checkmark-circle { 0% {stroke-dashoffset: 480px;}100%
{stroke-dashoffset:0px;}
}@keyframes colored-circle { 0% {opacity: 0;}100%{opacity:1;}}
</style>

<!-- Main Container Starts -->
<div class="order-confirm-container">

	<%
	Orders order = (Orders) session.getAttribute("order");
	List<OrderItems> orderItems = (List<OrderItems>) session.getAttribute("orderItems");
	List<MenuItems> menuItemsList = (List<MenuItems>) session.getAttribute("menuItemsList");
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy HH:mm");
	LocalDateTime orderDateTime = order.getOrderDateTime();
	String formattedDate = orderDateTime != null ? formatter.format(orderDateTime) : "No date provided";

	if (order == null || orderItems == null || menuItemsList == null || orderItems.isEmpty() || menuItemsList.isEmpty()) {
	%>
	<div class="no-order">
		<img src="assets/images/noorder.png" alt="No Orders Found">
		<h3>Something went wrong</h3>
	</div>
	<%
	} else {
	%>

	<div class="order-main">
		<div class="order-header-top">
			<div class="animation-ctn">
				<div class="icon icon--order-success svg">
					<svg xmlns="http://www.w3.org/2000/svg" width="154px"
						height="154px">
		                <g fill="none" stroke="#DAA520" stroke-width="2">
		                    <circle cx="77" cy="77" r="72"
							style="stroke-dasharray:480px, 480px; stroke-dashoffset: 480px;">
		                    </circle>
		                    <circle id="colored" fill="#DAA520" cx="77"
							cy="77" r="72"
							style="stroke-dasharray:480px, 480px; stroke-dashoffset: 480px;"></circle>
		                    <polyline class="st0" stroke="#FFF"
							stroke-width="10" points="43.5,77.8 63.7,97.9 112.2,49.4"
							style="stroke-dasharray:100px, 100px; stroke-dashoffset: 100px;" />
		                </g>
		            </svg>
				</div>
			</div>
		</div>
		<h1 class="restaurant-name center">Order Placed Successfully</h1>
		<hr class="dotted-line">
		<div class="order-content">
			<h3>Order Info :</h3>
			<div class="order-details">
				<span> <b>Order Date:</b> <%=formattedDate%>
				</span> <span> <b>Delivery Address:</b> <%=order.getDeliveryAddress()%></span>
			</div>
			<hr class="dotted-line">
			<h3>
				Items Ordered: <span class="badge-success"><%=orderItems.size()%></span>
			</h3>
			<%
			for (int i = 0; i < orderItems.size(); i++) {
				OrderItems item = orderItems.get(i);
				MenuItems menuItem = menuItemsList.get(i);
			%>
			<div class="cart-item">
				<img src="FoodItems/<%=menuItem.getPhotoURL()%>"
					alt="<%=menuItem.getName()%>" class="cart-item-img">
				<div class="cart-item-details">
					<div class="cart-item-title"><%=menuItem.getName()%></div>
					<div class="cart-item-price">
						<i class="bx bx-rupee"></i><%=item.getPrice()%>
					</div>
				</div>
				<div class="cart-item-qty">
					Qty:
					<%=item.getQuantity()%>
				</div>
				<div class="cart-item-total">
					<i class="bx bx-rupee"></i><%=item.getItemTotalPrice()%>
				</div>
			</div>
			<%
			}
			%>
			<div class="cart-bottom">
				<span>Sub Total: <i class="bx bx-rupee"></i><%=order.getSubtotal()%></span>
				<span>GST: <i class="bx bx-rupee"></i><%=order.getGst()%></span> <span>Total:
					<i class="bx bx-rupee"></i><%=order.getTotalAmount()%></span>
			</div>
		</div>
		<hr class="dotted-line">
		<%
		String status = order.getStatus();
		%>
		<div class="order-status">
			<ol class="progtrckr" data-progtrckr-steps="4">
				<li
					class="<%="Cancelled".equalsIgnoreCase(status) ? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(status) || "Out for Delivery".equalsIgnoreCase(status)
				|| "In Progress".equalsIgnoreCase(status) || "Pending".equalsIgnoreCase(status) ? "progtrckr-done"
						: "progtrckr-todo")%>">Order
					Placed</li>
				<li
					class="<%="Cancelled".equalsIgnoreCase(status) ? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(status) || "In Progress".equalsIgnoreCase(status) ? "progtrckr-done"
				: "progtrckr-todo")%>">Preparing</li>
				<li
					class="<%="Cancelled".equalsIgnoreCase(status) ? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(status) || "Out for Delivery".equalsIgnoreCase(status) ? "progtrckr-done"
				: "progtrckr-todo")%>">Out
					for Delivery</li>
				<li
					class="<%="Cancelled".equalsIgnoreCase(status) ? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(status) ? "progtrckr-done" : "progtrckr-todo")%>">Delivered</li>
			</ol>
		</div>
	</div>
	<%
	}
	%>
	<div class="order-btn">
		<a href="UserHome">Home Page</a> <a href="OrderHistory">View Order</a>
	</div>
</div>


<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>
