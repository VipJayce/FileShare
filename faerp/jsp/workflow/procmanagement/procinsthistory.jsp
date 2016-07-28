<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="gap.wf.wapi.worklist.TaskItem"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="gap.wf.wapi.snapshot.ProcessInstanceSnapShot"%>
<%@ page import="gap.wf.wapi.snapshot.ActivityInstanceSnapShot"%>
<%@ page import="gap.wf.bizcommon.data.RelevantDataDTO"%>

<%
List actInstlist = new ArrayList();
ProcessInstanceSnapShot procInst = null;

actInstlist = (ArrayList)request.getAttribute("actInstlist");
procInst = (ProcessInstanceSnapShot)request.getAttribute("procInst");
%>

<SCRIPT language=Javascript>
function querytask() 
{
	window.location="<%=request.getContextPath()%>/queryTaskByPersonIDAction.do";
}

function querydonetask() 
{
	window.location="<%=request.getContextPath()%>/queryTaskByPersonIDAction.do?done=true";
}
</SCRIPT>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
writeTableTop('<fmt:message key="historical_process_information"/>','<%=request.getContextPath()%>/');
</script>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr>
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
			<fmt:message key="historical_activity_list"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
	<table class="table_div_content2">
		<tr>
		  <td colspan="4">

		  </td>
	  	</tr>
	  	
		<tr>
			<td><strong><fmt:message key="process_instance_id"/></strong></td>
			<td><%=procInst.getProcInstID()%></td>
			<td><strong><fmt:message key="process_instance_name"/></strong></td>
			<td><%=procInst.getName()%></td>
		</tr>
		
		<tr>
			<td><strong><fmt:message key="process_definition_id"/></strong></td>
			<td><%=procInst.getProcDefID()%></td>
			<td><strong><fmt:message key="process_definition_version"/></strong></td>
			<td><%=procInst.getVersion()%></td>
		</tr>
		
		<tr>
			<td><strong><fmt:message key="process_instance_launch_time"/></strong></td>
			<td><%=procInst.getStartTime()%></td>
			<td><strong><fmt:message key="process_instance_deadLine"/></strong></td>
			<td><%=procInst.getDeadLine()%></td>
		</tr>
		
		<tr>
			<td><strong><fmt:message key="process_initiator_id"/></strong></td>
			<td><%=procInst.getInitiatorID()%></td>
			<td><strong><fmt:message key="process_state"/></strong></td>
			<td><%=procInst.getState()%></td>
		</tr>
		
		<%for(Iterator iter=actInstlist.iterator();iter.hasNext();){
			ActivityInstanceSnapShot bean = (ActivityInstanceSnapShot)iter.next();
		%>
		<tr>
			<td colspan="6">
			<table width="80%" align="center" class="table_dashed" id="table_toolbar4">
				<tr>
					<td colspan="6" class="th_3">
					<fmt:message key="activity_instance_information" >
					   <fmt:param><%=bean.getActDefID()%></fmt:param>
					</fmt:message></td>
				</tr>
				<tr>
					<td class="th_1" nowrap><fmt:message key="activity_name"/></td>
					<td nowrap><%=bean.getName()%></td>
					<td class="th_1" nowrap><fmt:message key="activity_instance_id"/></td>
					<td nowrap><%=bean.getActInstID()%></td>
					<td class="th_1" nowrap><fmt:message key="activity_instance_state"/></td>
					<td nowrap><%=bean.getState()%>（<%=bean.getStateChangeReasonDesc()%>）</td>
				</tr>
				<tr>
					<td class="th_1" nowrap><fmt:message key="resume_time"/></td>
					<td nowrap><%=bean.getActiveTime()%></td>
					<td class="th_1" nowrap><fmt:message key="commit_time"/></td>
					<td nowrap><%=bean.getCommitTime()%></td>
					<td class="th_1" nowrap><fmt:message key="limit_time"/></td>
					<td nowrap><%=bean.getDeadLine()%></td>
				</tr>
				<tr>
				    <td class="th_1" nowrap><fmt:message key="assign_strategy"/></td>
				    <td nowrap><%= bean.getAssignStrategy()%></td>
				    <td class="th_1" nowrap><fmt:message key="execute_strategy"/></td>
				    <td nowrap><%= bean.getExecuteStrategy()%></td>
				    <td class="th_1" nowrap><fmt:message key="commit_strategy"/></td>
				    <td nowrap><%= bean.getCommitStrategy()%></td>
				</tr>
			</table>
			</td>
		</tr>
		<%}%>
		<tr>
			<td colspan="6">
			<input name="goback" type="button" value='<fmt:message key="return" bundle="${applicationResources}" />' onclick="javascript:history.back(1);" class="button_ellipse">
			<input name="Submit" type="button" value='<fmt:message key="view_all_completed_task"/>' onclick="querydonetask();" class="button_ellipse">
			<input name="Submit" type="button" value='<fmt:message key="view_all_actived_task"/>' onclick="querytask();" class="button_ellipse">
			</td>
		</tr>
	</table>
</div>
<script language="javascript">
writeTableBottom('<%=request.getContextPath()%>/');
</script>
</fmt:bundle>
</body>
</HTML>