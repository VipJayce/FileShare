<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<%@ page import="com.use.tools.helper.VoHelperTools" %>
<%@ page import="com.alexander.workflow.extend.util.DynamicRelevantData" %>
<%@ page import="gap.wf.wapi.restrict.OvertimeState" %>
<%@ page import="java.util.List" %>

<%
	boolean done = false;
	if("true".equals(request.getParameter("done")))
		done = true;
	List rdList = (List)request.getAttribute("relevantDataList");
	String procName = (String)request.getAttribute("procName");
	String registerRelevantData = request.getParameter("registerRelevantData");
%>

<jsp:include page="/workflowForm/globalForm.jsp" flush="true"/>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">

	var checkboxName="checkbox_template";

	//find taskUid
	function findSelTaskUid(){
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array0 = arrayAll[0];
 
				ids.push(array0);  //加入选中的checkbox
			}
		}

		if(ids == null) {  //如果ids为空
	  		alert(i18n.please_select_a_record);
	  		return;
		}
		if(ids.length > 1) {
	  		alert(i18n.can_only_select_a_record);
	  		return;
		}

		return ids;
	}

	//find procInstID
	function findSelProcInstID(){
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array1 = arrayAll[1];
 
				ids.push(array1);  //加入选中的checkbox
			}
		}

		if(ids == null) {  //如果ids为空
	  		alert(i18n.please_select_a_record);
	  		return;
		}
		if(ids.length > 1) {
	  		alert(i18n.can_only_select_a_record);
	  		return;
		}

		return ids;
	}

	//find ProcDefID
	function findSelProcID(){
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array2 = arrayAll[2];
 
				ids.push(array2);  //加入选中的checkbox
			}
		}

		if(ids == null) {  //如果ids为空
	  		alert(i18n.please_select_a_record);
	  		return;
		}
		if(ids.length > 1) {
	  		alert(i18n.can_only_select_a_record);
	  		return;
		}

		return ids;
	}

	function accept(){
		var theid=findSelTaskUid();
	    if(theid==null)return;
		if(!window.confirm(i18n_wf.whether_to_accept_this_task))return;
		var form = document.all["form"];
		form.action = "<%=request.getContextPath()%>/accepttask.do?taskuid="+theid;
		form.submit();
	}

	//需要与 globalForm.jsp 同步
	function rollback(){
		var theid=findSelTaskUid();
	    if(theid==null)return;
		if(!window.confirm(i18n_wf.whether_to_rollback_this_task))return;
		/*马啸注释
		var form = document.all["form"];
		var stateReason = window.prompt("退回任务的原因/备注？","");
		if(stateReason!=null && ""!=stateReason){
    		var oNewItem1 = document.createElement("input");
    		oNewItem1.type = "hidden";
    		oNewItem1.name = "stateReason";
    		oNewItem1.value = stateReason;
    		form.insertAdjacentElement("afterBegin",oNewItem1);
		}*/
		var obj =window.showModalDialog('<venus:base/>/EditRollbackReasonAction.do','','dialogHeight:300px;dialogWidth:480px;center:yes;help:no;resizable:no;scroll:no;status:no;');
		if(obj==null)return;
		var oNewItem1 = document.createElement("input");
		oNewItem1.type = "hidden";
		oNewItem1.name = "stateReason";
		oNewItem1.value = obj[0];
		form.insertAdjacentElement("afterBegin",oNewItem1);
		//window.open('<venus:base/>/EditRollbackReasonAction.do');
		form.action = "<%=request.getContextPath()%>/rollbacktask.do?taskuid="+theid;
		form.submit();
		//alert("'"+obj[0]+"'")
	}
	
	function history(){
		var theid=findSelProcInstID();
	    if(theid==null)return;
		window.location.href = "queryhistory.do?flag=query&procInstID="+theid;
	}
	
	function monitor(){
		var procID=findSelProcID();
	    if(procID==null)return;
		var procInstID=findSelProcInstID();
		if(procInstID==null)return;
		window.location.href = "<%=request.getContextPath()%>/MonitorByProcInstIdAction.do"
			+"?procDefID="+procID
			+"&procInstID="+procInstID;
	}

	function withdraw(){
		var theid=findSelTaskUid();
	    if(theid==null)return;
		if(!window.confirm(i18n_wf.whether_to_withdraw_this_task))return;
		var form = document.all["form"];
		form.action = "<%=request.getContextPath()%>/withdrawtask.do?flag=delete&taskuid="+theid;
		form.submit();
	}

	function showRollBackReason(taskItemId){//马啸添加  查看退回理由
		window.showModalDialog('<venus:base/>/ShowRollbackReasonAction.do?taskuid='+taskItemId,'','dialogHeight:300px;dialogWidth:480px;center:yes;help:no;resizable:no;scroll:no;status:no;');
		//window.open('<venus:base/>/ShowRollbackReasonAction.do?taskuid='+taskItemId);
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script language="javascript">
    if(<%=done%>)
           writeTableTop('<fmt:message key="completed_task"/>','<venus:base/>/');
     else
       writeTableTop('<fmt:message key="actived_task"/>','<venus:base/>/');
</script>

<form name="form" method="post" id="form">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr>
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
			<%if(done) {%>
                <fmt:message key="query_completed_task"/>
            <% }else {%>
                <fmt:message key="query_actived_task"/>
            <%} %>
		</td>
		<td>
			<table align="right">
				<tr>
					<%if(done){%>
					<td nowrap class="button_ellipse" onClick = "javascript:queryHistoryTask();">
					<img src="<%=request.getContextPath()%>/images/icon/view.gif" class="div_control_image"><fmt:message key="view" bundle="${applicationResources}" /></td>
					<td nowrap class="button_ellipse" onClick = "javascript:withdraw();">
					<img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="withdraw"/></td>
					<td nowrap class="button_ellipse" onClick = "javascript:history();">
					<img src="<%=request.getContextPath()%>/images/icon/history.gif" class="div_control_image"><fmt:message key="history"/></td>
					<td nowrap class="button_ellipse" onClick = "javascript:monitor();">
					<img src="<%=request.getContextPath()%>/images/icon/monitor.gif" class="div_control_image"><fmt:message key="monitor"/></td>
					<%}else{%>
					<td nowrap class="button_ellipse" onClick = "javascript:accept();">
					<img src="<%=request.getContextPath()%>/images/icon/confirm.gif" class="div_control_image"><fmt:message key="accept"/></td>
					<td nowrap class="button_ellipse" onClick = "javascript:rollback();">
					<img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="rollback"/></td>
					<td nowrap class="button_ellipse" onClick = "javascript:history();">
					<img src="<%=request.getContextPath()%>/images/icon/history.gif" class="div_control_image"><fmt:message key="history"/></td>
					<%}%>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<!-- 列表开始 -->
<div id="ccChild1">
<table class="table_div_content2">
	<tr>
		<td>
		
		<layout:collection name="tasklist" id="taskItem" styleClass="listCss" width="99%" indexId="orderNumber" align="center" sortAction="0">
			
			<data:collectionItemAlexander width="3%" title="" style="text-align:center;">
				<bean:define id="wy3" name="taskItem" property="taskUid"/>
				<bean:define id="wy4" name="taskItem" property="procInstID"/>
				<bean:define id="wy5" name="taskItem" property="procID"/>
				<input title="<%=LocaleHolder.getMessage("gap.wf.task")+wy3%>" type="radio" name="checkbox_template" value="<%=wy3+","+wy4+","+wy5%>"/>
			</data:collectionItemAlexander>
			
			<data:collectionItemAlexander width="3%" title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="wy3" name="taskItem" property="taskUid"/>
				<input type="hidden" signName="hiddenId" value="<%=wy3%>"/>
			</data:collectionItemAlexander>
			
			<data:collectionItemAlexander width="6%" title='<%=LocaleHolder.getMessage("gap.wf.agent_overtime")%>' style="text-align:center;">
				<bean:define id="byagent" name="taskItem" property="isByagentTask"/>
				<bean:define id="agent" name="taskItem" property="isAgentTask"/>
				<bean:define id="stateCode" name="taskItem" property="overtimeState.code"/>
				<bean:define id="stateDesc" name="taskItem" property="overtimeState.desc"/>
				<bean:define id="performerName" name="taskItem" property="performerName"/>
				<bean:define id="agentPersonName" name="taskItem" property="agentPersonName"/>
				<%
                if (((Boolean)byagent).booleanValue()) {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/proxy003.gif' title='");
                    %>
                    <fmt:message key="agented"/>
                    <%  
                    out.write(agentPersonName+"'>");
                } else if (((Boolean)agent).booleanValue()) {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/proxy002.gif' title='");
                    %>
                    <fmt:message key="agent"/>
                    <%
                    out.write(performerName+"'>");
                } else {
                    out.write("<img src='" + request.getContextPath() + "/images/taskIcon/proxy004.gif' title='");
                    %>
                    <fmt:message key="no_agent"/>
                    <%
                    out.write("'>");
                }

				out.write("&nbsp;&nbsp;&nbsp;");

				if(OvertimeState.STATE_FALSE.getCode().equals(stateCode)) {
					out.write("<img src='" + request.getContextPath() + "/images/taskIcon/alert001.gif' title='" + stateDesc + "'>");
				} else if(OvertimeState.STATE_TRUE.getCode().equals(stateCode)) {
					out.write("<img src='" + request.getContextPath() + "/images/taskIcon/alert003.gif' title='" + stateDesc + "'>");
				} else {
					out.write("<img src='" + request.getContextPath() + "/images/taskIcon/alert004.gif' title='" + stateDesc + "'>");
				}
				%>
			</data:collectionItemAlexander>

			<data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.task_name")%>' property="taskName" sortable="false"/>
			<data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.process_name")%>' property="processName" sortable="false"/>
			<data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.task_launch_time")%>' property="startTime" sortable="false"/>
			<%if(!done){	%>
			<data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.task_deadline")%>' property="deadLine" sortable="false"/>
			<%}%>
			<%if(done){	%>
			<data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.task_completed_time")%>' property="endTime" sortable="false"/>
			<%}%>
			<data:collectionItemAlexander width="10%" title='<%=LocaleHolder.getMessage("gap.wf.current_state")%>'>
				<bean:define id="taskItemId" name="taskItem" property="taskUid"/>
				<bean:define id="taskItemState" name="taskItem" property="state"/>
             <%
                if (taskItemState != null && taskItemState.toString().indexOf(LocaleHolder.getMessage("gap.wf.rollbacked")) != -1) {
                    out.println("<a onclick=showRollBackReason('"+taskItemId+"') title='");
                   %>
                   <fmt:message key="view_the_reasons_for_rollback"/>
                   <%
                    out.println("'>" + taskItemState + "</a>");
                } else {
                    out.println(taskItemState);
                }
                %>
			</data:collectionItemAlexander>
			<%
			if(rdList!=null)
			{
				for(int i=0; i<rdList.size(); i++)
				{				
					if(!((DynamicRelevantData)rdList.get(i)).isInTable()) continue;
					if(((DynamicRelevantData)rdList.get(i)).getDataDesc()==null||"".equals(((DynamicRelevantData)rdList.get(i)).getDataDesc())) continue;
			%>
			<data:collectionItemAlexander width="10%" title="<%=((DynamicRelevantData)rdList.get(i)).getDataDesc()%>" titleCode ="<%=((DynamicRelevantData)rdList.get(i)).getDataCode()%>" property="relevantData" nestProperty1="code" nestProperty2="value" sortable="false"/>
			<%
				}
			}%>
		</layout:collection>		
		<jsp:include page="/jsp/include/page.jsp" />
		
		</td>
	</tr>
</table>
</div>
<!-- 列表结束 -->

<input type="hidden" name="id" value="">
<input type="hidden" name="isPrint" value="">
<input type="hidden" name="queryCondition" value="">
</form>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');
</script>
</fmt:bundle>
</body>
</html>

<%  
	//表单回写
	if(request.getAttribute("writeBackFormValues") != null) {  //如果request中取出的bean不为空
		out.print("<script language=\"javascript\">\n");  //输出script的声明开始
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));  //输出表单回写方法的脚本
		out.print("writeBackMapToForm();\n");  //输出执行回写方法
		out.print("</script>");  //输出script的声明结束
	}
%>

<script language="javascript">
try {
	parent.parent.frames[1].funcTreeFrame.location.reload();
} catch(e) {
	alert("No Frameset.");
}
</script>