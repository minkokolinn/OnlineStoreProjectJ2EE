<%@page import="daos.AccountDao"%>
<%@page import="daos.ProductDao"%>
<%@page import="models.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="header.jsp">
	<jsp:param value="Product" name="pageTitle" />
	<jsp:param value="product" name="pageName" />
</jsp:include>

<style>
.card {
	box-shadow: 4px 4px 8px #999;
}

.product {
	background-color: #eee
}

.brand {
	font-size: 13px
}

.act-price {
	color: red;
	font-weight: 700
}

.dis-price {
	text-decoration: line-through
}

.about {
	font-size: 14px
}

.color {
	margin-bottom: 10px
}

label.radio {
	cursor: pointer
}

label.radio input {
	position: absolute;
	top: 0;
	left: 0;
	visibility: hidden;
	pointer-events: none
}

label.radio span {
	padding: 2px 9px;
	border: 2px solid #ff0000;
	display: inline-block;
	color: #ff0000;
	border-radius: 3px;
	text-transform: uppercase
}

label.radio input:checked+span {
	border-color: #ff0000;
	background-color: #ff0000;
	color: #fff
}

.btn-danger {
	background-color: #ff0000 !important;
	border-color: #ff0000 !important
}

.btn-danger:hover {
	background-color: #da0606 !important;
	border-color: #da0606 !important
}

.btn-danger:focus {
	box-shadow: none
}

.cart i {
	margin-right: 10px
}
</style>

<%
int pidtodetail = Integer.parseInt(request.getParameter("pidtodetail"));
if (new ProductDao().getProductByID(pidtodetail) == null) {
	response.sendRedirect("product");
}

Product product = new ProductDao().getProductByID(pidtodetail);
%>

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
if (request.getAttribute("error") != null) {
%>
<div class="alert alert-danger mx-5 my-3"><%=request.getAttribute("error")%></div>
<%
}
%>

<!-- Section-->
<section class="py-5">

	<div class="container-fluid">
		<div class="row d-flex justify-content-center">
			<div class="col-md-10">
				<div class="card">
					<div class="row">
						<div class="col-md-4 py-5">
							<div class="images p-3">
								<div class="text-center p-4">
									<%
									if (product.getImage().equals("")) {
									%>
									<img id="main-image"
										src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg"
										width="250" />
									<%
									} else {
									%>
									<img id="main-image" src="productImg/<%=product.getImage()%>"
										width="250" />
									<%
									}
									%>

								</div>
							</div>
						</div>
						<div class="col-md-8 py-5">
							<div class="product p-4">
								<div class="d-flex justify-content-between align-items-center">
									<div class="d-flex align-items-center">
										<a href="product"><i class="fa fa-long-arrow-left"></i> <span
											class="ml-1">Back</span></a>
									</div>
									<i class="fa fa-shopping-cart text-muted"></i>
								</div>
								<div class="mt-4 mb-3">
									<span class="text-uppercase text-muted brand"><%=product.getBrand()%></span>
									<h5 class="text-uppercase"><%=product.getName()%></h5>
									<div class="price">
										<div class="act-price"><%=product.getPrice()%>
											MMK
										</div>
										<div>
											Category : <b><%=product.getCategory().getCategory()%></b>
										</div>
										<div style="text-decoration: underline;">
											<%=product.getModel()%>
										</div>
									</div>
								</div>
								<p class="about"><%=product.getDescription()%></p>
								<div class="cart mt-4 align-items-center">
									<% if(new AccountDao().checkUserAuth(request)!=0){ %>
									<div class="">

										<i class="fa fa-heart" aria-hidden="true" id="likeBtn"
											style="font-size: 40px; cursor: pointer; color: grey;"></i> <span
											class="ui basic blue label" id="likeCount"><%=product.getLikecount()%></span>
									</div>
									<% } %>

									<form action="productdetail" method="POST" class="mt-3">
										<input type="hidden" name="pidtocart"
											value="<%=product.getId()%>" id="hiddenPID"> <input
											type="number" name="cartQuantity" class="form-control col-2"
											placeholder="Quantity" min="1"
											max="<%=product.getQuantity()%>" required>
										<button class="btn btn-danger text-uppercase mr-2 px-4">Add
											to cart</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</section>

<script type="text/javascript">
	$(document).ready(function() {
		var btn = document.getElementById("likeBtn");
		$.ajax({
			url: "/OnlineStore/hasbeenliked",
			type: "POST",
			data: {
				status: "sent",
				productId: $("#hiddenPID").val()
			},
			success: function(result){
				if(result==="liked"){
					btn.style.color = "red";
				}
			}
		});
		
		$("#likeBtn").click(function() {
			
			if (btn.style.color == "red") {
				btn.style.color = "grey";
				$.ajax({
					url : "/OnlineStore/likeunlike",
					type : "POST",
					data : {
						status : "sent",
						fntype : "unlike",
						pid : $("#hiddenPID").val()
					},
					success : function(result) {
						$("#likeCount").text(result);
					}
				});
			} else {
				btn.style.color = "red";
				$.ajax({
					url : "/OnlineStore/likeunlike",
					type : "POST",
					data : {
						status : "sent",
						fntype : "like",
						pid : $("#hiddenPID").val()
					},
					success : function(result) {
						$("#likeCount").text(result);
					}
				});
			}

		});
	});
</script>

<jsp:include page="footer.jsp"></jsp:include>