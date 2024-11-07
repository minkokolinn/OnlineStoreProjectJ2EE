<%@page import="models.CartRow"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="header.jsp">
	<jsp:param value="Product" name="pageTitle" />
	<jsp:param value="product" name="pageName" />
</jsp:include>

<style>
.title {
	margin-bottom: 5vh
}

.card {
	margin: auto;
	box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	border-radius: 1rem;
	border: transparent
}

@media ( max-width :767px) {
	.card {
		margin: 3vh auto
	}
}

.cart {
	background-color: #fff;
	padding: 4vh 5vh;
	border-bottom-left-radius: 1rem;
	border-top-left-radius: 1rem
}

@media ( max-width :767px) {
	.cart {
		padding: 4vh;
		border-bottom-left-radius: unset;
		border-top-right-radius: 1rem
	}
}

.summary {
	background-color: #ddd;
	border-top-right-radius: 1rem;
	border-bottom-right-radius: 1rem;
	padding: 4vh;
	color: rgb(65, 65, 65);
}

@media ( max-width :767px) {
	.summary {
		border-top-right-radius: unset;
		border-bottom-left-radius: 1rem
	}
}

.summary .col-2 {
	padding: 0
}

.summary .col-10 {
	padding: 0
}

.row {
	margin: 0
}

.title b {
	font-size: 1.5rem
}

.main {
	margin: 0;
	padding: 2vh 0;
	width: 100%
}

.col-2, .col {
	padding: 0 1vh
}

a {
	padding: 0 1vh
}

.close {
	margin-left: auto;
	font-size: 0.7rem
}

.back-to-shop {
	margin-top: 4.5rem
}

h5 {
	margin-top: 4vh
}

hr {
	margin-top: 1.25rem
}



select {
	border: 1px solid rgba(0, 0, 0, 0.137);
	padding: 1.5vh 1vh;
	margin-bottom: 4vh;
	outline: none;
	width: 100%;
	background-color: rgb(247, 247, 247)
}

input {
	border: 1px solid rgba(0, 0, 0, 0.137);
	padding: 1vh;
	margin-bottom: 4vh;
	outline: none;
	width: 100%;
	background-color: rgb(247, 247, 247)
}

input:focus::-webkit-input-placeholder {
	color: transparent
}



#code {
	background-image: linear-gradient(to left, rgba(255, 255, 255, 0.253),
		rgba(255, 255, 255, 0.185)),
		url("https://img.icons8.com/small/16/000000/long-arrow-right.png");
	background-repeat: no-repeat;
	background-position-x: 95%;
	background-position-y: center
}

.progresses {
	position: relative;
	max-width: 70%;
	margin: auto;
}

.progresses ul {
	list-style: none;
	/* border: 1px solid red; */
	padding: 0;
}

.progresses ul li {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	background-color: #f0f0f0;
	z-index: 200;
	position: relative;
}

.progresses ul li.blue {
	color: #007BFF;
	background-color: #007BFF;
}

.progresses ul li::after {
	position: absolute;
	top: 35px;
	left: -15px;
	font-size: 0.8rem;
	width: 90px;
}

#step-1::after {
	content: "Product";
	font-weight: bold;
	font-size: 26px;
	color: white;
}

#step-2::after {
	content: "Cart";
	font-weight: bold;
	font-size: 26px;
	color: white;
	left: -20px;
}

#step-3::after {
	content: "Checkout";
	font-weight: bold;
	font-size: 26px;
	color: white;
}

.progresses .progress {
	height: 0.8rem;
	width: 100%;
	top: 33px;
	position: absolute;
	background-color: #f0f0f0;
	border-radius: 10px;
}
</style>

<script>
    $(document).ready(function() {
        $('#deliBox').change(function() {
            let totalIncluding = 0;
            let totalItemCount = parseInt($('#totalOfSub').html());
            if ($('#deliBox').val() == "standard") {
                totalIncluding = totalItemCount + 1500;
            } else if ($('#deliBox').val() == "faster") {
                totalIncluding = totalItemCount + 4000;
            } else {
                totalIncluding = totalItemCount;
            }
            $('#totalShowAll').html(totalIncluding + " MMK");
            $('#hiddenTotal').val(totalIncluding);
            
        });
    });
