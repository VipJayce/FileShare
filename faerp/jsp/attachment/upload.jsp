<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<HTML>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="upload_attachments"/></title></HEAD>
<%
String taskid=(String)request.getParameter("workItemId");
%>
<script language="javascript">

function onSend(param) {
	var fileName = document.getElementById("fileUpload").value;

	if (fileName.length == 0) {
		alert('<fmt:message key="please_choose_attachments_to_upload" bundle="${applicationResources}"/>');
	} else if ( checkSingleComma(fileName) ) {
		alert('<fmt:message key="attachment_name_rule"/>');
	} else {
		form1.action="<%=request.getContextPath()%>/attachmentAction.do?cmd=addAttachmentToActInst&workItemId=<%=taskid%>&dataCode=" + param;
		form1.submit();
	}
}

function checkSingleComma(obj) {
	var reg  = /[\']/;
	if (reg.test(obj)) {
		return true;
	} else {
		return false;
	}
}

</script>
<BODY>
<script language="javascript">
	writeTableTop('','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="upload_attachments"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<FORM name="form1" method="post" enctype="multipart/form-data">
<input type="hidden" name="dataCode" value="<%=request.getParameter("businessDataCode")%>">
  <TR>
    <TD colspan="2" align="left"><fmt:message key="file"/>
      <INPUT class="text_field"  size=40 type=file name="fileUpload" id="fileUpload"></TD>
  </TR>
  <TR>
    <TD colspan="2" align="left"><fmt:message key="remark" bundle="${applicationResources}"/>
    	<textarea class="textarea_limit_words" cols="60" rows="5" title="250" maxLength="250" name="remark" id="remark"></textarea>
    </TD>
  </TR>
  <TR>
    <TD colspan="2"><hr></TD>
    </TR>
    <TR>
      <TD colspan="2">
	  <a href="javascript:onSend(document.form1.dataCode.value)"><fmt:message key="send"/></a> | 
	  <a href="<%=request.getContextPath()%>/attachmentAction.do?cmd=findAllAttachmentsByActInst&workItemId=<%=taskid%>"><fmt:message key="attachments_list"/></a>
    </TR>
</FORM>
</table>
</div>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</BODY>
</fmt:bundle>
</HTML>
	
	