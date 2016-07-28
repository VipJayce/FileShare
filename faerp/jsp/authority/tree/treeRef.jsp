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
<table class="table_noFrame">
	<tr>
		<td>&nbsp;&nbsp;
			<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Determine' bundle='${applicationAuResources}' />" onClick="javascript:myTree.returnValueName();">
			<input name="button_cancel" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onclick="javascript:window.close();" >
		</td>
	</tr>
</table>
<table class="table_noFrame">
  <tr> 
     <td width="100%" valign="top"> 
		<!--树开始-->    
		<iframe name="myTree" width="100%" height="450" src="deeptree.jsp
			?inputType=<%=request.getParameter("inputType")%>
			&submitType=<%=request.getParameter("submitType")==null?"submitAll":request.getParameter("submitType")%>
			&nodeRelationType=<%=request.getParameter("nodeRelationType")==null?"hasRelation":request.getParameter("nodeRelationType")%>
			&rootXmlSource=<%=gap.authority.util.StringHelperTools.encodeUrl(request.getParameter("rootXmlSource"))%>">
		</iframe>
		<!--树结束-->
    </td>
  </tr>
</table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

