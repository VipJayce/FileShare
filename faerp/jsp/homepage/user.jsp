<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GAP<fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
</head>
<%
	String loginName = LoginHelper.getLoginName(request);
	if( loginName == null ) {
%>
	<script language="javascript">
		self.parent.parent.location="<%=request.getContextPath() %>/jsp/login/login.jsp?errorType=1";
	</script>
<%
	}
%>
<body>
<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td bgcolor="#D6E8F4">&nbsp;</td>
    <td bgcolor="#D6E8F4"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
		<td height="25"><img src="<%=request.getContextPath() %>/images/index/user_m.jpg" width="17" height="19"><span class="wel"><%=loginName%>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Hello_' bundle='${applicationAuResources}' /></span></td>
      </tr>
    </table></td>
    <td height="3" valign="top" align="right" bgcolor="#D6E8F4"><img src="<%=request.getContextPath() %>/images/index/user_l_r.jpg" width="19" height="23"></td>
  </tr>
</table>
<table height="27" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="<%=request.getContextPath() %>/images/index/user_dif.jpg" width="175"></td>
  </tr>
</table>
</body>
</html>

