<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="gap.authority.sample.xmport.lock.EtlLock" %>
<%@ page import="gap.authority.sample.xmport.lock.SequenceCountLock" %>
<%@ page import="gap.authority.service.syserror.bs.ISysErrorBs" %>
<%@ page import="gap.authority.service.syserror.util.IContants" %>
<%
    EtlLock multiLock = SequenceCountLock.getInstance();
    ISysErrorBs sysErrorBs = (ISysErrorBs) Helper.getBean(IContants.BS_KEY);
    String queryCondition = " ERROR_TYPE = '1' ";
    int errorCount = sysErrorBs.getRecordCount(queryCondition);
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="300"><!-- 每5分钟刷新一次页面 -->
<title><fmt:message key='gap.authority.One_click_import' bundle='${applicationAuResources}' /></title>
</head>
<script>
function importData(){
    showBlockPage();
    form.action="<venus:base/>/XmportAction.do?cmd=importData";
    setTimeout('form.submit()',100);
}

function showErrorData() {
    window.location = "<venus:base/>/SysErrorAction.do?cmd=queryAll&errorType=1";
}
</script>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.One_click_import' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<input type="hidden" name="checkbox_template" value="xmport.company.xml;xmport.department.xml;xmport.employee.xml">
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.One_click_import' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>
<div id="auDivChild0"> 
<table class="table_div_content" height="200">
    <%if (errorCount > 0) { %>
    <tr>
        <td  align=center><fmt:message key='gap.authority.Last_import_data_found' bundle='${applicationAuResources}' /><font color="red"><strong><%=errorCount %></strong></font><fmt:message key='gap.authority.Error_data_' bundle='${applicationAuResources}' /><a href="javascript:showErrorData();"><font color="blue"><fmt:message key='gap.authority.Click_here_to_view' bundle='${applicationAuResources}' /></font></a></td>
    </tr>
    <% } %>   
    <tr>
        <td  align=center><fmt:message key='gap.authority.Please_confirm_configured_organizational_relationships_and_then_click_Start_Import_' bundle='${applicationAuResources}' /></td>
    </tr>     
    <tr>
        <td align=center><input type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Start_Import' bundle='${applicationAuResources}' />" onclick="JavaScript:importData();"></td>
    </tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<%if (multiLock.isLock()) {%>
<script>
    showBlockPage();
</script>
<%}%>

