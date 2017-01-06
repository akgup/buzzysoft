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


</head>
<body>
	<c:choose>
		<c:when test="${mode == 'MODE_TEAM'}">
			<div class="container text-center" id="tasksDiv">
				<h4>My Team</h4>
				<hr>

				<div class="container">
					<div class="row">
						<div class="input-group col-md-4 pull-right">
							<form id="form_search" name="form_search" method="get" action=""
								class="form-inline">
								<div class="form-group">
									<div class="input-group">
										<input class="form-control" 
											placeholder="Name or Id to add..." type="text">
										<span class="input-group-btn">
											<button class="btn btn-info" type="button">Search!</button>
										</span>
									</div>

								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- <div class="container">
	<div class="row">
           <div id="custom-search-input">
                <div class="input-group col-md-4 pull-right">
                    <input type="text" class="  search-query form-control" placeholder="Search by name or id to add.." />
                    <span class="input-group-btn">
                        <button class="btn btn-danger" type="button">
                            <span class=" glyphicon glyphicon-search"></span>
                        </button>
                    </span>
                     <button class="btn btn-danger" type="button">
                            <span class=" glyphicon glyphicon-search"></span>
                            </button>
                </div>
            </div>
	</div>
</div> -->

				<br>
				<div class="table-responsive">
					<table
						class="table table-stripped table-bordered text-left  table2excel"
						id="team-members">

						<col width="60">
						<col width="150">
						<col width="100">
						<col width="130">
						<col width="100">
						<col width="200">
						<col width="30">
						<col width="30">
						<col width="120">
						<col width="30">
						<col width="60">

						<thead>
							<tr>
								<th style="font-size: 12px">Emp Id</th>
								<th style="font-size: 12px">Name</th>
								<th style="font-size: 12px">Phone</th>
								<th style="font-size: 12px">Emergency Ph.</th>
								<th style="font-size: 12px">Email</th>
								<th style="font-size: 12px">Current Address</th>
								<th style="font-size: 12px">DOB</th>
								<th style="font-size: 12px">DOJ</th>
								<th style="font-size: 12px">Blood Group</th>
								<th style="font-size: 12px">PAN</th>
								<th style="font-size: 12px">Calendar</th>
							</tr>
						</thead>
						<tbody>


							<c:forEach var="member" items="${teamlist}">
								<tr id="row${member.userId}">
									<td>${member.employeeId}</td>
									<td>${member.employeeName}</td>
									<td>${member.employeePhone}</td>
									<td>${member.emergencyContact}</td>
									<td>${member.employeeMail}</td>
									<td>${member.currentAddress}</td>
									<td>${member.dateOfBirth}</td>
									<td>${member.dateOfJoining}</td>
									<td>${member.bloodGroup}</td>
									<td>${member.panNumber}</td>
									<td>
										<button type="button" id="calendar_button${member.userId}"
											onclick="viewCalendar(${member.userId},'${member.employeeName}')"
											class="btn btn-info">
											<span class="glyphicon glyphicon-calendar"></span>
										</button>
									</td>

								</tr>

							</c:forEach>

						</tbody>

					</table>
				</div>


			</div>
		</c:when>

	</c:choose>

	<div class="modal fade" id="calendarModal" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="cal-title-name">Employee Calendar</h4>
				</div>
				<div class="modal-body">

					<div id='calendar'></div>
				</div>
			</div>

		</div>
	</div>

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
function viewCalendar(userid,username)
{
	document.getElementById("cal-title-name").innerHTML = "Name: "+username;
	$('#calendarModal').modal();
	$('#calendarModal').on('shown.bs.modal', function() {
		$.ajax({
			type : "GET",
			url : "get-attendance-data",
			data : "userid="+userid,
			success : function(data) {	
			openCalModel(data);
			employeeTasks(userid);
				},
			dataType : "html"
		
		});
	})
}


function openCalModel(data)
{
	
	
	calObject.fullCalendar({
		height : 550,	
		editable : true,
		eventLimit : false, // allow "more" link when too many events
		events : JSON.parse(data),
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
			else
				{
			//$('#removeModal').modal();
				}

		}
		

	});

	
	}
	
	
function  employeeTasks(userid)
{	
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
							
				var newdata = {
					"start" : date,
					"title" : title,
					"userId" : "<%=userId%>",
					"id" : id ,
					"description" : json[x]["description"] ,
					"status" : json[x]["status"] ,
					"comments" : json[x]["comments"],
					"type":"task"
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