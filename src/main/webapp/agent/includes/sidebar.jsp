<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodiedelight.model.*"%>
<%@ page import="com.foodiedelight.daoimpl.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodie Delight - Agent</title>
<link rel="shortcut icon"
	href="https://logo.com/image-cdn/images/kts928pd/production/7ab5def0ab1dad26a90bc35cb7eed9e628f7f201-430x430.png?w=1080&q=72"
	type="image/x-icon">
<link href="assets/css/foodiedelight.css" rel="stylesheet" />
<link href="assets/css/foodiedelight.mob.css" rel="stylesheet" />
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- SweetAlert CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="assets/js/foodiedelight.js"></script>
<style>
.grayscale {
	filter: grayscale(100%);
	-webkit-filter: grayscale(100%);
}

.ribbon-2 {
	--f: 10px;
	--r: 15px;
	--t: 10px;
	position: absolute;
	inset: var(--t) calc(-1 * var(--f)) auto auto;
	padding: 0 10px var(--f) calc(10px + var(--r));
	clip-path: polygon(0 0, 100% 0, 100% calc(100% - var(--f)),
		calc(100% - var(--f)) 100%, calc(100% - var(--f)) calc(100% - var(--f)),
		0 calc(100% - var(--f)), var(--r) calc(50% - var(--f)/2));
	background: #BD1550;
	z-index: 2;
	color: white;
	box-shadow: 0 calc(-1 * var(--f)) 0 inset #0005;
}

.container {
	min-height: 100vh;
	width: 100%;
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin: auto;
	align-items: flex-start;
}

.column-sections {
	display: flex;
	flex: 1;
	flex-direction: column;
	gap: 10px;
}

.side-section {
	position: sticky;
	top: 90px;
	max-width: 600px;
	border: 1px solid var(--border-color);
	background-color: transparent;
	display: flex;
	flex-direction: column;
}
/* ===== Box Overview ===== */
.box-overview {
	display: grid;
	width: 100%;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
	margin-bottom: 20px;
}

.info-box {
	padding: 15px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: var(--sidebar-color);
	border-radius: 8px;
	width: 100%;
	cursor: pointer;
	transition: transform 0.3s ease;
	box-shadow: 0 0 4px rgba(0, 0, 0, 0.1);
}

.info-box-icon {
	display: flex;
	align-items: center;
}

.info-box-icon img {
	width: 60px;
	height: 60px;
}

.info-box-content {
	flex: 1;
}

.info-box-text, .info-box-number {
	margin: 0;
}

.info-box-text {
	font-size: 18px;
	font-weight: 500;
}

.info-box-number {
	font-size: 36px;
	font-weight: bold;
	margin-top: 5px;
}

.info-box:hover {
	transform: translateY(-8px);
	cursor: pointer;
	background-color: var(--primary-color-light);
	color: var(--primary-color);
}
/* ===== Box Overview Ends ===== */
/* ===== Breadcrumb Section Starts ===== */
.breadcrumb {
	font-family: Arial, sans-serif;
	padding: 10px 0;
	width: 100%;
	list-style: none;
	padding-left: 10px;
	margin-bottom: 10px;
}

.breadcrumb ul {
	display: flex;
	align-items: center;
	padding: 0;
	margin: 0;
}

.breadcrumb li {
	list-style-type: none;
}

.breadcrumb li a {
	color: #0275d8;
	text-decoration: none;
	transition: color 0.3s ease;
}

.breadcrumb li a:hover {
	color: #025aa5;
}

.breadcrumb li:not(:last-child)::after {
	content: "/";
	margin: 0 8px;
	color: #6c757d;
}

.breadcrumb li:last-child {
	color: #6c757d;
	pointer-events: none;
	cursor: default;
}
/* ===== Breadcrumb Section Ends ===== */
.agent-header {
	display: flex;
	flex-direction: column;
	padding: 10px;
	background-color: transparent;
	position: -webkit-sticky;
	position: sticky;
	top: 0;
	max-width: 100%;
	box-shadow: rgba(17, 17, 26, 0.05) 0px 1px 0px, rgba(17, 17, 26, 0.1)
		0px 0px 8px;
	z-index: 1000;
	overflow: hidden;
	transition: background-color 0.3s ease, box-shadow 0.3s ease;
	position: relative;
}

