<%@ page import="java.util.Map, java.math.BigDecimal"%>
<%@ page import="com.foodiedelight.model.Cart"%>
<%@ page import="com.foodiedelight.model.CartGenerator"%>

<!-- Side Bar File -->
<%@ include file="includes/sidebar.jsp"%>

<!-- Top Bar File -->
<%@ include file="includes/topbar.jsp"%>
<%
// Session-based flags
boolean addressAdded = session.getAttribute("addressAdded") != null && (Boolean) session.getAttribute("addressAdded");
boolean paymentInfoAdded = session.getAttribute("paymentInfoAdded") != null
		&& (Boolean) session.getAttribute("paymentInfoAdded");

// Cart and item calculations
boolean hasItemsInCart = cartGenerator != null && cartGenerator.cart != null && !cartGenerator.cart.isEmpty();
BigDecimal subtotal = BigDecimal.ZERO;
final BigDecimal GST_RATE = new BigDecimal("0.18"); // GST rate of 18%
BigDecimal gst = BigDecimal.ZERO;
BigDecimal grandTotal = BigDecimal.ZERO;

if (hasItemsInCart) {
	for (Map.Entry<Integer, Cart> entry : cartGenerator.cart.entrySet()) {
		Cart cartItem = entry.getValue();
		BigDecimal itemTotal = cartItem.getItemPrice().multiply(new BigDecimal(cartItem.getQuantity()));
		subtotal = subtotal.add(itemTotal);
	}
	gst = subtotal.multiply(GST_RATE);
	grandTotal = subtotal.add(gst);
}

// Restaurant details
String restaurantName = (String) session.getAttribute("restaurantName");
String restaurantLocation = (String) session.getAttribute("restaurantLocation");
String restaurantImage = (String) session.getAttribute("restaurantImage");
%>

