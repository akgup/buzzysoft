<!DOCTYPE HTML>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%@ include file="header.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">

<title>My Team</title>

<link href="static/css/searchbox.css" rel="stylesheet">
<link href='static/css/fullcalendar.min.css' rel='stylesheet' />
<link href='static/css/fullcalendar.print.min.css' rel='stylesheet'
	media='print' />
<script src='static/js/lib/moment.min.js'></script>
<script src='static/js/fullcalendar.min.js'></script>
<script src='static/js/custom/calendar.js'></script>
<script src='static/js/custom/myteam.js'></script>

<style>
body {
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 1000px;
	margin: 0 auto;
	margin-bottom: 50px;
}
</style>

</head>
<body>
	<c:choose>
		<c:when test="${mode == 'MODE_TEAM'}">

			<div class="container text-center" id="tasksDiv">
			<div class="col-xs-9">
				<h4><b>My Team</b></h4>
				</div>
				
				<div class="col-xs-3">
					
						<div class="input-group">
							<form id="form_search" name="form_search" method="get" action=""
								class="form-inline">
								<div class="form-group">
									<div class="input-group">
										<input class="form-control" placeholder="Name or Id to add..."
											type="text"> <span class="input-group-btn">
											<button class="btn btn-info" type="button">Search!</button>
										</span>
									</div>

								</div>
							</form>
						</div>					
				
				</div>				
			</div>
			<hr>
			

			<div class="container-fluid">
				<div class="row">
					<div class="col-xs-2">
						<c:forEach var="member" items="${teamlist}"  varStatus="myIndex">
							<button type="button" id="btn-employee-${myIndex.index}"
								onclick='viewCalendar(${member.userId})'
								class='list-group-item list-group-item-action'>${member.employeeName}-(${member.employeeId})</button>

						</c:forEach>
					</div>
					<div class="col-xs-3">

						<div class="table-responsive" id="user-profile" style="display:none">
							<table class="table table-stripped table-bordered text-left"
								>

								<tr>
									<th>Name:</th>
									<td id="employee-name"></td>
								</tr>
								<tr>
									<th>Phone:</th>
									<td id="employee-phone">  </td>
								</tr>
								<tr>
									<th>Mail:</th>
									<td id="employee-mail"></td>
								</tr>
								<tr>
									<th>Emergency Ph:</th>
									<td id="employee-emer-phone"></td>
								</tr>
								<tr>
									<th>Address:</th>
									<td id="employee-address"> </td>
								</tr>
								<tr>
									<th>Birth Date:</th>
									<td id="employee-dob"></td>
								</tr>
								<tr>
									<th>Joining Date:</th>
									<td id="employee-doj"></td>
								</tr>
								<tr>
									<th>Blood Group:</th>
									<td id="employee-bg"></td>
								</tr>
							</table>
						</div>

					</div>
					<div class="col-xs-7">
						<div id='calendar'></div>
					</div>
				</div>
			</div>

		</c:when>

	</c:choose>

	<!--  Task Details Modal -->
	<div class="modal fade" id="taskDetailsModal" role="dialog">
		<div class="modal-dialog ">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="task_title"></h4>

				</div>
				<div class="modal-body">
					<table
						class="table table-stripped table-bordered text-left  table2excel"
						id="task-history">

						<col width="300">
						<col width="100">
						<col width="200">

						<thead>
							<tr>
								<th>Description</th>
								<th>Status</th>
								<th>Comments</th>

							</tr>
						</thead>
						<tbody>

							<tr id="${task.id}">
								<td id="task_desc"></td>
								<td id="task_status"></td>
								<td id="task_comment"></td>
							</tr>
						</tbody>

					</table>

				</div>

			</div>

		</div>
	</div>
</body>
<script>
var calObject = $('#calendar');	
document.getElementById("btn-employee-0").click();
</script>

</html>