.header-top {
	display: flex;
	justify-content: space-between;
	gap: 10px;
	width: 100%;
	padding-top: 10px;
}

.header-top>img {
	object-fit: cover;
	width: 160px;
	height: 160px;
	border-radius: 20px;
}

.right-end p {
	background-color: var(--success);
	padding: 5px 10px;
	border-radius: 5px;
	width: fit-content;
	color: var(--panel-color);
	font-size: 14px;
	justify-content: end;
	margin: 0;
}

.dotted-line {
	margin: 10px 10px 0 0;
	border-style: dashed;
	border-color: var(--border-color);
}

.sticky-header {
	background-color: var(--sidebar-color);
	box-shadow: 0 2px 2px rgba(0, 0, 0, 0.1);
}

.sticky-header .info-hidden {
	max-height: 0;
	opacity: 0;
}

.action-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	background-color: var(--secondary-color);
	color: var(--button-text);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	border: none;
	padding: 0 5px 5px 5px;
	font-family: "Trebuchet MS", "Lucida Sans Unicode", "Lucida Grande",
		"Lucida Sans", Arial, sans-serif;
	font-size: 16px;
	border-radius: 4px;
	cursor: pointer;
}

.action-btn:focus {
	border: 2px solid var(--border-color);
}

.grayscale {
	filter: grayscale(100%);
	-webkit-filter: grayscale(100%);
}

