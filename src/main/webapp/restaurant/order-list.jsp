<!-- Side Bar File -->
<%@ include file="includes/sidebar.jsp"%>

<!-- Top Bar File -->
<%@ include file="includes/topbar.jsp"%>
<style>
.orders-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr); /* 3 cards per row */
	gap: 20px; /* Space between cards */
	padding: 20px;
}

.order-card {
	background: #fff;
	border: 1px solid #ccc;
	border-radius: 8px;
	overflow: hidden;
	transition: box-shadow 0.3s ease-in-out;
}

.order-card:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-header, .card-footer {
	padding: 15px;
	background-color: #f1f1f1;
}

.panel {
	max-height: 0;
	overflow: hidden;
	transition: max-height 0.2s ease-out;
	background-color: #fff;
	padding: 0 15px;
}

.accordion {
	background-color: #eee;
	color: #444;
	cursor: pointer;
	padding: 18px;
	border: none;
	text-align: left;
	outline: none;
	width: 100%;
	transition: background-color 0.3s ease;
}

.accordion:hover {
	background-color: #ccc;
}

.accordion:after {
	content: '\002B';
	color: #777;
	font-weight: bold;
	float: right;
}

.accordion.active, .accordion:hover {
	background-color: #ccc;
}

.accordion.active:after {
	content: "\2212";
}

.panel.active {
	max-height: 500px; /* Adjust as per content size */
}
</style>

<div class="orders-container">
	<%
	List<Orders> orders = (List<Orders>) request.getAttribute("orders");
	Map<Integer, List<OrderItems>> orderItemsMap = (Map<Integer, List<OrderItems>>) request.getAttribute("orderItemsMap");
	Map<Integer, MenuItems> menuItemsMap = (Map<Integer, MenuItems>) request.getAttribute("menuItemsMap");
	Map<Integer, PaymentDetails> paymentDetailsMap = (Map<Integer, PaymentDetails>) request
			.getAttribute("paymentDetailsMap");
	Map<Integer, Users> userMap = (Map<Integer, Users>) request.getAttribute("userMap");

	for (Orders order : orders) {
		List<OrderItems> items = orderItemsMap.get(order.getOrderID());
		PaymentDetails payment = paymentDetailsMap.get(order.getOrderID());
		Users customer = userMap.get(order.getUserID());
	%>
	<div class="order-card">
		<div class="card-header">
			<h2>
				Order ID:
				<%=order.getOrderID()%></h2>
			<p>
				Customer:
				<%=customer != null ? customer.getName() : "Unknown"%>
				(<%=customer != null ? customer.getPhoneNumber() : "No phone"%>)
			</p>
		</div>
		<button class="accordion">View Items</button>
		<div class="panel">
			<h3>Items Ordered:</h3>
			<ul>
				<%
				if (items != null && !items.isEmpty()) {
					for (OrderItems item : items) {
						MenuItems menuItem = menuItemsMap.get(item.getItemID());
						if (menuItem != null) {
				%><li><%=menuItem.getName()%> -
					Quantity: <%=item.getQuantity()%></li>
				<%
				} else {
				%><li>Item ID: <%=item.getItemID()%>
					- Details not available
				</li>
				<%
				}
				}
				} else {
				%>
				<li>No items found for this order.</li>
				<%
				}
				%>
			</ul>
		</div>
		<div class="card-footer">
			<h3>Payment Details:</h3>
			<p>
				Method:
				<%=payment != null ? payment.getPaymentMethod() : "No payment info"%></p>
			<p>
				Amount Paid: ₹<%=payment != null ? payment.getAmount() : "0.00"%></p>
		</div>
	</div>
	<%
	}
	%>
</div>

<script>
document.querySelectorAll('.accordion').forEach(button => {
    button.addEventListener('click', function() {
        this.classList.toggle("active");
        var panel = this.nextElementSibling;
        panel.classList.toggle("active");
        if (panel.style.maxHeight) {
            panel.style.maxHeight = null;
        } else {
            panel.style.maxHeight = panel.scrollHeight + "px";
        }
    });
});
</script>

<!-- Footer Main File -->
<%@ include file="includes/footer-main.jsp"%>

