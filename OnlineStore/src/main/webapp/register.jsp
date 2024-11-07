<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="Register" name="pageTitle" />
	<jsp:param value="register" name="pageName" />
</jsp:include>
<!-- inner page section -->
<section class="inner_page_head">
	<div class="container_fuild">
		<div class="row">
			<div class="col-md-12">
				<div class="full">
					<h3>Register</h3>
				</div>
			</div>
		</div>
	</div>
</section>

<%
if (request.getAttribute("error") != null) {
%>
<div class="alert alert-danger mx-5 my-3"><%=request.getAttribute("error") %></div>
<%
}
%>

<%
if (request.getAttribute("success") != null) {
%>
<div class="alert alert-success mx-5 my-3"><%=request.getAttribute("success") %></div>
<%
}
%>


<div class="container-fluid my-5">
	<div class="row d-flex justify-content-center my-5">
		<div class="col-md-6 col-sm-12 my-5">
			<div class="card">
				<div class="card-header text-center">
					<h3>Sign Up A New Account</h3>
				</div>
				<div class="card-body">
					<form action="register" method="POST">
						<div class="form-group">
							<label for="nameInput">Name</label> <input type="text"
								class="form-control" id="nameInput" placeholder="Name"
								autocomplete="off" name="tfName" required>
						</div>
						<div class="form-group">
							<label for="emailInput">Email</label> <input type="email"
								class="form-control" id="emailInput" placeholder="Email"
								autocomplete="off" name="tfEmail" required>
						</div>
						<div class="form-group">
							<label for="passwordInput">Password</label> <input
								type="password" class="form-control" id="passwordInput"
								placeholder="Password" autocomplete="off" name="tfPassword"
								required>
						</div>
						<div class="form-group">
							<label for="confirmPasswordInput">Confirm Password</label> <input
								type="password" class="form-control" id="confirmPasswordInput"
								placeholder="Confirm Password" autocomplete="off"
								name="tfConfirmPassword" required>
						</div>
						<div class="form-group">
							<label for="nrcInput">NRC</label> <input type="text"
								class="form-control" id="nrcInput" placeholder="NRC"
								autocomplete="off" name="tfNrc">
						</div>
						<div class="form-group">
							<label for="phoneInput">Phone</label> <input type="number"
								class="form-control" id="phoneInput" placeholder="Phone"
								autocomplete="off" name="tfPhone">
						</div>
						<div class="form-group">
							<label for="dobInput">Date of Birth</label> <input type="date"
								class="form-control" id="dobInput" placeholder="Date of birth"
								autocomplete="off" name="tfDob">
						</div>
						<div class="form-group">
							<label for="despInput">Address</label>
							<textarea class="form-control" placeholder="Description"
								id="despInput" style="height: 150px;" autocomplete="off"
								name="tfAddress"></textarea>
						</div>
						<div class="d-flex justify-content-end">
							<button type="submit" class="btn btn-danger">Register</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="footer.jsp"></jsp:include>