.ribbon-2 {
	--f: 10px;
	--r: 15px;
	--t: 10px;
	position: absolute;
	inset: var(--t) calc(-1 * var(--f)) auto auto;
	padding: 0 10px var(--f) calc(10px + var(--r));
	clip-path: polygon(0 0, 100% 0, 100% calc(100% - var(--f)),
		calc(100% - var(--f)) 100%, calc(100% - var(--f)) calc(100% - var(--f)),
		0 calc(100% - var(--f)), var(--r) calc(50% - var(--f)/2));
	background: #bd1550;
	z-index: 2000;
	color: white;
	box-shadow: 0 calc(-1 * var(--f)) 0 inset #0005;
}
/* ===== Restaurant Main Header Ends ===== */
/* ===== Modern Checkbox ===== */
.checkbox-wrapper-5 .check {
	--size: 30px;
	margin-top: 10px;
	position: relative;
	background: linear-gradient(90deg, #f19af3, #f099b5);
	line-height: 0;
	perspective: 400px;
	font-size: var(--size);
}

.checkbox-wrapper-5 .check input[type="checkbox"], .checkbox-wrapper-5 .check label,
	.checkbox-wrapper-5 .check label::before, .checkbox-wrapper-5 .check label::after,
	.checkbox-wrapper-5 .check {
	appearance: none;
	display: inline-block;
	border-radius: var(--size);
	border: 0;
	transition: 0.35s ease-in-out;
	box-sizing: border-box;
	cursor: pointer;
}

.checkbox-wrapper-5 .check label {
	width: calc(2.2 * var(--size));
	height: var(--size);
	background: #d7d7d7;
	overflow: hidden;
}

.checkbox-wrapper-5 .check input[type="checkbox"] {
	position: absolute;
	z-index: 1;
	width: calc(0.8 * var(--size));
	height: calc(0.8 * var(--size));
	top: calc(0.1 * var(--size));
	left: calc(0.1 * var(--size));
	background: linear-gradient(45deg, #dedede, #ffffff);
	box-shadow: 0 6px 7px rgba(0, 0, 0, 0.3);
	outline: none;
	margin: 0;
}

.checkbox-wrapper-5 .check input[type="checkbox"]:checked {
	left: calc(1.3 * var(--size));
}

.checkbox-wrapper-5 .check input[type="checkbox"]:checked+label {
	background: transparent;
}

.checkbox-wrapper-5 .check label::before, .checkbox-wrapper-5 .check label::after
	{
	content: "· ·";
	position: absolute;
	overflow: hidden;
	left: calc(0.15 * var(--size));
	top: calc(0.5 * var(--size));
	height: var(--size);
	letter-spacing: calc(-0.04 * var(--size));
	color: #9b9b9b;
	font-family: "Times New Roman", serif;
	z-index: 2;
	font-size: calc(0.6 * var(--size));
	border-radius: 0;
	transform-origin: 0 0 calc(-0.5 * var(--size));
	backface-visibility: hidden;
}

.checkbox-wrapper-5 .check label::after {
	content: "●";
	top: calc(0.65 * var(--size));
	left: calc(0.2 * var(--size));
	height: calc(0.1 * var(--size));
	width: calc(0.35 * var(--size));
	font-size: calc(0.2 * var(--size));
	transform-origin: 0 0 calc(-0.4 * var(--size));
}

.checkbox-wrapper-5 .check input[type="checkbox"]:checked+label::before,
	.checkbox-wrapper-5 .check input[type="checkbox"]:checked+label::after
	{
	left: calc(1.55 * var(--size));
	top: calc(0.4 * var(--size));
	line-height: calc(0.1 * var(--size));
	transform: rotateY(360deg);
}

.checkbox-wrapper-5 .check input[type="checkbox"]:checked+label::after {
	height: calc(0.16 * var(--size));
	top: calc(0.55 * var(--size));
	left: calc(1.6 * var(--size));
	font-size: calc(0.6 * var(--size));
	line-height: 0;
}
/* ===== Modern Checkbox Ends ===== */
</style>
</head>
<body>

	<%
	Users user = (Users) session.getAttribute("user");
	boolean isLoggedIn = user != null;
	%>
	<nav class="sidebar close">
		<header>
			<div class="image-text">
				<span class="image"> <img
					src="https://logo.com/image-cdn/images/kts928pd/production/7ab5def0ab1dad26a90bc35cb7eed9e628f7f201-430x430.png?w=1080&q=72"
					alt="Logo">
				</span>

				<div class="text logo-text">
					<%
					if (isLoggedIn && user != null) {
						String displayName = user.getUserName() != null && !user.getUserName().isEmpty() ? user.getUserName() : "Guest";
						String displayRole = user.getUserRole() != null && !user.getUserRole().isEmpty() ? user.getUserRole() : "Visitor";
					%>
					<span class="username"><%=displayName%></span> <span
						class="profession"><%=displayRole%></span>
					<%
					} else {
					%>
					<span class="username">Guest</span> <span class="profession">Visitor</span>
					<%
					}
					%>
				</div>

			</div>
			<i class='bx bx-chevron-right toggle'></i>
		</header>

		<div class="menu-bar">
			<div class="menu">

				<ul class="menu-links">

					<li class="nav-link"><a href="AgentHome"
						class="tooltip active"> <i class='bx bxs-dashboard icon'></i>
							<span class="text nav-text">Dashboard</span> <span
							class="tooltip-text">Dashboard</span>
					</a></li>


					<li class="nav-link"><a href="LiveOrders" class="tooltip">
							<i class='bx bx-station icon'></i> <span class="text nav-text">
								Live Orders</span> <span class="tooltip-text">Live Orders</span>
					</a></li>

					<li class="nav-link"><a href="AllDeliveredOrders"
						class="tooltip"> <i class='bx bx-list-ol icon'></i> <span
							class="text nav-text"> All Orders</span> <span
							class="tooltip-text">All Orders</span>
					</a></li>

				</ul>
			</div>

			<div class="bottom-content">
				<%
				if (isLoggedIn) {
				%>
				<ul>
					<li class="nav-link"><a href="Out"> <i
							class='bx bx-power-off icon'></i> <span class="text nav-text">Logout</span>
					</a></li>
				</ul>
				<%
				}
				%>
			</div>
		</div>

	</nav>

	<%
	String loginFailedMessage = (String) session.getAttribute("loginFailed");
	if (loginFailedMessage != null) {
		session.removeAttribute("loginFailed");
	%>
	<script>
    Swal.fire({
        icon: 'error',
        text: '<%=loginFailedMessage%>',
        confirmButtonText: 'Try Again'
    }).then((result) => {
        if (result.isConfirmed) {
            const loginOffcanvas = document.getElementById("loginOffcanvas");
            const errorMessage = document.getElementById("errorMessage");
            const errorText = document.querySelector("#errorMessage .error-text");

            if (loginOffcanvas && errorMessage && errorText) {
                errorText.textContent = '<%=loginFailedMessage%>'; 
                errorMessage.classList.remove('hide'); 
                errorMessage.style.display = 'flex'; 
                loginOffcanvas.classList.add("show");
            }
        }
    });
</script>
	<%
	}
	%>