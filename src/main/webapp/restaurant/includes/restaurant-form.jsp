
<%@page import="com.foodiedelight.model.*"%>

<%
Users userID = (Users) session.getAttribute("user");
%>
<form action="RestaurantAdd" method="POST" class="form"
	enctype="multipart/form-data" accept-charset="UTF-8">
	<div class="form-row ">
		<div class="form-group">
			<input type="hidden" name="UserID" value="<%=userID.getUserID()%>">
			<label for="name">Restaurant Name:</label> <input type="text"
				placeholder="Foodie Delight" name="name" required> <span
				id="name-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="contactInfo">Restaurant Contact:</label> <input
				maxlength="10" type="text" placeholder="9900140463"
				name="contactInfo" required> <span id="contactInfo-error"
				class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="eta">Estimated Time of Arrival:</label> <select
				name="eTA" required>
				<option value="" disabled selected>Choose ETA...</option>
				<option value="10 - 30">10 - 30 min</option>
				<option value="15 - 30">15 - 30 min</option>
				<option value="20 - 30">20 - 30 min</option>
				<option value="25 - 40">25 - 40 min</option>
				<option value="30 - 40">30 - 40 min</option>
				<option value="35 - 45">35 - 45 min</option>
				<option value="40 - 50">40 - 50 min</option>
			</select> <span id="eta-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="averageCost">Average Cost:</label> <input type="number"
				placeholder="&#8377;99" name="averageCost" required> <span
				id="averageCost-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<div class="form-group-type">
				<label for="cuisineTypes">Cuisine Types (Select up to 2):</label> <input
					type="text" id="selectedOptionsInput" readonly name="cuisineTypes"
					placeholder="Select Cuisine Types..">
				<div class="dropdown-content">
					<div data-value="South Indian">South Indian</div>
					<div data-value="North Indian">North Indian</div>
					<div data-value="Sweets">Sweets</div>
					<div data-value="Chinese">Chinese</div>
					<div data-value="Fast Food">Fast Food</div>
					<div data-value="Snacks">Snacks</div>
					<div data-value="Sandwich">Sandwich</div>
					<div data-value="Street Food">Street Food</div>
					<div data-value="Ice cream">Ice cream</div>
					<div data-value="Dessert">Dessert</div>
					<div data-value="Biryani">Biryani</div>
					<div data-value="Burger">Burger</div>
					<div data-value="Pizza">Pizza</div>
					<div data-value="Roll">Roll</div>
					<div data-value="Paratha">Paratha</div>
					<div data-value="Noodles">Noodles</div>
					<div data-value="Cakes">Cakes</div>
					<div data-value="Pasta">Pasta</div>
					<div data-value="Kebabs">Kebabs</div>
					<div data-value="Shawarma">Shawarma</div>
					<div data-value="Dosa">Dosa</div>
					<div data-value="Vegetarian">Vegetarian</div>
					<div data-value="Momos">Momos</div>
					<div data-value="Pav Bhaji">Pav Bhaji</div>
					<div data-value="Idli">Idlyi</div>
					<div data-value="Salad">Salad</div>
				</div>
				<span id="cuisineTypes-error" class="error-message"></span>
			</div>
		</div>
	</div>
	<div class="form-row ">
		<div class="form-group">
			<label for="discounts">Discounts:</label> <select name="discounts"
				required>
				<option value="" disabled>Choose Discount...</option>
				<option value="No Discount">No Discount</option>
				<option value="10% OFF UPTO &#8377;40">10% OFF UPTO
					&#8377;40</option>
				<option value="20% OFF UPTO &#8377;50">20% OFF UPTO
					&#8377;50</option>
				<option value="30% OFF UPTO &#8377;60">30% OFF UPTO
					&#8377;60</option>
				<option value="40% OFF UPTO &#8377;80">40% OFF UPTO
					&#8377;80</option>
				<option value="50% OFF UPTO &#8377;100">50% OFF UPTO
					&#8377;100</option>
				<option value="60% OFF UPTO &#8377;120">60% OFF UPTO
					&#8377;120</option>
				<option value="FREE DELIVERY" selected>Free Delivery</option>
			</select> <span id="discounts-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="street">Street:</label> <input type="text" maxlength="20"
				placeholder="BTM Layout 1st Stage" name="street" required> <span
				id="street-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="cityName">City Name:</label> <input type="text"
				placeholder="Bengaluru" name="cityName" required> <span
				id="cityName-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="state">State:</label> <input type="text"
				placeholder="Karnataka" name="state" required> <span
				id="state-error" class="error-message"></span>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="pinCode">Pin Code:</label> <input type="text"
				maxlength="6" placeholder="560029" name="pinCode" required>
			<span id="pinCode-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="type">Restaurant Type:</label> <select id="type"
				name="type" required>
				<option value="" disabled selected>Choose Type...</option>
				<option value="Veg">Vegetarian</option>
				<option value="Non-Veg">Non Vegetarian</option>
				<option value="Both">Both</option>
			</select> <span id="type-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="imageUrl">Restaurant Cover:</label> <input type="file"
				accept="image/*" class="image-file" id="imageUrl" name="imageURL">
			<span id="imageUrl-error" class="error-message"></span>
		</div>
	</div>
	<div class="form-row ">
		<div class="form-group">
			<label for="description">Restaurant Short Description:</label>
			<textarea
				placeholder="A vibrant Indian restaurant offering a diverse menu of traditional and modern dishes, crafted from fresh ingredients and a symphony of spices to tantalize your taste buds."
				name="description" rows="2" cols="1" maxlength="60"></textarea>
		</div>
		<div class="form-group">
			<label for="openTime">Open Time:</label> <input type='time'
				name="openTime" /> <span id="openTime-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="openTime">Close Time:</label> <input type='time'
				name="closeTime" /> <span id="closeTime-error"
				class="error-message"></span>
		</div>
	</div>
	<div class="form-row ">
		<div class="form-group">
			<label for="selectedTagsInput">Select Tags:</label>
			<textarea id="selectedTagsInput" name="tagSelection"
				placeholder="Select Tags..." rows="3" readonly></textarea>
			<div class="chips-container" id="tagsChips">
				<div class="chip" data-value="South Indian">South Indian</div>
				<div class="chip" data-value="North Indian">North Indian</div>
				<div class="chip" data-value="Sweets">Sweets</div>
				<div class="chip" data-value="Chinese">Chinese</div>
				<div class="chip" data-value="Snacks">Snacks</div>
				<div class="chip" data-value="Sandwich">Sandwich</div>
				<div class="chip" data-value="Fast Food">Fast Food</div>
				<div class="chip" data-value="Street Food">Street Food</div>
				<div class="chip" data-value="Ice cream">Ice cream</div>
				<div class="chip" data-value="Dessert">Dessert</div>
				<div class="chip" data-value="Biryani">Biryani</div>
				<div class="chip" data-value="Burger">Burger</div>
				<div class="chip" data-value="Pizza">Pizza</div>
				<div class="chip" data-value="Roll">Roll</div>
				<div class="chip" data-value="Paratha">Paratha</div>
				<div class="chip" data-value="Noodles">Noodles</div>
				<div class="chip" data-value="Cakes">Cakes</div>
				<div class="chip" data-value="Pasta">Pasta</div>
				<div class="chip" data-value="Kebabs">Kebabs</div>
				<div class="chip" data-value="Shawarma">Shawarma</div>
				<div class="chip" data-value="Dosa">Dosa</div>
				<div class="chip" data-value="Vegetarian">Vegetarian</div>
				<div class="chip" data-value="Momos">Momos</div>
				<div class="chip" data-value="Pav Bhaji">Pav Bhaji</div>
				<div class="chip" data-value="Idli">Idli</div>
				<div class="chip" data-value="Salad">Salad</div>
			</div>
		</div>

	</div>
	<div class="right">
		<button type="submit" id="submitButton" class="button-29">Save
			Changes</button>
	</div>
