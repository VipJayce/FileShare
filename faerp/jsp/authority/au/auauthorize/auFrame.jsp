<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Authorization_page' bundle='${applicationAuResources}' /></title>
</head>
<%
	String retMessage = (String)request.getAttribute("retMessage");
	if(retMessage!=null) {
		out.print("<script language='javascript'>alert('"+retMessage+"'); parent.window.close();</script>");
	} 
%>
<body topmargin=0 leftmargin=0 >
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Authorization_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<table class="table_noFrame">
	<tr>
		<td>&nbsp;&nbsp;
			<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Save' bundle='${applicationAuResources}' />" onClick="javascript:myTree.saveOnClick();">
			<input name="button_cancel" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onclick="javascript:window.close();" >
		</td>
	</tr>
</table>
<table class="table_noFrame" width="100%">
  <tr> 
     <td valign="top" width="100%"> 
     	<!--树开始--> 
		<iframe name="myTree" width="100%" height="600" src="<%=request.getContextPath()%>/AuAuthorizeAction.do?cmd=<%=request.getParameter("cmd")%>&relId=<%=request.getParameter("relId")%>&pType=<%=request.getParameter("pType")%>&rType=<%=request.getParameter("rType")%>"></iframe>
		<!--树结束-->
    </td>
  </tr>
</table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

