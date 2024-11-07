<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="header.jsp">
	<jsp:param value="dashboard" name="active" />
</jsp:include>



<div class="container-fluid mt-3 p-4">
	<!-- Content -->
	<div class="row flex-column flex-lg-row">
		<h5 class="alert alert-primary">Dashboard</h5>
	</div>
	<div class="row flex-column flex-lg-row">
		<!-- Content Row 1 -->
		
		<!-- <div class="col">
			<div class="card mb-3">
				<div class="card-body">
					<h3 class="card-title h2">1,250</h3>
					<span class="text-success"> <i class="fas fa-chart-line"></i>
						Daily visitors
					</span>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card mb-3">
				<div class="card-body">
					<h3 class="card-title h2">8,210</h3>
					<span class="text-success"> <i class="fas fa-chart-line"></i>
						Weekly visitors
					</span>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card mb-3">
				<div class="card-body">
					<h3 class="card-title h2">12,560</h3>
					<span class="text-success"> <i class="fas fa-chart-line"></i>
						Monthly visitors
					</span>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card mb-3">
				<div class="card-body">
					<h3 class="card-title h2">102,250</h3>
					<span class="text-success"> <i class="fas fa-chart-line"></i>
						Yearly visitors
					</span>
				</div>
			</div>
		</div>
	</div>
	

	<div class="row mt-4 flex-column flex-lg-row">
		
		<div class="col">
			<h2 class="h6 text-white-50">LOCATION</h2>
			<div class="card mb-3" style="height: 280px">
				<div class="card-body">
					<small class="text-muted">Regional</small>
					<div class="progress mb-4 mt-2" style="height: 5px">
						<div class="progress-bar bg-success w-25"></div>
					</div>

					<small class="text-muted">Global</small>
					<div class="progress mb-4 mt-2" style="height: 5px">
						<div class="progress-bar bg-primary w-75"></div>
					</div>

					<small class="text-muted">Local</small>
					<div class="progress mb-4 mt-2" style="height: 5px">
						<div class="progress-bar bg-warning w-50"></div>
					</div>

					<small class="text-muted">Internal</small>
					<div class="progress mb-4 mt-2" style="height: 5px">
						<div class="progress-bar bg-danger w-25"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col">
			<h2 class="h6 text-white-50">DATA</h2>
			<div class="card mb-3" style="height: 280px">
				<div class="card-body">
					<div class="text-end">
						<button class="btn btn-sm btn-outline-secondary">
							<i class="fas fa-search"></i>
						</button>
						<button class="btn btn-sm btn-outline-secondary">
							<i class="fas fa-sort-amount-up"></i>
						</button>
						<button class="btn btn-sm btn-outline-secondary">
							<i class="fas fa-filter"></i>
						</button>
					</div>
					<table class="table">
						<tr>
							<th>ID</th>
							<th>Age Group</th>
							<th>Data</th>
							<th>Progress</th>
						</tr>
						<tr>
							<td>1</td>
							<td>20-30</td>
							<td>19%</td>
							<td><i class="fas fa-chart-pie"></i></td>
						</tr>
						<tr>
							<td>2</td>
							<td>30-40</td>
							<td>40%</td>
							<td><i class="fas fa-chart-bar"></i></td>
						</tr>
						<tr>
							<td>3</td>
							<td>40-50</td>
							<td>20%</td>
							<td><i class="fas fa-chart-line"></i></td>
						</tr>
						<tr>
							<td>4</td>
							<td>>50</td>
							<td>11%</td>
							<td><i class="fas fa-chart-pie"></i></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		 -->
	</div>
	<!-- Content Row 2 -->

</div>
<!-- Content -->


<jsp:include page="footer.jsp"></jsp:include>
