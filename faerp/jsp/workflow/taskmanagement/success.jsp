<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%String msg=(String)request.getAttribute("msg");%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script language="Javascript">
function querytask() {
    window.location="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
}

function querytaskdone() {
    window.location="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=true";
}
</script>
</head>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="process_operating_result"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<!-- 列表开始 -->
<div id="ccParent1"> 
<table class="table_div_control">
	<tr>
		<td>
		<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
		<fmt:message key="operation_successful" bundle="${applicationResources}" />
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content">
	<tr>
		<td><fmt:message key="complete_information"/><textarea name="reason" cols="60" rows="6" readonly><%=msg%></textarea></td>
		<td>&nbsp;
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<!--
			<input name="goback" type="button" class="button_ellipse" value='<fmt:message key="return" bundle="${applicationResources}" />'  onClick="javascript:history.back(1);">
			-->
			<input name="Submit1" type="button" class="button_ellipse" value='<fmt:message key="view_all_actived_task"/>' onClick="querytask();">
			<input name="Submit2" type="button" class="button_ellipse" value='<fmt:message key="view_all_completed_task"/>' onClick="querytaskdone();">
		</td>
	</tr>
</table>
</div>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>