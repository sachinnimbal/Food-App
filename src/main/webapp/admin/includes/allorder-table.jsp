<%@ page import="java.util.stream.Collectors"%>
<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

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

.td-tooltip-container {
	position: relative;
	cursor: pointer;
	display: inline-block;
}

.td-tooltip-text {
	visibility: hidden;
	width: 280px;
	background-color: var(--sidebar-color);
	color: var(--text-color);
	text-align: center;
	border-radius: 6px;
	position: absolute;
	z-index: 1;
	bottom: -5px;
	text-align: left;
	padding: 10px;
	left: 50%;
	transform: translateX(-50%);
	margin-bottom: 15px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	opacity: 0;
	transition: opacity 0.3s, visibility 0.3s ease-in-out, margin-bottom
		0.3s ease-in-out;
}

.td-tooltip-container:hover .td-tooltip-text {
	visibility: visible;
	opacity: 1;
	margin-bottom: 0px;
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
		<table id="orderTable" class="table-sortable">
			<%-- "Paid": "&#8377; <%= payment != null ? payment.getAmount() : "0.00" %>",--%>
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
    const dynamicTable = new DynamicTable("#orderTable", {
        data: [],
        columns: ["Sl", "ID", "Customer Details", "Items Ordered", "Order Date", "Total", "Mode", "Delivery Address", "Order Status"],
        searchInput: "#search-input",
        rowsPerPageSelect: "#rows-per-page",
        paginationContainer: ".pagination",
        paginationInfo: ".pagination-info",
        sortableColumns: ["Sl", "ID", "Total", "Mode"],
        centerAlignedColumns: ["Sl", "ID", "Order Status"] 
    });

    function generateTableRows() {
        const ordersData = [
            <% 
            List<Orders> orders = (List<Orders>) request.getAttribute("allorders"); 
            if (orders != null) {
                orders.sort(Comparator.comparing(Orders::getOrderDateTime).reversed());
                Map<Integer, List<OrderItems>> orderItemsMap = (Map<Integer, List<OrderItems>>) request.getAttribute("orderItemsMap");
                Map<Integer, MenuItems> menuItemsMap = (Map<Integer, MenuItems>) request.getAttribute("menuItemsMap");
                Map<Integer, PaymentDetails> paymentDetailsMap = (Map<Integer, PaymentDetails>) request.getAttribute("paymentDetailsMap");
                Map<Integer, Users> userMap = (Map<Integer, Users>) request.getAttribute("userMap");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE, MMM dd, yyyy - hh:mm a");
                int inc = 0;

                for (Orders order : orders) {
                    List<OrderItems> items = orderItemsMap.get(order.getOrderID());
                    PaymentDetails payment = paymentDetailsMap.get(order.getOrderID());
                    Users customer = userMap.get(order.getUserID());
                    String itemList = "( " + items.size() + " ) " + items.stream()
                    .limit(2)
                    .map(item -> menuItemsMap.get(item.getItemID()).getName() + " - " + item.getQuantity())
                    .collect(Collectors.joining(", "));
                    String itemListFull = "Total " + items.size() + " items: " + items.stream()
                    .map(item -> menuItemsMap.get(item.getItemID()).getName() + " - " + item.getQuantity())
                    .collect(Collectors.joining(", "));
                    LocalDateTime orderDateTime = order.getOrderDateTime(); 
                    String formattedDate = orderDateTime != null ? formatter.format(orderDateTime) : "No date provided";
                    String fullAddress = order.getDeliveryAddress();
                    String displayedAddress = fullAddress.length() > 20 ? fullAddress.substring(0, 17) + "..." : fullAddress;
            %>
            {
                "Sl": <%= ++inc %>,
                "ID": <%= order.getOrderID()%>,
                "Customer Details": "<%= customer.getName() %> (<%= customer.getPhoneNumber() %>)",
                "Items Ordered": `<div class="td-tooltip-container">
                    <%= itemList %>
                    <div class="td-tooltip-text">
                        <%= itemListFull %>
                    </div>
                </div>`,
                "Order Date": "<%= formattedDate %>",
                "Total": "&#8377; <%= order.getTotalAmount() %>",
                "Mode": "<%= payment != null ? payment.getPaymentMethod() : "No payment info" %>",
                "Delivery Address": `<div class="td-tooltip-container">
                    <%= displayedAddress %>
                    <div class="td-tooltip-text">
                        <%= fullAddress %>
                    </div>
                </div>`,
                "Order Status": `<form action="UpdateOrdersStatus" method="POST">
                    <input type="hidden" name="orderID" value="<%= order.getOrderID() %>">
                    <select name="Status" onchange="this.form.submit();">
                        <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                        <option value="In Progress" <%= "In Progress".equals(order.getStatus()) ? "selected" : "" %>>In Progress</option>
                        <option value="Delivered" <%= "Delivered".equals(order.getStatus()) ? "selected" : "" %>>Delivered</option>
                        <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                    </select>
                </form>`
            },
            <%}
}%>
        ];

        dynamicTable.setData(ordersData);
    }

    generateTableRows(); 
});
</script>
