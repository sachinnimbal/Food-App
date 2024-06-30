<%@page import="java.time.Duration"%>
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>

<!-- ===== Main Conatiner Starts ===== -->
<style>
.order-main-container {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	box-sizing: border-box;
}

.order-main {
	background-color: var(--sidebar-color);
	padding: 10px;
	box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 5px 0px, rgba(0, 0, 0, 0.1) 0px
		0px 1px 0px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	position: relative;
}

.card-footer {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	justify-content: flex-end;
	width: 100%;
}

.no-order {
	text-align: center;
	padding: 20px;
	background-color: var(--sidebar-color);
	box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 5px 0px, rgba(0, 0, 0, 0.1) 0px
		0px 1px 0px;
}

.order-header-top {
	display: flex;
	align-items: flex-start;
	justify-content: space-between;
	position: relative;
}

.restaurant-image {
	width: 100px;
	height: 100px;
	object-fit: cover;
	margin-right: 3px;
}

.restaurant-info {
	flex-grow: 1;
}

.cart-item-details {
	flex-grow: 1;
	width: 100px;
}

.delivery-info {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.right-end {
	flex: 0 0 auto;
	display: flex;
	align-items: center;
}

.right-end p {
	margin: 0;
	white-space: nowrap;
}

.badge-success {
	background-color: var(--success);
	color: white;
	border-radius: 50%;
	padding: 2px 6px;
	font-size: 12px;
	min-width: 20px;
	height: fit-content;
}

.order-content {
	overflow: auto;
	max-height: 200px;
}

.cart-item-qty {
	display: flex;
	flex-grow: 1;
}

.cart-bottom {
	width: 100%;
	display: flex;
	justify-content: end;
	flex-direction: column;
	align-items: end;
	display: flex;
}

.cart-bottom>span {
	font-weight: bold;
}

.order-status {
	width: 100%;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.cart-item-title {
	max-width: 200px;
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

.grayscale {
	filter: grayscale(100%);
	-webkit-filter: grayscale(100%);
}

.delivery-section {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 10px;
}

.left, .right {
	flex: 1;
}

.tooltip-container {
	position: relative;
	display: inline-block;
	cursor: pointer;
}

.tooltip-text {
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
	margin-bottom: 0;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	opacity: 0;
	transition: opacity 0.3s, visibility 0.3s ease-in-out;
}

.tooltip-container:hover .tooltip-text {
	visibility: visible;
	opacity: 1;
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
	background: green;
	z-index: 20;
	color: white;
	box-shadow: 0 calc(-1 * var(--f)) 0 inset #0005;
}

.progtrckr li:before {
	content: '';
	position: absolute;
	top: 30px;
	left: 50%;
	transform: translateX(-50%);
	width: 32px;
	height: 32px;
	display: block;
	background-size: cover;
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

@media screen and (max-width: 767px) {
	.cart-item-title {
		font-size: 12px;
	}
	.order-content, .cart-item-price, .cart-item-total {
		font-size: 13px;
	}
	.progtrckr li {
		width: 100%;
		display: block;
		margin-bottom: 10px;
	}
	.no-order img {
		width: 250px;
		height: auto;
	}
	.order-main-container {
		grid-template-columns: repeat(1, 1fr);
		gap: 10px;
		padding: 10px;
	}
	.progtrckr li {
		width: calc(100%/ 3);
		text-align: center;
		line-height: 30px;
		position: relative;
		font-size: 10px;
	}
	.progtrckr li:before {
		content: '';
		position: absolute;
		top: 20px;
		left: 50%;
		transform: translateX(-50%);
		width: 32px;
		height: 32px;
		display: block;
		background-size: cover;
	}
}

@media ( min-width : 768px) and (max-width: 1024px) {
	.cart-item-title {
		font-size: 12px;
	}
	.order-content, .cart-item-price, .cart-item-total {
		font-size: 13px;
	}
	.progtrckr li {
		width: 100%;
		display: block;
		margin-bottom: 10px;
	}
	.order-main-container {
		grid-template-columns: repeat(2, 1fr);
		gap: 10px;
		padding: 10px;
	}
	.progtrckr li {
		width: calc(100%/ 3);
		text-align: center;
		line-height: 30px;
		position: relative;
		font-size: 10px;
	}
	.progtrckr li:before {
		content: '';
		position: absolute;
		top: 20px;
		left: 50%;
		transform: translateX(-50%);
		width: 32px;
		height: 32px;
		display: block;
		background-size: cover;
	}
}

.star-rating {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 10px;
}

.star-rating button.star {
	background: none;
	border: none;
	font-size: 25px;
	color: #ddd;
	cursor: pointer;
	transition: color 0.2s ease-in-out;
	color: #ddd;
}

.star-rating button.star:hover, .star-rating button.star:focus {
	color: #FEBE10;
}

.star-rating button.star.active {
	color: #FEBE10;
}

.star-rating button.star.filled {
	color: #FEBE10;
}

.stars-rating {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 10px;
}

.stars-rating button.stars {
	background: none;
	border: none;
	font-size: 25px;
	color: #ddd;
	cursor: pointer;
	transition: color 0.2s ease-in-out;
	color: #ddd;
}

.stars-rating button.stars:hover, .stars-rating button.stars:focus {
	color: #FEBE10;
}

.stars-rating button.stars.active {
	color: #FEBE10;
}

.stars-rating button.stars.filled {
	color: #FEBE10;
}
</style>

<div class="order-main-container">
	<%
	Map<Integer, Restaurants> restaurantMap = (Map<Integer, Restaurants>) request.getAttribute("restaurantMap");
	List<Orders> orders = (List<Orders>) request.getAttribute("orders");
	Map<Integer, List<OrderItems>> orderItemsMap = (Map<Integer, List<OrderItems>>) request.getAttribute("orderItemsMap");
	Map<Integer, PaymentDetails> paymentDetailsMap = (Map<Integer, PaymentDetails>) request
			.getAttribute("paymentDetailsMap");
	Map<Integer, MenuItems> menuItemsMap = (Map<Integer, MenuItems>) request.getAttribute("menuItemsMap");
	Map<Integer, DeliveryInfo> deliveryInfoMap = (Map<Integer, DeliveryInfo>) request.getAttribute("deliveryInfoMap");
	Map<Integer, Users> deliveryPersonnelMap = (Map<Integer, Users>) request.getAttribute("deliveryPersonnelMap");
	Map<Integer, RatingsReviews> ratingsMap = (Map<Integer, RatingsReviews>) request.getAttribute("ratingsMap");
	Map<Integer, Agents> agentMap = (Map<Integer, Agents>) request.getAttribute("agentMap");
	Map<Integer, AgentRatings> agentRatingsMap = (Map<Integer, AgentRatings>) request.getAttribute("agentRatingsMap");
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, MMM dd, yyyy - hh:mm a");
	if (orders == null || orders.isEmpty()) {
	%>
	<div class="no-order">
		<img src="assets/images/noorder.png" alt="No Orders Found">
		<h3>No Orders Found</h3>
	</div>
	<%
	} else {
	Collections.sort(orders, new Comparator<Orders>() {
		public int compare(Orders o1, Orders o2) {
			return o2.getOrderDateTime().compareTo(o1.getOrderDateTime());
		}
	});

	for (Orders order : orders) {
		Restaurants restaurant = restaurantMap.get(order.getRestaurantID());
		List<OrderItems> items = orderItemsMap.get(order.getOrderID());
		PaymentDetails paymentDetails = paymentDetailsMap.get(order.getOrderID());
		DeliveryInfo deliveryInfo = deliveryInfoMap.get(order.getOrderID());
		Users deliveryAgent = deliveryPersonnelMap.get(deliveryInfo != null ? deliveryInfo.getDeliveryPersonnelID() : null);
		String formattedDate = order.getOrderDateTime() != null
		? formatter.format(order.getOrderDateTime())
		: "No date provided";
		String status = order.getStatus();
		String deliveryStatus = deliveryInfo != null ? deliveryInfo.getStatus() : "Not Available";
		boolean isCancelled = "Cancelled".equalsIgnoreCase(status);
		boolean isCancellable = "Pending".equalsIgnoreCase(status);
		String name = restaurant.getName();
		String restaurantName = name.length() > 35 ? name.substring(0, 35) + "..." : name;
		boolean isDelivered = "Delivered".equalsIgnoreCase(deliveryStatus);
	%>

	<div class="order-main <%=isCancelled ? "grayscale" : ""%>"
		data-order-id="<%=order.getOrderID()%>"
		data-restaurant-id="<%=restaurant.getRestaurantID()%>"
		data-user-id="<%=user.getUserID()%>">
		<%
		if (isDelivered) {
		%>
		<div class="ribbon-2">Delivered</div>
		<%
		} else if (isCancelled) {
		%>
		<div class="ribbon-2">Cancelled</div>
		<%
		}
		%>
		<div class="order-header-top">
			<img
				src="RestaurantImages/<%=(restaurant != null && restaurant.getImageURL() != null)
		? restaurant.getImageURL()
		: "RestaurantImages/default.png"%>"
				alt="<%=restaurant != null ? restaurantName : "Restaurant Name"%>"
				class="restaurant-image">
			<div class="restaurant-info">
				<h3>
					<a href="Menus?restaurantId=<%=restaurant.getRestaurantID()%>"
						style="text-decoration: none; color: inherit;"> <%=restaurant != null ? restaurantName : "Restaurant Name"%>
					</a>
				</h3>
				<span><%=restaurant != null ? restaurant.getStreet() + ", " + restaurant.getCity() : "Location"%></span>

				<%
				RatingsReviews userRating = ratingsMap.get(restaurant.getRestaurantID());
				boolean userHasRated = userRating != null && userRating.getUserID() == user.getUserID();
				int currentRating = userHasRated ? Math.round(userRating.getRating()) : 0;

				if (!isCancelled && isDelivered) {
				%>
				<form action="Ratings" method="POST">
					<input type="hidden" name="restaurantId"
						value="<%=restaurant.getRestaurantID()%>" /> <input type="hidden"
						name="userId" value="<%=user.getUserID()%>" />
					<div class="star-rating">
						<%
						for (int i = 1; i <= 5; i++) {
							String starClass = (i <= currentRating) ? "star filled" : "star";
						%>
						<button type="submit" name="rating" value="<%=i%>"
							class="<%=starClass%>" aria-label="Rate <%=i%> out of 5">&#9733;</button>
						<%
						}
						%>
					</div>
				</form>
				<%
				}
				%>

			</div>
			<div class="right-end mt-5">
				<p>
					<i class="bx bxs-star"></i><%=restaurant != null ? String.format("%.1f", restaurant.getAverageRating()) : "N/A"%></p>
			</div>
		</div>

		<hr class="dotted-line">
		<div class="order-content">
			<h3>Order Info :</h3>
			<div class="order-details">
				<span> <b>Order Date:</b> <%=formattedDate%></span> <span> <b>Delivery
						Address:</b> <%=order.getDeliveryAddress()%></span>
				<div class="delivery-section">
					<div class="left">
						<%
						if (deliveryAgent != null) {
						%>
						<p>
							<b>Delivery Agent:</b>
							<%=deliveryAgent.getName()%></p>
						<%
						}
						%>

						<%
						if (deliveryInfo != null) {
							boolean delivered = "Delivered".equalsIgnoreCase(deliveryInfo.getStatus());
							DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("EEE, MMM dd, yyyy - hh:mm a");
							LocalDateTime deliveryDateTime = deliveryInfo.getDeliverDateTime();

							if (delivered && deliveryDateTime != null) {
						%>
						<p>
							<b>Delivered On:</b>
							<%=dateTimeFormatter.format(deliveryDateTime)%></p>
						<%
						} else {
						LocalTime now = LocalTime.now();
						LocalTime estimatedTime = deliveryInfo.getEstimatedDeliveryTime();
						if (estimatedTime != null) {
							long minutesUntil = Duration.between(now, estimatedTime).toMinutes();
							minutesUntil += (minutesUntil < 0) ? 10 : 10; // Adjust this logic if needed
							String timeMessage = String.format("%d minutes", minutesUntil);
						%>
						<p>
							<b>Estimated Time:</b>
							<%=timeMessage%></p>
						<%
						}
						}
						}
						%>
					</div>
					<div class="right mr-5">

						<%
						if (deliveryInfo != null && isDelivered) {
							Agents agent = agentMap.get(deliveryInfo.getDeliveryPersonnelID());
							AgentRatings agentRating = agentRatingsMap.get(agent.getAgentID());
							boolean agentHasRated = agentRating != null && agentRating.getUserID() == user.getUserID();
							int currentAgentRating = agentHasRated ? Math.round(agentRating.getRating()) : 0;
						%>
						<form action="Ratings" method="POST">
							<input type="hidden" name="agentId"
								value="<%=agent != null ? agent.getAgentID() : 0%>" /> <input
								type="hidden" name="userId" value="<%=user.getUserID()%>" />
							<div class="stars-rating">
								<%
								for (int i = 1; i <= 5; i++) {
									String starClass = (i <= currentAgentRating) ? "stars filled" : "stars";
								%>
								<button type="submit" name="rating" value="<%=i%>"
									class="<%=starClass%>" aria-label="Rate <%=i%> out of 5">&#9733;</button>
								<%
								}
								%>
							</div>
						</form>
						<%
						}
						%>

					</div>
				</div>
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
						<span class="tooltip-container"> <%=menuItem.getName().length() > 15 ? menuItem.getName().substring(0, 15) + "..." : menuItem.getName()%>
							<span class="tooltip-text"><%=menuItem.getName()%></span>
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
			<div class="cart-bottom">
				<span>Sub Total: <i class="bx bx-rupee"></i><%=order.getSubtotal()%></span>
				<span>GST: <i class="bx bx-rupee"></i><%=order.getGst()%></span> <span>Total:
					<i class="bx bx-rupee"></i><%=order.getTotalAmount()%></span>
			</div>
		</div>
		<hr class="dotted-line">
		<div class="card-footer">
			<div class="order-status">
				<ol class="progtrckr" data-progtrckr-steps="4">
					<li
						class="<%="Cancelled".equalsIgnoreCase(status)
		? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(status) || "Out for Delivery".equalsIgnoreCase(status)
				|| "In Progress".equalsIgnoreCase(status) || "Pending".equalsIgnoreCase(status)
						? "progtrckr-done"
						: "progtrckr-todo")%>">Order
						Placed</li>
					<li
						class="<%="Cancelled".equalsIgnoreCase(status)
		? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(status) || "In Progress".equalsIgnoreCase(status)
				? "progtrckr-done"
				: "progtrckr-todo")%>">Preparing</li>
					<li
						class="<%="Cancelled".equalsIgnoreCase(status)
		? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(deliveryStatus) || "Out for Delivery".equalsIgnoreCase(deliveryStatus)
				? "progtrckr-done"
				: "progtrckr-todo")%>">Out
						for Delivery</li>
					<li
						class="<%="Cancelled".equalsIgnoreCase(status)
		? "progtrckr-cancelled"
		: ("Delivered".equalsIgnoreCase(deliveryStatus) ? "progtrckr-done" : "progtrckr-todo")%>">Delivered</li>
				</ol>
			</div>
			<%
			if (isCancellable && !"Delivered".equalsIgnoreCase(status) && !"Cancelled".equalsIgnoreCase(status)) {
			%>
			<div class="right mt-5">
				<form action="CancelOrder" method="POST">
					<input type="hidden" name="OrderID" value="<%=order.getOrderID()%>">
					<button type="submit" class="button-25">Cancel Order</button>
				</form>
			</div>
			<%
			}
			%>
		</div>


	</div>
	<%
}
}
%>
</div>


<script>
document.querySelectorAll('.star-rating button.star').forEach(button => {
    button.addEventListener('mouseover', function() {
        let stars = button.parentNode.children;
        let starValue = parseInt(button.value, 10);
        Array.from(stars).forEach(star => {
            let value = parseInt(star.value, 10);
            if (value <= starValue) {
                star.classList.add('active');
                star.style.transform = 'scale(1.3)';
            } else {
                star.classList.remove('active');
                star.style.transform = 'scale(1)';
            }
        });
    });
    button.addEventListener('mouseout', function() {
        let stars = button.parentNode.children;
        Array.from(stars).forEach(star => {
            star.classList.remove('active');
            star.style.transform = 'scale(1)';
        });
    });
});
document.querySelectorAll('.stars-rating button.stars').forEach(button => {
    button.addEventListener('mouseover', function() {
        let stars = button.parentNode.children;
        let starValue = parseInt(button.value, 10);
        Array.from(stars).forEach(star => {
            let value = parseInt(star.value, 10);
            if (value <= starValue) {
                star.classList.add('active');
                star.style.transform = 'scale(1.3)';
            } else {
                star.classList.remove('active');
                star.style.transform = 'scale(1)';
            }
        });
    });
    button.addEventListener('mouseout', function() {
        let stars = button.parentNode.children;
        Array.from(stars).forEach(star => {
            star.classList.remove('active');
            star.style.transform = 'scale(1)';
        });
    });
});
</script>



<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>
