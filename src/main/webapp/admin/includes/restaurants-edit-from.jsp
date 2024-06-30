<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.foodiedelight.model.Restaurants"%>
<%
Restaurants restaurant = (Restaurants) request.getAttribute("restaurant");
if (restaurant != null) {
	String discountPrefix = restaurant.getDiscounts() != null ? restaurant.getDiscounts().split(" ")[0] : ""; // Extracts the first word
%>

<form action="UpdateRestaurant" method="POST" class="form"
	enctype="multipart/form-data" accept-charset="UTF-8">
	<div class="form-row">
		<input type="hidden" name="RestaurantID"
			value="<%=restaurant != null ? restaurant.getRestaurantID() : ""%>">

		<div class="form-group">
			<label for="nameUpdate">Restaurant Name:</label> <input type="text"
				value="<%=restaurant != null ? restaurant.getName() : ""%>"
				placeholder="Foodie Delight" name="nameUpdate" id="nameUpdate"
				required> <span id="nameUpdate-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="contactInfoUpdate">Restaurant Contact:</label> <input
				maxlength="10" type="text" placeholder="9900140463"
				id="contactInfoUpdate"
				value="<%=restaurant != null ? restaurant.getContactInfo() : ""%>"
				name="contactInfoUpdate" required> <span
				id="contactInfoUpdate-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="etaUpdate">Estimated Time of Arrival:</label> <input
				type="text" placeholder="15 - 35 min" name="etaUpdate"
				id="etaUpdate"
				value="<%=restaurant != null ? restaurant.getETA() : ""%>" required>
			<span id="etaUpdate-error" class="error-message"></span>

		</div>
		<div class="form-group">
			<label for="averageCostUpdate">Average Cost:</label> <input
				type="number" placeholder="&#8377; 99" name="averageCostUpdate"
				id="averageCostUpdate"
				value="<%=restaurant != null ? restaurant.getAverageCost() : ""%>"
				required> <span id="averageCostUpdate-error"
				class="error-message"></span>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<div class="form-group-type">
				<label for="cuisineTypesUpdate">Cuisine Types (Select up to
					2):</label> <input type="text"
					value="<%=restaurant != null ? restaurant.getCuisineTypes() : ""%>"
					id="selectedOptionsInputUpdate" readonly name="cuisineTypesUpdate"
					placeholder="Select Cuisine Types..">
				<div class="dropdown-content">
					<div data-value="South Indian">South Indian</div>
					<div data-value="North Indian">North Indian</div>
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
					<div data-value="Idli">Idli</div>
					<div data-value="Salad">Salad</div>
				</div>
				<span id="cuisineTypesUpdate-error" class="error-message"></span>
			</div>
		</div>
		<div class="form-group">
			<label for="discountsUpdate">Discounts:</label> <select
				name="discountsUpdate" id="discountsUpdate" required>
				<option value="" disabled
					<%=restaurant.getDiscounts() == null ? "selected" : ""%>>Choose
					Discount...</option>
				<option value="No Discount"
					<%="NO".equals(discountPrefix) ? "selected" : ""%>>No
					Discount</option>
				<option value="10% OFF UPTO &#8377;40"
					<%="10%".equals(discountPrefix) ? "selected" : ""%>>10%
					OFF UPTO &#8377;40</option>
				<option value="20% OFF UPTO &#8377;50"
					<%="20%".equals(discountPrefix) ? "selected" : ""%>>20%
					OFF UPTO &#8377;50</option>
				<option value="30% OFF UPTO &#8377;60"
					<%="30%".equals(discountPrefix) ? "selected" : ""%>>30%
					OFF UPTO &#8377;60</option>
				<option value="40% OFF UPTO &#8377;80"
					<%="40%".equals(discountPrefix) ? "selected" : ""%>>40%
					OFF UPTO &#8377;80</option>
				<option value="50% OFF UPTO &#8377;100"
					<%="50%".equals(discountPrefix) ? "selected" : ""%>>50%
					OFF UPTO &#8377;100</option>
				<option value="60% OFF UPTO &#8377;120"
					<%="60%".equals(discountPrefix) ? "selected" : ""%>>60%
					OFF UPTO &#8377;120</option>
				<option value="FREE DELIVERY"
					<%="FREE".equals(discountPrefix) ? "selected" : ""%>>Free
					Delivery</option>
			</select> <span id="discountsUpdate-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="streetUpdate">Street:</label> <input type="text"
				maxlength="20" id="streetUpdate"
				value="<%=restaurant != null ? restaurant.getStreet() : ""%>"
				placeholder="BTM Layout 1st Stage" name="streetUpdate" required>
			<span id="streetUpdate-error" class="error-message"></span>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="cityNameUpdate">City Name:</label> <input type="text"
				name="cityNameUpdate"
				value="<%=restaurant != null ? restaurant.getCity() : ""%>"
				placeholder="Bengaluru" required> <span
				id="cityNameUpdate-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="stateUpdate">State:</label> <input type="text"
				id="stateUpdate"
				value="<%=restaurant != null ? restaurant.getState() : ""%>"
				placeholder="Karnataka" name="stateUpdate" required> <span
				id="stateUpdate-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="pinCodeUpdate">Pin Code:</label> <input type="text"
				id="pinCodeUpdate"
				value="<%=restaurant != null ? restaurant.getPinCode() : ""%>"
				maxlength="6" placeholder="560029" name="pinCodeUpdate" required>
			<span id="pinCodeUpdate-error" class="error-message"></span>

		</div>
		<div class="form-group">
			<label for="typeUpdate">Restaurant Type:</label> <select
				id="typeUpdate" name="typeUpdate" required>
				<option value="" disabled>Choose Type...</option>
				<option value="Veg"
					<%="Veg".equals(restaurant.getType()) ? "selected" : ""%>>Vegetarian</option>
				<option value="Non-Veg"
					<%="Non-Veg".equals(restaurant.getType()) ? "selected" : ""%>>Non
					Vegetarian</option>
				<option value="Both"
					<%="Both".equals(restaurant.getType()) ? "selected" : ""%>>Both</option>
			</select> <span id="typeUpdate-error" class="error-message"></span>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="imageUpdateURL">Restaurant Cover:</label> <input
				type="file" class="image-file" id="imageUpdateURL" accept="image/*"
				name="imageUpdateURL" accept=""> <span
				id="imageUrlUpdate-error" class="error-message"></span>
		</div>

		<div class="form-group">
			<label for="descriptionUpdate">Restaurant Short Description:</label>
			<textarea
				placeholder="A vibrant Indian restaurant offering a diverse menu of traditional and modern dishes, crafted from fresh ingredients and a symphony of spices to tantalize your taste buds."
				name="descriptionUpdate" rows="2" cols="1" maxlength="60"><%=restaurant != null ? restaurant.getDescription() : ""%></textarea>
			<span id="descriptionUpdate-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="openTimeUpdate">Open Time:</label> <input type='time'
				value="<%=restaurant != null ? restaurant.getOpeningTime() : ""%>"
				name="openTimeUpdate" /> <span id="openTimeUpdate-error"
				class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="closeTimeUpdate">Close Time:</label> <input type='time'
				value="<%=restaurant != null ? restaurant.getClosingTime() : ""%>"
				name="closeTimeUpdate" /> <span id="closeTimeUpdate-error"
				class="error-message"></span>
		</div>

	</div>
	<div class="form-row ">
		<div class="form-group">
			<label for="selectedTagsInput">Select Tags:</label>
			<textarea id="selectedTagsInput" name="tagSelectionUpdate"
				placeholder="Select Tags..." rows="3" readonly><%=restaurant != null && restaurant.getTags() != null ? restaurant.getTags() : ""%></textarea>
			<div class="chips-container" id="tagsChips">
				<div class="chip" data-value="South Indian">South Indian</div>
				<div class="chip" data-value="North Indian">North Indian</div>
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
		<button type="submit" id="submitButton" class="button-29">Update
			Changes</button>
	</div>
	<!-- Image preview container -->
	<div class="cover-container">
		<%
		if (restaurant.getImageURL() != null && !restaurant.getImageURL().isEmpty()) {
		%>
		<div>
			<p>Previous Cover:</p>
			<img src="RestaurantImages/<%=restaurant.getImageURL()%>"
				alt="Restaurant Cover" style="max-width: 200px; height: auto;" />
		</div>
		<%
		} else {
		%>
		<p>No previous cover image available.</p>
		<%
		}
		%>
		<div>
			<p>New Cover:</p>
			<img id="imagePreview" src="" alt="Image preview"
				style="display: none; max-width: 200px; height: auto;" />
		</div>
	</div>
</form>
	<%
}
%>

