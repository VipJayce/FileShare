<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Reference_page' bundle='${applicationAuResources}' /></title>
</head>
<body topmargin=0 leftmargin=0 >
	<script language="javascript">
		writeTableTop("<fmt:message key='gap.authority.Reference_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<iframe name="myTree" width="100%" height="500" src="<%=request.getContextPath()%>/AuRoleAction.do?cmd=queryUserList&roleId=<%=request.getParameter("roleId")%>">
	</iframe>
	<script language="javascript">
		writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
	</script>
</body>
</html>

