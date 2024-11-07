<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="Login" name="pageTitle"/>
	<jsp:param value="login" name="pageName"/>
</jsp:include>
<!-- inner page section -->
<section class="inner_page_head">
	<div class="container_fuild">
		<div class="row">
			<div class="col-md-12">
				<div class="full">
					<h3>Login</h3>
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

<div class="container-fluid my-5">
	<div class="row d-flex justify-content-center my-5">
	<div class="col-md-6 col-sm-12 my-5">
		<div class="card">
		  <div class="card-header text-center">
		    <h3>Sign In With Your Account</h3>
		  </div>
		  <div class="card-body">
		    <form action="login" method="POST">
				<div class="form-group">
				   <label for="exampleInputEmail1">Email address</label>
				    <input type="email" class="form-control" name="emailInput" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" autocomplete="off" required>
				    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
				</div>
				<div class="form-group">
				    <label for="exampleInputPassword1">Password</label>
				    <input type="password" class="form-control" name="passwordInput" id="exampleInputPassword1" placeholder="Password" autocomplete="off" required>
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

<jsp:include page="footer.jsp"></jsp:include>