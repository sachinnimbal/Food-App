<form action="MenuAdd" method="POST" class="form"
	enctype="multipart/form-data" accept-charset="UTF-8">
	<div class="form-row">
		<div class="form-group">
			<label for="name">Item Name:</label> <input type="text"
				placeholder="Idli" name="itemName" required> <span
				id="itemName-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="itemDescription">Description:</label>
			<textarea name="itemDescription" rows="1"
				placeholder="Indian breakfast."></textarea>
			<span id="itemDescription-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="price">Price:</label> <input type="number"
				placeholder="&#8377; 250" name="itemPrice" required> <span
				id="itemPrice-error" class="error-message"></span>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="itemImageUrl">Item Image:</label> <input type="file"
				class="image-file" id="itemImageUrl" name="photoURL"
				accept="image/*"> <span id="itemImageUrl-error"
				class="error-message"></span>

		</div>
		<div class="form-group">
			<label for="status">Status:</label> <select name="itemStatus"
				required>
				<option value="" disabled>Select Status</option>
				<option value="Available" selected>Available</option>
				<option value="Not Available">Not Available</option>
			</select> <span id="itemStatus-error" class="error-message"></span>
		</div>
		<div class="form-group">
			<label for="type">Type:</label> <select name="itemType" required>
				<option value="" disabled>Choose Type...</option>
				<option value="Veg" selected>Vegetarian</option>
				<option value="Non-Veg">Non Vegetarian</option>
			</select> <span id="itemType-error" class="error-message"></span>
		</div>
	</div>
	<div class="right">
		<button type="submit" id="submitButton" class="button-29">Add
			Item</button>
	</div>
	<div>
		<p>Item Image Preview:</p>
		<img id="imagePreview" src="" alt="Image preview"
			style="display: none; max-width: 200px; height: auto;" />
	</div>
</form>

<style>
.image-file::-webkit-file-upload-button {
	visibility: hidden;
}

.image-file::before {
	content: 'Choose Item Image';
	display: inline-block;
	background: linear-gradient(top, #f9f9f9, #e3e3e3);
	outline: none;
	white-space: nowrap;
	cursor: pointer;
}

.image-file:active::before {
	background: -webkit-linear-gradient(top, #e3e3e3, #f9f9f9);
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
	const imageUrlInput = document.getElementById('itemImageUrl');
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
document.addEventListener("DOMContentLoaded", () => {
    validateForm(); // Initial validation call

    document.querySelectorAll(
        '.form input[type="text"], .form input[type="number"], .form input[type="file"], ' +
        '.form select, .form input[type="time"], ' +
        '.form-group-type input[type="text"], ' +
        '.form-group .form-group-type input[type="text"], input, select'
    ).forEach((input) => {
        if (input.type === "text") {
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

    // Validate Item Name
    const itemName = document.querySelector('[name="itemName"]');
    const itemNameError = document.getElementById("itemName-error");
    if (isEmpty(itemName.value)) {
        itemName.classList.add("invalid");
        itemNameError.textContent = "Item Name is required.";
        isValid = false;
    } else {
        itemName.classList.remove("invalid");
        itemNameError.textContent = "";
    }
    itemNameError.style.display = itemName.classList.contains("invalid") ? "block" : "none";

    // Validate Item Price
    const price = document.querySelector('[name="itemPrice"]');
    const priceError = document.getElementById("itemPrice-error");
    if (isEmpty(price.value)) {
        price.classList.add("invalid");
        priceError.textContent = "Item price is required.";
        isValid = false;    	
    }else if(Number(price.value) <= 0){
        price.classList.add("invalid");
        priceError.textContent = "Please enter a valid item price.";
        isValid = false;
    } else {
        price.classList.remove("invalid");
        priceError.textContent = "";
    }
    priceError.style.display = price.classList.contains("invalid") ? "block" : "none";

    // Validate Item Status
    const status = document.querySelector('[name="itemStatus"]');
    const statusError = document.getElementById("itemStatus-error");
    if (status.selectedIndex === 0) {
        status.classList.add("invalid");
        statusError.textContent = "Status is required.";
        isValid = false;
    } else {
        status.classList.remove("invalid");
        statusError.textContent = "";
    }
    statusError.style.display = status.classList.contains("invalid") ? "block" : "none";

    // Validate Image Upload (recommended but not enforced as mandatory)
    const itemImageUrl = document.querySelector('[name="photoURL"]');
    const itemImageUrlError = document.getElementById("itemImageUrl-error");
    if (itemImageUrl.files.length === 0) {
        itemImageUrlError.textContent = "Uploading an image is recommended.";
    } else {
        itemImageUrl.classList.remove("invalid");
        itemImageUrlError.textContent = "";
    }
    itemImageUrlError.style.display = itemImageUrl.files.length === 0 ? "block" : "none";

    // Validate Item Type
    const itemType = document.querySelector('[name="itemType"]');
    const itemTypeError = document.getElementById("itemType-error");
    if (itemType.selectedIndex === 0) {
        itemType.classList.add("invalid");
        itemTypeError.textContent = "Type is required.";
        isValid = false;
    } else {
        itemType.classList.remove("invalid");
        itemTypeError.textContent = "";
    }
    itemTypeError.style.display = itemType.classList.contains("invalid") ? "block" : "none";

    document.getElementById("submitButton").disabled = !isValid;
}

</script>