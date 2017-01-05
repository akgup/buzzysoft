function addTask()
 {
		$('#taskModal').modal();
 }
 
 function createTask()
 {
	 $.ajax({
		  type: "POST",
		  url: "save-task",
		  data: $(this).serialize(),
		  success:function(data) {
			 
	        },
		  dataType: "html",
			  beforeSend: function(xhr){xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');}, 
		});
 }
 

var intime=document.getElementById("timepicker1").value;

var removingeventid=0;
function removeEvent() 
{ 
	if(removingeventid!=0)
	{
		
	$.ajax({
		  type: "GET",
		  url: "calendar-data-remove?id="+removingeventid,
		  data:null,
		  success: function(data) {			  
			  calObject.fullCalendar('removeEvents',removingeventid )
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


       
function getEvents(date){
	var eventid=0;
	initialEvents.forEach(function(entry) {
        if (entry['start'] == date.format()){
                        
        	eventid= entry['id'];
                        
        }
        
        
     });
return eventid;
}