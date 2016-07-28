<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<html>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="view_attachments"/></title>

<%
	String attachmentId = (String)request.getAttribute("read.attachmentId");
	String taskid = (String)request.getAttribute("read.workItemId");
	String fileName = (String)request.getAttribute("read.fileName");
	String isHistory = request.getAttribute("read.done") == null ? null : (String)request.getAttribute("read.done");
	String remark = (String)request.getAttribute("read.remark");
%>

<script language="javascript">
	function downloadFile(){
		window.location.target = "_blank";
		window.location.href = "<%=request.getContextPath()%>/attachmentDownload.do"
			+"?cmd=directly"
			+"&attachmentId=<%=attachmentId%>"
			+"&workItemId=<%=taskid%>";
	}
</script>

</head>
<body>

<script language="javascript">
	writeTableTop('','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<FORM name="form1" method="post">
<input type="hidden" name="attachmentId" value="<%=attachmentId%>">
<input type="hidden" name="workItemId" value="<%=taskid%>">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="atachments_reading"/>
		</td>
		<td nowrap class="td_hand" onClick="javascript:window.location.href='<%=request.getContextPath()%>/attachmentAction.do?cmd=findAllAttachmentsByActInst&done=<%=isHistory%>&workItemId=<%=taskid%>';">
			<img src="<%=request.getContextPath()%>/images/icon/search.gif"><fmt:message key="return" bundle="${applicationResources}"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
	<table class="table_div_content">
		<tr>
			<td class="Table_line" valign="middle" bgcolor="#E2E7ED">
				<table>
				    <tr>
				      <td valign="middle">
				      	<fmt:message key="attachment"/><b><%=fileName%></b>
				      </td>
				    </tr>
				    <tr>
				      <td valign="middle">
				      	<fmt:message key="remark" bundle="${applicationResources}"/><%=remark%>
				      </td>
				    </tr>
				    <tr>
				      <td valign="middle">
				      	&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:downloadFile();"><fmt:message key="read"/></a>
				      </td>
				    </tr>
				</table>
			</td>
		</tr>
	</table>
</div>
</FORM>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>