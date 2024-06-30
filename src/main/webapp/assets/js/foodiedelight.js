// Sidebar
document.addEventListener("DOMContentLoaded", function() {
	var toggleButton = document.querySelector(".sidebar header .toggle");
	var sidebar = document.querySelector(".sidebar");
	var mainContent = document.querySelector(".main");

	toggleButton.addEventListener("click", function() {
		sidebar.classList.toggle("close");
		if (sidebar.classList.contains("close") && mainContent) {
			mainContent.style.marginLeft = "88px";
		} else if (mainContent) {
			mainContent.style.marginLeft = "240px";
		}
	});

	var currentPageUrl = window.location.href;
	var navLinks = document.querySelectorAll(".menu-links a");

	navLinks.forEach(function(link) {
		var href = link.getAttribute("href");
		if (currentPageUrl.includes(href)) {
			link.closest("li").classList.add("active");
		}
	});
});


// Main Slider
document.addEventListener("DOMContentLoaded", function() {
	const container = document.querySelector(".card-slider-main");
	const leftButton = document.querySelector(".arrow-left");
	const rightButton = document.querySelector(".arrow-right");

	function updateButtonState() {
		// Disable the left button only if at the very start
		leftButton.disabled = container.scrollLeft <= 0;
		// Disable the right button if scrolled all the way to the end
		rightButton.disabled =
			container.scrollLeft + container.offsetWidth >= container.scrollWidth;
	}

	leftButton.addEventListener("click", function() {
		// If the right button is disabled, meaning we're at the end, scroll to the start
		if (rightButton.disabled) {
			container.scrollTo({
				left: 0,
				behavior: "smooth",
			});
		} else {
			// If not at the end, scroll left normally
			container.scrollBy({
				left: -container.offsetWidth / 2,
				behavior: "smooth",
			});
		}
	});

	rightButton.addEventListener("click", function() {
		// Always scroll right normally
		container.scrollBy({ left: container.offsetWidth / 2, behavior: "smooth" });
	});

	container.addEventListener("scroll", updateButtonState);
	updateButtonState();
});

// Restaurant Slider
document.addEventListener("DOMContentLoaded", function() {
	const restaurantContainer = document.querySelector(".card-slider");
	const leftRButton = document.querySelector(".restaurant-arrow-left");
	const rightRButton = document.querySelector(".restaurant-arrow-right");

	function updateButtonState() {
		// Disable the left button only if at the very start
		leftRButton.disabled = restaurantContainer.scrollLeft <= 0;
		// Disable the right button if scrolled all the way to the end
		rightRButton.disabled =
			restaurantContainer.scrollLeft + restaurantContainer.offsetWidth >=
			restaurantContainer.scrollWidth;
	}

	leftRButton.onclick = function() {
		// If the right button is disabled, meaning we're at the end, scroll to the start
		if (
			restaurantContainer.scrollLeft + restaurantContainer.offsetWidth >=
			restaurantContainer.scrollWidth
		) {
			restaurantContainer.scrollTo({
				left: 0,
				behavior: "smooth",
			});
		} else {
			// If not at the end, scroll left normally
			restaurantContainer.scrollBy({
				left: -restaurantContainer.offsetWidth / 2,
				behavior: "smooth",
			});
		}
	};

	rightRButton.onclick = function() {
		// Always scroll right normally
		restaurantContainer.scrollBy({
			left: restaurantContainer.offsetWidth / 2,
			behavior: "smooth",
		});
	};

	restaurantContainer.addEventListener("scroll", updateButtonState);
	updateButtonState();
});

