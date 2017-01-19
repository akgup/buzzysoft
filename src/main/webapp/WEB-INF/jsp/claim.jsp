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

<title>Claim</title>

<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />

<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />
<script src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>

</head>
<body>
	<div id="content" class="content">
		<c:choose>
			<c:when test="${mode == 'MODE_NEW' || mode == 'MODE_UPDATE'}">

				<h1 class="page-header1">Expense Reimbursement</h1>

				<!-- begin panel -->
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<h4 class="panel-title">Claim</h4>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" method="POST" action="create-claim"
							enctype="multipart/form-data" id="claim-form"
							onsubmit="return validateForm()">

							<div class="formStart">
								<input type="hidden" name="id" value="${claim.claimId}" /> <input
									type="hidden" name="userId" value="<%=userId%>" />

								<div class="form-group">
									<div class="col-sm-6">
										<label>From Date</label> <input class="form-control picker"
											id="start-date" name="start" placeholder="MM/DD/YYY"
											type="text"
											value="<fmt:formatDate pattern="yyyy-MM-dd" value="${claim.start}"/>" required />
									</div>
									<div class="col-sm-6">
										<label>End Date</label><input class="form-control picker"
											id="end-date" name="end" placeholder="MM/DD/YYY" type="text"
											value="<fmt:formatDate pattern="yyyy-MM-dd"
																						value="${claim.end}" />" required />
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6">
										<label>Manager</label> <input type="text" name="manager"
											id="manager" class="form-control" required/>
									</div>
									<div class="col-sm-6">
										<label>Business Purpose</label><input type="text"
											name="purpose" id="purpose" class="form-control"
											required />
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6">
										<label>Advance</label><input type="number" name="advance"
											id="advance" class="form-control" required />
									</div>
									<div class="col-sm-6">
										<label>Department</label><select
											class="selectpicker form-control" name="department">
											<option value="Engineering">Engineering</option>
											<option value="HR">HR</option>
											<option value="Finance">Finance</option>
											<option value="Admin">Admin</option>
										</select>
									</div>
								</div>

							</div>
							<p id="errormsg" style="color: red; font-size: 20px;"></p>
							<div class="panel panel-inverse innerPanel" id="innerPanel">
								<div class="panel-heading">
									<div class="panel-heading-btn">
										<a href="javascript:;" id="add_row"
											class="btn btn-white btn-sm panelButton">Add Row</a> <a
											href="javascript:;" id='delete_row'
											class="btn btn-danger btn-sm m-l-5 panelButton">Delete
											Row</a>
									</div>
									<h4 class="panel-title">Attachment</h4>
								</div>

								<div class="panel-body">
									<table class="table table-bordered" id="item_table">

										<col width="80">
										<col width="120">
										<col width="200">
										<col width="120">
										<col width="100">
										<col width="150">
										<thead>
											<tr>
												<th class="text-center">#</th>
												<th class="text-center">Date</th>
												<th class="text-center">Description</th>
												<th class="text-center">Category</th>
												<th class="text-center">Cost</th>
												<th class="text-center">attachment</th>
											</tr>
										</thead>
										<tbody>
											<tr id='addr0'>
												<td>1</td>
												<td><input type="text" name='claimItems[0].expenseDate'
													id='expenseDate' placeholder='Date'
													class="form-control picker" required/></td>
												<td><input type="text" name='claimItems[0].description'
													placeholder='Description' class="form-control" required /></td>
												<td><select class="selectpicker form-control"
													name='claimItems[0].category'>
														<option value="travel">Travel</option>
														<option value="food">Food</option>
														<option value="admin">Admin</option>
														<option value="product">Product</option>
														<option value="other">Other</option>
												</select></td>
												<td><input type="number" name='claimItems[0].cost'
													placeholder='Cost' class="form-control" required/></td>
												<td><input type='file' name='upload_file'
													id='js-upload-files'></td>
											</tr>
											<tr id='addr1'></tr>
										</tbody>
									</table>
								</div>
							</div>

							<div class="panel-footer text-right">
								<div id="errorDiv" align="left">
									<p id="error" style="color: red; font-size: 20px;"></p>
								</div>
								<a href="javascript:;" class="btn btn-white btn-sm">Cancel</a> <input
									type="submit" class="btn btn-primary btn-sm m-l-5"
									value="Submit" />
							</div>
						</form>
					</div>
				</div>
				<!-- end panel -->
			</c:when>


			<c:when test="${mode == 'MODE_HISTORY'}">
				<div class="" id="tasksDiv">

					<h1 class="page-header1">Claim History</h1>

					<!-- begin panel -->
					<div class="panel panel-inverse claimPanel ">
						<div class="panel-heading">
							<h4 class="panel-title">History</h4>
						</div>
						<div class="panel-body">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th class="text-center">Claim Id</th>
										<th class="text-center">Submission Date</th>
										<th class="text-center">Period</th>
										<th class="text-center">Download</th>
										<th class="text-center">List</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="claim" items="${claimList}">
										<tr>
											<td>${claim.claimId}</td>
											<td><fmt:formatDate type="date"
													value="${claim.createDate}" /></td>
											<td><fmt:formatDate pattern="yyyy-MM-dd"
													value="${claim.start}" /> to <fmt:formatDate
													pattern="yyyy-MM-dd" value="${claim.end}" /></td>
											<td><a href="/claim-download?claimid=${claim.claimId}"><span
													class="glyphicon glyphicon-download"></span></a></td>
											
											<td>
												<div class="dropdown">
													<button class="btn btn-primary" onmouseover="getAttachmentList(${claim.claimId})">Attachments</button>
													<ul id="attachment-${claim.claimId}" onmouseleave="clearAttachmentList(${claim.claimId})" class="dropdown-menu animated fadeInLeft">
														
													</ul>

												</div>

											</td>

										</tr>

									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!-- end panel -->
				</div>
			</c:when>
		</c:choose>
	</div>


	<script type="text/javascript">
	
	function getAttachmentList(claimid){
		$(".file_list").remove();
		$.ajax({
			type : "GET",
			url : "file-list",
			data : "claimid=" + claimid,
			success : function(data) {
				
				var json = JSON.parse(data);
				for (x in json) {
					var title = json[x]["claimItemFile"];
					var claimid = json[x]["claimId"];
					
					 $("#attachment-"+claimid).append('<li><a class="file_list" href="/file-attachment?file_name='+title+'&claimid='+claimid+'">'+title+'</a></li>');
				        
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

	<script type="text/javascript">
		$('#js-upload-files').bind('change', function() {
		  if(this.files[0].size>1048576){
			  document.getElementById("errormsg").innerHTML ="File size Limit 1MB!";
		  }
		});
		</script>

	<script>
		$(document)
				.ready(
						function() {
							var i = 1;
							$("#add_row").click(function() {
												$('#addr' + i)
														.html("<td>"
																		+ (i + 1)
																		+ "</td><td><input name='claimItems["
																		+ i
																		+ "].expenseDate' type='text' placeholder='Date' class='form-control picker' onfocus='showDatePicker(this)'/> </td><td><input  name='claimItems["+i+"].description' type='text' placeholder='Description'  class='form-control input-md'></td><td><select class='selectpicker form-control' name='claimItems["+i+"].category'><option value='travel'>Travel</option><option value='food'>Food</option><option value='admin'>Admin</option><option value='product'>Product</option><option value='other'>Other</option></select></td><td><input  name='claimItems["+i+"].cost' type='number' placeholder='Cost'  class='form-control input-md'></td><td><input type='file' name='upload_file' id='js-upload-files' required></td>");
												
												$('#item_table').append(
														'<tr id="addr'
																+ (i + 1)
																+ '"></tr>');
												i++;
											});
							$("#delete_row").click(function() {
								if (i > 1) {
									$("#addr" + (i - 1)).html('');
									i--;
								}
							});
						});
	</script>
	
	<script>
		
		$('body').on('focus',".picker", function(){
		    $(this).datepicker({
				format : 'mm/dd/yyyy',
				todayHighlight : true,
				autoclose : true,
			});
		});
	</script>


	<script>
		function validateForm() {
			var startdate = document.forms["claim-form"]["start-date"].value;
			var enddate = document.forms["claim-form"]["end-date"].value;
			var manager = document.forms["claim-form"]["manager"].value;
			var advance = document.forms["claim-form"]["advance"].value;
			var purpose = document.forms["claim-form"]["purpose"].value;
			if (startdate.trim() == "" || enddate.trim() == ""
					|| manager.trim() == "" || advance.trim() == ""
					|| purpose.trim() == "") {
				document.getElementById("error").innerHTML = "All fields are mandatory! Kindly fill.";
				return false;
			}
		}
	</script>
</body>
</html>