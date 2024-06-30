<%@page import="com.foodiedelight.model.*"%>
<%@page import="java.util.*"%>
<!-- Cuisines Type Slider -->
<div class="main-slider">
	<div class="label-container">
		<h2>What's on your mind?</h2>
		<button class="arrow-left">
			<i class='bx bxs-left-arrow-circle'></i>
		</button>
		<button class="arrow-right">
			<i class='bx bxs-right-arrow-circle'></i>
		</button>
	</div>
	<div class="card-slider-main">
		<%
		List<Cuisine> allCuisine = (List<Cuisine>) request.getAttribute("allCuisine");
		if (allCuisine != null && !allCuisine.isEmpty()) {
			for (Cuisine cuisine : allCuisine) {
		%>
		<div class="card-wrapper">
			<form id="form_<%=cuisine.getCuisineID()%>" action="Cuisines"
				method="POST">
				<input type="hidden" name="cuisineID"
					value="<%=cuisine.getCuisineID()%>" /> <input type="hidden"
					name="cuisineName" value="<%=cuisine.getCuisineName()%>" /> <img
					src="<%=cuisine.getCuisineUrl()%>" alt=""
					onclick="submitForm('<%=cuisine.getCuisineID()%>');">
			</form>
		</div>
		<%
		}
		} else {
		out.println("<p>No cuisines found.</p>");
		}
		%>
	</div>
</div>
<!-- Cuisines Type Slider -->
<script>
	function submitForm(cuisineID) {
		document.getElementById('form_' + cuisineID).submit();
	}
</script>
<hr class="dotted-line">