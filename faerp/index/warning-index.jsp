<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<html>
	<head>
		<title><fmt:message key="title"/></title>
	</head>
    <logic:notEmpty  name="local_in_sesson_key" scope="session">
        <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
    </logic:notEmpty>
    <fmt:setBundle basename="ApplicationResources" scope="session" var="applicationResources"/>
	<frameset cols="209,*" border="0">
		<frame src="<%=request.getContextPath()%>/jsp/warning/taskmenu/TaskMenu.jsp" noresize>
		<frame src="<%=request.getContextPath()%>/WarningObjectAction.do?cmd=queryAllWarningObjects" noresize border="0" frameborder="0">
	</frameset>

	<noframes>
		<body>
			对不起,您的浏览器不支持框架
		</body>
	</noframes>
</html>
</fmt:bundle>