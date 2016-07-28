<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="java.lang.Integer" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.io.FileUtils" %>

<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="gap.wf.adaptor.organization.OrgAdaptor" %>
<%@ page import="gap.wf.bizcommon.org.PersonInfo" %>
<%@ page import="com.alexander.businessdata.bo.AttachmentBo" %>

<%
	response.addHeader("Progma","No-cache");
	response.addHeader("Cache-Control","No-cache");
	response.addDateHeader("Expires",1);

	String taskid = request.getParameter("workItemId");

	List attachmentList = (List)request.getAttribute("attachment.list");

	String performer = (String)request.getAttribute("attachment.performer");

	int attachmentNow = Integer.parseInt((String)request.getAttribute("attachment.now.number"));
	String isHistory = request.getAttribute("attachment.done") == null ? null : (String)request.getAttribute("attachment.done");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<script language="javascript">
parent.window.dialogArguments.document.getElementById('attachmentNumber').innerHTML = <%=attachmentNow%>;

function addAttachment(dataCode) {
	window.location.href = "<%=request.getContextPath()%>/jsp/attachment/upload.jsp"
		+"?workItemId=<%=taskid%>"
		+"&attachmentRequire=<%=attachmentNow%>"
		+"&businessDataCode=" + dataCode;
}

function readAttachment(attachmentId, fileName) {
	window.location.href = "<%=request.getContextPath()%>/attachmentAction.do"
			+ "?cmd=readAttachmentById"
			+ "&workItemId=<%=taskid%>"
			+ "&attachmentId=" + attachmentId
			+ "&fileName=" + fileName
			+ "&done=<%=isHistory%>";
}

function updateAttachment(businessDataId, oFileName, businessDataCode, attachmentId){
	window.location.href = "<%=request.getContextPath()%>/attachmentAction.do"
			+ "?cmd=modifyAttachmentById"
			+ "&workItemId=<%=taskid%>"
			+ "&businessDataId=" + businessDataId
			+ "&businessDataCode=" + businessDataCode
			+ "&attachmentId=" + attachmentId
			+ "&oFileName=" + oFileName;
}

function deleteLatestVersionAttachment(businessDataId, oFileName) {
	if(window.confirm('<fmt:message key="confirm_to_delete_attachement"/>')) {
		form1.action = "<%=request.getContextPath()%>/attachmentAction.do"
			+ "?cmd=deleteNewestVersionAttachmentByCode"
			+ "&workItemId=<%=taskid%>"
			+ "&businessDataId=" + businessDataId
			+ "&oFileName=" + oFileName;
		form1.submit();
	}
}

function getAllVersionAttachments(procInstId, businessDataCode){
	window.location.href = "<%=request.getContextPath()%>/attachmentAction.do"
		+"?cmd=findAllVersionAttachmentsByCode"
		+"&workItemId=<%=taskid%>"
		+"&procInstId=" + procInstId
		+"&businessDataCode=" + businessDataCode
		+"&done=<%=isHistory%>";
}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="attachments_list"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<form name="form1" method="post"></form>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="attachments_list"/>
		</td>
		<td nowrap class="td_hand" onClick = "javascript:window.close();">
			<img src="<%=request.getContextPath()%>/images/icon/delete.gif"><fmt:message key="close" bundle="${applicationResources}"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td class="Table_line" valign="middle" bgcolor="#E2E7ED">
			<table border="0" width="100%" id="table2" cellspacing="1" cellpadding="0"  class="Table_line">
				<tr align="center" bgcolor="#AFB8D5"  class="Table_line">
					<td nowrap><fmt:message key="operating"/></td>
					<td nowrap><fmt:message key="attachment_id"/></td>
					<td nowrap><fmt:message key="file_name"/></td>
					<td nowrap><fmt:message key="file_size"/></td>
					<td nowrap><fmt:message key="latest_version"/></td>
					<td nowrap><fmt:message key="creator"/></td>
					<td nowrap><fmt:message key="create_time"/></td>
				</tr>

				<%for(int i=0; attachmentList!=null && i<attachmentList.size(); i++){
					AttachmentBo bo = (AttachmentBo)attachmentList.get(i);%>
					<tr bgcolor="#FEFEFE">
						<%if (bo.getBusinessDataName() != null){%>
						<td nowrap>
							<a href="javascript:readAttachment('<%=bo.getAttachmentId2Str()%>','<%=bo.getFileName()%>')">[<fmt:message key="read"/>]</a>
							<a href="javascript:getAllVersionAttachments('<%=bo.getProcInstId()%>','<%=bo.getBusinessDataCode()%>')">[<fmt:message key="file_version"/>]</a>
						    <%if(!bo.getReadOnly()){%>
						    	<a href="javascript:deleteLatestVersionAttachment('<%=bo.getBusinessDataId2Str()%>', '<%=bo.getFileName()%>')">[<fmt:message key="delete" bundle="${applicationResources}"/>]</a>
						    	<a href="javascript:updateAttachment('<%=bo.getBusinessDataId2Str()%>','<%=bo.getFileName()%>', '<%=bo.getBusinessDataCode()%>', '<%=bo.getAttachmentId2Str()%>')">[<fmt:message key="modify" bundle="${applicationResources}"/>]</a>
						    <%}%>
					    <%} else if (!bo.getReadOnly()) {%>
						    <td nowrap>
						    	<a href="javascript:addAttachment('<%=bo.getBusinessDataCode()%>');">[<fmt:message key="upload_attachments"/>]</a>
					    <%} else {%>
					    	<td nowrap>
						    	&nbsp;
					    <%}%>
						</td>
						<td nowrap><%=("null".equals(bo.getReservation1()) || bo.getReservation1() == null) ? "" : bo.getReservation1()%></td>
						<td nowrap><%=(bo.getFileName() == null) ? "" : bo.getFileName()%></td>
						<td nowrap><%=FileUtils.byteCountToDisplaySize(bo.getFileSize())%></td>
						<td nowrap><%=bo.getVersion()%></td>
						<%
						    if ( bo.getCreator2Str() != null && !("".equals(bo.getCreator2Str())) ) { 
							  OrgAdaptor org = (OrgAdaptor)Helper.getBean("organization.adaptorTarget.model");
							  PersonInfo personInfo = org.getPersonByID(bo.getCreator2Str());
						%>
						<td nowrap><%=(personInfo == null) ? "" : personInfo.getName()%></td>
                        <%} else { %>
                        <td nowrap>&nbsp;</td>
                        <%} %>        
						<td nowrap><%=(bo.getCreatedDate() == null) ? "" : bo.getCreatedDate().toString()%></td>
					</tr>
				<%}%>

			</table>
		</td>
	</tr>
</table>
</div>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>