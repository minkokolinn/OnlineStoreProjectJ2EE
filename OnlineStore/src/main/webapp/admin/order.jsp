<%@page import="daos.ProductDao"%>
<%@page import="models.OrderDetail"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="daos.OrderDao"%>
<%@page import="models.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="order" name="active" />
</jsp:include>


<div class="container-fluid mt-3 p-4">
	<!-- Content -->

	<div class="row flex-column flex-lg-row">
		<h5
			class="alert alert-primary d-flex justify-content-between align-item-center">
			<span class="d-flex align-items-center">Order Management</span>
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
	
	<% 
	if(request.getParameter("deliver")!=null){
		int idtodeliver = Integer.parseInt(request.getParameter("deliver"));
		if(new OrderDao().makeDeliver(idtodeliver)){
			Set<OrderDetail> orderDetails = new OrderDao().getOrderByID(idtodeliver).getOrderDetails();
			for(OrderDetail od : orderDetails){
				if (new ProductDao().updateQuantityForOrder(od.getProduct().getId(), od.getQuantity())) {
					System.out.println("Updated quantity");
				}else {
					System.out.println("Failed to update product quantity");
				}
			}
			response.sendRedirect("order");	
		}
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
						<th>Order Number</th>
						<th>Order Date</th>
						<th>Name</th>
						<th>Phone</th>
						<th>Payment</th>
						<th>Total</th>
						<th>Delivery</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody id="mySearchTable">
					<%
					List<Order> list = new OrderDao().getAllOrders();

					if (list.size() > 0) {
						int count = 0;
						for (Order order : list) {
							count++;
					%>
					<tr>
						<td>
							<div style="float:left;" class="me-2">
								<form class="col" action="orderdelete" method="POST">
									<input type="hidden" value="<%=order.getId()%>"
										name="oidtodel">
									<button type="submit" class="btn btn-danger">
										<i class="fas fa-trash"></i>
									</button>
								</form>
							</div>
							<div style="float:left" class="me-2">
								<a class="btn btn-success" href="orderdetail?view=<%=order.getId()%>">
									<i class="fas fa-eye"></i>
								</a>
							</div>
							<% if(!order.isIsdelivered()){ %>
							<div style="float:left">
								<a class="btn btn-dark" href="order?deliver=<%=order.getId()%>">
									<i class="fas fa-truck"></i>
								</a>
							</div>
							<% } %>

						</td>
						<th scope="row"><%=count%></th>
						<td><%=order.getOrdernumber()%></td>
						<td><%=new SimpleDateFormat("dd-MM-yyyy").format(order.getOrderdate())%></td>
						<td><%=order.getUser().getName()%></td>
						<td><%=order.getContactphone()%></td>
						<td><%=order.getPaymenttype()%></td>
						<td><%=order.getTotal()%> MMK</td>
						<td><%=order.getDeliverytype()%></td>
						<td>
							<%
							if (order.isIsdelivered()) {
							%>
							<p class="text-success">Delivered</p> <%
 } else {
 %>
							<p class="text-danger">In progress</p> <%
 }
 %>
						</td>
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



<jsp:include page="footer.jsp"></jsp:include>