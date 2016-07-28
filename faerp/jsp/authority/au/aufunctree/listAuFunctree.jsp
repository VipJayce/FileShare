<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Function_Menu_Management' bundle='${applicationAuResources}' /></title>
</head>
<body>
 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">菜单管理</div>
	</div>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
  <tr>
    <td width="205" id=frmTitle noWrap name="fmTitle" align="center" valign="top"><table width="171" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
      <tr>
        <td width="220" height="500" valign="top"><iframe id="funcTree" name="funcTree" height="100%" width="220" src="<%=request.getContextPath()%>/jsp/authority/tree/deeptree.jsp?rootXmlSource=<%=request.getContextPath()%>/jsp/authority/au/aufunctree/rootXmlData.jsp?root_code=101" border="0" frameborder="0" scrolling="yes"></iframe></td>
      </tr>
    </table>		</td>
    <td width="100%" height="500" align="center" valign="top"><iframe id="detailAuFunctree" name="detailAuFunctree" height="100%" width="100%" border="0" frameborder="0" src="<%=request.getContextPath()%>/jsp/authority/au/aufunctree/default.jsp" scrolling="yes"></iframe></td>
  </tr>
</table>
</div>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

	

