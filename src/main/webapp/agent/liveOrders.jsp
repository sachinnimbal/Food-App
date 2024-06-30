<%@ page
	import="java.util.List, java.util.Map, com.foodiedelight.model.*"%>
<%@ include file="includes/sidebar.jsp"%>
<%@ include file="includes/topbar.jsp"%>

<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="AgentHome">Home</a></li>
		<li aria-current="page">Live Orders</li>
	</ul>
</nav>


<div class="deliver-order-main-container">
	<%
	List<DeliveryInfo> assignedDeliveries = (List<DeliveryInfo>) request.getAttribute("assignedDeliveries");
	Map<Integer, Orders> ordersMap = (Map<Integer, Orders>) request.getAttribute("ordersMap");
	Map<Integer, List<OrderItems>> orderItemsMap = (Map<Integer, List<OrderItems>>) request.getAttribute("orderItemsMap");
	Map<Integer, MenuItems> menuItemsMap = (Map<Integer, MenuItems>) request.getAttribute("menuItemsMap");
	Map<Integer, PaymentDetails> paymentDetailsMap = (Map<Integer, PaymentDetails>) request
			.getAttribute("paymentDetailsMap");
	Map<Integer, Users> customerMap = (Map<Integer, Users>) request.getAttribute("customerMap");
	Map<Integer, Restaurants> restaurantMap = (Map<Integer, Restaurants>) request.getAttribute("restaurantMap");
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, MMM dd, yyyy - hh:mm a");
	boolean foundLiveOrders = false;
	if (assignedDeliveries != null && !assignedDeliveries.isEmpty()) {
		Collections.sort(assignedDeliveries, new Comparator<DeliveryInfo>() {
			@Override
			public int compare(DeliveryInfo d1, DeliveryInfo d2) {
		LocalDateTime dt1 = d1.getDeliverDateTime();
		LocalDateTime dt2 = d2.getDeliverDateTime();
		if (dt1 == null && dt2 == null)
			return 0;
		if (dt1 == null)
			return -1;
		if (dt2 == null)
			return 1;
		return dt1.compareTo(dt2);
			}
		});

		for (DeliveryInfo delivery : assignedDeliveries) {
			boolean isDelivered = "Delivered".equals(delivery.getStatus());
			if (!isDelivered) {
		foundLiveOrders = true;
		Orders order = ordersMap.get(delivery.getOrderID());
		Users customer = customerMap.get(order != null ? order.getUserID() : null);
		Restaurants restaurant = restaurantMap.get(order != null ? order.getRestaurantID() : null);
		List<OrderItems> items = orderItemsMap.get(delivery.getOrderID());
		PaymentDetails paymentDetails = paymentDetailsMap.get(delivery.getOrderID());
		LocalDateTime delivered = delivery.getDeliverDateTime();
		String deliveredDate = delivered != null ? formatter.format(delivered) : "No date provided";
	%>

	<div class="deliver-order-main  <%=isDelivered ? "grayscale" : ""%>">
		<%
		if (isDelivered) {
		%>
		<div class="ribbon-2">Delivered</div>
		<%
		}
		%>
		<div class="deliver-order-header-top">
			<img
				src="RestaurantImages/<%=(restaurant != null && restaurant.getImageURL() != null)
		? restaurant.getImageURL()
		: "RestaurantImages/default.png"%>"
				alt="<%=restaurant != null ? restaurant.getName() : "Restaurant Name"%>"
				class="restaurant-image">
			<div class="restaurant-info">
				<h4>
					<a href="Menus?restaurantId=<%=restaurant.getRestaurantID()%>"
						style="text-decoration: none; color: inherit;"> <span
						class="tooltip-container-order"> <%=restaurant.getName().length() > 20 ? restaurant.getName().substring(0, 20) + "..." : restaurant.getName()%>
							<span class="tooltip-text-order"><%=restaurant.getName()%></span></span></a>
				</h4>
				<span><%=restaurant != null ? restaurant.getStreet() + ", " + restaurant.getCity() : "Location"%></span>
			</div>

		</div>

		<hr class="dotted-line">
		<div class="deliver-order-content">
			<h3>Customer Info :</h3>
			<div class="order-details">
				<span><b>Name: </b><%=customer.getName()%></span> <span><b>Phone:
				</b><%=customer.getPhoneNumber()%></span> <span style="text-align: justify;"><b>Address:
				</b><%=order.getDeliveryAddress()%></span>
			</div>
			<hr class="dotted-line">
			<h3>
				Items Ordered : <span class="badge-success"><%=items != null ? items.size() : "0"%></span>
			</h3>
			<%
			for (OrderItems item : items) {
				MenuItems menuItem = menuItemsMap.get(item.getItemID());
				if (menuItem != null) {
			%>
			<div class="cart-item">
				<img src="FoodItems/<%=menuItem.getPhotoURL()%>"
					alt="<%=menuItem.getName()%>" class="cart-item-img">
				<div class="cart-item-details">
					<div class="cart-item-title">
						<span class="tooltip-container-order"> <%=menuItem.getName().length() > 10 ? menuItem.getName().substring(0, 10) + "..." : menuItem.getName()%>
							<span class="tooltip-text-order"><%=menuItem.getName()%></span>
						</span>
					</div>
					<div class="cart-item-price">
						<i class="bx bx-rupee"></i><%=item.getPrice()%>
					</div>
				</div>
				<div class="cart-item-qty">
					Qty :
					<%=item.getQuantity()%></div>
				<div class="cart-item-total">
					<i class="bx bx-rupee"></i><%=item.getItemTotalPrice()%>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
		<hr class="dotted-line">
		<div class="card-bottom">
			<span><b>Total Amount:</b> <i class="bx bx-rupee"></i><%=order.getTotalAmount()%></span>
			<%
			if (delivery.getEstimatedDeliveryTime() == null) {
			%>
			<div class="update-details">
				<form action="DeliveredStatus" method="POST">
					<input type="hidden" name="deliveryID"
						value="<%=delivery.getDeliveryID()%>">
					<div class="estimated-delivery">
						<label for="estimatedDeliveryTime">Estimated Delivery
							Time:</label> <input type="time" id="estimatedDeliveryTime"
							name="estimatedDeliveryTime" required>
					</div>
					<div class="right mt-5">
						<button type="submit" class="button-25">Update</button>
					</div>
				</form>
			</div>
			<%
			} else if (delivery.getDeliverDateTime() == null) {
			%>
			<div class="delivered-details">
				<span><b>Estimated Delivery Time:</b> <%=delivery.getEstimatedDeliveryTime()%></span>
				<form action="DeliveredStatus" method="POST">
					<input type="hidden" name="orderID" value="<%=order.getOrderID()%>">
					<input type="hidden" name="deliveryID"
						value="<%=delivery.getDeliveryID()%>"> <input
						type="hidden" name="Status">
					<div class="delivered-time">
						<label for="deliveredTime">Delivered Time:</label> <input
							type="datetime-local" id="deliveredTime" name="deliveredTime"
							required>
					</div>
					<div class="right mt-5">
						<button type="submit" class="button-25">Delivered</button>
					</div>
				</form>
			</div>
			<%
			} else {
			%>
			<div class="delivered">
				<span><b>Delivered:</b> <%=deliveredDate%></span>
			</div>
			<%
			}
			%>
		</div>

	</div>
	<%
	}
	}
	}
	if (!foundLiveOrders) {
	%>
	<div class="no-order">
		<h3>No Live Orders Found</h3>
		<img src="assets/images/noorder.png" alt="No Live Orders Found">
	</div>
	<%
	}
	%>

</div>



<style>
.deliver-order-main-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 10px;
	padding: 10px;
	box-sizing: border-box;
}

.deliver-order-main {
	background-color: var(--sidebar-color);
	padding: 10px;
	box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 5px 0px, rgba(0, 0, 0, 0.1) 0px
		0px 1px 0px;
}

.deliver-order-header-top {
	display: flex;
	align-items: flex-start;
	gap: 10px;
	justify-content: flex-start;
}

.deliver-order-header-top img {
	width: 60px;
	height: 60px;
	object-fit: cover;
}

.deliver-order-content {
	max-height: 220px;
	overflow: auto;
}

.green {
	background: green;
}

.card-bottom {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	justify-content: flex-end;
	width: 100%;
	gap: 5px;
}

.restaurant-orders {
	display: flex;
	justify-content: space-between;
}

.tooltip-container-order {
	position: relative;
	display: inline-block;
	cursor: pointer;
}

.tooltip-text-order {
	visibility: hidden;
	width: 280px;
	background-color: var(--sidebar-color);
	color: var(--text-color);
	text-align: center;
	border-radius: 6px;
	padding: 5px 10px;
	position: absolute;
	z-index: 1;
	bottom: 100%;
	left: 100%;
	transform: translateX(-50%);
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	margin-bottom: 0;
	opacity: 0;
	transition: opacity 0.3s, visibility 0.3s ease-in-out;
}

.tooltip-container-order:hover .tooltip-text-order {
	visibility: visible;
	opacity: 1;
}

.delivered {
	display: flex;
	flex-direction: column;
}

.no-order {
	text-align: center;
	padding: 10px;
	background-color: var(--sidebar-color);
	box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 5px 0px, rgba(0, 0, 0, 0.1) 0px
		0px 1px 0px;
}

.no-order img {
	object-fit: cover;
	width: 300px;
}
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