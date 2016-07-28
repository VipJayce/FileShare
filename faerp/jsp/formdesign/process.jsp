<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.net.URLEncoder" %>

<html>
    <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
	<head>
		<title><fmt:message key="form_upload"/></title>
	<script language="javascript">
	<!--
	function closeAndRefreshWindow() {
		window.opener.location.href = '<%=request.getContextPath()%>/formDesign.do?cmd=importFile&fileName=<%=URLEncoder.encode(request.getAttribute("fileName").toString(),"UTF-8")%>';
		window.close();
	}
	//-->
	</script>
	</head>

	<body scroll="no" style="OVERFLOW: hidden" style="background-color: #EBE9ED;">
		<p align="center">
			<br/><br/><font color="#000080"><fmt:message key="form_upload_success"/></font><br/><br/>
			<input type="button" value='<fmt:message key="close" bundle="${applicationResources}"/>' onclick="javascript:closeAndRefreshWindow();"/>
		</p>
	</body>
    </fmt:bundle>
</html>