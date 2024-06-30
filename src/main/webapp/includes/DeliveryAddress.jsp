<%@page import="com.foodiedelight.model.*"%>

<h3 class="header-title">
	Delivery Address
	<%
	Users users = (Users) session.getAttribute("user");
	CartGenerator cartGenerators = (CartGenerator) session.getAttribute("cartGenerator");
	int cartItemsCount = 0;
	if (cartGenerators != null && cartGenerators.cart != null) {
		cartItemsCount = cartGenerators.cart.size(); // Count of unique item IDs
	}
	if (users.getAddress() != null && !users.getAddress().isEmpty()) {%>
	<img width="20" height="20" src="assets/images/checked.png"
		alt="checked" />
	<%
	}
	%>
</h3>
<div class="left-section">
	<%
	if (users.getAddress() != null && !users.getAddress().isEmpty() && users.getStreet() != null && !users.getStreet().isEmpty()
			&& users.getCityName() != null && !users.getCityName().isEmpty() && users.getState() != null
			&& !users.getState().isEmpty() && users.getPinCode() != null && !users.getPinCode().isEmpty()) {
	%>
	<div class="box-address" id="addressInfo">
		<div class="info-box" id="addressCard">
			<div class="info-box-icon">
				<img width="30" height="30" src="assets/images/address.png"
					alt="order-delivered" />
			</div>
			<div class="info-box-content">
				<%=users.getAddress() + ", " + users.getStreet() + ", " + users.getCityName() + ", " + users.getState() + ", "
		+ users.getPinCode()%>
			</div>
		</div>
		<div class="info-box-edit" id="updateAddressCard">
			<button class="button-25" onclick="showEditAddressForm()">Update
				Address?</button>
		</div>
	</div>
	<%
	} else {
	%>
	<div id="addressFormMain" class="form-container">
		<form action="saveDeliveryInfo" method="POST" class="form"
			id="deliveryForm">
			<div class="form-group">
				<label for="address">Address:</label>
				<textarea id="description" name="Address" rows="1" cols="50"
					placeholder="Plot No. 10, 1st Cross, 2nd Main, BTM Layout 1st Stage"
					oninput="checkFormFields()" required><%=users.getAddress() != null ? users.getAddress() : ""%></textarea>
			</div>

			<div class="form-row">
				<div class="form-group">
					<label for="street">Street:</label> <input type="text" id="street"
						name="Street"
						value="<%=users.getStreet() != null ? users.getStreet() : ""%>"
						placeholder="BTM Layout 1st Stage" oninput="checkFormFields()"
						required>
				</div>
				<div class="form-group">
					<label for="cityName">City Name:</label> <input type="text"
						id="cityName" name="CityName"
						value="<%=users.getCityName() != null ? users.getCityName() : ""%>"
						placeholder="Bengaluru" oninput="checkFormFields()" required>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group">
					<label for="state">State:</label> <input type="text" id="state"
						name="State"
						value="<%=users.getState() != null ? users.getState() : ""%>"
						placeholder="Karnataka" oninput="checkFormFields()" required>
				</div>
				<div class="form-group">
					<label for="pinCode">Pin Code:</label> <input type="text"
						id="pinCode" name="PinCode"
						value="<%=users.getPinCode() != null ? users.getPinCode() : ""%>"
						placeholder="560029" oninput="checkFormFields()" required>
				</div>
			</div>

			<div class="right">
				<button type="submit" id="submitButton" class="button-29" disabled>Submit</button>
			</div>
		</form>
	</div>
	<%
	}
	%>
	<div id="editAddressForm" class="form-container" style="display: none;">
		<form action="saveDeliveryInfo" method="POST" class="form">
			<div class="form-group">
				<label for="description">Address:</label>
				<textarea id="description" name="Address" rows="1" cols="50"
					placeholder="Plot No. 10, 1st Cross, 2nd Main, BTM Layout 1st Stage"
					oninput="checkFormFields()" required><%=users.getAddress() != null ? users.getAddress() : ""%></textarea>
			</div>

			<div class="form-row">
				<div class="form-group">
					<label for="street">Street:</label> <input type="text" id="street"
						name="Street"
						value="<%=users.getStreet() != null ? users.getStreet() : ""%>"
						placeholder="BTM Layout 1st Stage" oninput="checkFormFields()"
						required>
				</div>
				<div class="form-group">
					<label for="cityName">City Name:</label> <input type="text"
						id="cityName" name="CityName"
						value="<%=users.getCityName() != null ? users.getCityName() : ""%>"
						placeholder="Bengaluru" oninput="checkFormFields()" required>
				</div>
			</div>

			<div class="form-row">
				<div class="form-group">
					<label for="state">State:</label> <input type="text" id="state"
						name="State"
						value="<%=users.getState() != null ? users.getState() : ""%>"
						placeholder="Karnataka" oninput="checkFormFields()" required>
				</div>
				<div class="form-group">
					<label for="pinCode">Pin Code:</label> <input type="text"
						id="pinCode" name="PinCode"
						value="<%=users.getPinCode() != null ? users.getPinCode() : ""%>"
						placeholder="560029" oninput="checkFormFields()" required>
				</div>
			</div>

			<div class="right">
				<button type="submit" id="submitButton" class="button-29" disabled>Submit</button>
			</div>
		</form>
	</div>


</div>