<style>
/* input.invalid, select.invalid, textarea.invalid, .form-group-type input {
    border-color: #d8000c;
} */
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
	width: 100%;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	border-radius: 8px;
	padding: 10px;
	cursor: pointer;
	border: 2px solid var(--border-color);
}

.dropdown-content div:hover, .dropdown-content div.selected {
	background-color: var(--primary-color);
	color: var(--text-color);
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
	document.addEventListener('DOMContentLoaded', function() {
		const imageUrlInput = document.getElementById('imageUpdateURL');
		const imagePreview = document.getElementById('imagePreview');

		imageUrlInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file && file.type.startsWith('image/')) {
				const reader = new FileReader();
				reader.onload = function(e) {
					imagePreview.src = e.target.result;
					imagePreview.style.display = 'block';
				};
				reader.readAsDataURL(file);
			} else {
				imagePreview.src = '';
				imagePreview.style.display = 'none';
			}
		});
	});
	
	let selectedOptions = [];
	const selectedOptionsInput = document.getElementById('selectedOptionsInputUpdate');
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
		if (!event.target.matches('#selectedOptionsInputUpdate')) {
			dropdownContent.classList.remove('show');
		}
	});
	


</script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const tagsInput = document.getElementById('selectedTagsInput');
    let selectedTags = tagsInput.value.trim().replace(/^,|,$/g, '').split(/\s*,\s*/).filter(Boolean);
    const tagsChips = document.getElementById('tagsChips');

    // Initialize chips as selected based on the textarea value
    tagsChips.querySelectorAll('.chip').forEach(chip => {
        if (selectedTags.includes(chip.getAttribute('data-value'))) {
            chip.classList.add('selected');
        }

        // Toggle selection on chip click
        chip.addEventListener('click', function() {
            const value = this.getAttribute('data-value');
            const index = selectedTags.indexOf(value);

            if (index === -1) {
                if (selectedTags.length < 10) { // Limit to 10 selections
                    selectedTags.push(value);
                    this.classList.add('selected');
                } else {
                    alert("You can select up to 10 options only.");
                }
            } else {
                selectedTags.splice(index, 1);
                this.classList.remove('selected');
            }
            tagsInput.value = selectedTags.join(", ");
        });
    });

    // Check if the textarea is initially empty to clean it up
    if (!tagsInput.value.trim()) {
        tagsInput.value = ''; // Ensure the textarea is truly empty
    }
});

// Normalize and clean up the tags in the textarea
function updateTagsInput() {
    const tagsInput = document.getElementById('selectedTagsInput');
    let selectedTags = tagsInput.value.trim().replace(/^,|,$/g, '').split(/\s*,\s*/).filter(Boolean);
    tagsInput.value = selectedTags.join(", "); // Rejoin the array into a string with proper formatting
}

// Add a tag dynamically, example function can be called from elsewhere in your application
function addTag(newTag) {
    const tagsInput = document.getElementById('selectedTagsInput');
    let selectedTags = tagsInput.value.split(/\s*,\s*/).filter(Boolean);
    if (!selectedTags.includes(newTag)) {
        selectedTags.push(newTag);
        updateTagsInput(); // Normalize and clean up the input
    }
}
</script>
