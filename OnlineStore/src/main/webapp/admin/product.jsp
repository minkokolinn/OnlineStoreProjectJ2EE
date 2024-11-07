<%@page import="models.Product"%>
<%@page import="java.util.List"%>
<%@page import="daos.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="product" name="active" />
</jsp:include>


<div class="container-fluid mt-3 p-4">
	<!-- Content -->

	<div class="row flex-column flex-lg-row">
		<h5
			class="alert alert-primary d-flex justify-content-between align-item-center">
			<span class="d-flex align-items-center">Product List</span>
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
						<th>Image</th>
						<th>Name</th>
						<th>Brand</th>
						<th>Model</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Like</th>
						<th>Category</th>
					</tr>
				</thead>
				<tbody id="mySearchTable">
					<%
					ProductDao dao = new ProductDao();
					List<Product> productList=dao.getAllProducts();					
					if (productList.size() > 0) {
						int count = 0;
						for (Product product : productList) {
							count++;
					%>
					<tr>
						<td>
							<form action="productdelete" method="POST" class="d-inline">
								<input type="hidden" value="<%=product.getId()%>"
									name="useridtodel">
								<button type="submit" class="btn btn-danger">
									<i class="fas fa-trash"></i>
								</button>
							</form>
							<a href="productupdate?pidtoupd=<%=product.getId() %>" class="btn btn-warning"><i class="fas fa-edit"></i></a>
						</td>
						<td><%=count %></td>
						<td>
							<% if(!product.getImage().equals("")){ %>
								<img alt="" src="<%="../productImg/"+product.getImage() %>" width="50px" height="50px">
							<% } %>
						</td>
						<td><%=product.getName() %></td>
						<td><%=product.getBrand() %></td>
						<td><%=product.getModel() %></td>
						<td><%=product.getPrice() %> MMK</td>
						<td><%=product.getQuantity() %></td>
						<td><%=product.getLikecount() %></td>
						<td><%=product.getCategory().getCategory() %></td>
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

<jsp:include page="footer.jsp"></jsp:include>