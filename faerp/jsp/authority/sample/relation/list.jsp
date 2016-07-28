<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.org.aupartyrelationtype.bs.IAuPartyRelationTypeBS" %>
<%
	String parentCode = (String)request.getAttribute("parent_code");
    IAuPartyRelationTypeBS bs = (IAuPartyRelationTypeBS)venus.frames.mainframe.util.Helper.getBean(gap.authority.org.aupartyrelationtype.util.IConstants.BS_KEY);
    String relationTypeName = ((gap.authority.org.aupartyrelationtype.vo.AuPartyRelationTypeVo)bs.find(parentCode.substring(0,19))).getName();
    String relid = request.getParameter("parentRelId");
    if(null==relid||"".equals(relid)){
        relid = null==request.getParameter("relationId")?"":request.getParameter("relationId");
    }
%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Organization_Management' bundle='${applicationAuResources}' /></title>
</head>
<body>

<form name="form" action="" method="post"> 
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title">组织架构行政联系管理</div>
	</div>
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
  <tr>
    <td width="205" id=frmTitle noWrap name="fmTitle" align="center" valign="top"><table width="171" height="100%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
      <tr>
        <td width="280" height="500" valign="top">
        <iframe name="tree" width="100%" height="100%"  frameborder=0  
				src="<%=request.getContextPath()%>/jsp/authority/tree/deeptree_iframe.jsp?
				rootXmlSource=<venus:base/>/jsp/authority/tree/treeLimitData.jsp?
				parent_code=<%=parentCode%>%26currentRelid%3D<%=relid%>%26data_limit%3D1%26return_type%3Dparty_id%26target%3Ddetail<%=parentCode%>%26url%3D<%=request.getContextPath()%>/RelationAction.do?cmd=detail">
			
</iframe></td>
      </tr>
    </table>		</td>
    <td width="100%" height="500" align="center" valign="top">

			<iframe id="detail<%=parentCode%>" name="detail<%=parentCode%>"	style="HEIGHT:100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 2" scrolling=auto frameborder=0 src="<%=request.getContextPath()%>/jsp/authority/sample/relation/default.jsp" ></iframe> 
		
</iframe></td>
  </tr>
</table>
</div>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>