<%@ page import="com.foodiedelight.model.Users"%>
<%@ page import="java.util.List"%>

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

.suspended {
	background-color: #f8d7da; /* light red */
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

		<%
		    String currentRoleFilter = request.getParameter("Role");
		%>

		<form action="UsersList" method="POST" class="filter-form">
			<label for="roleFilter">Filter by Role:</label> <select name="Role"
				id="roleFilter" onchange="this.form.submit();">
				<option value="">All Users</option>
				<option value="SuperAdmin"
					<% if ("SuperAdmin".equals(currentRoleFilter)) { out.print("selected"); } %>>Super
					Admin</option>
				<option value="RestaurantOwner"
					<% if ("RestaurantOwner".equals(currentRoleFilter)) { out.print("selected"); } %>>Restaurant
					Owners</option>
				<option value="Customer"
					<% if ("Customer".equals(currentRoleFilter)) { out.print("selected"); } %>>Customers</option>
				<option value="DeliveryPerson"
					<% if ("DeliveryPerson".equals(currentRoleFilter)) { out.print("selected"); } %>>Delivery
					Persons</option>
			</select>
		</form>

		<div class="right-controls">
			<label>Search: <input type="text" id="search-input"
				placeholder="Type to search..."></label>
		</div>
	</div>
	<div class="table-responsive">
		<table id="userTable" class="table-sortable">

		</table>
	</div>
	<div class="pagination-area">
		<div class="pagination-info"></div>
		<div class="pagination"></div>
	</div>
</div>

<script src="assets/js/foodiedelight.table.js"></script>

<script>
    const dynamicTable = new DynamicTable("#userTable", {
        data: [],
        columns: ["ID", "UserID", "Name", "Username", "Phone", "Role", "Status", "Street", "City", "State", "Pincode", "Action"],
        searchInput: "#search-input",
        rowsPerPageSelect: "#rows-per-page",
        paginationContainer: ".pagination",
        paginationInfo: ".pagination-info",
        sortableColumns: ["ID","UserID", "Name", "Username", "Phone", "Role", "Status"],
        centerAlignedColumns: ["ID","UserID", "Phone", "Role", "Status", "Pincode", "Action"],
        rowClassField: "rowClass"
    });

    generateTableRows();

    function generateTableRows() {
        const userData = [
            <%List<Users> userList = (List<Users>) request.getAttribute("userData");
			int sequenceNo = 1;
			for (Users currentUser : userList) {
				String rowClass = "Suspended".equals(currentUser.getStatus()) ? "suspended" : "";
			%>
                {
                    ID: <%=sequenceNo++%>,
                    UserID: <%=currentUser.getUserID()%>,
                    Name: '<%=currentUser.getName()%>',
                    Username: '<%=currentUser.getUserName()%>',
                    Phone: '<%=currentUser.getPhoneNumber()%>',
                    Role: `<form action="UpdateUser" method="POST" onchange="this.submit();">
                        <input type="hidden" name="userId" value="<%= currentUser.getUserID() %>">
                        <select name="Role" <%= "SuperAdmin".equals(currentUser.getUserRole()) ? "disabled" : "" %>>
                            <option value="SuperAdmin" <%= "SuperAdmin".equals(currentUser.getUserRole()) ? "selected" : "" %> disabled>Super Admin</option>
                            <option value="RestaurantOwner" <%= "RestaurantOwner".equals(currentUser.getUserRole()) ? "selected" : "" %> <% if("SuperAdmin".equals(currentUser.getUserRole())) { %>disabled<% } %>>Restaurant Owner</option>
                            <option value="Customer" <%= "Customer".equals(currentUser.getUserRole()) ? "selected" : "" %> <% if("SuperAdmin".equals(currentUser.getUserRole())) { %>disabled<% } %>>Customer</option>
                            <option value="DeliveryPerson" <%= "DeliveryPerson".equals(currentUser.getUserRole()) ? "selected" : "" %> <% if("SuperAdmin".equals(currentUser.getUserRole())) { %>disabled<% } %>>Delivery Person</option>
                        </select>
                    </form>`,
                	Status: `<form action="UpdateUser" method="POST" onchange="this.submit();">
                	    <input type="hidden" name="userId" value="<%= currentUser.getUserID() %>">
                	    <select name="Status" <%= "SuperAdmin".equals(currentUser.getUserRole()) ? "disabled" : "" %>>
                	        <option value="Active" <%= "Active".equals(currentUser.getStatus()) ? "selected" : "" %>>Active</option>
                	        <option value="Inactive" <%= "Inactive".equals(currentUser.getStatus()) ? "selected" : "" %>>Inactive</option>
                	        <option value="Suspended" <%= "Suspended".equals(currentUser.getStatus()) ? "selected" : "" %>>Suspended</option>
                	    </select>
                	</form>`,
                    Street: '<%=currentUser.getStreet() != null ? currentUser.getStreet() : "No data"%>',
                    City: '<%=currentUser.getCityName() != null ? currentUser.getCityName() : "No data"%>',
                    State: '<%=currentUser.getState() != null ? currentUser.getState() : "No data"%>',
                    Pincode: '<%=currentUser.getPinCode() != null ? currentUser.getPinCode() : "No data"%>',
                    Action: `<form method="POST" action="EditUser" style="display: inline;">
                        <input type="hidden" name="userId" value="<%= currentUser.getUserID() %>">
                        <button type="submit" class="action-btn"><i class="bi bi-pencil-square"></i></button>
                     </form>`,
                     rowClass: '<%= rowClass %>'
                },
            <%}%>
        ];

        // Sort userData based on ID by default
        userData.sort((a, b) => a.ID - b.ID);

        dynamicTable.setData(userData);
    }
    
    
/*     function editUser(userId) {
        window.location.href = "EditUser?userId=" + userId;
    } */
</script>