</script>

<%
	if(request.getParameter("cardrowidtodel")!=null){
		int idtodel = Integer.parseInt(request.getParameter("cardrowidtodel"));
		List<CartRow> cartRow = (List<CartRow>)session.getAttribute("cart");
		cartRow.remove(idtodel);
		session.setAttribute("cart", cartRow);
		response.sendRedirect("cart");
	}
%>

<!-- inner page section -->
<section class="inner_page_head">
	<div class="container_fuild">
		<div class="row">
			<div class="col-md-12">
				<div class="full">
					<h3>Shopping Cart</h3>
					<div class="progresses py-4">
						<ul class="d-flex align-items-center justify-content-between">
							<li id="step-1" class="blue"></li>
							<li id="step-2"></li>
							<li id="step-3"></li>
						</ul>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 50%;"
								aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Section-->
<section class="">

	<div class="container-fluid">
		<div class="row">
			<div class="card col-9 my-5 px-0">
				<div class="row">
					<div class="col-md-8 cart">
						<div class="title">
							<div class="row">
								<div class="col">
									<h4>
										<b>Shopping Cart</b>
									</h4>
								</div>
								
							</div>
						</div>

						<div class='row border-top border-bottom'>
							<%
							int total = 0;
							int index=0;
							if (session.getAttribute("cart") != null) {
								List<CartRow> cartInfo = (List<CartRow>) session.getAttribute("cart");
								for (CartRow cartRow : cartInfo) {
									total+=cartRow.getCart_subtotal();
							%>
							<div class='row main align-items-center'>
								<div class='col-2'>
									<img class='img-fluid' id='cartImg' src='productImg/<%=cartRow.getProduct().getImage() %>'>
								</div>
								<div class='col'>
									<div class='row text-muted'><%=cartRow.getProduct().getName() %></div>
									<div class='row'><%=cartRow.getProduct().getModel() %></div>
								</div>
								<div class='col' style='text-align: center;'><%=cartRow.getProduct().getPrice() %> MMK</div>
								<div class='col'><%=cartRow.getCart_quantity() %></div>
								<div class='col'>
									<%=cartRow.getCart_subtotal() %> MMK <a href='cart?cardrowidtodel=<%=index %>'><span
										class='close'>&#10005;</span></a>
								</div>
							</div>
							<%
							index++;
							}
							}
							%>
						</div>

						<div class='back-to-shop'>
							<a href='product'>&leftarrow;</a><span class='text-muted'>Back
								to shop</span>
						</div>
					</div>
					<div class="col-md-4 summary">
						<div>
							<h5>
								<b>Summary</b>
							</h5>
						</div>
						<hr>
						<div class="row">
							<div class="col" style="padding-left: 0;">
								ITEMS - 
								<%=index %>
							</div>
							<div class="col text-right">
								<span id="totalOfSub"> <%=total %>
								</span> MMK
							</div>
						</div>
						<form method="get" action="checkout" class="mt-5">
							<p>SHIPPING</p>
							<select id="deliBox" name="shippingMethod" required>
								<option class="text-muted" value="">Choose Shipping
									Method</option>
								<option class="" value="standard">Standard-Delivery
									- (+1500 MMK) within 1 week</option>
								<option class="" value="faster">Faster-Delivery
									- (+4000 MMK) within 2 or 3 days</option>
							</select>
							<input type="hidden" id="hiddenTotal" name="hiddenTotal">

							<div class="row"
								style="border-top: 1px solid rgba(0, 0, 0, .1); padding: 2vh 0;">
								<div class="col">TOTAL PRICE</div>
								<div class="col text-right" id="totalShowAll"></div>

							</div>
							<div class="row">
								<div class="col">
									<a href="clearsessioncart" class="btn"
										style="background-color: brown; border-color: brown;">CANCEL
										CART</a>
								</div>
								<div class="col">
									<button type="submit" class="btn"
										style="background-color: #17A2B8; border-color: #17A2B8;">CHECKOUT</button>
								</div>
							</div>

						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

</section>

<jsp:include page="footer.jsp"></jsp:include>

