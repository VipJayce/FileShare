<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.quartz.quartz_resource" prefix="gap.quartz.">

<%String errorInfo = (String)request.getAttribute("errorInfo");
%>
<html>
	<head>
		<title><fmt:message key="Error_Page"/></title>
	</head>
<script language="javascript">
	writeTableTop('<fmt:message key="Error_Page"/>','<venus:base/>/');
</script>
	<body>
		<font face="Comic Sans MS" size=8>
		<blockquote>
		<center>
		<h2><fmt:message key="Error_Info"/></h2>
		</center>
		<span id="errorInfo"><h1><font color=red><%=errorInfo%></font></h1>
		</span>
		</blockquote>
		</font>
	</body>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</fmt:bundle>	
</html>
