<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<SCRIPT language="Javascript">

function realCallback(responseXML){
	//alert(responseXML);
    if(responseXML&&responseXML.xml!=""){
       var msg = responseXML.getElementsByTagName("msg")[0].firstChild.data;
       alert(msg);
    }
}

function clear1(){
	if(window.confirm(i18n_wf.clear_release_history))
		ajaxGet("<%=request.getContextPath()%>/RubbishClearAction.do?cmd=clearRubbishProcessDefine",realCallback);
}

function clear2(){
	if(window.confirm(i18n_wf.clear_data_but_process))
		ajaxGet("<%=request.getContextPath()%>/RubbishClearAction.do?cmd=clearPubAndInstAllData",realCallback);
}

function clear3(){
	if(window.confirm(i18n_wf.clear_data_but_process_and_publish))
		ajaxGet("<%=request.getContextPath()%>/RubbishClearAction.do?cmd=clearInstAllDataNotPub",realCallback);
}

</SCRIPT>
</head>

<body>
<script language="javascript">
	writeTableTop('<fmt:message key="clean_process"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<!-- 列表开始 -->
<div id="ccParent1"> 
<table class="table_div_control">
	<tr>
		<td>
		<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
		<fmt:message key="clean_function_list"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
<table class="table_div_content2">
	<tr>
	<td colspan="2" class="th_list_2">
		<br>
		<input name="Submit1" type="button" class="button_ellipse" value='<fmt:message key="history_clean"/>' onclick="clear1();"> <fmt:message key="clear_release_history"/>
		<br><br>
		<input name="Submit2" type="button" class="button_ellipse" value='<fmt:message key="reset_system_data"/>' onclick="clear2();"> <fmt:message key="clear_data_but_process"/>
		<br><br>
		<input name="Submit3" type="button" class="button_ellipse" value='<fmt:message key="reset_system_data"/>' onclick="clear3();"><fmt:message key="clear_data_but_process_and_publish"/>
		<br><br>
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