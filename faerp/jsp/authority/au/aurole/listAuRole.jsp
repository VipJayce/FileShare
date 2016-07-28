<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
	String parentCode = (String)request.getAttribute("parent_code");
%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Role_management' bundle='${applicationAuResources}' /></title>
</head>
<body>
 <form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">角色管理</div>
	</div>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
  <tr>
    <td width="205" id=frmTitle noWrap name="fmTitle" align="center" valign="top"><table width="171" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
      <tr>
        <td width="220" height="500" valign="top"><iframe name="tree" height="100%" width="100%" src="<%=request.getContextPath()%>/jsp/authority/tree/deeptree_iframe.jsp?
				rootXmlSource=<venus:base/>/jsp/authority/au/aurole/xmlData.jsp?parent_code=<%=parentCode%>%26data_limit%3D1" border="0" frameborder="0" scrolling="yes"></iframe></td>
      </tr>
    </table>		</td>
    <td width="100%" height="500" align="center" valign="top">	<iframe id="detail" width="100%"  height="100%" name="detail"	style="HEIGHT:100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 2" scrolling=auto frameborder=0 src="<%=request.getContextPath()%>/jsp/authority/au/aurole/default.jsp" ></iframe> 
			</iframe></td>
  </tr>
</table>
</div>
</form>
 
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

	

