<%@ page import="java.util.stream.Collectors"%>
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
        columns: ["Sl", "Customer Details", "Items Ordered", "Order Date", "Delivery Address", "Total", "Delivered Date"],
        searchInput: "#search-input",
        rowsPerPageSelect: "#rows-per-page",
        paginationContainer: ".pagination",
        paginationInfo: ".pagination-info",
        sortableColumns: ["Sl" , "Total"],
        centerAlignedColumns: ["Sl"]
    });

    function generateTableRows() {
        var ordersData = [
            <%int inc = 0;
				List<DeliveryInfo> assignedDelivery = (List<DeliveryInfo>) request.getAttribute("assignedDeliveries");
				Map<Integer, Orders> orderMap = (Map<Integer, Orders>) request.getAttribute("ordersMap");
				Map<Integer, List<OrderItems>> orderItemMap = (Map<Integer, List<OrderItems>>) request.getAttribute("orderItemsMap");
				Map<Integer, MenuItems> menuItemMap = (Map<Integer, MenuItems>) request.getAttribute("menuItemsMap");
				Map<Integer, PaymentDetails> paymentDetailMap = (Map<Integer, PaymentDetails>) request
						.getAttribute("paymentDetailsMap");
				Map<Integer, Users> customersMap = (Map<Integer, Users>) request.getAttribute("customerMap");
				Map<Integer, Restaurants> restaurantsMap = (Map<Integer, Restaurants>) request.getAttribute("restaurantMap");
				DateTimeFormatter format = DateTimeFormatter.ofPattern("EEE, MMM dd, yyyy - hh:mm a");
				
				if (assignedDelivery != null && !assignedDelivery.isEmpty()) {
					Collections.sort(assignedDelivery, new Comparator<DeliveryInfo>() {
						@Override
						public int compare(DeliveryInfo d1, DeliveryInfo d2) {
							LocalDateTime dt1 = d1.getDeliverDateTime();
							LocalDateTime dt2 = d2.getDeliverDateTime();
							if (dt1 == null && dt2 == null)
								return 0;
							if (dt1 == null)
								return -1;
							if (dt2 == null)
								return 1;
							return dt1.compareTo(dt2);
						}
					});

			for (DeliveryInfo deliveries : assignedDelivery) {
				Orders orders = orderMap.get(deliveries.getOrderID());
				Users customers = customersMap.get(orders != null ? orders.getUserID() : null);
				Restaurants restaurant = restaurantsMap.get(orders != null ? orders.getRestaurantID() : null);
				List<OrderItems> items = orderItemMap.get(deliveries.getOrderID());
				PaymentDetails paymentDetails = paymentDetailMap.get(deliveries.getOrderID());
				String item_List = "( " + items.size() + " ) "
						+ items.stream().limit(2)
								.map(item -> menuItemMap.get(item.getItemID()).getName() + " - " + item.getQuantity())
								.collect(Collectors.joining(", "));
				String item_ListFull = "Total " + items.size() + " items: "
						+ items.stream().map(item -> menuItemMap.get(item.getItemID()).getName() + " - " + item.getQuantity())
								.collect(Collectors.joining(", "));
				LocalDateTime deliver = deliveries.getDeliverDateTime();
				String delivered_Date = deliver != null ? format.format(deliver) : "No date provided";
				boolean is_Delivered = "Delivered".equals(deliveries.getStatus());
				LocalDateTime orderDateTime = orders.getOrderDateTime();
				String formatted_Date = orderDateTime != null ? format.format(orderDateTime) : "No date provided";
				String full_Address = orders.getDeliveryAddress();
				String address = full_Address.length() > 20 ? full_Address.substring(0, 17) + "..." : full_Address;%>
            {
                "Sl": <%=++inc%>,
                "Customer Details": "<%=customers.getName()%> (<%=customers.getPhoneNumber()%>)",
                "Items Ordered": `<div class="td-tooltip-container">
                    <%=item_List%>
                    <div class="td-tooltip-text">
                        <%=item_ListFull%>
                    </div>
                </div>`,
                "Order Date": "<%=formatted_Date%>",
                "Delivery Address": `<div class="td-tooltip-container">
                    <%=address%>
                    <div class="td-tooltip-text">
                        <%=full_Address%>
                    </div>
                </div>`,
                "Total": "&#8377; <%=orders.getTotalAmount()%>",
                "Delivered Date" : "<%= delivered_Date %>"
                
            },
            <%}
				}%>
        ];

        dynamicTable.setData(ordersData);
    }

    generateTableRows();
});

</script>
