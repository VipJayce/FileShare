<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Gap-DD</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <logic:notEmpty  name="local_in_sesson_key" scope="session">
        <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
        </logic:notEmpty>
	    <fmt:setBundle basename="ApplicationResources" scope="session" var="applicationResources"/>
	    <fmt:setBundle basename="gap.dd.dd_resource" scope="session" var="dd"/>
	</head>

	<frameset cols="180,*" border="0">
		<frame src="<%=request.getContextPath()%>/jsp/dd/taskmenu/TaskMenu.jsp" noresize>
		<frame src="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryTables" noresize border="0" frameborder="0">
	</frameset>

	<noframes>
		<body>
			对不起,您的浏览器不支持框架
		</body>
	</noframes>
</html>