<div class="container">
	<div class="column-sections">
		<%
		if (!isLoggedIn) {
		%>
		<div class="column login-signup">
			<%@ include file="includes/CheckLogin.jsp"%>
		</div>
		<%
		} else {
		%>
		<div class="column user-info">
			<h3 class="header-title">
				Logged in <img width="20" height="20"
					src="assets/images/checked.png" alt="checked" />
			</h3>
			<span class="fullname"> <%=user.getName()%></span>
		</div>
		<%
		if (!addressAdded) {
		%>
		<div class="column delivery-address">
			<%@ include file="includes/DeliveryAddress.jsp"%>
		</div>
		<%
		if (!paymentInfoAdded) {
		%>
		<div class="column payment">

			<h3 class="header-title">
				Payment
				<%if (grandTotal != null && grandTotal.compareTo(BigDecimal.ZERO) > 0) {%>
				<img width="20" height="20" src="assets/images/checked.png"
					alt="checked" />
				<%
				}
				%>
			</h3>
			<form class="form">
				<div class="form-row">
					<div class="form-group">
						<label for="amount">Amount to be Paid:</label> <input type="text"
							id="amount" value="<%=String.format("%.2f", grandTotal)%>"
							name="Amount" disabled placeholder="0.00"
							pattern="^\d*(\.\d{0,2})?$" required>
					</div>

					<div class="form-group">
						<label for="paymentMethod">Payment Method:</label> <select
							id="paymentMethod" name="PaymentMethod" required>
							<option value="" disabled>Select a method</option>
							<option value="Cash">Cash</option>
							<option value="UPI" disabled>UPI</option>
							<option value="Card" disabled>Card</option>
							<option value="Other" disabled>Other</option>
						</select>
					</div>
				</div>
			</form>
		</div>
		<%
		}
		%>
		<%
		}
		%>
		<%
		}
		%>
		<form id="checkoutForm" action="Checkout" method="POST">
			<input type="hidden" name="deliveryAddress"
				value="<%=user != null && user.getAddress() != null && !user.getAddress().isEmpty()
		? user.getAddress() + ", " + user.getStreet() + ", " + user.getCityName() + ", " + user.getState() + ", "
				+ user.getPinCode()
		: ""%>"
				required> <input type="hidden" id="amount" name="amount"
				value="<%=grandTotal != null ? String.format("%.2f", grandTotal) : ""%>">
			<input type="hidden" id="paymentMethod" name="paymentMethod"
				value="Cash">
			<%
			if (cartGenerator != null && cartGenerator.cart != null && !cartGenerator.cart.isEmpty()) {
				for (Map.Entry<Integer, Cart> entry : cartGenerator.cart.entrySet()) {
					Cart cartItem = entry.getValue();
			%>
			<input type="hidden" name="itemId[]" value="<%=entry.getKey()%>">
			<input type="hidden" name="itemQuantity[]"
				value="<%=cartItem.getQuantity()%>"> <input type="hidden"
				name="restaurantID" value="<%=cartItem.getRestaurantId()%>">
			<input type="hidden" name="itemName[]"
				value="<%=cartItem.getItemName()%>"> <input type="hidden"
				name="itemPrice[]" value="<%=cartItem.getItemPrice()%>"> <input
				type="hidden" name="itemTotalPrice[]"
				value="<%=String.format("%.2f", cartItem.getItemPrice().multiply(new BigDecimal(cartItem.getQuantity())).doubleValue())%>">
			<%
			}
			}
			%>
			<input type="hidden" name="subtotal"
				value="<%=subtotal != null ? String.format("%.2f", subtotal) : ""%>">
			<input type="hidden" name="gst"
				value="<%=gst != null ? String.format("%.2f", gst) : ""%>">
			<input type="hidden" name="grandTotal"
				value="<%=grandTotal != null ? String.format("%.2f", grandTotal) : ""%>">
			<div class="right">
				<button type="submit" class="button-29" id="check-out" disabled>Checkout</button>
			</div>
		</form>

	</div>

	<div class="side-section">

		<%
		boolean enableCheckout = isLoggedIn && addressAdded && paymentInfoAdded && hasItemsInCart;
		if (hasItemsInCart) {
			if (restaurantName != null && restaurantLocation != null && restaurantImage != null) {
		%>
		<div class="side-section-header">
			<img src="RestaurantImages/<%=restaurantImage%>"
				alt="Restaurant Image" class="restaurant-image">
			<div class="restaurant-info">
				<span class="restaurant-name"><%=restaurantName%></span>
				<div class="restaurant-location"><%=restaurantLocation%></div>
			</div>
			<div class="restaurant-view">
				<button class="button-25"
					onclick="window.location.href='Menus?restaurantId=<%=session.getAttribute("currentRestaurantId")%>';">View
					Menu</button>
			</div>
		</div>
		<%
}
}
%>

		<div class="side-section-content">
			<%
			if (hasItemsInCart) {
				for (Map.Entry<Integer, Cart> entry : cartGenerator.cart.entrySet()) {
					Cart cartItem = entry.getValue();
			%>
			<div class="cart-item">
				<img src="FoodItems/<%=cartItem.getItemImage()%>"
					alt="<%=cartItem.getItemImage()%>" class="cart-item-img">
				<div class="cart-item-details">
					<div class="cart-item-title"><%=cartItem.getItemName()%></div>
					<div class="cart-item-price">
						<i class="bx bx-rupee"><%=cartItem.getItemPrice()%></i>
					</div>
				</div>
				<div class="cart-item-action">
					<form action="CartPage" method="post">
						<input type="hidden" name="itemId"
							value="<%=cartItem.getItemId()%>" /> <input type="hidden"
							name="action" value="decrement" />
						<button type="submit">
							<i class="bx bx-minus"></i>
						</button>
					</form>
					<span class="quantity-display"><%=cartItem.getQuantity()%></span>
					<form action="CartPage" method="post">
						<input type="hidden" name="itemId"
							value="<%=cartItem.getItemId()%>" /> <input type="hidden"
							name="action" value="increment" />
						<button type="submit">
							<i class="bx bx-plus"></i>
						</button>
					</form>
				</div>
				<div class="cart-item-total">
					<i class="bx bx-rupee"></i><%=String.format("%.2f",
		cartItem.getItemPrice().multiply(new java.math.BigDecimal(cartItem.getQuantity())).doubleValue())%>
				</div>
				<form action="CartPage" method="post">
					<input type="hidden" name="itemId"
						value="<%=cartItem.getItemId()%>" /> <input type="hidden"
						name="action" value="remove" />
					<button type="submit" class="cart-item-remove">
						<i class="bx bxs-trash"></i>
					</button>
				</form>
			</div>
			<%
			}
			} else {
			%>
			<div class="no-items-container">
				<div class="no-items-message">No items in your cart.</div>
				<img src="assets/images/cart.png" alt="Empty Cart"
					class="empty-cart-image" style="width: 100%; height: auto;">
			</div>
			<%
			}
			%>
		</div>
		<%
		if (hasItemsInCart) {
		%>
		<div class="side-section-footer">

			<div class="billing-details">
				<div class="billing-item">
					<span class="billing-label">Subtotal:</span> <span
						class="billing-value"><i class="bx bx-rupee"></i><%=String.format("%.2f", subtotal)%></span>
				</div>
				<div class="billing-item">
					<span class="billing-label">GST (18%):</span> <span
						class="billing-value"><i class="bx bx-rupee"></i><%=String.format("%.2f", gst)%></span>
				</div>
				<div class="billing-item">
					<span class="billing-label">Grand Total:</span> <span
						class="billing-value"><i class="bx bx-rupee"></i><%=String.format("%.2f", grandTotal)%></span>
				</div>
			</div>
		</div>
		<%
}
%>
	</div>
