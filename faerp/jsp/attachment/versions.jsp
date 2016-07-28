<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="java.util.*" %>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="gap.wf.adaptor.organization.OrgAdaptor" %>
<%@ page import="gap.wf.bizcommon.org.PersonInfo" %>
<%@ page import="com.alexander.businessdata.bo.AttachmentBo" %>

<%
String taskid = (String)request.getParameter("workItemId");
String isHistory = request.getAttribute("version.done") == null ? null : (String)request.getAttribute("version.done");
%>

<html>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>version</title>

<script language="javascript">
<!--
function readAttachment(attachmentId, fileName) {
	window.location.href = "<%=request.getContextPath()%>/attachmentAction.do"
			+ "?cmd=readAttachmentById"
			+ "&workItemId=<%=taskid%>"
			+ "&attachmentId=" + attachmentId
			+ "&fileName=" + fileName
			+ "&done=<%=isHistory%>";
}
//-->
</script>

</head>

<body>

<script language="javascript">
	writeTableTop('','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="version_list"/>
		</td>
		<td nowrap class="td_hand" onClick="javascript:window.location.href='<%=request.getContextPath()%>/attachmentAction.do?cmd=findAllAttachmentsByActInst&done=<%=isHistory%>&workItemId=<%=taskid%>';">
			<img src="<%=request.getContextPath()%>/images/icon/search.gif"><fmt:message key="return" bundle="${applicationResources}"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1">
<%
	List attachments = (List)request.getAttribute("attachments");
	int count = 0;
	if(attachments!=null)
		count = attachments.size();
%>
<table class="table_div_content">
	<tr>
		<td><fmt:message key="total_version" ><fmt:param><%=count%></fmt:param></fmt:message></td>
	</tr>
	<tr>
		<td class="Table_line" valign="middle" bgcolor="#E2E7ED">
			<table border="0" width="100%" id="table2" cellspacing="1" cellpadding="0"  class="Table_line">
				<tr align="center" bgcolor="#AFB8D5"  class="Table_line">
					<td nowrap><fmt:message key="operating"/></td>
					<td nowrap><fmt:message key="attachment_id"/></td>
					<td nowrap><fmt:message key="file_name"/></td>
					<td nowrap><fmt:message key="version_number"/></td>
					<td nowrap><fmt:message key="version_submitter"/></td>
					<td nowrap><fmt:message key="submit_date"/></td>
				</tr>

				<%for(int i=0; attachments!=null && i<attachments.size(); i++){
					AttachmentBo bo = (AttachmentBo)attachments.get(i);%>
					<tr bgcolor="#FEFEFE">
					    <td nowrap><a href="javascript:readAttachment('<%=bo.getAttachmentId2Str()%>','<%=bo.getFileName()%>')">[<fmt:message key="read"/>]</a></td>
					    <td nowrap><%=bo.getReservation1()%></td>
					    <td nowrap><%=bo.getFileName()%></td>
					    <td nowrap><%=bo.getVersion()%></td>
						<%
							OrgAdaptor org = (OrgAdaptor)Helper.getBean("organization.adaptorTarget.model");
							PersonInfo personInfo = org.getPersonByID(bo.getLastUpdator2Str());
						%>
						<td nowrap><%=(personInfo == null) ? "" : personInfo.getName()%></td>
					    <td nowrap><%=bo.getLastModifiedDate()%></td>
					</tr>
				<%}%>
			</table>
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