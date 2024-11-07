<%@page import="daos.AccountDao"%>
<%@page import="models.User"%>
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

<script type="text/javascript">
$(document).ready(function() {
    $('#paymentType').change(function() {
        if ($('#paymentType').val() == "cash") {
        	$("#bankInfo").removeAttr("required");
        	$("#cardNo").removeAttr("required");
        	$("#bankInfo").attr("disabled","");
        	$("#cardNo").attr("readonly","");
        }else{
        	$("#bankInfo").attr("required","");
        	$("#cardNo").attr("required","");
        	$("#bankInfo").removeAttr("disabled");
        	$("#cardNo").removeAttr("readonly");
        }
    });
});
</script>

<!-- inner page section -->
<section class="inner_page_head">
	<div class="container_fuild">
		<div class="row">
			<div class="col-md-12">
				<div class="full">
					<h3>Checkout</h3>
					<div class="progresses py-4">
						<ul class="d-flex align-items-center justify-content-between">
							<li id="step-1" class="blue"></li>
							<li id="step-2" class="blue"></li>
							<li id="step-3"></li>
						</ul>
						<div class="progress">
							<div class="progress-bar" role="progressbar" style="width: 100%;"
								aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
						</div>
					</div>
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

<!-- Section-->
<section class="">

	<div class="container-fluid">
		<form action="checkout" method="POST">
			<div class="row">
				<div class="card col-9 my-5 px-0">

					<div class="row">

						<div class="col-md-8 cart">
							<div class="title">
								<div class="row">
									<div class="col">
										<h4>
											<b>Checkout</b>
										</h4>
									</div>
								</div>
							</div>

							<div class='row border-top border-bottom'>
							<% User user = new AccountDao().getUserByID(new AccountDao().checkUserAuth(request)); %>
								<div class="col">
									<div class="form-group">
										<label for="name">Name</label> <input type="text"
											class="form-control" id="exampleInputEmail1"
											aria-describedby="emailHelp" value="<%=user.getName() %>" readonly required>
									</div>
									<div class="form-group">
										<label for="name">Email</label> <input type="email"
											class="form-control" id="exampleInputEmail1"
											aria-describedby="emailHelp" value="<%=user.getEmail() %>" readonly required>
									</div>
									<div class="form-group">
										<label for="name">Phone</label> <input type="number"
											class="form-control" id="exampleInputEmail1" name="contactPhone"
											aria-describedby="emailHelp" value="<%=user.getPhone() %>" required>
									</div>
									<div class="form-group">
										<label for="exampleFormControlTextarea1">Address</label>
										<textarea class="form-control" name="contactAddress"
											id="exampleFormControlTextarea1" rows="3" required><%=user.getAddress() %></textarea>
									</div>
								</div>
							</div>

							<div class='back-to-shop'>
								<a href='cart'>&leftarrow;</a><span class='text-muted'>Back
									to cart</span>
							</div>
						</div>
						<div class="col-md-4 summary">
							<div>
								<h5>
									<b>Billing Info</b>
								</h5>
							</div>
							<hr>
							<p>Payment Type</p>
							<select id="paymentType" name="paymentType" required>
								<option class="text-muted" value="">Choose Payment Type</option>
								<option value="cash">Cash On Delivery</option>
								<option value="bank">Online Payment</option>
							</select>

							<p>Bank</p>
							<select id="bankInfo" name="bankInfo" required>
								<option class="text-muted" value="">Choose Bank</option>
								<option value="KBZ Bank">KBZ Bank</option>
								<option value="AYA Bank">AYA Bank</option>
								<option value="CB Bank">CB Bank</option>
								<option value="UAB Bank">UAB Bank</option>
								<option value="AGD Bank">AGD Bank</option>
							</select>
							
							<p>Card No</p>
							<input type="text" class="form-control" id="cardNo" name="cardNo" autocomplete="off" required>

							<div class="row"
								style="border-top: 1px solid rgba(0, 0, 0, .1); padding: 2vh 0;">
								<div class="col">TOTAL PRICE</div>
								<div class="col text-right" id="totalShow"><%=request.getParameter("hiddenTotal") %> MMK</div>
								<input type="hidden" id="hiddenTotal" name="hiddenTotal" value="<%=request.getParameter("hiddenTotal") %>" required>
								<input type="hidden" id="shippingMethod" name="shippingMethod" value="<%=request.getParameter("shippingMethod") %>" required>
							</div>
							<div class="row">
								<div class="col">
									<button type="submit" class="btn"
										style="background-color: #17A2B8; border-color: #17A2B8;">FINISH</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

</section>
<jsp:include page="footer.jsp"></jsp:include>

