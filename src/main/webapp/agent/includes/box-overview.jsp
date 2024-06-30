<div class="box-overview">

	<div class="info-box" id="liveOrderBox">
		<div class="info-box-content">
			<p class="info-box-number">${totalOutForDelivery}</p>
			<p class="info-box-text">Live Orders</p>
		</div>
		<div class="info-box-icon">
			<img src="assets/images/process.png" alt="Out for Delivery" />
		</div>
	</div>
	<div class="info-box" id="deliveredBox">
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
	document.getElementById("liveOrderBox").addEventListener('click',
			function() {
				window.location.href = "LiveOrders";
			});
	document.getElementById("deliveredBox").addEventListener('click',
			function() {
				window.location.href = "AllDeliveredOrders";
			});
</script>