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

<title>My Calendar</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/>


<link href='static/css/fullcalendar.min.css' rel='stylesheet' />

<link href='static/css/bootstrap-timepicker.css' rel='stylesheet' />
<link href='static/css/fullcalendar.print.min.css' rel='stylesheet'	media='print' />
<script src='static/js/lib/moment.min.js'></script>

<script src='static/js/fullcalendar.min.js'></script>
<script src='static/js/bootstrap-timepicker.js'></script>

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
<body>

	<c:set var="cal-data" value="${caldata}" />
	<%
    String d1 = (String)pageContext.getAttribute("cal-data");
     
  %>

	<div id='calendar'></div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-sm">

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
						onclick="putCalData('Leave')">Leave</button>
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="putCalData('present')">Present</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>

			</div>

		</div>
	</div>


	<!-- remove Modal -->
	<div class="modal fade" id="removeModal" role="dialog">
		<div class="modal-dialog modal-sm">

			<!-- Modal content-->
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
	</div>


</body>

<script>

 var inDate;
 var oldevent;
 var initialEvents = <%=d1%>; 
 var calObject=$('#calendar');
 
 calObject.fullCalendar({
	  height: 500,
	defaultDate: '2016-12-12',
	editable: true,
	eventLimit: false, // allow "more" link when too many events
	events: initialEvents ,
	
    dayClick: function(date, jsEvent, view) {	    	
    	   oldeventid=getEvents(date);
    	      	  
         inDate=new Date(date.format());
        // change the day's background color just for fun
        //$(this).css('background-color', 'gray');
        jQuery.noConflict() ;
    	$('#myModal').modal();

    },
    
    eventRender: function(event, element) {
        if(event.title == "Leave") {
            element.css('background-color', '#FFA07A');
        }
    },
	
	eventClick: function(calEvent, jsEvent, view) {
		removingeventid=calEvent.id;
		  jQuery.noConflict() ;
	    	$('#removeModal').modal();
       
      } 
});
 
	var intime=document.getElementById("timepicker1").value;
	
function putCalData(type)
{ 
	var data=null;
	var calid=null;
	
	if(type == "Leave" )
		{
		data ={"start":inDate,"title":"Leave","userId":<%=userId%>,"id":oldeventid};	
		
		}
	else
		{
		 data ={"start":inDate,"title":intime,"userId":<%=userId%>,"id":oldeventid};	
	
		}	

	if(oldeventid!=0)
	{

	calObject.fullCalendar( 'removeEvents',oldeventid )
	oldeventid=0;
	}
		calObject.fullCalendar('renderEvent', data, true);
		
$.ajax({
		  type: "POST",
		  url: "calendar-data",
		  data: data,
		  success: null,
		  dataType: "html",
			  beforeSend: function(xhr){xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');}, 
		});
       }
 
 var removingeventid=0;
function removeEvent() 
{ 
	if(removingeventid!=0)
	{
	calObject.fullCalendar( 'removeEvents',removingeventid )
	
	$.ajax({
		  type: "GET",
		  url: "calendar-data-remove?id="+removingeventid,
		  data: null,
		  success: null,			  
		});	
	}
		
}


       
function getEvents(date){
	var eventid=0;
	initialEvents.forEach(function(entry) {
        if (entry['start'] == date.format()){
                        
        	eventid= entry['id'];
                        
        }
        
        
     });
return eventid;
}
 </script>


</html>
