
<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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


<title>My Profile</title>

<link href="static/css/style.css" rel="stylesheet">
<!-- Include Date Range Picker -->
	<script type="text/javascript"
		src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>
	<link rel="stylesheet"	href='static/bootstrap/css/bootstrap-datepicker3.css'/>
</head> 
<body>

	<c:set var="bg" value="${userProfile.bloodGroup}" />
	<%
		String blood = (String) pageContext.getAttribute("bg");
	%>

	<c:choose>
		<c:when test="${mode == 'MODE_PROFILE'}">
			<div class="container text-center">

				<h4>My Profile</h4>
				<hr>
				<div style="color: green;" id="update-success"></div>
				<form class="form-horizontal" id="profileForm" method="POST" >
					<input type="hidden" id="u_id" name="userId" value="<%=userId%>" /> 
					
					<input type="hidden" id="supervisor_id" name="supervisorId" value="${userProfile.supervisorId}" /> 
					
					<input type="hidden" name="userProfileId" value="${userProfile.userProfileId}" />
					
					<div class="form-group">
						<label class="control-label col-md-3 ">Name</label>
						<div class="col-md-5 col-sm-6 ">
							<input type="text" id="emp_name" name="employeeName" class="form-control"
								value="${userProfile.employeeName}" />
							</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Employee Id</label>
						<div class="col-md-5">
							<input type="text" id="emp_id" name="employeeId" class="form-control"
								value="${userProfile.employeeId}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Date Of Joining</label>
						<div class="col-md-5">
							<input class="form-control" id="doj" name="dateOfJoining"
								placeholder="DD/MM/YYYY" type="text"
								value="${userProfile.dateOfJoining}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Date Of Birth</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="dob"
								name="dateOfBirth" placeholder="DD/MM/YYYY"
								value="${userProfile.dateOfBirth}">

						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Mail</label>
						<div class="col-md-5">
							<input type="text" id="emp_mail" name="employeeMail" class="form-control"
								value="${userProfile.employeeMail}" />
						</div>
					</div>


					<div class="form-group">
						<label class="control-label col-md-3">Phone</label>
						<div class="col-md-5">
							<input type="text" id="emp_phone" name="employeePhone" class="form-control"
								value="${userProfile.employeePhone}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Blood Group</label>
						<div class="col-md-5">
							<select class="selectpicker form-control" id="bloodgroup"
								name="bloodGroup" >
								<option value="A+" id="A+">A+</option>
								<option value="A-" id="A-">A-</option>
								<option value="B+" id="B-">B+</option>
								<option value="B-" id="B-">B-</option>
								<option value="O+" id="O+">O+</option>
								<option value="O-" id="O-">O-</option>
								<option value="AB+" id="AB+">AB+</option>
								<option value="AB-" id="AB-">AB-</option>
							</select>

						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Emergency Contact</label>
						<div class="col-md-5">
							<input type="text" id="emp_emergency" name="emergencyContact" class="form-control"
								value="${userProfile.emergencyContact}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">Current Address</label>
						<div class="col-md-5">
							<input type="text" id="emp_add" name="currentAddress" class="form-control"
								value="${userProfile.currentAddress}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-md-3">PAN Number</label>
						<div class="col-md-5">
							<input type="text" id="emp_pan" name="panNumber" class="form-control"
								value="${userProfile.panNumber}" />
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-5">
							<button type="button" class="btn btn-primary" onclick="updateUser()">Update</button>
						</div>
					</div>
				</form>
			</div>

		</c:when>
		<c:when test="${mode == 'MODE_PASSWORD_CHANGE'}">
			<div class="container text-center">

				<h4>Change Password</h4>
				<hr>
				<div id="errorDiv">
					<p id="error" style="color: red; font-size: 20px;"></p>
				</div>
				<form class="form-horizontal" method="POST" action="update-password"
					name="userCredentials" onsubmit="return validateForm()">
					
					<input type="hidden" name="userName" value="<%=userName%>" />
					
					<input type="hidden"  name="userId" value="<%=userId%>" />
					<div class="form-group">
						<label class="control-label col-md-3">New Password</label>
						<div class="col-md-5">

							<input type="text" id="new-password" name="password" class="form-control"
								placeholder="New Password" value="${userCredentials.password}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-md-3">Confirm password</label>
						<div class="col-md-5">
							<input type="password" name="confirm" id="confirm-password" placeholder="Confirm Password"
								class="form-control" />
						</div>
					</div>

					<div class="form-group">
						<input type="submit" class="btn btn-primary" value="Update" />
					</div>
				</form>
			</div>
		</c:when>



	</c:choose>
	<script src="static/js/bootstrap.min.js"></script>
	
	<script>
		function validateForm() {

			var newpassword = document.forms["userCredentials"]["new-password"].value;
			var cnfpassword = document.forms["userCredentials"]["confirm-password"].value;
			
			if (newpassword.trim() == "" || cnfpassword.trim() == "") {
			     document.getElementById("error").innerHTML ="Password field can't be empty!";
				return false;
			}
			else if(newpassword.trim() != cnfpassword.trim())
				{
				 document.getElementById("error").innerHTML ="Password did not match!";
					return false;
				}
				
		}
		
		function updateUser(){
			var val=$('#profileForm').serialize();
			//alert(val);
			$.ajax({
				type :"POST",
				url :"saveProfile",
				data : val,
				success : function(data) {
					if(data){
						 document.getElementById("update-success").innerHTML ="Profile Updated Successfully!";
						 document.getElementById("update-success").style.color = "green";
											}
					else{
						document.getElementById("update-success").innerHTML ="Kindly try again!";	
						document.getElementById("update-success").style.color = "red";
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
	
	
	<script>
	
	$('select[name="bloodGroup"]').val('<%=blood%>');
	</script>
	


</body>
</html>