<%@ page contentType="text/html; charset=UTF-8" buffer="none" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<%
	String url = "http://" + request.getServerName() + ":"
		+ request.getServerPort() + request.getContextPath();
		String urlScheme = request.getScheme()+"://" + request.getServerName() + ":"
		+ request.getServerPort() + request.getContextPath();
	String requestID = request.getParameter("id");
	
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0); 
%>

<!--object params, eip: 8000 10000 width="778" height="550"-->
<OBJECT ID="GraphNFlow"
CLASSID="CLSID:4168303F-E374-4AE7-9C77-F5155A878476"
	CODEBASE="<%=request.getContextPath()%>/activex/GraphNotFlow.CAB#version=1,1,0,192"
	align="baseline" valign="middle" border="0" width="735" height="480">
	
	<param name="LibUrl" value="<%=url%>/jsp/flowdesign/tbl4New/newlib.tbl">
	<param name="OrgXmlUrl" value="<%=urlScheme%>/jsp/flowdesign/orgModel.jsp">
	<param name="FlowDefineUrl" value="<%=url%>/publishedFlow.do">
	<param name="FormalUrl" value="<%=url%>/formalParameters.do?id=">
	<param name="CtrHeight" value="9000">
	<param name="CtrWight" value="13600">
	<param name="FormActUrl" value="<%=url%>/formConfigureAction.do?wfId=<%=requestID%>">
	<param name="FormConfigUrl" value="<%=url%>/jsp/flowdesign/formConfig.jsp">
	<%
	if (request.getParameter("bnew").equals("true")) {%> 
		<!--new flow file-->
		<param name="FileUrl" value="<%=url%>/jsp/flowdesign/tbl4New/new.tbl">
	<%} 
	else if (request.getParameter("bmonitor").equals("true")) {%> 
		<!--monitor flow file-->
		<param name="FileUrl"
			value="<%=url%>/MonitorDefineQuery.do?id=<%=request.getAttribute("procDefID")%>&random=<%=Math.random()%>">
		<param name="MonitorUrl"
			value="<%=url%>/MonitorXmlDataAction.do?procInstID=<%=request.getAttribute("procInstID")%>&random=<%=Math.random()%>">
	<%} 
	else {%> 
		<!--exist flow file-->
		<param name="FileUrl" value="<%=url%>/defineQuery.do?id=<%=requestID%>&random=<%=Math.random()%>">
	<%}
	if (request.getParameter("bedit").equals("true")) {%>
		<!--not runtime-->
		<param name="RunTime" value="false">
	<%} 
	else {%>
		<!--is runtime-->
		<param name="RunTime" value="true">
	<%}%>
	
</OBJECT>

<script>
GraphNFlow.IniVg();
</script>

<div align="right">
<input type="button" name="downloadPatch" value='<fmt:message key="download_control_patch"/>'
	onClick="javascript:window.location.href='<%=request.getContextPath()%>/activex/installGraph.rar';" class="button_ellipse">

<input type="button" name="refInst" value='<fmt:message key="script_variable_reference"/>'
	onClick="javascript:window.open('<%=request.getContextPath()%>/helper/WfEngine4ActionDoc/nucleus/model/package-summary.html', 'newwindow', 'height=600px,width=650px,top=0,left=0,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,status=no');" class="button_ellipse">

<!--input type="button" name="formPreview" value="表单预览" onClick="BrowseFormEvent()"-->

&nbsp;&nbsp;&nbsp;&nbsp;
</div>
</fmt:bundle>