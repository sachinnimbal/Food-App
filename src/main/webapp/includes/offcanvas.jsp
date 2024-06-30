<!-- Off Canvas Sign in Section -->
<div class="loginOffcanvas offcanvas-right" tabindex="-1"
	id="loginOffcanvas" aria-labelledby="loginOffcanvasLabel">
	<div class="offcanvas-header">
		<i class="bx bx-x" id="loginCloseOffcanvas"></i>
	</div>

	<div class="offcanvas-content">

		<div id="errorMessage" class="custom-alert" style="display: none;">
			<span class="error-text"></span>
			<button onclick="closeErrorMessage()" class="close-btn">&times;</button>
		</div>

		<div id="loginFormOffcanvas" class="form-container">
			<form action="AuthServlet" method="POST">
				<div class="login-container">
					<div class="left-side">
						<h2>Login</h2>
						<span>or <a href="#" id="showRegisterFormOffcanvas">create
								an account</a></span>
					</div>
					<div class="right-side">
						<img class="form-img" src="assets/images/icon.png" alt="">
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

		<div id="registerFormOffcanvas" class="form-container hidden">
			<form action="RegisterServlet" method="POST">
				<div class="register-container">
					<div class="left-side">
						<h2>Register</h2>
						<span>or <a href="#" id="showLoginFormOffcanvas">login
								to your account</a></span>
					</div>
					<div class="right-side">
						<img class="form-img" src="assets/images/icon.png" alt="">
					</div>
				</div>
				<div class="floating-label">
					<input type="text" class="floating-input" placeholder=" "
						name="fullname" required> <label>Full Name</label> <span
						class="highlight"></span>
				</div>
				<div class="floating-label">
					<input type="text" maxlength="10" class="floating-input" placeholder=" "
						name="mobile" required> <label>Mobile Number</label> <span
						class="highlight"></span>
				</div>
				<div class="floating-label">
					<input type="text" class="floating-input" placeholder=" "
						name="username" required> <label>Username</label> <span
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

<script>
function closeErrorMessage() {
    document.getElementById('errorMessage').style.display = 'none';
}
</script>


