<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="java.util.*"%>

<div class="table-container">
	<div class="controls">
		<div class="left-controls">
			<div class="select-wrapper">
				<label> <select id="rows-per-page">
						<option value="5" selected>5</option>
						<option value="10">10</option>
						<option value="25">25</option>
						<option value="50">50</option>
						<option value="100">100</option>
				</select> entries per page
				</label>
			</div>
		</div>
		<div class="right-controls">
			<label>Search: <input type="text" id="search-input"
				placeholder="Type to search..."></label>
		</div>
	</div>
	<div class="table-responsive">
		<table id="restaurantTable" class="table-sortable">

		</table>
	</div>
	<div class="pagination-area">
		<div class="pagination-info"></div>
		<div class="pagination"></div>
	</div>
</div>

<script src="assets/js/foodiedelight.table.js"></script>

<script>
    const dynamicTable = new DynamicTable("#restaurantTable", {
        data: [],
        columns: ["Sl", "ID", "Cover", "Name", "Contact", "Rating", "ETA", "Cost", "Cuisine", "Status", "Discounts", "Street", "City", "State", "Pincode", "Type", "Opening", "Closing"],
        searchInput: "#search-input",
        rowsPerPageSelect: "#rows-per-page",
        paginationContainer: ".pagination",
        paginationInfo: ".pagination-info",
        sortableColumns: ["Sl","ID", "Name", "Rating", "Cost", "Street", "City", "State", "Pincode", "Type"],
        centerAlignedColumns: ["Sl","ID", "Cover", "Contact",  "Rating", "Cost", "Status", "Action", "Pincode", "Type", "Opening", "Closing"] 

    });

    generateTableRows();
    
    function generateTableRows() {
        const userData = [
        	<% List<Restaurants> restaurantsList = (List<Restaurants>) request.getAttribute("restaurantsTable");
			int inc = 0;
        	for (Restaurants restaurant : restaurantsList) {
        		String name = restaurant.getName();
        		String restaurantName = name.length() > 25 ? name.substring(0, 22) + "..." : name;
        	%>
                {
                    Sl: <%= ++inc %>,
                    ID: <%=restaurant.getRestaurantID()%>,
                    Cover: `<img src="RestaurantImages/<%=restaurant.getImageURL()%>" alt="Restaurant Image" style="width: 80px; height: 80px; object-fit: cover; border-radius: 20px;">`,
                    Name: `<div class="td-tooltip-container">
							<%=restaurantName%>
						<div class="td-tooltip-text">
							<%=name%>
						</div>
					</div>`,
                    Contact: '<%=restaurant.getContactInfo()%>',
                    Rating: <%= restaurant != null ? String.format("%.1f", restaurant.getAverageRating()) : "" %>,
                    ETA: '<%=restaurant.getETA()%> min',
                    Cost: <%=restaurant.getAverageCost() != null ? restaurant.getAverageCost() : "No data"%>,
                    Cuisine: '<%=restaurant.getCuisineTypes()%>',
                    Status: '<%=restaurant.getStatus()%>',
                    Discounts: '<%=restaurant.getDiscounts()%>',
                    Street: '<%=restaurant.getStreet() != null ? restaurant.getStreet() : "No data"%>',
                    City: '<%=restaurant.getCity() != null ? restaurant.getCity() : "No data"%>',
                    State: '<%=restaurant.getState() != null ? restaurant.getState() : "No data"%>',
                    Pincode: '<%=restaurant.getPinCode() != null ? restaurant.getPinCode() : "No data"%>',
                    Type: '<%=restaurant.getType() != null ? restaurant.getType() : "No data"%>',
                    Opening: '<%=restaurant.getOpeningTime() != null ? restaurant.getOpeningTime() : "No data"%>',
                    Closing: '<%=restaurant.getClosingTime() != null ? restaurant.getClosingTime() : "No data"%>',
                },
            <%}%>
        ]; 

        // Sort userData based on ID by default
        userData.sort((a, b) => a.ID - b.ID);

        console.log(userData);
        dynamicTable.setData(userData);

    }
</script>

