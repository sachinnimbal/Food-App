<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>

<style>
.action-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	background-color: var(--secondary-color);
	color: var(--button-text);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border: none;
	padding: 0 5px 5px 5px;
	border-radius: 4px;
	cursor: pointer;
}

.red {
	background-color: red;
}

.action-btn:focus {
	border: 2px solid var(--border-color);
}

.text-center {
	text-align: center;
}

select {
	padding: 3px;
	font-size: 16px;
	background-color: var(--panel-color);
	border: 1px solid var(--toggle-color);
	border-radius: 5px;
	transition: border-color 0.3s, box-shadow 0.3s;
	outline: none;
	color: var(--text-color);
}

select:focus {
	outline: none;
	box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
	border-color: var(--primary-color);
}

select::placeholder {
	color: var(--placeholder-color);
}
</style>



<div class="table-container">
	<div class="controls">
		<div class="left-controls">
			<div class="select-wrapper">
				<label> <select id="rows-per-page">
						<option value="5">5</option>
						<option value="10" selected>10</option>
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
		<table id="menuTable" class="table-sortable">

		</table>
	</div>
	<div class="pagination-area">
		<div class="pagination-info"></div>
		<div class="pagination"></div>
	</div>
</div>

<script src="assets/js/foodiedelight.table.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const dynamicTable = new DynamicTable("#menuTable", {
            data: [], 
            columns: ["Sl","ID", "Image", "RestaurantID", "Name",  "Price", "Status", "Type", "Description", "Action"],
            searchInput: "#search-input",
            rowsPerPageSelect: "#rows-per-page",
            paginationContainer: ".pagination",
            paginationInfo: ".pagination-info",
            sortableColumns: ["Sl","ID", "RestaurantID", "Name", "Price", "Status"],
            centerAlignedColumns: ["Sl","ID", "Image", "RestaurantID", "Action"] 
        });

        generateTableRows();

        function generateTableRows() {
        	const menusData = [
        	    <%List<MenuItems> allMenus = (List<MenuItems>) request.getAttribute("menus");
        	    int sl = 0;
    				for (MenuItems menu : allMenus) {
    					if (menu != null) {%>
        	            {
        	            	Sl: <%= ++sl %>,
        	            	ID: <%=menu.getItemID()%>,
        	            	Image: `<img src="FoodItems/<%=menu.getPhotoURL()%>" alt="Food Image" style="width: 40px; height: 40px; object-fit: cover;">`,
        	            	RestaurantID: <%=menu.getRestaurantID()%>,
        	            	Name: "<%=menu.getName().replace("\"", "\\\"")%>",
        	                Price: "<i class='bx bx-rupee'></i><%=menu.getPrice()%>",
        	            	Status: "<%=menu.getStatus()%>",
        	                Type: "<%=menu.getType()%>",
        	            	Description: "<%=menu.getDescription() == null ? menu.getDescription().replace("\"", "\\\"") : "No Data"%>",
        	            	Action: `<form method="POST" action="EditMenu" style="display: inline;">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="ItemID" value="<%= menu.getItemID() %>">
                                <button type="submit" class="action-btn"><i class="bi bi-pencil-square"></i></button>
                            </form>
                            `,        	            },
        	    <%}
}%>
    			];

            dynamicTable.setData(menusData);
        }
    });
</script>


