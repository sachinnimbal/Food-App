<%@page import="com.foodiedelight.model.Restaurants"%>
<div class="box-overview-resto">


	<%
	Restaurants restaurantCount = (Restaurants) request.getAttribute("restaurant");
	if (restaurantCount != null) {
	%>
	<div class="info-box-resto" id="itemsBox"
		onclick="submitMenuForm('MenuItemList', 'RestaurantID', '<%=restaurantCount.getRestaurantID()%>');">
		<div class="info-box-content">
			<p class="info-box-number">${totalMenuItem}</p>
			<p class="info-box-text">Menu Items</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/items.png" alt="items" />
		</div>
	</div>
	<%
	}
	%>

	<div class="info-box-resto" id="orderBox"
		onclick="submitFormWithStatus('All')">
		<div class="info-box-content">
			<p class="info-box-number">${totalOrder}</p>
			<p class="info-box-text">All Orders</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/ingredients.png" alt="items" />
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
		form.action = "OrderLists";

		var statusField = document.createElement("input");
		statusField.type = "hidden";
		statusField.name = "Status";
		statusField.value = status;

		form.appendChild(statusField);
		document.body.appendChild(form);
		form.submit();
	}
</script>


<script>
	function submitMenuForm(actionUrl, parameterName, parameterValue) {
		var form = document.createElement("form");
		form.method = "POST";
		form.action = actionUrl;

		var hiddenField = document.createElement("input");
		hiddenField.type = "hidden";
		hiddenField.name = parameterName;
		hiddenField.value = parameterValue;

		form.appendChild(hiddenField);
		document.body.appendChild(form);
		form.submit();
	}
</script>

