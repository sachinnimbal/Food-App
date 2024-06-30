


</section>


<%@ include file="offcanvas.jsp"%>

</section>


<script>
	document.getElementById("open-cart").addEventListener("click", function() {
		window.location.href = "CartPage";
	});
	document.getElementById("search").addEventListener("click", function() {
		window.location.href = "Search";
	});
</script>

<script>
	document.getElementById("year").textContent = new Date().getFullYear();
</script>

<script>
	function checkFormFields() {
		var address = document.getElementById('description').value.trim();
		var street = document.getElementById('street').value.trim();
		var cityName = document.getElementById('cityName').value.trim();
		var state = document.getElementById('state').value.trim();
		var pinCode = document.getElementById('pinCode').value.trim();
		var isFormFilled = address && street && cityName && state && pinCode;

		document.getElementById('submitButton').disabled = !isFormFilled;
	}
	checkFormFields();
</script>

<script>
	function showEditAddressForm() {
		document.getElementById('addressInfo').style.display = 'none';

		document.getElementById('editAddressForm').style.display = 'block';
	}
</script>

</body>

</html>