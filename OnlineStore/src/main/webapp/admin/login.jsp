<%@page import="daos.AccountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<link rel="shortcut icon" href="images/favicon.png" type="">

<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
<!-- font awesome style -->
<link href="../css/font-awesome.min.css" rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="../css/style.css" rel="stylesheet" />
<!-- responsive style -->
<link href="../css/responsive.css" rel="stylesheet" />
</head>
<body>

	<!-- inner page section -->
	<section class="inner_page_head">
		<div class="container_fuild">
			<div class="row">
				<div class="col-md-12">
					<div class="full">
						<h3>Administration</h3>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%
	if (request.getAttribute("error") != null) {
	%>
	<div class="alert alert-danger mx-5 my-3">
		<%=request.getAttribute("error")%>
	</div>
	<%
	}
	%>
	<%
	if (request.getAttribute("success") != null) {
	%>
	<div class="alert alert-success mx-5 my-3">
		<%=request.getAttribute("success")%>
	</div>
	<%
	}
	%>


	<div class="container-fluid my-5">
		<div class="row d-flex justify-content-center my-5">
			<div class="col-md-6 col-sm-12 my-5">
				<div class="card">
					<div class="card-header text-center">
						<h3>Admin Login</h3>
					</div>
					<div class="card-body">
						<form action="login" method="POST">
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" class="form-control" name="emailInput"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email" autocomplete="off" required>
								<small id="emailHelp" class="form-text text-muted">Request
									admin team to get admin account</small>
							</div>
							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									type="password" class="form-control" name="passwordInput"
									id="exampleInputPassword1" placeholder="Password"
									autocomplete="off" required>
							</div>
							<div class="d-flex justify-content-end">
								<button type="submit" class="btn btn-danger">Login</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- jQery -->
	<script src="../js/jquery-3.4.1.min.js"></script>
	<!-- popper js -->
	<script src="../js/popper.min.js"></script>
	<!-- bootstrap js -->
	<script src="../js/bootstrap.js"></script>
	<!-- custom js -->
	<script src="../js/custom.js"></script>
</body>
</html>