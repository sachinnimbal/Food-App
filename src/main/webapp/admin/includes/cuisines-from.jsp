<form action="AddCuisines" method="POST" class="form">
	<div class="form-row">
		<div class="form-group">
			<label for="cuisineName">Cuisine Name:</label> <input type="text"
				placeholder="" name="cuisineName" required>
		</div>
		<div class="form-group">
			<label for="cuisineDescription">Cuisine Description:</label>
			<textarea name="cuisineDescription" rows="1" placeholder=""></textarea>
		</div>
		<div class="form-group">
			<label for="cuisineURL">Cuisine Url:</label> <input type="text"
				name="cuisineURL">
		</div>
	</div>

	<div class="right">
		<button type="submit" id="submitButton" class="button-29">Add
			Cuisine</button>
	</div>
</form>
