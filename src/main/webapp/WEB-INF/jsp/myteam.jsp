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
<link href="static/css/jquery-ui.css" rel="stylesheet">
<link href='static/css/fullcalendar.min.css' rel='stylesheet' />
<link href='static/css/fullcalendar.print.min.css' rel='stylesheet'
	media='print' />
<script src='static/js/lib/moment.min.js'></script>
<script src='static/js/fullcalendar.min.js'></script>
<script src='static/js/custom/calendar.js'></script>
<script src='static/js/custom/myteam.js'></script>
<script src='static/js/jquery-ui.js'></script>

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
	<!-- begin #sidebar -->
	<div id="sidebar" class="sidebar">
		<!-- begin sidebar nav -->
		
		<ul class="nav" id="leftNavList">
			<li class="has-sub"> <div class="col-xs-12">

					<div class="input-group">
						<form id="form_search" name="form_search" method="get" action="">
							<div class="form-group">
								<div class="input-group">
									<input class="form-control" id="search-keyword"
										placeholder="Name or Id to add..." type="text">
								</div>
<<<<<<< HEAD
							</div>
						</form>
					</div>
				</div></li>
=======
								
													</div>

						</form>
					</div>

				</div>	<br><br></li>
			
>>>>>>> b9ac895c88b5203552924daa189b0f5981c43311
			<c:forEach var="member" items="${teamlist}" varStatus="myIndex">
				<li class="has-sub">
					<button type="button" id="btn-employee-${myIndex.index}"
						onclick='viewCalendar(${member.userId})'
						class='list-group-item list-group-item-action'>${member.employeeName}-(${member.employeeId})</button>

				</li>
			</c:forEach>
		</ul>
	</div>
	<!-- end #sidebar -->
	<div id="content" class="content">

		<c:choose>
			<c:when test="${mode == 'MODE_TEAM'}">

				<!-- begin row -->
				<div class="row" id="myteam">
					<!-- begin col-6 -->
					<div class="col-md-5">

						<!-- begin panel -->
						<div class="panel panel-inverse" id="memberDetailPanel">
							<div class="panel-heading">
								<h4 class="panel-title">Details</h4>
							</div>
							<div class="panel-body">
								<div class="table-responsive" id="user-profile"
									style="display: none">
									<table class="table table-bordered">

										<tbody>

											<tr>
												<th>Name:</th>
												<td id="employee-name"></td>
											</tr>

											<tr>
												<th>Phone:</th>
												<td id="employee-phone"></td>
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
												<td id="employee-address"></td>
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

										</tbody>
									</table>
								</div>


							</div>
						</div>
					</div>
					<!-- end panel -->
					<div class="col-md-7">
						<!-- begin panel -->
						<div class="panel panel-inverse">
							<div class="panel-heading">
								<h4 class="panel-title">Calendar</h4>
							</div>
							<div class="panel-body">
								<div class="container-fluid" id="tasksDiv">

									<div>
										<div id='calendar'></div>
									</div>
								</div>

							</div>
						</div>
						<!-- end panel -->
					</div>

				</div>

			</c:when>

		</c:choose>
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
document.getElementById("btn-employee-0").click();
var n=0;

$(document).ready(function() {
    $(function() {    	

            $("#form_search").autocomplete({     
            	
             source : function(request, response) {
            	
            	var keyword=$('#search-keyword').val();
                 $.ajax({
                    url : "search-employee",
                    type : "GET",
                    data : "keyword="+keyword,
                    dataType : "json",
                    success : function(data) {
                    
                    	var empArray=[];
                    	for (x in data)
                    		{
                    		//alert(data[x]["employeeName"]+"-"+data[x]["employeeId"]);
                    		var value=data[x]["employeeName"]+"-"+data[x]["employeeId"];
                    		var userid=data[x]["userId"]
                    		var json='{"value":"'+value+'","userid":"'+userid+'"}';
                    		empArray.push(JSON.parse(json));
                    		 
                    		}
                    	
                   
                         	  response(empArray);
                         	
                    }
            });
    }, 
    
    select: function( event, ui ) {
    	event.preventDefault()
      
    	
    	$.ajax({
            url : "addSupervisor",
            type : "GET",
            data : "supervisorid="+<%=userId%>+"&userid="+ui.item.userid,
            dataType : "json",
            success : function(data) {
                       	
            }
    });
        return false;
     }
<<<<<<< HEAD
}).data( "ui-autocomplete" )._renderItem = function( ul, item ) {
=======
})
.data( "ui-autocomplete" )._renderItem = function( ul, item ) {
            	
            
>>>>>>> b9ac895c88b5203552924daa189b0f5981c43311
                return $( "<li>" )
                .append( "<a>"+ item.value + "</a>" )
                .appendTo( ul );
             };
});
});

</script>
<script src="static/js/jquery.min.js"></script>

</html>