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

<title>Task Manager | Home</title>

		<!-- Include Date Range Picker -->
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://formden.com/static/cdn/bootstrap-iso.css" />

</head>
<body>


	<c:choose>
		<c:when test="${mode == 'MODE_TASKS'}">
			<div class="container text-center" id="tasksDiv">
				<h3>My Tasks</h3>
				<hr>
				<div class="table-responsive">
					<table class="table table-stripped table-bordered text-left">
						<thead>
							<tr>
								<th>Id</th>
								<th>Task Name</th>
								<th>Description</th>
								<th>Task Date</th>
								<th>Status</th>
								<th>Comments</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="task" items="${tasks}">
								<tr>
									<td>${task.id}</td>
									<td>${task.name}</td>
									<td>${task.description}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${task.taskDate}" /></td>
									<td>${task.status}</td>
									<td>${task.comments}</td>
									<td><a href="update-task?id=${task.id}"><span
											class="glyphicon glyphicon-pencil"></span></a></td>
									<td><a href="delete-task?id=${task.id}&userid=<%=userId%>"><span
											class="glyphicon glyphicon-trash"></span></a></td>

								</tr>


							</c:forEach>
						</tbody>

					</table>
				</div>


			</div>
		</c:when>

		<c:when test="${mode == 'MODE_NEW' || mode == 'MODE_UPDATE'}">
			<div class="container text-center">
            
				<h4>Manage Tasks</h4>
				<hr>
				 <div id="errorDiv"> 
                        <p id="error"  style="color:red;font-size:20px;"></p></div> 
				<form class="form-horizontal" method="POST" action="save-task"
					name="taskForm" onsubmit="return validateForm()">
					<input type="hidden" name="id" value="${task.id}" /> <input
						type="hidden" name="userId" value="<%=userId%>" />
					<div class="form-group">
						<label class="control-label col-md-3">Task Name*</label>
						<div class="col-md-5">

							<input type="text" name="name" class="form-control"
								placeholder="Task Name*" value="${task.name}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Description</label>
						<div class="col-md-5">
							<input type="text" name="description"
								placeholder="Task Description" class="form-control"
								value="${task.description}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Date*</label>
						<div class="col-md-5">
							<input class="form-control" id="date" name="taskDate"
								placeholder="YYYY/MM/DD*" type="date"
								value="<fmt:formatDate pattern="yyyy-MM-dd" value="${task.taskDate}" />" />

						</div>

					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Comments</label>
						<div class="col-md-5">
							<input type="text" name="comments" placeholder="Comments if any!"
								class="form-control" value="${task.comments}" />
						</div>
					</div>


					<div class="dropdown form-group">
						<label class="control-label col-md-3">Status</label>
						<div class="col-md-5">
							<select class="selectpicker form-control" name="status">
								<option value="Not Started">Not Started</option>
								<option value="In Progress">In Progress</option>
								<option value="Done">Done</option>
							</select>

						</div>
					</div>

					<div class="form-group">
						<input type="submit" class="btn btn-primary" value="Save" />
					</div>
				</form>
			</div>
		</c:when>

	</c:choose>

	<script src="static/js/bootstrap.min.js"></script>



	<script>
		$(document).ready(
				function() {
					var date_input = $('input[name="taskDate"]'); //our date input has the name "date"
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'yyyy/MM/dd',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>

	<script>
		function validateForm() {

			var date = document.forms["taskForm"]["taskDate"].value;
			var taskname = document.forms["taskForm"]["name"].value;
			if (date.trim() == "" || taskname.trim() == "") {
			     document.getElementById("error").innerHTML ="Please fill all mandatory fields!";
				return false;
			}
		}
	</script>
	

</body>
</html>