<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<fmt:bundle basename="gap.wf.wapi.wf_wapi_resource" prefix="gap.workflow.wapi.">
<SCRIPT>
	var mainDefId = "<%=request.getAttribute("mainDefId")%>";

	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);
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
                var array1 = arrayAll[0];
				ids.push(array1);  //加入选中的checkbox
			}
		}
		return ids;
	}

	function findSelect(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);
		var number = 0;  //定义游标
		var state = null;  //定义状态值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(state == null) {
					state = new Array(0);
				}
				var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array2 = arrayAll[1];
				state.push(array2);  //加入选中的checkbox
			}
		}
		return state;
	}

	function findSelectState(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);
		var number = 0;  //定义游标
		var section = null;  //定义状态值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(section == null) {
					section = new Array(0);
				}
				var array11 = elementCheckbox[i].value;
                var arrayAll = array11.split(",")
                var array3 = arrayAll[2];
				section.push(array3);  //加入选中的checkbox
			}
		}
		return section;
	}

	function findSelProcInstID() {
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
	            return elementCheckbox[i].value.split(",")[0];
			}
		}
	}
	
	function findSelProcDefID() {
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
	            return elementCheckbox[i].value.split(",")[1];
			}
		}
	}
	
	function findSelState() {
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
	            return elementCheckbox[i].value.split(",")[2];
			}
		}
	}

	function findParentInstID() {
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
	            return elementCheckbox[i].value.split(",")[3];
			}
		}
	}

	function monitorFlow() {
		var _procInstID = findSelections("checkbox_template","procInstID");
		var _procDefID = findSelect("checkbox_template","procDefID");
		if(_procInstID == null){
			alert(i18n_wf.please_select_process_instance);
			return;
		}
		if(_procInstID.length > 1) {  //如果ids有2条以上的纪录
	  		alert(i18n.can_only_select_a_record)
	  		return;
		}
		window.location.href = "<%=request.getContextPath()%>/MonitorByProcInstIdAction.do"
			+"?procDefID="+_procDefID+"&procInstID="+_procInstID;
	}

	function monitorParentFlow(procInstID){
		var url = "<%=request.getContextPath()%>/MonitorByProcInstIdAction.do"
			+"?procInstID="+procInstID;
		var obj = window.showModalDialog(url,window,"dialogHeight:545px;dialogWidth:795px;center:yes;help:no;resizable:no;scroll:yes;status:no;");
	}

	function endFlow() {
		var _procInstID = findSelections("checkbox_template","procInstID");
		//var _procDefID = findSelect("checkbox_template","procDefID");
		if(_procInstID == null){
			alert(i18n_wf.please_select_process_instance);
			return;
		}
		if(_procInstID.length > 1) {  //如果ids有2条以上的纪录
	  		alert(i18n.can_only_select_a_record);
	  		return;
		}
		var _states = findSelectState("checkbox_template","state");
		if(_states == '<fmt:message key="completed" />'  || _states == '<fmt:message key="aborted" />' ){
			alert(i18n_wf.end_process_instance_error);
			return false;
		}
		if(window.confirm(i18n_wf.confirm_to_terminate_the_process_instance)){
			window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
				+"?procInstId="+_procInstID
				+"&mainDefId="+mainDefId
				+"&operationType=terminate";
		}
	}
	
	function clearFlow() {
		var _procInstID = findSelections("checkbox_template","procInstID");
		var _parentInstID = findParentInstID();
		if(_procInstID == null){
			alert(i18n_wf.please_select_process_instance);
			return;
		}
		if(_procInstID.length > 1) {
			//如果ids有2条以上的纪录
	  		alert(i18n.can_only_select_a_record)
	  		return;
		}
		var clearParent=false;
		if(_parentInstID!=null && _parentInstID.length>10){
			clearParent = window.confirm(i18n_wf.need_to_clear_parent_process_instance);
		}
		if(window.confirm(i18n_wf.confirm_to_clear_all_data)){
			var hrefstr = "<%=request.getContextPath()%>/RubbishClearAction.do"
				+"?mainDefId="+mainDefId
				+"&procInstId="+_procInstID
				+"&cmd=clearProcessInstanceDataByID";
			if(clearParent)
				hrefstr = hrefstr+"&parentInstId="+_parentInstID;
			window.location.href=hrefstr;
		}
	}
	
	function handupFlow()
	{
		alert(i18n_wf.function_has_not_been_mounted);
		return;
		var _processid = findSelection('monitors','procInstID');
		var _ids  = findSelection('monitors','procDefID');
		if(_processid == null)
		{
			alert(i18n_wf.please_select_process_instance)
			return;
		}
		var _states  = findSelection('monitors','state');
		if(_states != '<fmt:message key="excuting" />' && _states != '<fmt:message key="initialization" />' && _states != '<fmt:message key="resume" />' )
		{
			alert(i18n_wf.suspend_process_instance_error)
			return false;
		}
		window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
			+"?procInstId="+_procInstID
			+"&mainDefId="+mainDefId
			+"&operationType=terminate";
	}
	
	function resumeFlow()
	{
		alert(i18n_wf.function_has_not_been_mounted);
		return;
		var _processid = findSelection('monitors','procInstID');
		var _ids  = findSelection('monitors','procDefID');
		if(_processid == null)
		{
			alert(i18n_wf.please_select_process_instance)
			return;
		}
		var _states  = findSelection('monitors','state');
		if(_states != '<fmt:message key="handup" />' )
		{
			alert(i18n_wf.resume_process_instance_error)
			return false;
		}
		window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
			+"?procInstId="+_procInstID
			+"&mainDefId="+mainDefId
			+"&operationType=terminate";
	}
