<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Gap-Report</title>
        <logic:notEmpty  name="local_in_sesson_key" scope="session">
        <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
        </logic:notEmpty>
	    <fmt:setBundle basename="ApplicationResources" scope="session" var="applicationResources"/>
	</head>

	<frameset cols="209,*" border="0">
		<frame src="<%=request.getContextPath()%>/jsp/report/taskmenu/TaskMenu.jsp" noresize>
		<frame src="<%=request.getContextPath()%>/ReportAction.do?cmd=queryReporta" noresize border="0" frameborder="0">
	</frameset>

	<noframes>
		<body>
			对不起,您的浏览器不支持框架
		</body>
	</noframes>
</html>
