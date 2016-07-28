<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<%
String rootXmlSource=request.getContextPath()+"/jsp/authority/au/auauthorize/orgWithFunction.jsp?parent_code="+request.getParameter("rootCode")+"&relId="+request.getParameter("relId")+"&pType="+request.getParameter("pType");
%>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Authorization_page' bundle='${applicationAuResources}' /></title>
</head>
<body topmargin=0 leftmargin=0 >
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Authorization_page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<table class="table_noFrame">
	<tr>
		<td>&nbsp;&nbsp;
			<input name="button_ok" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Save' bundle='${applicationAuResources}' />" onClick="javascript:orgTree.saveOnClick();">
			<input name="button_cancel" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onclick="javascript:window.close();" >
		</td>
	</tr>
</table>
<table  class="table_noFrame" width="100%">
<tr><td width="65%">
<table class="table_noFrame" width="100%">
  <tr> 
     <td valign="top" width="100%"> 
     	<!--树开始--> 
		<iframe id="myTree" name="myTree" width="100%" height="600" src="<%=request.getContextPath()%>/AuAppendAction.do?cmd=<%=request.getParameter("cmd")%>&relId=<%=request.getParameter("relId")%>&pType=<%=request.getParameter("pType")%>&rType=<%=request.getParameter("rType")%>"></iframe>
		<!--树结束-->
    </td>
  </tr>
</table>
</td><td width="35%">
<table class="table_noFrame" width="100%">
  <tr> 
     <td valign="top" width="100%"> 
     	<input type="hidden" name="orgTreeSrc" id="orgTreeSrc" value="<%=request.getContextPath()%>/jsp/authority/tree/deeptree4AuOrg.jsp?inputType=checkbox&submitType=submitAll&nodeRelationType=noRelation&relId=<%=request.getParameter("relId")%>&pType=<%=request.getParameter("pType")%>&rootXmlSource=<%=gap.authority.util.StringHelperTools.encodeUrl(rootXmlSource)%>">
     	<!--树开始--> 
		<iframe id="orgTree" name="orgTree" width="100%" height="600" src="<%=request.getContextPath()%>/jsp/authority/au/auauthorize/default.jsp"></iframe>
		<!--树结束-->
    </td>
  </tr>
</table>
</td></tr></table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

