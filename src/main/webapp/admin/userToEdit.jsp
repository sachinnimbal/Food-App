<!-- ===== Side Bar File ===== -->
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>
<style>
.form-middle {
	max-width: 100%;
}

.error-message {
	display: none;
	background-color: transparent;
	color: var(--text-color);
	padding: 5px;
	font-size: clamp(8px, 2vw, 12px);
	margin-top: 5px;
	border-radius: 4px;
	margin-top: 5px;
}

.error-message::before {
	content: "\2139";
	display: inline-block;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	background-color: #d8000c;
	color: white;
	text-align: center;
	line-height: 20px;
	font-size: 14px;
	margin-right: 5px;
}

.error-message.show {
	display: block;
	animation: fadeIn 0.5s;
}

@keyframes fadeIn {from {opacity: 0;}to {opacity: 1;}}

input.invalid {
	border-color: #d8000c;
}
</style>


<!-- ===== Main Conatiner Starts ===== -->
<nav aria-label="Breadcrumb" class="breadcrumb">
	<ul>
		<li><a href="AdminHome">Home</a></li>
		<li><a href="UsersList">Users List</a></li>
		<li aria-current="page">Edit User</li>
	</ul>
</nav>

<%
Users editUser = (Users) request.getAttribute("userToEdit");
%>
<div class="form-middle">

	<form action="UpdateUser" method="POST" class="form">
		<input type="hidden" name="userId" value="<%=editUser.getUserID()%>">
		<div class="form-row">
			<div class="form-group">
				<label for="username">Username:</label> <input type="text"
					id="username" value="<%=editUser.getUserName()%>" name="username"
					readonly>
			</div>

			<div class="form-group">
				<label for="name">Name:</label> <input type="text"
					value="<%=editUser.getName()%>" name="name" required maxLength="40"
					oninput="validateForm()"> <span id="name-error"
					class="error-message">Name must contain only letters and
					spaces.</span>
			</div>
			<div class="form-group">
				<label for="phone">Phone:</label> <input type="text"
					value="<%=editUser.getPhoneNumber() != null ? editUser.getPhoneNumber() : ""%>"
					name="phone" placeholder="560029" required maxLength="10"
					oninput="validateForm()"> <span id="phone-error"
					class="error-message"></span>
			</div>

			<div class="form-group">
				<label for="Role">Role:</label> <select name="role"
					onchange="checkFormFields()"
					<%="SuperAdmin".equals(editUser.getUserRole()) ? "disabled" : ""%>>
					<option value="SuperAdmin"
						<%="SuperAdmin".equals(editUser.getUserRole()) ? "selected" : ""%>
						disabled>Super Admin</option>
					<option value="RestaurantOwner"
						<%="RestaurantOwner".equals(editUser.getUserRole()) ? "selected" : ""%>
						<%if ("SuperAdmin".equals(editUser.getUserRole())) {%> disabled
						<%}%>>Restaurant Owner</option>
					<option value="Customer"
						<%="Customer".equals(editUser.getUserRole()) ? "selected" : ""%>
						<%if ("SuperAdmin".equals(editUser.getUserRole())) {%> disabled
						<%}%>>Customer</option>
					<option value="DeliveryPerson"
						<%="DeliveryPerson".equals(editUser.getUserRole()) ? "selected" : ""%>
						<%if ("SuperAdmin".equals(editUser.getUserRole())) {%> disabled
						<%}%>>Delivery Person</option>
				</select>
			</div>
			<div class="form-group">
				<label for="status">Status:</label> <select name="status"
					onchange="checkFormFields()"
					<%="SuperAdmin".equals(editUser.getUserRole()) ? "disabled" : ""%>>
					<option value="Active"
						<%="Active".equals(editUser.getStatus()) ? "selected" : ""%>>Active</option>
					<option value="Inactive"
						<%="Inactive".equals(editUser.getStatus()) ? "selected" : ""%>>Inactive</option>
					<option value="Suspended"
						<%="Suspended".equals(editUser.getStatus()) ? "selected" : ""%>>Suspended</option>
				</select>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group">
				<label for="address">Address:</label> <input type="text"
					maxlength="40" name="address"
					placeholder="Plot No. 10, 1st Cross, 2nd Main"
					value="<%=editUser.getAddress() != null ? editUser.getAddress() : ""%>">
				<span id="address-error" class="error-message"></span>
			</div>
			<div class="form-group">
				<label for="street">Street:</label> <input type="text"
					maxlength="20"
					value="<%=editUser.getStreet() != null ? editUser.getStreet() : ""%>"
					name="street" placeholder="BTM Layout 1st Stage" required
					oninput="validateForm()"> <span id="street-error"
					class="error-message"></span>
			</div>
		</div>
		<div class="form-row">
			<div class="form-group">
				<label for="city">City:</label> <input type="text" maxlength="20"
					value="<%=editUser.getCityName() != null ? editUser.getCityName() : ""%>"
					name="city" placeholder="Bengaluru" required
					oninput="validateForm()"> <span id="city-error"
					class="error-message"></span>
			</div>
			<div class="form-group">
				<label for="state">State:</label> <input type="text" maxlength="30"
					value="<%=editUser.getState() != null ? editUser.getState() : ""%>"
					name="state" placeholder="Karnataka" required
					oninput="validateForm()"> <span id="state-error"
					class="error-message"></span>
			</div>
			<div class="form-group">
				<label for="pincode">Pincode:</label> <input type="text"
					value="<%=editUser.getPinCode() != null ? editUser.getPinCode() : ""%>"
					name="pincode" placeholder="560029" required maxLength="6"
					oninput="validateForm()"> <span id="pincode-error"
					class="error-message"></span>
			</div>
		</div>
		<div class="right">
			<button type="submit" id="submitButton" class="button-29" disabled>Save
				Changes</button>
		</div>
	</form>

