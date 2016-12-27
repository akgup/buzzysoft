
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


<title>My Profile</title>

<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
<link rel="stylesheet"
	href="https://formden.com/static/cdn/bootstrap-iso.css" />
</head>
<body>

	<div class="container text-center">

		<h3>My Profile</h3>
		<hr>
		<form class="form-horizontal" method="POST" action="saveProfile">
			<input type="hidden" name="userId" value="<%=userId%>" /> <input
				type="hidden" name="userProfileId"
				value="${userProfile.userProfileId}" />
			<div class="form-group">
				<label class="control-label col-md-3">Name</label>
				<div class="col-md-5">

					<input type="text" name="employeeName" class="form-control"
						value="${userProfile.employeeName}" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">Employee Id</label>
				<div class="col-md-5">
					<input type="text" name="employeeId" class="form-control"
						value="${userProfile.employeeId}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-3">Date Of Joining</label>
				<div class="col-md-5">
					<input class="form-control" id="doj" name="dateOfJoining"
						placeholder="DD/MM/YYYY" type="text"
						value="${userProfile.dateOfJoining}" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-md-3">Date Of Birth</label>
				<div class="col-md-5">
					<input type="text" class="form-control" id="dob" name="dateOfBirth"
						placeholder="DD/MM/YYYY" value="${userProfile.dateOfBirth}">

				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-3">Mail</label>
				<div class="col-md-5">
					<input type="text" name="employeeMail" class="form-control"
						value="${userProfile.employeeMail}" />
				</div>
			</div>


			<div class="form-group">
				<label class="control-label col-md-3">Phone</label>
				<div class="col-md-5">
					<input type="text" name="employeePhone" class="form-control"
						value="${userProfile.employeePhone}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-3">Blood Group</label>
				<div class="col-md-5">
					<input type="text" name="bloodGroup" class="form-control"
						value="${userProfile.bloodGroup}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-3">Emergency Contact</label>
				<div class="col-md-5">
					<input type="text" name="emergencyContact" class="form-control"
						value="${userProfile.emergencyContact}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-3">Current Address</label>
				<div class="col-md-5">
					<input type="text" name="currentAddress" class="form-control"
						value="${userProfile.currentAddress}" />
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-md-3">PAN Number</label>
				<div class="col-md-5">
					<input type="text" name="panNumber" class="form-control"
						value="${userProfile.panNumber}" />
				</div>
			</div>

			<div class="form-group">
				<div class="col-md-5">
					<button type="submit" class="btn btn-primary" value="Submit">Update</button>
				</div>
			</div>
		</form>
	</div>
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


</body>
</html>