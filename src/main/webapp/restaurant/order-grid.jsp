<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>
<!-- Side Bar File -->
<%@ include file="includes/sidebar.jsp"%>

<!-- Top Bar File -->
<%@ include file="includes/topbar.jsp"%>

<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="RestaurantHome">Home</a></li>
		<li aria-current="page">Live Order Status</li>
	</ul>
</nav>

<!-- ===== Main Conatiner Starts ===== -->
<style>
.order-main-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	box-sizing: border-box;
	gap: 10px;
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
	justify-content: space-between;
	margin-top: 5px;
	width: 100%;
	align-items: center;
}

.no-order {
	position: relative;
	padding: 10px;
	background-color: var(--sidebar-color);
	box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 5px 0px, rgba(0, 0, 0, 0.1) 0px
		0px 1px 0px;
}

.no-order > h3{
	position: absolute;
	z-index: 2;
	top: 50%;            
    left: 50%;           
    transform: translate(-50%, -50%); 
    width: 100%;         
    text-align: center;
}

.no-order img{
	object-fit: cover;
	mix-blend-mode: color-burn;
}

.order-header-top {
	display: flex;
	align-items: flex-start;
	justify-content: space-between;
	position: relative;
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

.customer-info {
	flex-grow: 1;
}

.badge-success {
	background-color: var(--success);
	color: white;
	border-radius: 50%;
	padding: 2px 6px;
	font-size: 12px;
	min-width: 20px;
	height: fit-content;
	animation: blink 1s infinite;
}

.order-content {
	overflow: auto;
	max-height: 200px;
}

/* ===== Cart Item Section ===== */
.cart-item {
	display: flex;
	align-items: center;
	gap: 10px;
	border-bottom: 1px dashed var(--border-color);
}

.cart-item-img {
	width: 40px;
	height: 40px;
	object-fit: cover;
}

.cart-item-details {
	flex-grow: 1;
	width: 200px;
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

.highlight-in-progress {
	background-color: green;
}

.highlight-in-pending {
	background-color: red;
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

.grayscale {
	filter: grayscale(100%);
	-webkit-filter: grayscale(100%);
	background-color: grey;
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
	z-index: 20;
	color: white;
	box-shadow: 0 calc(-1 * var(--f)) 0 inset #0005;
}

@media screen and (max-width: 767px) {
	.cart-item-title {
		font-size: 12px;
	}
	.order-content, .cart-item-price, .cart-item-total {
		font-size: 13px;
	}
}

@media ( min-width : 768px) and (max-width: 1024px) {
	.cart-item-title {
		font-size: 12px;
	}
	.order-content, .cart-item-price, .cart-item-total {
		font-size: 13px;
	}
}
</style>

<div class="order-main-container">
	<%
	List<Orders> orders = (List<Orders>) request.getAttribute("orders");
	List<Users> deliveryAgents = (List<Users>) request.getAttribute("deliveryAgents");
	boolean foundLiveOrders = false;
	Map<Integer, List<OrderItems>> orderItemsMap = (Map<Integer, List<OrderItems>>) request.getAttribute("orderItemsMap");
	Map<Integer, MenuItems> menuItemsMap = (Map<Integer, MenuItems>) request.getAttribute("menuItemsMap");
	Map<Integer, PaymentDetails> paymentDetailsMap = (Map<Integer, PaymentDetails>) request
			.getAttribute("paymentDetailsMap");
	Map<Integer, Users> userMap = (Map<Integer, Users>) request.getAttribute("userMap");
	Map<Integer, DeliveryInfo> deliveryInfoMap = (Map<Integer, DeliveryInfo>) request.getAttribute("deliveryInfoMap");
	Map<Integer, Users> deliveryPersonnelMap = (Map<Integer, Users>) request.getAttribute("deliveryPersonnelMap");

	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, MMM dd, yyyy - hh:mm a");

	if (orders != null && !orders.isEmpty()) {
		Collections.sort(orders, new Comparator<Orders>() {
			public int compare(Orders o1, Orders o2) {
		DeliveryInfo di1 = deliveryInfoMap.get(o1.getOrderID());
		DeliveryInfo di2 = deliveryInfoMap.get(o2.getOrderID());
		boolean isAssigned1 = di1 != null && di1.getDeliveryPersonnelID() != 0;
		boolean isAssigned2 = di2 != null && di2.getDeliveryPersonnelID() != 0;

		if (!isAssigned1 && isAssigned2) {
			return -1; 
		} else if (isAssigned1 && !isAssigned2) {
			return 1; 
		}

		String status1 = o1.getStatus();
		String status2 = o2.getStatus();
		if ("Pending".equalsIgnoreCase(status1) && !"Pending".equalsIgnoreCase(status2)) {
			return -1; 
		} else if (!"Pending".equalsIgnoreCase(status1) && "Pending".equalsIgnoreCase(status2)) {
			return 1;
		} else if ("In Progress".equalsIgnoreCase(status1) && !"In Progress".equalsIgnoreCase(status2)) {
			return -1;
		} else if (!"In Progress".equalsIgnoreCase(status1) && "In Progress".equalsIgnoreCase(status2)) {
			return 1;
		}
		return 0; 
			}
		});

		for (Orders order : orders) {
			List<OrderItems> items = orderItemsMap.get(order.getOrderID());
			PaymentDetails payment = paymentDetailsMap.get(order.getOrderID());
			Users customer = userMap.get(order.getUserID());
			DeliveryInfo deliveryInfo = deliveryInfoMap.get(order.getOrderID());
			Users deliveryAgent = deliveryPersonnelMap
			.get(deliveryInfo != null ? deliveryInfo.getDeliveryPersonnelID() : null);
			LocalDateTime orderDateTime = order.getOrderDateTime();
			String formattedDate = orderDateTime != null ? formatter.format(orderDateTime) : "No date provided";
			String status = order.getStatus();
			String orderClass = "Pending".equalsIgnoreCase(status) ? "highlight-in-pending"
			: "In Progress".equalsIgnoreCase(status) ? "highlight-in-progress" : "";
			if ("Pending".equalsIgnoreCase(status) || "In Progress".equalsIgnoreCase(status)) {
		foundLiveOrders = true;
	%>
	<div class="order-main <%=orderClass%>">
		<div class="order-header-top">
			<div class="customer-info">
				<h3><%=customer != null ? customer.getName() : "Unknown"%></h3>
				<p>
					Mobile:
					<%=customer != null ? customer.getPhoneNumber() : "N/A"%></p>
			</div>
			<div class="right-end">
				<h3>
					<span class="badge-success"><%=items != null ? items.size() : "0"%></span>
				</h3>
			</div>
		</div>
		<div class="order-content">
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
						<span class="tooltip-container-order"> <%=menuItem.getName().length() > 25 ? menuItem.getName().substring(0, 25) + "..." : menuItem.getName()%>
							<span class="tooltip-text-order"><%=menuItem.getName()%></span>
						</span>
					</div>
					<div class="cart-item-price">
						<i class="bx bx-rupee"></i><%=item.getPrice()%></div>
				</div>
				<div class="cart-item-qty">
					Qty :
					<%=item.getQuantity()%></div>
				<div class="cart-item-total">
					<i class="bx bx-rupee"></i><%=item.getItemTotalPrice()%></div>
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
		<div class="border-top">
			<%
			if ("Pending".equals(status)) {
			%>
			<div class="card-footer">
				<form action="UpdateOrderStatus" method="POST">
					<input type="hidden" name="orderID" value="<%=order.getOrderID()%>">
					<input type="hidden" name="Status" value="In Progress">
					<button type="submit" class="button-25">Accept</button>
				</form>
			</div>
			<%
			} else {
			%>
			<div class="card-footer">
				<%
				if ("In Progress".equalsIgnoreCase(status) && deliveryAgent == null) {
				%>
				<form action="AssignDeliveryAgent" method="POST">
					<input type="hidden" name="orderID" value="<%=order.getOrderID()%>">
					<select name="deliveryAgentID">
						<%
						for (Users agent : deliveryAgents) {
						%>
						<option value="<%=agent.getUserID()%>"><%=agent.getName()%></option>
						<%
						}
						%>
					</select>
					<button type="submit" class="button-25">Assign</button>
				</form>
				<%
				} else if (deliveryAgent != null) {
				%>
				<div>
					<p>
						<b>Assigned to:</b>
						<%=deliveryAgent.getName()%></p>
					<p>
						<b>Status:</b>
						<%=deliveryInfo.getStatus()%></p>
				</div>
				<%
				}
				%>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<%
	}
	}
	if (!foundLiveOrders) {
	%>
	<div class="no-order">
		<h3>No live Orders Found</h3>
		<img src="assets/images/noorder.png" alt="No Orders Found">
	</div>
	<%
	}
	} else {
	%>
	<div class="no-order">
		<h3>No Orders Found</h3>
		<img src="assets/images/noorder.png" alt="No Orders Found">
	</div>
	<%
	}
	%>

</div>


<!-- Footer Main File -->

<%@ include file="includes/footer-main.jsp"%>