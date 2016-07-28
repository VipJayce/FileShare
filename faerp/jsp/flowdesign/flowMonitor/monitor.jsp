<%@ page contentType="text/html; charset=UTF-8" buffer="none" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.wf.wapi.state.ActInstState" %>
<%@ page import="gap.wf.wapi.snapshot.ProcessInstanceSnapShot" %>

<%

response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 

ProcessInstanceSnapShot procInstSnapShot = (ProcessInstanceSnapShot)request.getAttribute("procInstSnapShot");
boolean isSub = procInstSnapShot.getParentProcInstID()!=null && procInstSnapShot.getParentProcInstID().length()>10;

String procInstId = procInstSnapShot.getProcInstID();
String procInstState = procInstSnapShot.getState();
%>

<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<title><fmt:message key="process_monitor"/></title>

<fmt:bundle basename="gap.wf.wapi.wf_wapi_resource">
<script language="javascript">
<!--
    var mainDefId = "";//监控功能历史遗留，目前没有作用
    function handupFlow() {
        var _procInstID = "<%=procInstId%>";
        var _states = "<%=procInstState%>";
        if(_states != '<fmt:message key="gap.workflow.wapi.excuting" />' && _states != '<fmt:message key="gap.workflow.wapi.initialization" />' && _states != '<fmt:message key="gap.workflow.wapi.resume"  />' ){
            alert(i18n_wf.suspend_process_instance_error);
            return false;
        }
        
        window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
                +"?procInstId="+_procInstID
                +"&mainDefId="+mainDefId
                +"&operationType=handup";
        
    }

    function resumeFlow() {
        var _procInstID = "<%=procInstId%>";
        var _states = "<%=procInstState%>";
        if(_states != '<fmt:message key="gap.workflow.wapi.handup" />'  ){
            alert(i18n_wf.resume_process_instance_error);
            return false;
        }
  
         window.location.href = "<%=request.getContextPath()%>/MonitorChangeProcInstStateAction.do"
                +"?procInstId="+_procInstID
                +"&mainDefId="+mainDefId
                +"&operationType=resume";
    }

    function endFlow() {
        var _procInstID = "<%=procInstId%>";
        var _states = "<%=procInstState%>";
        if(_states ==  '<fmt:message key="gap.workflow.wapi.completed" />'  || _states == '<fmt:message key="gap.workflow.wapi.aborted" />' ){
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
        var _procInstID = "<%=procInstId%>";
        var _parentInstID = "<%=procInstSnapShot.getParentProcInstID()%>";
        var clearParent = false;
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
            window.location.href = hrefstr;
        }
    }
//-->
</script>
</fmt:bundle>
<meta   http-equiv="pragma"   content="no-cache" content="text/html; charset=UTF-8">
</head>
<body OnUnLoad="GraphNFlow.ReleaseGraph()">
<script language="javascript">
	writeTableTop('<fmt:message key="process_monitor"/>','<%=request.getContextPath()%>/');
</script>

<div id="ccParent1"> 
<table class="table_div_content">
	<tr> 
		<td>
		<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/');">
		<span title="PUB定义ID：<%=request.getAttribute("procDefID")%>，实例ID：<%=request.getAttribute("procInstID")%>">
		<fmt:message key="monitoring_process_instance"/><%if(isSub)%><fmt:message key="sub_process"/>
		——<%=procInstSnapShot.getName()%></span>
		<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<fmt:message key="process_version"/><%=procInstSnapShot.getVersion()%>，
		<fmt:message key="process_sponsor"/><%=procInstSnapShot.getInitiatorName()%>，
		<fmt:message key="process_initiated_time"/><%=procInstSnapShot.getStartTime()%>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content2">
  <tr nowrap>
    <td colspan="1">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="border_color_legend"/>
	
	[<%=ActInstState.Initialed.getDesc()%>
	<span style="background-color: #<%=ActInstState.Initialed.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	[<%=ActInstState.Assigned.getDesc()%>
	<span style="background-color: #<%=ActInstState.Assigned.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	[<%=ActInstState.Running.getDesc()%>	
	<span style="background-color: #<%=ActInstState.Running.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	[<%=ActInstState.Suspend.getDesc()%>
	<span style="background-color: #<%=ActInstState.Suspend.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	[<%=ActInstState.Terminated.getDesc()%>
	<span style="background-color: #<%=ActInstState.Terminated.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	[<%=ActInstState.Executed.getDesc()%>
	<span style="background-color: #<%=ActInstState.Executed.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	[<%=ActInstState.Completed.getDesc()%>
	<span style="background-color: #<%=ActInstState.Completed.getMonitorColorHex()%>">&nbsp;&nbsp;&nbsp;&nbsp;</span>]
	
	</td>
  </tr>
  <tr nowrap>
  	<td colspan="4">
	<!-- object begin --><jsp:include page="/activex/ocxobject.jsp" flush="true"/><!-- object end -->
	</td>
  </tr>
  <tr nowrap>
    <td colspan="1">
    <table width="100%">
        <tr><td>
    <%if(isSub){%>
		<fmt:message key="parent_process_name"/><%=procInstSnapShot.getParentProcName()%>
		<input type="button" name="monitorParent" value='<fmt:message key="monitoring_parent_process"/>'
			onClick="toMonitorInst('<%=procInstSnapShot.getParentProcInstID()%>')">
	<%}%>
    	<input type="button" name="refresh" value='<fmt:message key="monitor_refresh"/>' onClick="toflashFlow()" class="button_ellipse">
    	<input type="button" name="backtoX" value='<fmt:message key="return" bundle="${applicationResources}" />' onClick="history.go(-1)" class="button_ellipse">
        </td><td width="296" align="left">
        <input type="button" name="refresh" value='<fmt:message key="suspend"/>' onClick="handupFlow()" class="button_ellipse">
        <input type="button" name="refresh" value='<fmt:message key="resume"/>' onClick="resumeFlow()" class="button_ellipse">
        <input type="button" name="refresh" value='<fmt:message key="terminate"/>' onClick="endFlow()" class="button_ellipse">
        <input type="button" name="refresh" value='<fmt:message key="remove"/>' onClick="clearFlow()" class="button_ellipse">
      </td></tr>
    </table>
    </td>
  </tr>
</table>
</div>

<script>
GraphNFlow.MonitorFlow();
writeTableBottom('<%=request.getContextPath()%>/');

function toflashFlow(){
	this.location.href = this.location.href 
		+ "&refresh=" + <%=System.currentTimeMillis()%>;
}

function toMonitorInst(procInstID){
	var url = "<%=request.getContextPath()%>/MonitorByProcInstIdAction.do"
		+"?procInstID="+procInstID;
	var obj = window.showModalDialog(url,window,"dialogHeight:545px;dialogWidth:795px;center:yes;help:no;resizable:no;scroll:yes;status:no;");
}
</script>

<jsp:include page="/activex/ocxfooter.jsp" flush="true"/>
</body>
</fmt:bundle>
</html>