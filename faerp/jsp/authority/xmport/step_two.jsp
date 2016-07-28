<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.util.StringHelperTools"%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Import_Step_2' bundle='${applicationAuResources}' /></title>
</head>
<link href="<venus:base/>/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<script language="javascript">
	var tabs  =  new Array(
		new Array ("&nbsp;&nbsp;&nbsp;SQL<fmt:message key='gap.authority.Tactics' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;","<venus:base/>/jsp/authority/xmport/sql_strategy.jsp?operate=<%=request.getParameter("operate")%>&organize=<%=request.getParameter("organize")%>&relation=<%=StringHelperTools.prt(request.getParameter("relation"))%>"),	
		new Array ("&nbsp;&nbsp;&nbsp;JAVA<fmt:message key='gap.authority.Tactics' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;","<venus:base/>/XmportAction.do?cmd=step_two4JAVA&operate=<%=request.getParameter("operate")%>&organize=<%=request.getParameter("organize")%>&relation=<%=StringHelperTools.prt(request.getParameter("relation"))%>"),
		new Array ("&nbsp;&nbsp;&nbsp;XML<fmt:message key='gap.authority.Tactics' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;","<venus:base/>/jsp/authority/xmport/xml_strategy.jsp"),
		new Array ("&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Reuse_strategy' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;","<venus:base/>/XmportAction.do?cmd=step_two4ALLXML&operate=<%=StringHelperTools.prt(request.getParameter("relation"))%>&superCode=<%=StringHelperTools.prt(request.getParameter("id3"))%>")
	); 
</script>
<script src="<venus:base/>/js/au/tabs.js"></script>
<body onload="writeTabs(600);">
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Import_Step_2' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_back" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onclick="javascript:returnBack();" >
		</td>
	</tr>
</table>
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.Import_Step_2' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="auDivChild0"> 
<table class="table_div_content" style="width:96%">
	<tr>
		<td>
			<table width="100%">
			  <tr>
				<td>
				<div id="tabsDiv"></div>
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

