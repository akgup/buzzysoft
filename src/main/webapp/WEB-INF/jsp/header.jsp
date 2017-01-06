<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <%@ page isELIgnored="false"%>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">

<link rel="stylesheet" href="static/css/bootstrap.min.css">
<script src="static/js/jquery.min.js"></script>
<script src="static/js/bootstrap.min.js"></script>
<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">

<link rel="stylesheet"	href='static/bootstrap/css/bootstrap-iso.css' />
</head>
<body>

	<%
		String userName = null;
		String userId = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username"))
					userName = cookie.getValue();
				if (cookie.getName().equals("userid"))
					userId = cookie.getValue();
			}
		}
		if (userName == null)
			response.sendRedirect("/");
	%>



	<nav class="navbar navbar-inverse  ">
		<div class="container-fluid ">
			<div class="navbar-header ">
				<a class="navbar-brand" href="/home?userid=<%=userId%>"><img src="/static/image/bb-logo.png"></img></a>
			</div>


			<ul class="nav navbar-nav">
					<!-- <li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Task<span class="caret"></span></a> -->
				
						
						<li><a href="all-tasks?userid=<%=userId%>">Work Log</a></li>
				


				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Claim<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/claim-form">New Claim</a></li>
						<li><a href="/claim-list?userid=<%=userId%>">Claim
								History</a></li>
					</ul></li>
					
					<li><a href="/direct-report?userid=<%=userId%>">My Team</a></li>

			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <span class="glyphicon glyphicon-user"></span> 
						<strong><%=userName%></strong> <span
						class="glyphicon glyphicon-chevron-down"></span>
				</a>
					<ul class="dropdown-menu">
						<li>
							<div class="navbar-login">
								<div class="row">
									<div class="col-lg-5">
									<p>
											<a href="/myProfile?userid=<%=userId%>" class="btn btn-primary btn-block">My Profile</a>
										</p>
									</div>
									
										<div class="col-lg-7">
									<p>
											<a href="/change-password" class="btn btn-info btn-block">Change Password</a>
										</p>
									</div>
								</div>
							</div>
						</li>
						<li class="divider"></li>
						<li>
							<div class="navbar-login navbar-login-session">
								<div class="row">
									<div class="col-lg-12">
										<p>
											<a href="/logout" class="btn btn-danger btn-block">Logout</a>
										</p>
									</div>
								</div>
							</div>
						</li>
					</ul></li>
			</ul>
		</div>
	</nav>

	<script src='static/js/jquery.min.js'></script>
	<script src="static/js/bootstrap.min.js"></script>
<script>
$(function(){
    $(".dropdown").hover(            
            function() {
                $('.dropdown-menu', this).stop( true, true ).fadeIn("fast");
                $(this).toggleClass('open');
                $('b', this).toggleClass("caret caret-up");                
            },
            function() {
                $('.dropdown-menu', this).stop( true, true ).fadeOut("fast");
                $(this).toggleClass('open');
                $('b', this).toggleClass("caret caret-up");                
            });
    });
    
</script>
</body>
</html>