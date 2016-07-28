<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ page import = "gap.authority.au.auuser.util.IAuUserConstants" %>
<%
    String hasLoginid = (String)request
				.getAttribute(IAuUserConstants.REQUEST_BEAN_VALUE);
	String result="<font color=green><fmt:message key='gap.authority.Do_not_duplicate_names_you_can_' bundle='${applicationAuResources}' /></font>";	
	if(hasLoginid.equals("true")){
		result="<font color=red><fmt:message key='gap.authority.Duplicate_names_replace_login_names_' bundle='${applicationAuResources}' /></font>";
	}
%>
<title><fmt:message key='gap.authority.Login_name_of_the_authentication_page' bundle='${applicationAuResources}' /></title>
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Login_name_of_the_validation' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<table width="100%" height="100%" border="0">
	<tr>
		<td nowrap align=center><%=result%></td>
	</tr>
	<tr>
		<td align=center><input type=button value=<fmt:message key='gap.authority.Close' bundle='${applicationAuResources}' /> class="button_ellipse" onClick=javascript:window.close();return false;></td>
	</tr>
</table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