// LOGIN OFF CANVAS
document.addEventListener("DOMContentLoaded", function() {
	// Off-canvas toggling
	const loginLink = document.querySelector(".login-icon");
	const loginOffcanvas = document.getElementById("loginOffcanvas");
	const loginCloseButton = document.getElementById("loginCloseOffcanvas");

	if (loginLink && loginOffcanvas) {
		loginLink.addEventListener("click", () => {
			loginOffcanvas.classList.toggle("show");
		});
	}

	if (loginCloseButton) {
		loginCloseButton.addEventListener("click", () => {
			loginOffcanvas.classList.remove("show");
		});
	}

	// Toggle forms within off-canvas
	const showRegisterFormOffcanvas = document.getElementById(
		"showRegisterFormOffcanvas"
	);
	const showLoginFormOffcanvas = document.getElementById(
		"showLoginFormOffcanvas"
	);
	const loginFormOffcanvas = document.getElementById("loginFormOffcanvas");
	const registerFormOffcanvas = document.getElementById(
		"registerFormOffcanvas"
	);

	if (showRegisterFormOffcanvas && registerFormOffcanvas) {
		showRegisterFormOffcanvas.addEventListener("click", function(e) {
			e.preventDefault();
			loginFormOffcanvas.classList.add("hidden");
			registerFormOffcanvas.classList.remove("hidden");
		});
	}

	if (showLoginFormOffcanvas && loginFormOffcanvas) {
		showLoginFormOffcanvas.addEventListener("click", function(e) {
			e.preventDefault();
			registerFormOffcanvas.classList.add("hidden");
			loginFormOffcanvas.classList.remove("hidden");
		});
	}

	// Toggle main body forms
	const showRegisterFormMain = document.getElementById("showRegisterFormMain");
	const showLoginFormMain = document.getElementById("showLoginFormMain");
	const loginFormMain = document.getElementById("loginFormMain");
	const registerFormMain = document.getElementById("registerFormMain");

	if (showRegisterFormMain && registerFormMain) {
		showRegisterFormMain.addEventListener("click", function(e) {
			e.preventDefault();
			loginFormMain.classList.add("hidden");
			registerFormMain.classList.remove("hidden");
		});
	}

	if (showLoginFormMain && loginFormMain) {
		showLoginFormMain.addEventListener("click", function(e) {
			e.preventDefault();
			registerFormMain.classList.add("hidden");
			loginFormMain.classList.remove("hidden");
		});
	}
});

// Slider Image
document.addEventListener("DOMContentLoaded", function() {
	let currentIndex = 0;
	const slides = document.querySelectorAll(".slide");
	const totalSlides = slides.length;
	const prevButton = document.querySelector(".prev");
	const nextButton = document.querySelector(".next");

	document.addEventListener("DOMContentLoaded", () => {
		updateButtonState();
	});

	prevButton.addEventListener("click", () => {
		moveSlide(-1);
	});

	nextButton.addEventListener("click", () => {
		moveSlide(1);
	});

	function moveSlide(step) {
		currentIndex += step;
		updateButtonState();

		const offset = -currentIndex * 100;
		document.querySelector(
			".slides"
		).style.transform = `translateX(${offset}%)`;
	}

	function updateButtonState() {
		prevButton.disabled = currentIndex <= 0;
		nextButton.disabled = currentIndex >= totalSlides - 1;
	}
});

// Popover Menu
document.addEventListener("DOMContentLoaded", (event) => {
	// Select the image and the popover menu by their class/ID
	const topbarImg = document.querySelector(".topbar-img");
	const popoverMenu = document.getElementById("popoverMenu");

	popoverMenu.style.display = "none";

	function clickOutsideElement(event, element) {
		return !element.contains(event.target);
	}
	topbarImg.addEventListener("click", (event) => {
		event.stopPropagation();
		popoverMenu.style.display =
			popoverMenu.style.display === "none" ? "block" : "none";
	});

	document.addEventListener("click", (event) => {
		if (
			clickOutsideElement(event, popoverMenu) &&
			clickOutsideElement(event, topbarImg)
		) {
			popoverMenu.style.display = "none";
		}
	});
});

// Restaurant Menu
document.addEventListener("DOMContentLoaded", function() {
	window.addEventListener("scroll", function() {
		const header = document.querySelector(".restaurant-header");
		if (window.scrollY > 0) {
			header.classList.add("sticky-header");
		} else {
			header.classList.remove("sticky-header");
		}
	});
});

// Restaurant Tabs
document.addEventListener("DOMContentLoaded", function() {
	var tabs = document.querySelectorAll(".tab");

	// Function to show all content
	function showAllContent() {
		document.querySelectorAll(".tab-content").forEach(function(content) {
			content.classList.add("active");
		});
	}

	// Check if "All Items" is the default active tab and show all content
	const allItemsTab = document.querySelector(".tab.active");
	if (allItemsTab && allItemsTab.getAttribute("href") === "#all") {
		showAllContent();
	}

	tabs.forEach(function(tab) {
		tab.addEventListener("click", function(event) {
			event.preventDefault();

			// Remove active class from all tabs and hide all tab contents
			tabs.forEach(function(otherTab) {
				otherTab.classList.remove("active");
			});
			document.querySelectorAll(".tab-content").forEach(function(content) {
				content.classList.remove("active");
			});

			// Add active class to the clicked tab
			tab.classList.add("active");

			if (tab.getAttribute("href") === "#all") {
				// Show all content for "All Items"
				showAllContent();
			} else {
				// Show only the content that corresponds to the clicked tab
				var activeTabContent = document.querySelector(tab.getAttribute("href"));
				if (activeTabContent) {
					activeTabContent.classList.add("active");
				}
			}
		});
	});
});


