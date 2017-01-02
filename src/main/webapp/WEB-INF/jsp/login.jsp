<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">

<title>Task Manager | Home</title>

<link href="static/css/bootstrap.min.css" rel="stylesheet">
<link href="static/css/style.css" rel="stylesheet">

<!--[if lt IE 9]>
		<script src="static/js/html5shiv.min.js"></script>
		<script src="static/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>

	<c:choose>
		<c:when test="${mode == 'MODE_LOGIN'}">
			<div
				class="container col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-3 col-md-6 col-lg-offset-4 col-lg-4">
				<br />
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3>Login</h3>
					</div>
					<form class="form-horizontal" method="POST" action="validate">
						<div class="panel-body">
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon"> <i
										class="glyphicon glyphicon-user" style="width: auto"></i>
									</span> <input id="txtUsername" type="text" value="${user.userName}"
										class="form-control" name="userName" placeholder="Username"
										required />
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<span class="input-group-addon"> <i
										class="glyphicon glyphicon-lock" style="width: auto"></i>
									</span> <input id="txtpasswd" type="password" value="${user.password}"
										class="form-control" name="password" placeholder="Password"
										required />
								</div>
							</div>



							<button id="btnLogin" type="submit" class="btn btn-default"
								style="width: 100%">
								Login<i class="glyphicon glyphicon-log-in"></i>
							</button>
						</div>
					</form>
				</div>
			</div>
		</c:when>




	</c:choose>
	<script src="static/js/jquery-1.11.1.min.js"></script>
	<script src="static/js/bootstrap.min.js"></script>
</body>
</html>