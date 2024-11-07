<%@page import="java.text.SimpleDateFormat"%>
<%@page import="daos.AccountDao"%>
<%@page import="models.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="account" name="active" />
</jsp:include>


<div class="container-fluid mt-3 p-4">
	<!-- Content -->

	<div class="row flex-column flex-lg-row">
		<h5
			class="alert alert-primary d-flex justify-content-between align-item-center">
			<span class="d-flex align-items-center">Account Management</span>
			<button class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#addAccount">NEW Account</button>
		</h5>
	</div>

	<%
	if (request.getAttribute("error") != null) {
	%>
	<div class="row flex-column flex-lg-row">
		<div class="alert alert-danger mx-0"><%=request.getAttribute("error")%></div>
	</div>
	<%
	}
	%>

	<div class="row d-flex justify-content-end">
		<div class="col-3">

			<input type="text" id="mySearchBox" class="form-control"
				placeholder="Search something...">
		</div>
	</div>
	<div class="row flex-column flex-lg-row mt-3">
		<div class="table-responsive mx-0 px-0">
			<table class="table table-striped">
				<thead class="bg-secondary text-white">
					<tr>
						<th>Action</th>
						<th scope="col">No</th>
						<th>Name</th>
						<th>Email</th>
						<th>NRC</th>
						<th>Phone</th>
						<th>DOB</th>
						<th>Address</th>
						<th>Admin</th>
					</tr>
				</thead>
				<tbody id="mySearchTable">
					<%
					AccountDao dao = new AccountDao();
					List<User> list = dao.getAllUsers();
					if (list.size() > 0) {
						int count = 0;
						for (User user : list) {
							count++;
					%>
					<tr>
						<td>
							<form action="accountdelete" method="POST" class="d-inline">
								<input type="hidden" value="<%=user.getId()%>"
									name="useridtodel">
								<button type="submit" class="btn btn-danger">
									<i class="fas fa-trash"></i>
								</button>
							</form>
							<a href="accountupdateform?accidtoupd=<%=user.getId() %>" class="btn btn-warning"><i class="fas fa-edit"></i></a>
						</td>
						<td><%=count %></td>
						<td><%=user.getName() %></td>
						<td><%=user.getEmail() %></td>
						<td><%=user.getNrc() %></td>
						<td><%=user.getPhone() %></td>
						<td>
							<%
								if(user.getDob()==null){
									out.print("");
								}else{
									out.print(new SimpleDateFormat("dd-MM-yyyy").format(user.getDob()));
								}
							%>
						</td>
						<td><p
								style="width: 200px; overflow: hidden; text-overflow: ellipsis; line-clamp: 1; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical;"><%=user.getAddress() %></p></td>
						<%
							if(user.isIsadmin()){
						%>
						<td><div class="bg-success rounded-circle" style="width:20px; height:20px"></div></td>
						<%
							}else{
						%>
						<td></td>
						<% } %>
					</tr>
					<%
					}
					}
					%>

				</tbody>
			</table>
		</div>
	</div>

</div>
<!-- Content -->

<!-- Modal -->
<div class="modal fade" id="addAccount" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">Create New
					Account</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form action="account" method="POST">
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="nameInput"
							placeholder="Name" autocomplete="off" name="tfName" required>
						<label for="nameInput">Name</label>
					</div>
					<div class="form-floating mb-3">
						<input type="email" class="form-control" id="emailInput"
							placeholder="Email" autocomplete="off" name="tfEmail" required>
						<label for="emailInput">Email</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="passwordInput"
							placeholder="Password" autocomplete="off" name="tfPassword"
							required> <label for="passwordInput">Password</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control"
							id="confirmPasswordInput" placeholder="Confirm Password"
							autocomplete="off" name="tfConfirmPassword" required> <label
							for="confirmPasswordInput">Confirm Password</label>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="nrcInput"
							placeholder="NRC" autocomplete="off" name="tfNrc"> <label
							for="nrcInput">NRC</label>
					</div>
					<div class="form-floating mb-3">
						<input type="number" class="form-control" id="phoneInput"
							placeholder="NRC" autocomplete="off" name="tfPhone"> <label
							for="phoneInput">Phone</label>
					</div>
					<div class="form-floating mb-3">
						<input type="date" class="form-control" id="dobInput"
							placeholder="Date of birth" autocomplete="off" name="tfDob">
						<label for="dobInput">Date of Birth</label>
					</div>
					<div class="form-floating mb-3">
						<textarea class="form-control" placeholder="Description"
							id="despInput" style="height: 150px;" autocomplete="off"
							name="tfAddress"></textarea>
						<label for="despInput">Address</label>
					</div>

					<div class="form-floating mb-3">

						<div class="form-check">
							<input class="form-check-input" type="checkbox"
								id="flexCheckDefault" name="cboAdmin"> <label
								class="form-check-label" for="flexCheckDefault"> Admin
								account </label>
						</div>
					</div>

					<div class="mb-3 d-flex justify-content-end">
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>



<jsp:include page="footer.jsp"></jsp:include>