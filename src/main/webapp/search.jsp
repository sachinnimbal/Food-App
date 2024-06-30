<!-- ===== Side Bar File ===== -->
<%@ include file="includes/sidebar.jsp"%>

<!-- ===== Top Bar File ===== -->
<%@ include file="includes/topbar.jsp"%>

<style>
.search-container {
	width: 490px;
	display: block;
	margin: 0 auto;
}

input#search-bar {
	margin: 0 auto;
	width: 100%;
	height: 45px;
	padding: 0 20px;
	font-size: 1rem;
	border: 1px solid #D0CFCE;
	outline: none; &: focus { border : 1px solid #008ABF;
	transition: 0.35s ease;
	color: #008ABF; &:: -webkit-input-placeholder { transition : opacity
	0.45s ease;
	opacity: 0;
}

&::-moz-placeholder {transition: opacity 0.45s ease;opacity: 0;}

&:-ms-placeholder {transition: opacity 0.45s ease; opacity: 0;}}}

.search-icon {
	position: relative;
	float: right;
	width: 75px;
	height: 75px;
	top: -62px;
	right: -20px;
}
</style>

<!-- ===== Main Conatiner Starts ===== -->

<%-- <%@ include file="includes/cuisine.jsp"%> --%>

<form class="search-container" method="POST">
	<input type="text" id="search-bar"
		placeholder="What can I help you with today?"> <a href="#"><img
		class="search-icon"
		src="http://www.endlessicons.com/wp-content/uploads/2012/12/search-icon.png"></a>
</form>

<!-- ===== Main Conatiner Ends ===== -->

<!-- ===== Footer Main File ===== -->
<%@ include file="includes/footer-main.jsp"%>