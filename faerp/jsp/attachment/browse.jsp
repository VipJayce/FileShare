<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="java.util.List"%>
<%@page import="com.alexander.businessdata.bo.AttachmentBrowsedBo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>version</title>
</head>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<body>
<table width="80%">
  <tr align="center" bgcolor="#CCCCCC">
    <td nowrap><fmt:message key="serial_number" bundle="${applicationResources}"/></td>
    <td nowrap><fmt:message key="reader"/></td>
    <td nowrap><fmt:message key="reading_date"/></td>
    <td nowrap><fmt:message key="message"/></td>
  </tr>
  	<%
	List attachments = (List)request.getAttribute("attachments");
	for(int i=0;attachments!=null&&i<attachments.size();i++ ){
		AttachmentBrowsedBo bo = (AttachmentBrowsedBo)attachments.get(i);
	%>
  <tr>
    <td nowrap align="center"><%=i%></td>
    <td nowrap align="center"><%=bo.getReader()%></td>
    <td nowrap align="center"><%=bo.getBrowsedDate()%></td>
    <td nowrap align="center"><%=bo.getLeaveword()%></td>
  </tr>
  <%}%>
</table>
</body>
</fmt:bundle>
</html>