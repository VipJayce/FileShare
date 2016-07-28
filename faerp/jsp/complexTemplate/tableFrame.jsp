<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%
	boolean isModify = false;
	if(request.getParameter("isModify") != null) {
		isModify = true;
	}	
	
    String empId = request.getParameter("empId");
    String id = request.getParameter("id");
    String tableId = request.getParameter("tableId");
%>
<html>
<title><fmt:message key="reference_page" bundle="${applicationResources}"/></title>
<!--</head> -->
<body>

<%if(tableId.equals("A")) {%>

	<%if(isModify) {%>
	<iframe src="<venus:base/>/ChildTableAAction.do?cmd=find&empId=<%=empId%>&id=<%=id%>&isModify=<%=isModify%>" frameBorder=0 scrolling=yes style="width:100%;height:100%" ></iframe>
	<%} else {%>
	<iframe src="<venus:base/>/ChildTableAAction.do?cmd=toAdd&empId=<%=empId%>" frameBorder=0 scrolling=yes style="width:100%;height:100%" ></iframe>
	<%}%>

<%} else {%>

	<%if(isModify) {%>
	<iframe src="<venus:base/>/ChildTableBAction.do?cmd=find&empId=<%=empId%>&id=<%=id%>&isModify=<%=isModify%>" frameBorder=0 scrolling=yes style="width:100%;height:100%" ></iframe>
	<%} else {%>
	<iframe src="<venus:base/>/ChildTableBAction.do?cmd=toAdd&empId=<%=empId%>" frameBorder=0 scrolling=yes style="width:100%;height:100%" ></iframe>
	<%}%>

<%}%>
</fmt:bundle>
</body>
</html>