</div>
<!-- ===== Main Conatiner Ends ===== -->

<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>


<script>
document.addEventListener("DOMContentLoaded", () => {
  validateForm();
  document.querySelectorAll('.form input[type="text"], .form textarea').forEach(input => {
    input.addEventListener("input", validateForm);
  });
});

function validateForm() {
  let isValid = true; // Overall form validity

  // Helper function for emptiness check
  function isEmpty(value) {
    return !value.trim();
  }

  // Name validation
  const name = document.querySelector('[name="name"]');
  const nameError = document.getElementById("name-error");
  if (isEmpty(name.value)) {
    name.classList.add("invalid");
    nameError.textContent = "Name is required.";
    isValid = false;
  } else {
    const nameWords = name.value.trim().split(/\s+/);
    if (!/^[A-Za-z\s]+$/.test(name.value) || nameWords.length !== 2) {
      name.classList.add("invalid");
      nameError.textContent = "Name must have exactly 2 words.";
      isValid = false;
    } else {
      name.classList.remove("invalid");
      nameError.textContent = "";
    }
  }
  nameError.style.display = name.classList.contains("invalid") ? "block" : "none";

  // Phone validation
  const phone = document.querySelector('[name="phone"]');
  const phoneError = document.getElementById("phone-error");
  if (isEmpty(phone.value)) {
    phone.classList.add("invalid");
    phoneError.textContent = "Phone number is required.";
    isValid = false;
  } else if (!/^\d{10}$/.test(phone.value)) {
    phone.classList.add("invalid");
    phoneError.textContent = "Phone number must be exactly 10 digits.";
    isValid = false;
  } else {
    phone.classList.remove("invalid");
    phoneError.textContent = "";
  }
  phoneError.style.display = phone.classList.contains("invalid") ? "block" : "none";

  // Address validation
  const address = document.querySelector('[name="address"]');
  const addressError = document.getElementById("address-error");
  const addressWords = address.value.trim().split(/\s+/);
  if (isEmpty(address.value)) {
    address.classList.add("invalid");
    addressError.textContent = "Address is required.";
    isValid = false;
  } else if (addressWords.length < 4 || addressWords.length > 10) {
    address.classList.add("invalid");
    addressError.textContent = "Address must have between 4 and 10 words.";
    isValid = false;
  } else {
    address.classList.remove("invalid");
    addressError.textContent = "";
  }
  addressError.style.display = address.classList.contains("invalid") ? "block" : "none";

  // Street validation
  const street = document.querySelector('[name="street"]');
  const streetError = document.getElementById("street-error");
  const streetWords = street.value.trim().split(/\s+/);
  if (isEmpty(street.value)) {
    street.classList.add("invalid");
    streetError.textContent = "Street is required.";
    isValid = false;
  } else if (streetWords.length < 1 || streetWords.length > 4) {
    street.classList.add("invalid");
    streetError.textContent = "Street must have between 1 and 4 words.";
    isValid = false;
  } else {
    street.classList.remove("invalid");
    streetError.textContent = "";
  }
  streetError.style.display = street.classList.contains("invalid") ? "block" : "none";

  // City validation
  const city = document.querySelector('[name="city"]');
  const cityError = document.getElementById("city-error");
  if (isEmpty(city.value)) {
    city.classList.add("invalid");
    cityError.textContent = "City is required.";
    isValid = false;
  } else if (city.value.length > 20) {
    city.classList.add("invalid");
    cityError.textContent = "City must not exceed 20 characters.";
    isValid = false;
  } else {
    city.classList.remove("invalid");
    cityError.textContent = "";
  }
  cityError.style.display = city.classList.contains("invalid") ? "block" : "none";

  // State validation
  const state = document.querySelector('[name="state"]');
  const stateError = document.getElementById("state-error");
  if (isEmpty(state.value)) {
    state.classList.add("invalid");
    stateError.textContent = "State is required.";
    isValid = false;
  } else if (state.value.length > 30) {
    state.classList.add("invalid");
    stateError.textContent = "State must not exceed 30 characters.";
    isValid = false;
  } else {
    state.classList.remove("invalid");
    stateError.textContent = "";
  }
  stateError.style.display = state.classList.contains("invalid") ? "block" : "none";

  // Pincode validation
  const pincode = document.querySelector('[name="pincode"]');
  const pincodeError = document.getElementById("pincode-error");
  if (isEmpty(pincode.value)) {
    pincode.classList.add("invalid");
    pincodeError.textContent = "Pincode is required.";
    isValid = false;
  } else if (!/^\d{6}$/.test(pincode.value)) {
    pincode.classList.add("invalid");
    pincodeError.textContent = "Pincode must be 6 digits.";
    isValid = false;
  } else {
    pincode.classList.remove("invalid");
    pincodeError.textContent = "";
  }
  pincodeError.style.display = pincode.classList.contains("invalid") ? "block" : "none";

  document.getElementById("submitButton").disabled = !isValid;
}
</script>