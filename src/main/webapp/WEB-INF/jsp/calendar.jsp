<!DOCTYPE HTML>
<%@ page isELIgnored="false"%>
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

<title>My Calendar</title>

<script	src='static/bootstrap/js/jquery.min.js'></script>
<script src='static/bootstrap/js/bootstrap.min.js'></script>
<link rel="stylesheet" type="text/css" href='static/bootstrap/css/bootstrap.min.css' />

<script type="text/javascript"src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>
<link rel="stylesheet" href='static/bootstrap/css/bootstrap-datepicker3.css'/>
<link href='static/css/fullcalendar.min.css' rel='stylesheet' />

<link href='static/css/bootstrap-timepicker.css' rel='stylesheet' />
<link href='static/css/fullcalendar.print.min.css' rel='stylesheet'
	media='print' />
<script src='static/js/lib/moment.min.js'></script>

<script src='static/js/fullcalendar.min.js'></script>
<script src='static/js/bootstrap-timepicker.js'></script>
<script src='static/js/custom/calendar.js'></script>

<script type="text/javascript">
	$(function() {
		$('#timepicker1').timepicker();
	});
</script>



<style>
body {
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 900px;
	margin: 0 auto;
}
</style>
</head>

<body onload="myTasks()">

	<%
		String d1 = (String) request.getAttribute("caldata");
	%>
	<div id='calendar'></div>

	<!--Primary Modal -->
	<div class="modal fade" id="primaryModal" role="dialog">
		<div class="modal-dialog modal-sm-4">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">In Time</h4>
					
				</div>
				<div class="modal-body">

					<div class="input-group bootstrap-timepicker timepicker">
						<input id="timepicker1" value="10:00 AM" type="text" name="inTime"
							class="form-control input-small"> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-time"></i></span>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="addTask()">Add Task</button>
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="putCalData('Leave','<%=userId%>')">Leave</button>
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="putCalData('present','<%=userId%>')">Present</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>

			</div>

		</div>
	</div>


<!-- 	<!-- remove Modal -->
	<div class="modal fade" id="removeModal" role="dialog">
		<div class="modal-dialog modal-sm">

			Modal content
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Remove Entry</h4>
				</div>
				<div class="modal-body">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="removeEvent()">Remove</button>
				</div>
			</div>

		</div>
	</div> -->

	<!-- Add Task Modal -->
	<div class="modal fade" id="taskModal" role="dialog">
		<div class="modal-dialog modal-sm-6">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">New Task</h4>
					<hr>
					<div id="errorDiv">
						<p id="error" style="color: red; font-size: 20px;"></p>
					</div>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" name="taskForm" id="taskForm"
						action="save-task" onsubmit="return validateForm()" method="post">
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
							
							<label class="control-label col-md-3">Date</label>
							<div class="col-md-5">
								<!-- <p id="task_date" name="taskDate"></p> -->
							
								 <input  name="taskDate" id="task_date" class="form-control" readonly />
							</div>
							

						</div>

						<div class="form-group">
							<label class="control-label col-md-3">Comments</label>
							<div class="col-md-5">
								<input type="text" name="comments"
									placeholder="Comments if any!" class="form-control"
									value="${task.comments}" />
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
							<input type="button" onclick="submitTask()" class="btn btn-primary"
								value="Save" />

						</div>
					</form>

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
	var inDate;
	var oldevent;
	var initialEvents =<%=d1%>;
	
	var calObject = $('#calendar');

	calObject.fullCalendar({
		height : 550,
		
		editable : true,
		eventLimit : false, // allow "more" link when too many events
		events : initialEvents,
		displayEventTime: false,
		
		dayClick : function(date, jsEvent, view) {
			oldeventid = getEvents(date);
			
			inDate = new Date(date.format());
			
			// change the day's background color just for fun
			//$(this).css('background-color', 'gray');
			jQuery.noConflict();
			$('#primaryModal').modal();

		},

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


	function  myTasks()
	{	
		$.ajax({
			type : "GET",
			url : "task-list",
			data : "userid="+"<%=userId%>",
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
	
function putCalData(type, userid) {
		
		var intime = document.getElementById("timepicker1").value;
		var data = null;
		var calid = null;
		
		
		var currentDate=((new Date()).setHours(0, 0, 0, 0, 0));
		var inTime=inDate.setHours(0, 0, 0, 0, 0);
			
				if( inTime >  currentDate && type != "Leave" )
					{
					
					alert("Future dates not allowed!");
					
					}
				
				else{
					
					if (type == "Leave") {
						data = {
							"start" : inDate,
							"title" : "Leave",
							"userId" : userid,
							"id" : oldeventid
						};

					} else {
						data = {
							"start" : inDate,
							"title" : intime,
							"userId" : userid,
							"id" : oldeventid
						};

					}
					
				}
		

	

		if (oldeventid != 0) {
			calObject.fullCalendar('removeEvents', oldeventid)
			oldeventid = 0;
		}
		//calObject.fullCalendar('renderEvent', data, true);

		$.ajax({
			type : "POST",
			url : "calendar-data",
			data : data,
			success : function(data) {
				var json = JSON.parse(data);
				var date = new Date(json["start"]);
				var title = json["title"];
				var id = json["id"];
				var newdata = {
					"start" : date,
					"title" : title,
					"userId" : userid,
					"id" : id
				};
				calObject.fullCalendar('renderEvent', newdata, true);
			},
			dataType : "html",
			beforeSend : function(xhr) {
				xhr.setRequestHeader('Content-Type',
						'application/x-www-form-urlencoded');
			},
		});
	}

			
/* add task from calendar */			
/* $("#taskForm").submit(function(event) { */
	
function submitTask(){	
	  $('#taskModal').modal('hide'); 
	//event.preventDefault();	
	
	//alert( $("#taskForm").serialize());
		
	$.ajax({
		type : "POST",
		url : "save-task",
		data :  $("#taskForm").serialize(),
		
		success : function(data) {
			var json = JSON.parse(data);	
						
			var date = new Date(json["taskDate"]);					
			var title = json["name"];
			var id = json["id"];
			
			var newdata = {
				"start" : date,
				"title" : title,
				"userId" : "<%=userId%>",
				"id" : id ,
				"description" : json["description"] ,
				"status" : json["status"] ,
				"comments" : json["comments"],
				"type":"task"
			};
			
			calObject.fullCalendar('renderEvent', newdata, true);
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
