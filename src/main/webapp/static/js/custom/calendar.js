

function addTask() {

	$('#taskModal').modal();
	document.getElementById("task_date").defaultValue = (inDate.getMonth() + 1)
			+ '/' + inDate.getDate() + '/' + inDate.getFullYear();

}

function createTask() {
	$.ajax({
		type : "POST",
		url : "save-task",
		data : $(this).serialize(),
		success : function(data) {

		},
		dataType : "html",
		beforeSend : function(xhr) {
			xhr.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
		},
	});
}



var removingeventid = 0;
function removeEvent() {
	if (removingeventid != 0) {

		$.ajax({
			type : "GET",
			url : "calendar-data-remove?id=" + removingeventid,
			data : null,
			success : function(data) {
				calObject.fullCalendar('removeEvents', removingeventid)
			},
		});
	}

}

function validateForm() {

	var date = document.forms["taskForm"]["taskDate"].value;
	var taskname = document.forms["taskForm"]["name"].value;
	if (date.trim() == "" || taskname.trim() == "") {
		document.getElementById("error").innerHTML = "Please fill all mandatory fields!";
		return false;
	}
}

function getEvents(date) {
	var eventid = 0;
	initialEvents.forEach(function(entry) {
		if (entry['start'] == date.format()) {

			eventid = entry['id'];

		}

	});
	return eventid;
}

function myTasks(userid) {
	$.ajax({
		type : "GET",
		url : "task-list",
		data : "userid=" + userid,
		success : function(data) {

			var json = JSON.parse(data);

			for (x in json) {
				var date = new Date(json[x]["taskDate"]);
				var title = json[x]["name"];
				var id = json[x]["id"];

				var newdata = {
					"start" : date,
					"title" : title,
					"userId" : "<%=userId%>",
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

function putCalData(type, userid) {
	
	//getEventList(inDate);
	var intime = document.getElementById("timepicker1").value;
	var data = null;
	var calid = null;
	var isAttendance=checkIfAlreadyPresent(inDate);
	
	var currentDate = ((new Date()).setHours(0, 0, 0, 0, 0));
	var inTime = inDate.setHours(0, 0, 0, 0, 0);
		if (inTime > currentDate && type != "Leave") {
			document.getElementById("errMsg").innerHTML="Future dates not allowed!";										 
			document.getElementById("errMsg").style.display = 'block';
	}
		
	else {

		if (type == "Leave") {
			data = {
				"start" : inDate,
				"title" : "Leave",
				"userId" : userid,
				"id" : null
			};

		} else {
			data = {
				"start" : inDate,
				"title" : intime,
				"userId" : userid,
				"id" : null
			};

		}
		
		$.ajax({
			type : "POST",
			url : "calendar-data",
			data : data,
			success : function(data) {
				
				if(data){
				var json = JSON.parse(data);
				var date = new Date(json["start"]);
				var title = json["title"];
				var id = json["id"];
				var newdata = {
					"start" : date,
					"title" : title,
					"userId" : userid,
					"id" : id,
					"type":"attendance"
				};
				
				jQuery.noConflict();
				$('#primaryModal').modal("hide");
				calObject.fullCalendar('renderEvent', newdata, true);
			}
				else
					{
					 document.getElementById("errMsg").innerHTML="Leave or present not allowed again!";										 
					  document.getElementById("errMsg").style.display = 'block';
			
					}
			},
			dataType : "html",
			beforeSend : function(xhr) {
				xhr.setRequestHeader('Content-Type',
						'application/x-www-form-urlencoded');
			},
		});

	}



}

function submitTask(){	
	  $('#taskModal').modal('hide'); 
	
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


function checkIfAlreadyPresent(date){	
	var flag=false;
	
	calObject.fullCalendar('clientEvents', function(event) {
		var d1=new Date(event['start']);
	
           if(d1.getTime() == date.getTime() && event.type!="task" ) {
        	   flag=true;
           }
         
       });
	  return flag;
}



