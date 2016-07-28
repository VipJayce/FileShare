<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Business Process Manager System</title>
		      <logic:notEmpty  name="local_in_sesson_key" scope="session">
                <fmt:setLocale value="${local_in_sesson_key}" scope="session"/>
            </logic:notEmpty>
           <fmt:setBundle basename="ApplicationResources" scope="session" var="applicationResources"/>
	</head>

	<frameset rows="99,*,0" border="0">
		<frame name="topFrame" src="<%=request.getContextPath()%>/common/top_workflow.jsp" scrolling=no noresize>
		<frame src="<%=request.getContextPath()%>/common/centerframe_workflow.htm" name="left"/>
		<frame src="<%=request.getContextPath()%>/jsp/homepage/hidden.htm" name="hiddenFrame" frameborder="no" scrolling="no" noresize id="hiddenFrame">
	</frameset>
	
	<noframes>
		<body>
			对不起,您的浏览器不支持框架
		</body>
	</noframes>
</html>
