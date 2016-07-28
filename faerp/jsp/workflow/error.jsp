<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<%
String msg=(String)request.getAttribute("msg");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<SCRIPT language="Javascript">
function querytask()
{
	window.location="<%=request.getContextPath()%>/queryTaskByPersonIDAction.do";
}

function querytaskdone() 
{
	window.location="<%=request.getContextPath()%>/queryTaskByPersonIDAction.do?done=true";
}
</SCRIPT>
</head>

<body>
<script language="javascript">
	writeTableTop('<fmt:message key="process_operation_failed"/>','<%=request.getContextPath()%>/');
</script>

<!-- 列表开始 -->
<div id="ccParent1"> 
<table class="table_div_control">
	<tr>
		<td>
		<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"> 
        <span class="font_warnning"><fmt:message key="operation_failed" bundle="${applicationResources}" /></span>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content2">
		<%if(request.getAttribute("taskname")!=null){%>
		<tr>
			<td><fmt:message key="task_name"/></td>
			<td><%=request.getAttribute("taskname").toString()%></td>
		</tr>
		<%}%>
		<%if(request.getAttribute("processid")!=null){%>
		<tr>
			<td><fmt:message key="process_external_definition_id"/></td>
			<td><%=request.getAttribute("processid").toString()%></td>
		</tr>
		<%}%>
		<tr>
			<td><fmt:message key="reasons_for_failure"/></td>
			<td><textarea name="reason" cols="60" rows="6" readonly><%=msg%></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<input name="goback" type="button" class="button_ellipse"  value='<fmt:message key="return" bundle="${applicationResources}" />' onclick="javascript:history.back(1);">
				<input name="Submit1" type="button" class="button_ellipse"  value='<fmt:message key="view_all_actived_task"/>' onclick="querytask();">
				<input name="Submit2" type="button" class="button_ellipse" value='<fmt:message key="view_all_completed_task"/>' onclick="querytaskdone();">
			</td>
		</tr>
</table>
</div>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');
</script>
</body>
</html>