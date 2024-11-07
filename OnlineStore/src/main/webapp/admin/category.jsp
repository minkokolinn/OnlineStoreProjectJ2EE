<%@page import="daos.CategoryDao"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="header.jsp">
	<jsp:param value="category" name="active" />
</jsp:include>


<div class="container-fluid mt-3 p-4">
	<!-- Content -->

	<div class="row flex-column flex-lg-row">
		<h5
			class="alert alert-primary d-flex justify-content-between align-item-center">
			<span class="d-flex align-items-center">Category Management</span>
			<button class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#addCategory">NEW CATEGORY</button>
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
			
			<input type="text" id="mySearchBox" class="form-control" placeholder="Search something...">
		</div>
	</div>
	<div class="row flex-column flex-lg-row mt-3">
		<div class="table-responsive mx-0 px-0">
			<table class="table table-striped">
				<thead class="bg-secondary text-white">
					<tr>
						<th>Action</th>
						<th scope="col">No</th>
						<th>Category</th>
						<th>Description</th>
					</tr>
				</thead>
				<tbody id="mySearchTable">
					<%
					List<Category> list = new CategoryDao().getAllCategories();
					if (list.size() > 0) {
						int count = 0;
						for (Category category : list) {
							count++;
					%>
					<tr>
						<td>
							<form action="categorydelete" method="POST">
								<input type="hidden" value="<%=category.getId()%>"
									name="catidtodel">
								<button type="submit" class="btn btn-danger">
									<i class="fas fa-trash"></i>
								</button>
							</form>
						</td>
						<th scope="row"><%=count%></th>
						<td><%=category.getCategory()%></td>
						<td><p
								style="width: 200px; overflow: hidden; text-overflow: ellipsis; line-clamp: 1; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical;"><%=category.getDescription()%></p></td>
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
<div class="modal fade" id="addCategory" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="staticBackdropLabel">Create New
					Category</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form action="category" method="POST" id="categoryAddForm">
					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="floatingInput"
							placeholder="e.g Smartphone" name="tb_category"
							autocomplete="off" required> <label for="floatingInput">Category</label>
					</div>
					<div class="form-floating mb-3">
						<textarea class="form-control" placeholder="Description"
							id="floatingTextarea" name="tb_description"
							style="height: 300px;" autocomplete="off"></textarea>
						<label for="floatingTextarea">Description</label>
					</div>
					<div class="mb-3 d-flex justify-content-end">
						<button type="submit" class="btn btn-primary">SAVE</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<jsp:include page="footer.jsp"></jsp:include>