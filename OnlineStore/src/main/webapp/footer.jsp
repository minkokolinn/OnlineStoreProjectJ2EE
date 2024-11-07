<%@page import="daos.CategoryDao"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<footer>
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<div class="full">
					<div class="logo_footer">
						<a href="#" class="brandText">Storebea</a>
					</div>
					<div class="information_f">
						<p>
							<strong>ADDRESS:</strong> Dagon, Yangon
						</p>
						<p>
							<strong>TELEPHONE:</strong> +959 2543 25731
						</p>
						<p>
							<strong>EMAIL:</strong> minkokolinn@gmail.com
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<div class="row">
					<div class="col-md-7">
						<div class="row">
							<div class="col-md-6">
								<div class="widget_menu">
									<h3>Menu</h3>
									<ul>
										<li><a href="#">Home</a></li>
										<li><a href="#">About</a></li>
										<li><a href="#">Services</a></li>
										<li><a href="#">Testimonial</a></li>
										<li><a href="#">Blog</a></li>
										<li><a href="#">Contact</a></li>
									</ul>
								</div>
							</div>
							<div class="col-md-6">
								<div class="widget_menu">
									<h3>Account</h3>
									<ul>
										<li><a href="#">Account</a></li>
										<li><a href="#">Checkout</a></li>
										<li><a href="#">Login</a></li>
										<li><a href="#">Register</a></li>
										<li><a href="#">Shopping</a></li>
										<li><a href="#">Widget</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-5">
						<div class="widget_menu">
							<h3>Newsletter</h3>
							<div class="information_f">
								<p>Subscribe by our newsletter and get update protidin.</p>
							</div>
							<div class="form_sub">
								<form>
									<fieldset>
										<div class="field">
											<input type="email" placeholder="Enter Your Mail"
												name="email" /> <input type="submit" value="Subscribe" />
										</div>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>



<div class="modal fade catfilter" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Category Filter</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="product" method="GET">
					<div class="form-group">
						<label for="exampleFormControlSelect2">Select one or more
							options select</label><select multiple class="form-control"
							id="exampleFormControlSelect2" name="selectedCat"
							style="height: 400px;">
							<%
							List<Category> list = new CategoryDao().getAllCategories();
							if (list != null && list.size() != 0) {
								for (Category cat : list) {
							%>
							<option value="<%=cat.getId() %>"><%=cat.getCategory() %></option>
							<%
							}
							}
							%>
						</select>
					</div>
					<div class="d-flex justify-content-end">
						<button type="submit" class="btn btn-danger">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<!-- jQery -->

<!-- popper js -->
<script src="js/popper.min.js"></script>
<!-- bootstrap js -->
<script src="js/bootstrap.js"></script>
<!-- custom js -->
<script src="js/custom.js"></script>




</body>
</html>