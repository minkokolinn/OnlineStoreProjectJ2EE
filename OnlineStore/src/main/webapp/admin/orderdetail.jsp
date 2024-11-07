<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Set"%>
<%@page import="models.OrderDetail"%>
<%@page import="java.util.List"%>
<%@page import="daos.OrderDao"%>
<%@page import="models.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="order" name="active" />
</jsp:include>


<div class="container-fluid mt-3 p-4">
	<!-- Content -->
	<a class="btn btn-secondary" href="order">Back</a>

	<%
	if (request.getParameter("view") == null || request.getParameter("view").equals("")) {	
		response.sendRedirect("order");
	}
	Order order = new OrderDao().getOrderByID(Integer.parseInt(request.getParameter("view")));
	if(order==null){
		response.sendRedirect("order");
	}
	%>

	<%
		if(order!=null){
	%>
	<div class="row flex-column flex-lg-row mt-3">
		<div class="container">
			<div class="row">
				<div class="col-6 mx-auto">
					<div class="card">
						<div class="card-header">
							<h2 class="d-flex justify-content-between">Order Detail <%=order.isIsdelivered()?"<span class='text-success'>Delivered</span>":"<span class='text-danger'>In Progress</span>" %></h2>
						</div>
						<div class="card-body">
							<table class="table">
								<tr>
									<td><b>Order Number</b></td>
									<td><b><u><%=order.getOrdernumber() %></u></b></td>
								</tr>
								<tr>
									<td><b>Order Date</b></td>
									<td><%=new SimpleDateFormat("dd-MM-yyyy").format(order.getOrderdate()) %></td>
								</tr>
								<tr>
									<td><b>Payment Type</b></td>
									<td><%=order.getPaymenttype() %></td>
								</tr>
								<tr>
									<td><b>Total</b></td>
									<td><b><u><%=order.getTotal() %> MMK</u></b></td>
								</tr>
								<tr>
									<td><b>Delivery Type</b></td>
									<td><%=order.getDeliverytype() %></td>
								</tr>
								<tr>
									<td><b>Merchant</b></td>
									<td><%=order.getMerchant()==null?"":order.getMerchant() %></td>
								</tr>
								<tr>
									<td><b>Card No</b></td>
									<td><%=order.getCardno() %></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="card my-3">
						<div class="card-header">
							<h2>Contact Detail</h2>
						</div>
						<div class="card-body">
							<table class="table">
								<tr>
									<td><b>Customer Name</b></td>
									<td><b><u><%=order.getUser().getName() %></u></b></td>
								</tr>
								<tr>
									<td><b>Email</b></td>
									<td><%=order.getUser().getEmail() %></td>
								</tr>
								<tr>
									<td><b>Phone</b></td>
									<td><%=order.getUser().getPhone() %></td>
								</tr>
								<tr>
									<td><b>Address</b></td>
									<td><%=order.getUser().getAddress() %></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="table-responsive mx-0 px-0">
			<table class="table table-striped">
				<thead class="bg-secondary text-white">
					<tr>
						<th scope="col">No</th>
						<th>Product</th>
						<th>Unit Price</th>
						<th>Quantity</th>
						<th>Sub Total</th>
					</tr>
				</thead>
				<tbody>
					<%
						Set<OrderDetail> odList = order.getOrderDetails();
						int count=0;
						for(OrderDetail od : odList){
							count++;
							out.print("<tr>");
							out.print("<td>"+count+"</td>");
							out.print("<td>"+od.getProduct().getName()+"</td>");
							out.print("<td>"+od.getProduct().getPrice()+" MMK</td>");
							out.print("<td>"+od.getQuantity()+"</td>");
							out.print("<td>"+od.getPrice()+" MMK</td>");
							out.print("</tr>");
						}
					%>
				</tbody>
			</table>
		</div>
		<% } %>
	</div>

</div>
<!-- Content -->



<jsp:include page="footer.jsp"></jsp:include>