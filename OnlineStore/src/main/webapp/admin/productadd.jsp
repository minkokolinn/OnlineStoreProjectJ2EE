<%@page import="daos.CategoryDao"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@page import="daos.AccountDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="header.jsp">
	<jsp:param value="productadd" name="active" />
</jsp:include>


<div class="container-fluid mt-3 p-4">
	<!-- Content -->

	<div class="row flex-column flex-lg-row">
		<h5
			class="alert alert-primary d-flex justify-content-between align-item-center">
			<span class="d-flex align-items-center">Create a new product</span>
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

	<%
	if (request.getAttribute("success") != null) {
	%>
	<div class="row flex-column flex-lg-row">
		<div class="alert alert-success mx-0"><%=request.getAttribute("success")%></div>
	</div>
	<%
	}
	%>

	<div class="row flex-column flex-lg-row">
		<div class="accountupdate">
			<div class="card-body">
				<form action="productadd" method="POST"
					enctype="multipart/form-data">
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="nameInput"
							placeholder="Name" autocomplete="off" name="tfName" required>
						<label for="nameInput">Name</label>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="nameInput"
							placeholder="Brand" autocomplete="off" name="tfBrand" required>
						<label for="nameInput">Brand</label>
					</div>
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="nameInput"
							placeholder="Model" autocomplete="off" name="tfModel" required>
						<label for="nameInput">Model</label>
					</div>
					<div class="form-floating mb-3">
						<textarea class="form-control" placeholder="Description"
							id="despInput" style="height: 150px;" autocomplete="off"
							name="tfDescription" required></textarea>
						<label for="despInput">Description</label>
					</div>
					<div class="form-floating mb-3">
						<div class="input-group mb-3">
							<input type="number" class="form-control" placeholder="Price"
								autocomplete="off" name="tfPrice" required> <span
								class="input-group-text" id="despInput">MMK</span>
						</div>
					</div>
					<div class="form-floating mb-3">
						<input type="number" class="form-control" id="nameInput"
							placeholder="Quantity" autocomplete="off" name="tfQuantity"
							required min="1"> <label for="nameInput">Quantity</label>
					</div>
					<div class="mb-3">
						<label for="nameInput" class="form-text">Image</label> <input
							type="file" class="form-control" id="nameInput"
							placeholder="Image" autocomplete="off" name="fileImage">
					</div>
					<div class="mb-3">
						<label class="form-text"></label> <select class="form-select"
							name="cboCategory" required>
							<option value="">No Option Selected</option>
							<%
							List<Category> categories = new CategoryDao().getAllCategories();
							for (Category category : categories) {
								out.print("<option value=" + category.getId() + ">" + category.getCategory() + "</option>");
							}
							%>
						</select>
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