</form>

<style>
input.invalid, select.invalid, .form-group-type input {
	border-color: #d8000c;
}

.form-group-type {
	position: relative;
	display: inline-block;
	width: 100%;
}

.form-group-type input[type="text"] {
	width: 100%;
	padding: 10px;
	border: 2px solid var(--border-color);
	border-radius: 8px;
	background-color: var(--panel-color);
	color: var(--text-color);
	font-family: "Franklin Gothic Medium", "Arial Narrow", Arial, sans-serif;
	margin-bottom: 5px;
}

.form-group-type input[type="text"]:focus {
	outline: none;
	/*border-color: #007bff; */
	box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
	border-color: var(--primary-color);
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: var(--sidebar-color);
	width: fit-content;
	max-height: 300px;
	overflow-y: auto;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	padding: 10px;
	cursor: pointer;
	border: 2px solid var(--border-color);
}

.dropdown-content div:hover, .dropdown-content div.selected {
	background-color: var(--light-color);
	color: var(--text-color);
}

.dropdown-content div {
	padding: 8px 10px;
	cursor: pointer;
	border: 1px solid var(--border-color);
}

.show {
	display: block;
}

.chips-container {
	display: flex;
	flex-wrap: wrap;
	padding: 10px;
	gap: 10px;
}

.chip {
	padding: 8px 12px;
	background-color: var(--light-color);
	border-radius: 25px;
	cursor: pointer;
	transition: background-color 0.3s;
	user-select: none;
	border: none;
}

