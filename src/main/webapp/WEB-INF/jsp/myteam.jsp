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
				<h4>My Team</h4>
				<div class="container">
					<div class="row">
						<div class="input-group col-md-4 pull-right">
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
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="col-xs-2">
						<c:forEach var="member" items="${teamlist}">
							<button type="button" id="btn-employee-${member.userId}"
								onclick='viewCalendar(${member.userId})'
								class='list-group-item list-group-item-action'>${member.employeeName}-(${member.employeeId})</button>

						</c:forEach>
					</div>
					<div class="col-xs-10">
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

function viewCalendar(userid)
{	
	calObject.fullCalendar('removeEvents');
	
	calObject.fullCalendar({
		height : 500,	
		editable : true,
		eventLimit : false, // allow "more" link when too many events
		events : null,
		displayEventTime: false,
		
		eventRender : function(event, element) {
			if (event.title == "Leave") {
				element.css('background-color', '#ff0000');
			}
			
			if (event.type == "task") {
				element.css('background-color', '#c2acac');
			}
		},
		
		eventClick : function(calEvent, jsEvent, view) {
			removingeventid = calEvent.id;
			jQuery.noConflict();
			if(calEvent.type=="task")
				{
				$('#taskDetailsModal').modal();
				document.getElementById("task_title").innerHTML = calEvent.title;
				document.getElementById("task_desc").innerHTML = calEvent.description;
				document.getElementById("task_status").innerHTML = calEvent.status;
				document.getElementById("task_comment").innerHTML = calEvent.comments;
				}
			
		}
		

	});	
	
		$.ajax({
			type : "GET",
			url : "get-attendance-data",
			data : "userid="+userid,
			success : function(data) {					
				calObject.fullCalendar('renderEvents', JSON.parse(data), true);
			
				},
			dataType : "html"
		
		});
		
		$.ajax({
			type : "GET",
			url : "task-list",
			data : "userid="+userid,
			success : function(data) {
			
				var json = JSON.parse(data);		
			
				for( x in json)
				{			
					var date = new Date(json[x]["taskDate"]);					
					var title = json[x]["name"];
					var id = json[x]["id"];
					var user_id = json[x]["userId"];
								
					var newdata = {
						"start" : date,
						"title" : title,
						"userId" : user_id,
							"id" : id,
							"description" : json[x]["description"],
							"status" : json[x]["status"],
							"comments" : json[x]["comments"],
							"type" : "task"
						};

						calObject.fullCalendar('renderEvent', newdata, true);
					}

				},
				dataType : "html",
				beforeSend : function(xhr) {
					xhr.setRequestHeader('Content-Type',
							'application/x-www-form-urlencoded');
				},
			});
}


</script>
</html>