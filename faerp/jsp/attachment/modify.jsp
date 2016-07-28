<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>

<%
	String taskid=(String)request.getAttribute("modify.workItemId");
	String businessDataId = (String)request.getAttribute("modify.businessDataId");
	String businessDataCode = (String)request.getAttribute("modify.businessDataCode");
	String oFileName=(String)request.getAttribute("modify.oFileName");
	String remark = (String)request.getAttribute("modify.remark");
%>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
function onSend() {
	if (document.getElementById("file1").value.length == 0) {
		alert('<fmt:message key="please_choose_attachments_to_upload" bundle="${applicationResources}"/>');
	} else {
		document.form1.file_1.value = document.getElementById("file1").value;
		document.form1.action = "<%=request.getContextPath()%>/attachmentAction.do"
			+"?cmd=addNewVersionAttachmentByCode"
			+"&workItemId=<%=taskid%>"
			+"&businessDataId=<%=businessDataId%>"
			+"&dataCode=<%=businessDataCode%>"
			+"&oFileName=<%=oFileName%>";
	
		document.form1.submit();
	}
}
</script>
<BODY>
<script language="javascript">
	writeTableTop('','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<FORM name="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="file_1" value="">
<input type="hidden" name="businessDataId" value="<%=businessDataId%>">
<input type="hidden" name="workItemId" value="<%=taskid%>">
<input type="hidden" name="dataCode" value="<%=businessDataCode%>">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="attachments_modify"/>
		</td>
		<td nowrap class="td_hand" onClick="javascript:window.location.href='<%=request.getContextPath()%>/attachmentAction.do?cmd=findAllAttachmentsByActInst&workItemId=<%=taskid%>';">
			<img src="<%=request.getContextPath()%>/images/icon/search.gif"><fmt:message key="return" bundle="${applicationResources}"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
	<table class="table_div_content">
		<tr>
			<td class="Table_line" valign="middle" bgcolor="#E2E7ED">
				<TABLE>
					<TR>
						<TD colspan="2"><fmt:message key="file_name"/>&nbsp;&nbsp;&nbsp;<b><%=oFileName%></b></TD></TR>
					<TR>
					<TR>
						<TD colspan="2" align="left">&nbsp;&nbsp;&nbsp;<fmt:message key="remark" bundle="${applicationResources}"/>&nbsp;&nbsp;&nbsp;<%=remark%></TD>
					</TR>
					<TR>
					    <TD colspan="2">&nbsp;&nbsp;&nbsp;<fmt:message key="file"/>&nbsp;&nbsp;&nbsp;<INPUT class="text_field"  size=30 type=file name="file1"></TD>
					</TR>
					<TR>
						<TD colspan="2">&nbsp;&nbsp;&nbsp;<fmt:message key="new_remark"/>&nbsp;&nbsp;&nbsp;<textarea class="textarea_limit_words" cols="60" rows="5" title="250" maxLength="250" name="remark" id="remark"></textarea></TD>
					</TR>
				    <TR>
						<TD colspan="2"><input name="btnReturn" type="button" value='<fmt:message key="change"/>' onclick="javascript:onSend();"></TD>
				    </TR>
				</TABLE>
			</td>
		</tr>
	</table>
</div>
</FORM>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</BODY>
</HTML>
	
	