
<div class="box-overview">
	<div class="info-box" id="userBox">
		<div class="info-box-content">
			<p class="info-box-number" id="totalUserCount">${totalUserCount}</p>
			<p class="info-box-text">All Users</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/customers.png" alt="users" />
		</div>
	</div>
	<div class="info-box" id="ownerBox">
		<div class="info-box-content">
			<p class="info-box-number" id="totalOwnersCount">${totalOwnersCount}</p>
			<p class="info-box-text">Restaurant Owners</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/user-shield.png" alt="owners" />
		</div>
	</div>
	<div class="info-box" id="customerBox">
		<div class="info-box-content">
			<p class="info-box-number" id="totalCustomerCount">${totalCustomerCount}</p>
			<p class="info-box-text">Customers</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/customer.png" alt="customers" />
		</div>
	</div>
	<div class="info-box" id="agentBox">
		<div class="info-box-content">
			<p class="info-box-number">${totalAgentCount}</p>
			<p class="info-box-text">Delivery Agents</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/deliveryAgent.png" alt="Delivery Agent" />
		</div>
	</div>
	<div class="info-box" id="activeUserBox">
		<div class="info-box-content">
			<p class="info-box-number">${activeUsersCount}</p>
			<p class="info-box-text">Active Users</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/active.png" alt="Active Users" />
		</div>
	</div>
	<div class="info-box" id="inactiveUserBox">
		<div class="info-box-content">
			<p class="info-box-number">${inactiveUsersCount}</p>
			<p class="info-box-text">Inactive Users</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/inactive.png" alt="Inactive Users" />
		</div>
	</div>
	<div class="info-box" id="suspendedUserBox">
		<div class="info-box-content">
			<p class="info-box-number">${suspendedUsersCount}</p>
			<p class="info-box-text">Suspended Users</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/suspend.png" alt="Suspended Users" />
		</div>
	</div>
	<div class="info-box" id="restaurantBox">
		<div class="info-box-content">
			<p class="info-box-number" id="totalRestaurantCount">${totalRestaurantCount}</p>
			<p class="info-box-text">Restaurants</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/restaurant.png" alt="tableware" />
		</div>
	</div>

	<div class="info-box" id="itemsBox">
		<div class="info-box-content">
			<p class="info-box-number" id="totalMenuItems">${totalMenuItems}</p>
			<p class="info-box-text">Menu Items</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/items.png" alt="items" />
		</div>
	</div>
	
	<div class="info-box" id="orderBox">
		<div class="info-box-content">
			<p class="info-box-number" id="totalOrderCount">${totalOrderCount}</p>
			<p class="info-box-text">All Orders</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/ingredients.png" alt="ingredients" />
		</div>
	</div>
	
	<div class="info-box-resto" id="inProgressBox"
		onclick="submitFormWithStatus('In Progress')">
		<div class="info-box-content">
			<p class="info-box-number">${totalInProgress}</p>
			<p class="info-box-text">In Progress</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/process.png" alt="items" />
		</div>
	</div>

	<div class="info-box-resto" id="pendingBox"
		onclick="submitFormWithStatus('Pending')">
		<div class="info-box-content">
			<p class="info-box-number">${totalPending}</p>
			<p class="info-box-text">Pending Orders</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/pending.png" alt="items" />
		</div>
	</div>

	<div class="info-box-resto" id="cancelledBox"
		onclick="submitFormWithStatus('Cancelled')">
		<div class="info-box-content">
			<p class="info-box-number">${totalCancelled}</p>
			<p class="info-box-text">Cancelled Orders</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/suspend.png" alt="items" />
		</div>
	</div>

	<div class="info-box-resto" id="deliveredBox"
		onclick="submitFormWithStatus('Delivered')">
		<div class="info-box-content">
			<p class="info-box-number">${totalDelivered}</p>
			<p class="info-box-text">Delivered Orders</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/delivered.png" alt="items" />
		</div>
	</div>
</div>

<script>
	function submitFormWithStatus(status) {
		var form = document.createElement("form");
		form.method = "POST";
		form.action = "AllOrders";

		var statusField = document.createElement("input");
		statusField.type = "hidden";
		statusField.name = "Status";
		statusField.value = status;

		form.appendChild(statusField);
		document.body.appendChild(form);
		form.submit();
	}

	document.querySelector('#restaurantBox').addEventListener('click',
			function() {
				window.location.href = 'RestaurantsView';
			});

	document.querySelector('#userBox').addEventListener('click', function() {
		window.location.href = 'UsersList';
	});

	document.querySelector('#orderBox').addEventListener('click', function() {
		window.location.href = 'AllOrders';
	});

	document.querySelector('#itemsBox').addEventListener('click', function() {
		window.location.href = 'AllMenus';
	});

	function submitForm(parameterName, parameterValue) {
		var form = document.createElement("form");
		form.method = "POST";
		form.action = "UsersList";

		var hiddenField = document.createElement("input");
		hiddenField.type = "hidden";
		hiddenField.name = parameterName;
		hiddenField.value = parameterValue;

		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	}

	// For status
	document.querySelector('#activeUserBox').addEventListener('click',
			function() {
				submitForm('Status', 'Active');
			});
	document.querySelector('#inactiveUserBox').addEventListener('click',
			function() {
				submitForm('Status', 'Inactive');
			});
	document.querySelector('#suspendedUserBox').addEventListener('click',
			function() {
				submitForm('Status', 'Suspended');
			});

	// For roles
	document.querySelector('#agentBox').addEventListener('click', function() {
		submitForm('Role', 'DeliveryPerson');
	});
	document.querySelector('#ownerBox').addEventListener('click', function() {
		submitForm('Role', 'RestaurantOwner');
	});
	document.querySelector('#customerBox').addEventListener('click',
			function() {
				submitForm('Role', 'Customer');
			});
</script>
