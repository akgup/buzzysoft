
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
		

		$.ajax({
			type : "GET",
			url : "get-profile",
			data : "userid="+userid,
			success : function(data) {	
				var profile=JSON.parse(data);		
				document.getElementById('user-profile').style.display = "block";
				
				$('#employee-name').text(profile["employeeName"]);
				$('#employee-phone').text(profile["employeePhone"]);
				$('#employee-mail').text(profile["employeeMail"]);
				$('#employee-emer-phone').text(profile["emergencyContact"]);
				$('#employee-address').text(profile["currentAddress"]);
				$('#employee-dob').text(profile["dateOfBirth"]);
				$('#employee-doj').text(profile["dateOfJoining"]);
				$('#employee-bg').text(profile["bloodGroup"]);
				
				},
			dataType : "html"
		
		});
}


