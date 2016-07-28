<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<%
//from StartProcessAction
String processname=(String)request.getAttribute("processname");
%>

</HEAD>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="process_operating_result"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<!-- 列表开始 -->
<div id="ccParent1">
<table class="table_div_control">
	<tr>
		<td colspan="2" class="th_bar"><fmt:message key="launch_process_sucess"/></td>
	</tr>
	<tr>
		<td class="th_1"><fmt:message key="process_name"/></td>
		<td>
		<input name="pd_name" type="text" class="textfield_noFrame" value="<%=processname%>" readonly>
		</td>
	</tr>
</table>
</div>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</HTML>