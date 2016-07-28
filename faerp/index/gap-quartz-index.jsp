<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Gap-quartz</title>
	</head>

	<frameset cols="209,*" border="0">
		<frame src="<%=request.getContextPath()%>/jsp/quartz/taskmenu/TaskMenu.jsp" noresize>
		<frame src="<%=request.getContextPath()%>/queryJobSchedules.do" noresize border="0" frameborder="0">
	</frameset>

	<noframes>
		<body>
			对不起,您的浏览器不支持框架
		</body>
	</noframes>
</html>
