<%@page import="com.foodiedelight.model.MenuItems"%>

<%
MenuItems menus = (MenuItems) request.getAttribute("menuItems");
if (menus != null) {
%>
<form action="MenuUpdate" method="POST" class="form"
	enctype="multipart/form-data" accept-charset="UTF-8">
	<input type="hidden" name="itemID" value="<%=menus.getItemID()%>">
	<input type="hidden" name="restaurantID"
		value="<%=menus.getRestaurantID()%>">

	<div class="form-row">
		<div class="form-group">
			<label for="itemNameUpdate">Item Name:</label> <input type="text"
				name="itemNameUpdate" placeholder="Item Name"
				value="<%=menus.getName()%>" required>
		</div>
		<div class="form-group">
			<label for="itemDescriptionUpdate">Description:</label>
			<textarea name="itemDescriptionUpdate" rows="1"
				placeholder="Item Description"><%=menus.getDescription()%></textarea>
		</div>
		<div class="form-group">
			<label for="itemPriceUpdate">Price:</label> <input type="number"
				name="itemPriceUpdate" placeholder="&#8377; 250"
				value="<%=menus.getPrice()%>" required>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="photoURLUpdate">Item Image:</label> <input type="file"
				class="image-file" id="photoURLUpdate" name="photoURLUpdate"
				accept="image/*">
		</div>
		<div class="form-group">
			<label for="itemStatusUpdate">Status:</label> <select
				name="itemStatusUpdate" required>
				<option value="Available"
					<%="Available".equals(menus.getStatus()) ? "selected" : ""%>>Available</option>
				<option value="Not Available"
					<%="Not Available".equals(menus.getStatus()) ? "selected" : ""%>>Not
					Available</option>
			</select>
		</div>
		<div class="form-group">
			<label for="itemTypeUpdate">Type:</label> <select
				name="itemTypeUpdate" required>
				<option value="Veg"
					<%="Veg".equals(menus.getType()) ? "selected" : ""%>>Vegetarian</option>
				<option value="Non-Veg"
					<%="Non-Veg".equals(menus.getType()) ? "selected" : ""%>>Non
					Vegetarian</option>
			</select>
		</div>
	</div>
	<div class="right">
		<button type="submit" id="submitButton" class="button-29">Update
			Item</button>
	</div>
	<div class="cover-container">
		<%
		if (menus.getPhotoURL() != null && !menus.getPhotoURL().isEmpty()) {
		%>
		<div>
			<p>Previous Cover:</p>
			<img src="FoodItems/<%=menus.getPhotoURL()%>" alt="Image preview"
				style="display: block; max-width: 200px; height: auto;">
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
		const imageUrlInput = document.getElementById('photoURLUpdate');
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
</script>