.chip:hover {
	background-color: var(--primary-color);
	color: white;
}

.chip.selected {
	background-color: var(--secondary-color);
	color: white;
}
</style>

<script>
    
document.addEventListener("DOMContentLoaded", () => {
	validateForm(); // Initial validation call

	document.querySelectorAll(
		'.form input[type="text"], .form input[type="number"], .form input[type="file"], ' +
		'.form select, .form input[type="time"], ' +
		'.form-group-type input[type="text"], ' +
		'.form-group .form-group-type input[type="text"], input, select'
	).forEach((input) => {
		if (input.type === "file") {
			input.addEventListener("change", validateForm);
		} else {
			input.addEventListener("input", validateForm);
		}
		input.classList.add("invalid");
	});
});

function validateForm() {
	let isValid = true; // Overall form validity

	// Helper function for emptiness check
	function isEmpty(value) {
		return !value.trim();
	}

	// Restaurant Name validation
	const name = document.querySelector('[name="name"]');
	const nameError = document.getElementById("name-error");
	if (isEmpty(name.value)) {
		name.classList.add("invalid");
		nameError.textContent = "Restaurant Name is required.";
		isValid = false;
	} else {
		name.classList.remove("invalid");
		nameError.textContent = "";
	}
	nameError.style.display = name.classList.contains("invalid") ? "block" : "none";

	// Restaurant Contact validation
	const contact = document.querySelector('[name="contactInfo"]');
	const contactError = document.getElementById("contactInfo-error");
	if (isEmpty(contact.value)) {
		contact.classList.add("invalid");
		contactError.textContent = "Contact is required.";
		isValid = false;
	} else if (!/^\d{10}$/.test(contact.value)) {
		contact.classList.add("invalid");
		contactError.textContent = "Contact must be exactly 10 digits.";
		isValid = false;
	} else {
		contact.classList.remove("invalid");
		contactError.textContent = "";
	}
	contactError.style.display = contact.classList.contains("invalid") ? "block" : "none";

	// ETA validation
	const eta = document.querySelector('[name="eTA"]');
	const etaError = document.getElementById("eta-error");
	if (isEmpty(eta.value)) {
		eta.classList.add("invalid");
		etaError.textContent = "ETA is required.";
		isValid = false;
	} else {
		eta.classList.remove("invalid");
		etaError.textContent = "";
	}
	etaError.style.display = eta.classList.contains("invalid") ? "block" : "none";

	// Average Cost validation
	const averageCost = document.querySelector('[name="averageCost"]');
	const averageCostError = document.getElementById("averageCost-error");
	if (isEmpty(averageCost.value)) {
		averageCost.classList.add("invalid");
		averageCostError.textContent = "Average Cost is required.";
		isValid = false;
	} else {
		averageCost.classList.remove("invalid");
		averageCostError.textContent = "";
	}
	averageCostError.style.display = averageCost.classList.contains("invalid") ? "block" : "none";

	// Cuisine Types validation
	validateCuisineTypes();

	// Discounts validation
	const discounts = document.querySelector('[name="discounts"]');
	const discountsError = document.getElementById("discounts-error");
	if (isEmpty(discounts.value)) {
		discounts.classList.add("invalid");
		discountsError.textContent = "Discounts are required.";
		isValid = false;
	} else {
		discounts.classList.remove("invalid");
		discountsError.textContent = "";
	}
	discountsError.style.display = discounts.classList.contains("invalid") ? "block" : "none";

	// Street validation
	const street = document.querySelector('[name="street"]');
	const streetError = document.getElementById("street-error");
	if (isEmpty(street.value)) {
		street.classList.add("invalid");
		streetError.textContent = "Street is required.";
		isValid = false;
	} else {
		street.classList.remove("invalid");
		streetError.textContent = "";
	}
	streetError.style.display = street.classList.contains("invalid") ? "block" : "none";

	// City validation
	const city = document.querySelector('[name="cityName"]');
	const cityError = document.getElementById("cityName-error");
	if (isEmpty(city.value)) {
		city.classList.add("invalid");
		cityError.textContent = "City Name is required.";
		isValid = false;
	} else if (city.value.length > 20) {
		city.classList.add("invalid");
		cityError.textContent = "City Name must not exceed 20 characters.";
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
	const pincode = document.querySelector('[name="pinCode"]');
	const pincodeError = document.getElementById("pinCode-error");
	if (isEmpty(pincode.value)) {
		pincode.classList.add("invalid");
		pincodeError.textContent = "Pin Code is required.";
		isValid = false;
	} else if (!/^\d{6}$/.test(pincode.value)) {
		pincode.classList.add("invalid");
		pincodeError.textContent = "Pin Code must be exactly 6 digits.";
		isValid = false;
	} else {
		pincode.classList.remove("invalid");
		pincodeError.textContent = "";
	}
	pincodeError.style.display = pincode.classList.contains("invalid") ? "block" : "none";

	// Type validation
	const type = document.querySelector('[name="type"]');
	const typeError = document.getElementById("type-error");
	if (type.selectedIndex === 0) {
		type.classList.add("invalid");
		typeError.textContent = "Restaurant Type is required.";
		isValid = false;
	} else {
		type.classList.remove("invalid");
		typeError.textContent = "";
	}
	typeError.style.display = type.classList.contains("invalid") ? "block" : "none";

	// Restaurant Cover validation
	const imageUrl = document.querySelector('[name="imageURL"]');
	const imageUrlError = document.getElementById("imageUrl-error");
	if (!imageUrl.files.length) {
		imageUrl.classList.add("invalid");
		imageUrlError.textContent = "Restaurant Cover is required.";
		isValid = false;
	} else {
		imageUrl.classList.remove("invalid");
		imageUrlError.textContent = "";
	}
	imageUrlError.style.display = imageUrl.classList.contains("invalid") ? "block" : "none";

	// Open Time validation
	const openTime = document.querySelector('[name="openTime"]');
	const openTimeError = document.getElementById("openTime-error");
	if (isEmpty(openTime.value)) {
		openTime.classList.add("invalid");
		openTimeError.textContent = "Open Time is required.";
		isValid = false;
	} else {
		openTime.classList.remove("invalid");
		openTimeError.textContent = "";
	}
	openTimeError.style.display = openTime.classList.contains("invalid") ? "block" : "none";

	// Close Time validation
	const closeTime = document.querySelector('[name="closeTime"]');
	const closeTimeError = document.getElementById("closeTime-error");
	if (isEmpty(closeTime.value)) {
		closeTime.classList.add("invalid");
		closeTimeError.textContent = "Close Time is required.";
		isValid = false;
	} else {
		closeTime.classList.remove("invalid");
		closeTimeError.textContent = "";
	}
	closeTimeError.style.display = closeTime.classList.contains("invalid") ? "block" : "none";

	document.getElementById("submitButton").disabled = !isValid;
}

let selectedOptions = [];
const selectedOptionsInput = document.getElementById('selectedOptionsInput');
const dropdownContent = document.querySelector('.dropdown-content');

selectedOptionsInput.addEventListener('click', () => dropdownContent.classList.toggle('show'));

dropdownContent.querySelectorAll('div').forEach(option => {
	option.addEventListener('click', () => {
		const value = option.getAttribute('data-value');
		const index = selectedOptions.indexOf(value);
		if (index === -1) {
			if (selectedOptions.length < 2) {
				selectedOptions.push(value);
				option.classList.add('selected');
			} else {
				alert("You can select up to 2 options only.");
			}
		} else {
			selectedOptions.splice(index, 1);
			option.classList.remove('selected');
		}
		selectedOptionsInput.value = selectedOptions.join(", ");
	});
});

// Close the dropdown if the user clicks outside of it
window.addEventListener('click', (event) => {
	if (!event.target.matches('#selectedOptionsInput')) {
		dropdownContent.classList.remove('show');
	}
});

function validateCuisineTypes() {
	const cuisineTypesError = document.getElementById("cuisineTypes-error");
	if (selectedOptions.length === 0) {
		cuisineTypesError.textContent = "Cuisine Types are required.";
		selectedOptionsInput.classList.add("invalid");
		cuisineTypesError.style.display = "block";
	} else {
		selectedOptionsInput.classList.remove("invalid");
		cuisineTypesError.textContent = "";
		cuisineTypesError.style.display = "none";
	}
}

let selectedTags = [];
const selectedTagsInput = document.getElementById('selectedTagsInput');
const tagsChips = document.getElementById('tagsChips');

tagsChips.querySelectorAll('.chip').forEach(chip => {
    chip.addEventListener('click', () => {
        const value = chip.getAttribute('data-value');
        const index = selectedTags.indexOf(value);
        if (index === -1) {
            if (selectedTags.length < 10) { // Limit to 10 selections
                selectedTags.push(value);
                chip.classList.add('selected');
            } else {
                alert("You can select up to 10 options only.");
            }
        } else {
            selectedTags.splice(index, 1);
            chip.classList.remove('selected');
        }
        selectedTagsInput.value = selectedTags.join(", ");
    });
});


</script>