</SCRIPT>
</fmt:bundle>
</head>
<body>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
	writeTableTop('<fmt:message key="monitoring_list"/>','<%=request.getContextPath()%>/');
</script>

<form name="form" method="post">

<div id="ccParent1">
<table class="table_div_control">
	<tr>
		<td><img src="<%=request.getContextPath()%>/images/icon/07-0.gif"
			class="div_control_image"
			onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="monitoring_information_list"/>
		</td>
		<td>
		<table align="right">
			<tr>
				<td colspan="9" nowrap>
				<input type="button" name="SubmitXX" value='<fmt:message key="monitoring_selected_instance"/>' 
					onClick="javascript:monitorFlow();">
				<input type="button" name="SubmitYY" value='<fmt:message key="terminate_selected_instance"/>'
					onClick="javascript:endFlow();">
				<input type="button" name="SubmitZZ" value='<fmt:message key="remove_selected_instance"/>'
					onClick="javascript:clearFlow();">
				<!-- input type="button" name="SubmitAA" value='<fmt:message key="suspend_selected_instance"/>' onClick="javascript:handupFlow();"-->
				<!-- input type="button" name="SubmitBB" value='<fmt:message key="resume_selected_instance"/>' onClick="javascript:resumeFlow();"-->
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content2">
	<tr>
		<td><layout:collection name="monitors" id="monitors_id"
			styleClass="listCss" width="99%" indexId="orderNumber" align="center"
			sortAction="0">

			<layout:collectionItem width="5%"
				title="<input type='checkbox' pdType='control' control='checkbox_template'/>"
				style="text-align:center;">
				<bean:define id="wy3" name="monitors_id" property="procInstID" />
				<bean:define id="wy4" name="monitors_id" property="procDefID" />
				<bean:define id="wy5" name="monitors_id" property="state" />
				<bean:define id="wy7" name="monitors_id" property="initiatorID" />
				<bean:define id="parentInstId" name="monitors_id" property="parentProcInstID" />
				<input title="<%="实例："+wy3+"，定义："+wy4+"，发起者："+wy7%>" type="checkbox"
					name="checkbox_template" value="<%=wy3+","+wy4+","+wy5+","+parentInstId%>" />
			</layout:collectionItem>

			<layout:collectionItem width="3%" title='<%=LocaleHolder.getMessage("sequence")%>'
				style="text-align:center;">
				<venus:sequence />
				<bean:define id="wy3" name="monitors_id" property="procInstID" />
				<input type="hidden" signName="hiddenId" value="<%=wy3%>" />
			</layout:collectionItem>
			
			<!-- not sortable="true" -->
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.process_name")%>' property="name"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.version")%>' property="version"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.process_state")%>' property="state"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.launch_time")%>' property="startTime"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.complete_time")%>'  property="endTime"/>
			<layout:collectionItem width="8%"  title='<%=LocaleHolder.getMessage("gap.wf.overtime")%>' property="overtime"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.process_sponsor")%>' property="initiatorName"/>
			
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.wf.parent_process_instance")%>' >
				<bean:define id="parent_proc_inst_id" name="monitors_id"
					property="parentProcInstID" />
				<bean:define id="parent_proc_name" name="monitors_id"
					property="parentProcName" />
				<%if (!(parent_proc_name == null || parent_proc_name.equals(""))) {%>
				<a herf="javascript:monitorParentFlow('<%=parent_proc_inst_id%>');"
					onclick="javascript:monitorParentFlow('<%=parent_proc_inst_id%>');"
					title="<%=LocaleHolder.getMessage("gap.wf.click_to_monitor_parent_process_instance",new Object[]{parent_proc_inst_id})%>">
				<%=parent_proc_name%>
				</a>
				<%}%>
			</layout:collectionItem>

		</layout:collection><jsp:include page="/jsp/include/page.jsp" /></td>
	</tr>
</table>
</div>
<!-- 列表结束 --> <input type="hidden" name="id" value=""> <input
	type="hidden" name="isPrint" value=""> <input type="hidden"
	name="queryCondition" value=""></form>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');
</script>
</fmt:bundle>
</body>
</html>