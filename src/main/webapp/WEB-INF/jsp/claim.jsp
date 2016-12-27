<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="header.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">

<title>Claim</title>

<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
<link rel="stylesheet"
	href="https://formden.com/static/cdn/bootstrap-iso.css" />
</head>
<body>
	<c:choose>
		<c:when test="${mode == 'MODE_NEW' || mode == 'MODE_UPDATE'}">
			<div class="container text-center">

				<h3>Expense Reimbursement</h3>
				<hr>
				<form class="form-horizontal" method="POST" action="create-claim">
					<input type="hidden" name="id" value="${claim.claimId}" /> <input
						type="hidden" name="userId" value="<%=userId%>" />

					<div class="form-group">
						<label class="control-label col-md-3">From Date</label>
						<div class="col-md-5">
							<input class="form-control" id="date" name="start"
								placeholder="MM/DD/YYY" type="text"
								value="<fmt:formatDate pattern="yyyy-MM-dd"
											value="${claim.start}" />" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">End Date</label>
						<div class="col-md-5">
							<input class="form-control" id="date" name="end"
								placeholder="MM/DD/YYY" type="text"
								value="<fmt:formatDate pattern="yyyy-MM-dd"
											value="${claim.end}" />" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Manager</label>
						<div class="col-md-5">
							<input type="text" name="manager" class="form-control"
								value="${claim.manager}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Business Purpose</label>
						<div class="col-md-5">
							<input type="text" name="purpose" class="form-control"
								value="${claim.purpose}" />
						</div>
					</div>


					<div class="form-group">
						<label class="control-label col-md-3">Advance</label>
						<div class="col-md-5">
							<input type="number" name="advance" class="form-control"
								value="${claim.advance}" />
						</div>
					</div>


					<div class="dropdown">

						<label class="control-label col-md-3">Department</label>
						<div class="col-md-5">

							<select class="selectpicker show-tick" name="department"
								data-style="btn-primary">
								<option value="Engineering">Engineering</option>
								<option value="HR">HR</option>
								<option value="Finance">Finance</option>
								<option value="Admin">Admin</option>
							</select>

						</div>

					</div>


					<div class="container">

						<div class="row clearfix">
							<br>
							<div class="col-md-7 column">
								<br>
								<table class="table table-bordered table-hover" id="item_table">
									<col width="80">
									<col width="120">
									<col width="200">
									<col width="120">
									<col width="100">

									<thead>
										<tr>
											<th class="text-center">#</th>
											<th class="text-center">Date</th>
											<th class="text-center">Description</th>
											<th class="text-center">Category</th>
											<th class="text-center">Cost</th>
										</tr>
									</thead>
									<tbody>
										<tr id='addr0'>
											<td>1</td>
											<td><input type="text" name='claimItems[0].expenseDate'
												id='expenseDate' placeholder='Date'
												class="form-control picker" /></td>
											<td><input type="text" name='claimItems[0].description'
												placeholder='Description' class="form-control" /></td>
											<td><input type="text" name='claimItems[0].category'
												placeholder='Category' class="form-control" /></td>
											<td><input type="number" name='claimItems[0].cost'
												placeholder='Cost' class="form-control" /></td>
										</tr>
										<tr id='addr1'></tr>
									</tbody>
								</table>
							</div>

							<div class="col-md-12">
								<div class="col-md-3"></div>
								<div class="col-md-3">
									<a id="add_row" class="btn btn-default ">Add Row</a>
								</div>
								<div class="col-md-3">
									<a id='delete_row' class="btn btn-default pull-right">Delete
										Row</a>
								</div>
								<div class="col-md-3"></div>

							</div>
						</div>


					</div>

					<div class="form-group">
						<br> <input type="submit" class="btn btn-primary"
							value="Submit" />
					</div>
				</form>
			</div>
		</c:when>


		<c:when test="${mode == 'MODE_HISTORY'}">
			<div class="container text-center" id="tasksDiv">
				<h3>Claim History</h3>
				<hr>
				<div class="table-responsive">
					<div class="col-md-7">
						<table class="table table-stripped table-bordered text-center">
							<col width="100">
							<col width="200">
							<col width="100">
							<thead>
								<tr>
									<th>Claim Id</th>
									<th>Period</th>
									<th>Download</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="claim" items="${claimList}">
									<tr>
										<td>${claim.claimId}</td>
										<td ><fmt:formatDate pattern="yyyy-MM-dd"
												value="${claim.start}" /> to <fmt:formatDate
												pattern="yyyy-MM-dd" value="${claim.end}" /></td>
										<td><a href="/claim-download?claimid=${claim.claimId}"><span
												class="glyphicon glyphicon-download"></span></a></td>


									</tr>


								</c:forEach>
							</tbody>

						</table>
					</div>
				</div>


			</div>
		</c:when>

	</c:choose>

	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>

	<!-- Include jQuery -->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

	<!-- Include Date Range Picker -->
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />

	<script>
		$(document).ready(
				function() {
					var date_input = $('input[name="start"]');
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'mm/dd/yyyy',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>

	<script>
		$(document).ready(
				function() {
					var date_input = $('input[name="end"]'); //our date input has the name "date"
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'yyyy-MM-dd',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>


	<script>
		$(document)
				.ready(
						function() {
							var i = 1;
							$("#add_row")
									.click(
											function() {
												$('#addr' + i)
														.html(
																"<td>"
																		+ (i + 1)
																		+ "</td><td><input name='claimItems["
																		+ i
																		+ "].expenseDate' type='text' placeholder='Date' class='form-control input-md picker' onblur='showDatePicker(this)'  /> </td><td><input  name='claimItems["+i+"].description' type='text' placeholder='Description'  class='form-control input-md'></td><td><input  name='claimItems["+i+"].category' type='text' placeholder='Category'  class='form-control input-md'></td><td><input  name='claimItems["+i+"].cost' type='number' placeholder='Cost'  class='form-control input-md'></td>");

												$('#item_table').append(
														'<tr id="addr'
																+ (i + 1)
																+ '"></tr>');
												i++;
											});
							$("#delete_row").click(function() {
								if (i > 1) {
									$("#addr" + (i - 1)).html('');
									i--;
								}
							});

						});
	</script>
	<script>
		$(document).ready(
				function() {
					var date_input = $('.picker');

					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'mm/dd/yyyy',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>


	<script>
		function showDatePicker() {
			var date_input = $('.picker');

			var container = $('.bootstrap-iso form').length > 0 ? $(
					'.bootstrap-iso form').parent() : "body";
			date_input.datepicker({
				format : 'mm/dd/yyyy',
				container : container,
				todayHighlight : true,
				autoclose : true,
			})
		}
	</script>


</body>
</html>