<form action="" method="POST" class="form">
	<div class="form-row">
		<div class="form-group">
			<label for="name">Restaurant Name:</label> <input type="text"
				placeholder="Foodie Delight" name="Name" required>
		</div>
		<div class="form-group">
			<label for="contactInfo">Restaurant Contact:</label> <input
				type="text" placeholder="9900140463" name="ContactInfo" required>
		</div>
		<div class="form-group">
			<label for="eta">Estimated Time of Arrival:</label> <input
				type="number" placeholder="15 - 35 min" name="ETA" required>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="averageCost">Average Cost:</label> <input type="number"
				placeholder="&#8377;99" name="AverageCost" required>
		</div>
		<div class="form-group">
			<label for="cuisineTypes">Cuisine Types:</label> <input type="text"
				placeholder="South Indian, North Indian" name="CuisineTypes"
				required>
		</div>
		<div class="form-group">
			<label for="discounts">Discounts:</label> <input type="text"
				placeholder="20% OFF UPTO &#8377;50 OR FREE DELIVERY"
				name="Discounts" required>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="street">Street:</label> <input type="text"
				placeholder="BTM Layout 1st Stage" name="Street" required>
		</div>
		<div class="form-group">
			<label for="cityName">City Name:</label> <input type="text"
				placeholder="Bengaluru" name="CityName" required>
		</div>
		<div class="form-group">
			<label for="state">State:</label> <input type="text"
				placeholder="Karnataka" name="State" required>
		</div>
	</div>
	<div class="form-row">
		<div class="form-group">
			<label for="pinCode">Pin Code:</label> <input type="text"
				placeholder="560029" name="PinCode" required>
		</div>
		<div class="form-group">
			<label for="type">Restaurant Type:</label> <select id="type" name="type"
				required>
				<option value="" disabled>Choose Type...</option>
				<option value="Veg">Vegetarian</option>
				<option value="Non-Veg">Non Vegetarian</option>
				<option value="Both">Both</option>
			</select>
		</div>
		<div class="form-group">
			<label for="imageUrl">Restaurant Cover:</label> <input type="file"
				id="imageUrl" name="ImageURL" required>
		</div>
	</div>
	<div class="form-group">
		<label for="description">Restaurant Short Description:</label>
		<textarea
			placeholder="A vibrant Indian restaurant offering a diverse menu of traditional and modern dishes, crafted from fresh ingredients and a symphony of spices to tantalize your taste buds."
			name="Description" rows="2" cols="1" required></textarea>
	</div>
	<div class="form-group mt-5">
		<input type="submit">
	</div>
</form>
