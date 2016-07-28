<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Organization' bundle='${applicationAuResources}' /></title>
</head>
<body topmargin=0 leftmargin=0 >
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Reference_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<iframe name="myTree" width="100%" height="100%" src="<%=request.getContextPath()%>/AuPartyAction.do?cmd=queryByOrgType&typeId=<%=request.getParameter("typeId")%>">
</iframe>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

