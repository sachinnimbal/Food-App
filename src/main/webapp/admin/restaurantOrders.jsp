<!-- ===== Side Bar File ===== -->
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>

<!-- ===== Main Conatiner Starts ===== -->
<nav aria-label="Breadcrumb" class="breadcrumb">
  <ul>
    <li><a href="AdminHome">Home</a></li>
    <li><a href="RestaurantsView">Restaurants View</a></li>
    <li aria-current="page">Restaurant Orders</li>
  </ul>
</nav>

<%@ include file="includes/order-table.jsp"%>
<!-- ===== Main Conatiner Ends ===== -->
    
<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>