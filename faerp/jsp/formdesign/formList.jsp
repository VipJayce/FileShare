<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%
	String subWindow = request.getParameter("subwindow");
	String isFlow = request.getParameter("isflow");
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>
		  <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
		      <fmt:message key="form_select_page"/>
		  </fmt:bundle>
		</title>
	</head>

	<%
	if ("true".equals(subWindow) && "true".equals(isFlow)) {
	%>
	<frameset rows="0,*" border="0">
		<frame src="about:blank">
		<frame name="listBody" src="<%=request.getContextPath()%>/formDesign.do?cmd=list&subwindow=true&isflow=true" noresize border="0" frameborder="0">
	</frameset>
	<%
	} 
	%>
	
	<%
	if ("true".equals(subWindow) && (isFlow == null)) {
	%>
	<frameset rows="0,*" border="0">
		<frame src="about:blank">
		<frame name="listBody" src="<%=request.getContextPath()%>/formDesign.do?cmd=list&subwindow=true" noresize border="0" frameborder="0">
	</frameset>
	<%
	}
	%>

	<%
	if ((subWindow == null) && (isFlow == null)) {
	%>
	<frameset rows="0,*" border="0">
		<frame src="about:blank">
		<frame name="listBody" src="<%=request.getContextPath()%>/formDesign.do?cmd=list" noresize border="0" frameborder="0">
	</frameset>
	<%
	}
	%>

	<noframes>
		<body>
			对不起,您的浏览器不支持框架
		</body>
	</noframes>
</html>