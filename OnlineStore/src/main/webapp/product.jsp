<%@page import="java.util.ArrayList"%>
<%@page import="daos.ProductDao"%>
<%@page import="models.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="Product" name="pageTitle" />
	<jsp:param value="product" name="pageName" />
</jsp:include>

<!-- inner page section -->
<section class="inner_page_head">
	<div class="container_fuild">
		<div class="row">
			<div class="col-md-12">
				<div class="full">
					<h3>Our Products</h3>
				</div>
			</div>
		</div>
	</div>
</section>

<%
List<Product> list = null;
if (request.getParameter("selectedCat") != null) {
	String[] catArr = request.getParameterValues("selectedCat");
	List<Integer> newArr = new ArrayList<>();
	for (String cat : catArr) {
		int id = Integer.parseInt(cat);
		newArr.add(id);
	}

	list = new ProductDao().getProductsFilter(newArr);
} else {
	list = new ProductDao().getAllProducts();
}
%>

<!-- Section-->
<section class="py-5">
	<div class="container px-4 px-lg-5 mt-5">
		<div
			class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<%
			if (list == null || list.size()==0) {
				out.print("<div class='alert alert-secondary'>No Product Found</div>");
			} else {
				if (list.size() > 0) {
					for (Product product : list) {
			%>
			<div class="col-sm-12 col-md-4 mb-5">
				<div class="card h-100">
					<!-- Product image-->
					<%
					if (product.getImage().equals("")) {
					%>
					<img class="card-img-top"
						src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
					<%
					} else {
					%>
					<img class="card-img-top" src="productImg/<%=product.getImage()%>"
						alt="..." />
					<%
					}
					%>
					<!-- Product details-->
					<div class="card-body p-4">
						<div class="text-center">
							<!-- Product name-->
							<h5 class="fw-bolder"><%=product.getName()%></h5>
							<!-- Product price-->
							<%=product.getPrice()%>MMK
						</div>
						<div class="d-flex justify-content-between">
							<p class="text-muted"><%=product.getBrand()%></p>
							<p class="text-muted"><%=product.getModel()%></p>
						</div>
					</div>
					<!-- Product actions-->
					<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
						<div class="text-center">
							<a class="btn btn-outline-danger mt-auto"
								href="productdetail?pidtodetail=<%=product.getId()%>">View
								detail</a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			}
			%>
		</div>
	</div>
</section>

<jsp:include page="footer.jsp"></jsp:include>