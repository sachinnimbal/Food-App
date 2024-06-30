
<div class="login-signup-info">
	<div class="left-section">
		<h3 class="header-title">Account</h3>
		<p class="description">To place your order now, log in to your
			existing account or sign up.</p>
		<div class="buttons" id="buttonsContainer">
			<div class="login-button" onclick="showLoginForm()">
				<div>Have an account ?</div>
				<div>LOGIN</div>
			</div>
			<div class="signup-button" onclick="showRegisterForm()">
				<div>New to Foodie ?</div>
				<div>SIGN UP</div>
			</div>
		</div>
		<div class="authSection hidden">
			<div id="loginFormMain" class="form-container">
				<form action="AuthServlet" method="POST">
					<div class="login-container">
						<div class="left-side">
							<h2>Login</h2>
							<span>or <a href="#" id="showRegisterFormMain">create
									an account</a></span>
						</div>
					</div>
					<div class="floating-label">
						<input type="text" name="username" class="floating-input"
							placeholder=" " required> <label>Username</label> <span
							class="highlight"></span>
					</div>
					<div class="floating-label">
						<input type="password" name="password" class="floating-input"
							placeholder=" " required> <label>Password</label> <span
							class="highlight"></span>
					</div>
					<button type="submit" class="login-btn">Login</button>
				</form>
			</div>

			<div id="registerFormMain" class="form-container hidden">
				<form method="POST" action="RegisterServlet">
					<div class="register-container">
						<div class="left-side">
							<h2>Sign up</h2>
							<span>or <a href="#" id="showLoginFormMain">login to
									your account</a></span>
						</div>
					</div>
					<div class="floating-label">
						<input type="text" class="floating-input" placeholder=" "
							name="fullname" required> <label>Full Name</label> <span
							class="highlight"></span>
					</div>
					<div class="floating-label">
						<input type="text" class="floating-input" placeholder=" "
							name="mobile" maxlength="10" required> <label>Mobile Number</label> <span
							class="highlight"></span>
					</div>
					<div class="floating-label">
						<input type="text" class="floating-input" placeholder=" "
							name="username" maxlength="12" required> <label>Username</label> <span
							class="highlight"></span>
					</div>
					<div class="floating-label">
						<input type="password" class="floating-input" placeholder=" "
							name="password" required> <label>Password</label> <span
							class="highlight"></span>
					</div>
					<button type="submit" class="register-btn">Register</button>
				</form>
			</div>
		</div>
	</div>
	<img class="form-img" src="assets/images/icon.png" alt="">

</div>

<script>
	function showLoginForm() {
		document.getElementById("loginFormMain").classList.remove("hidden");
		document.getElementById("registerFormMain").classList.add("hidden");
		document.getElementById("buttonsContainer").classList.add("hidden");
		document.querySelector(".authSection").classList.remove("hidden");
	}

	function showRegisterForm() {
		document.getElementById("loginFormMain").classList.add("hidden");
		document.getElementById("registerFormMain").classList.remove("hidden");
		document.getElementById("buttonsContainer").classList.add("hidden");
		document.querySelector(".authSection").classList.remove("hidden");
	}
</script>