</div>

<!-- Footer Main File -->
<%@ include file="includes/footer-main.jsp"%>




<style>
.box-address {
	display: grid;
	width: 100%;
	margin-top: 10px;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
}

.box-address>.info-box {
	padding: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: var(--sidebar-color);
	border-radius: 8px;
	transition: transform 0.3s ease;
	box-shadow: 0 0 4px rgba(0, 0, 0, 0.1);
}

.info-box-icon {
	display: flex;
	align-items: center;
}

.info-box-icon img {
	width: 60px;
	height: 60px;
}

.info-box-content {
	flex: 1;
}

.info-box-edit {
	text-align: end;
}

.container {
	min-height: 100vh;
	width: 100%;
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin: auto;
	align-items: flex-start;
}

.column-sections {
	display: flex;
	flex: 1;
	flex-direction: column;
	gap: 10px;
}

.column {
	background-color: var(--sidebar-color);
	padding: 10px;
	box-shadow: rgba(67, 71, 85, 0.27) 0px 0px 0.25em,
		rgba(90, 125, 188, 0.05) 0px 0.25em 1em;
}

.login-signup-info {
	display: flex;
	position: relative;
	box-shadow: none;
}

.left-section {
	flex: 1;
	position: relative;
}

.header-title {
	font-size: 18px;
}

.description {
	font-size: 14px;
	margin-bottom: 10px;
}

.buttons {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	gap: 30px;
}

.login-button, .signup-button {
	background-color: var(--primary-color);
	color: var(--button-text);
	font-weight: 500;
	font-size: clamp(0.2em, 2vw, 0.8em);
	padding: 6px;
	display: flex;
	flex-direction: column;
	align-items: center;
	cursor: pointer;
	flex: 1;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.login-button:hover, .signup-button:hover {
	border: none;
	box-shadow: 0.6px 0.6px 5px 0.1px black;
}

.login-container, .register-container {
	margin-bottom: 15px;
}

.form-img {
	width: 120px;
	height: 120px;
	margin-left: auto;
}

.authSection {
	max-width: 70%;
}

.side-section {
	position: sticky;
	top: 90px;
	box-shadow: rgba(67, 71, 85, 0.27) 0px 0px 0.25em,
		rgba(90, 125, 188, 0.05) 0px 0.25em 1em;
	max-width: 400px;
	background-color: var(--sidebar-color);
	display: flex;
	flex-direction: column;
}

.side-section-header {
	display: flex;
	flex: 2;
	position: sticky;
	top: 0;
	gap: 5px;
	z-index: 1;
}

.restaurant-view {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-right: 10px;
}

.restaurant-view>a {
	border: 1px solid #eee;
}

.side-section-header img {
	height: 100%;
	width: 55px;
	object-fit: contain;
}

.side-section-content {
	max-height: calc(100vh - 310px);
	overflow-y: auto;
	padding: 10px;
	position: relative;
	box-shadow: inset 0px -10px 15px -10px rgba(60, 64, 67, 0.3), inset 0px
		10px 15px -10px rgba(60, 64, 67, 0.3);
}

.side-section-footer {
	padding-top: 10px;
}

.fullname {
	color: var(--black);
}

.hidden {
	display: none;
}

.no-items-message {
	color: var(--text-color);
	font-weight: 500;
	text-align: center;
}

@media screen and (max-width: 767px) {
	.form-img {
		width: 60px;
		height: 60px;
	}
	.authSection {
		max-width: 100%;
	}
	.container {
		min-height: 100vh;
		width: 100%;
		display: flex;
		flex-direction: column;
		gap: 10px;
		align-items: center;
	}
	.side-section {
		position: static;
		top: 0px;
	}
}

@media ( min-width : 576px) {
	.button-25 {
		padding-bottom: 10px;
		padding-top: 10px;
	}
}
</style>


<script>
document.addEventListener("DOMContentLoaded", function() {
    const checkFields = () => {
        const allFields = document.querySelectorAll('#checkoutForm input[type="hidden"]');
        let allFilled = true;

        allFields.forEach((field) => {
            const value = field.value.trim();
            console.log(`Checking field: ${field.name}, Value: '${value}'`); 
            if (value === "" || value === "0.00") {
                allFilled = false;
            }
        });

        const checkoutButton = document.getElementById("check-out");
        checkoutButton.disabled = !allFilled;
        console.log(`Button enabled: ${!checkoutButton.disabled}`); 
    };

    document.querySelectorAll('#checkoutForm input[type="text"]').forEach((input) => {
        input.addEventListener('input', checkFields);
    });

    checkFields(); 
});
</script>



