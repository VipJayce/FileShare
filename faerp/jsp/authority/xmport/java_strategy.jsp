<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<script>
function upload(){
	if(uploadform.filename.value==null || uploadform.filename.value==""){
            alert("<fmt:message key='gap.authority.Do_not_select_the_file_name_' bundle='${applicationAuResources}' />");
            return;
        }
        uploadform.action="<venus:base/>/XmportAction.do?cmd=onFileUpLoad&operate=<bean:write name = "operate" />&organize=<bean:write name = "organize" />&relation=<bean:write name = "relation" />";
        uploadform.submit();
}
function getJavaList(){
	var treePath = "<venus:base/>/XmportAction.do?cmd=javaClass";
	var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=300px;dialogWidth=600px;resizable:yes;status:no;scroll:auto;');
	if(rtObj != undefined && rtObj.length > 0) {
		form.java_name.value = rtObj;
	}
}
function nextStep(){
    form.action="<venus:base/>/XmportAction.do?cmd=step_three4JAVA";
    form.submit();
}
</script>
<table class="table_noFrame" width="100%">
<form name="uploadform" method="post" enctype="multipart/form-data" >
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
	<td align="right" width="10%"><fmt:message key='gap.authority.Upload_file' bundle='${applicationAuResources}' /></td>
	<td align="left" width="50%">
		<input type="file" class="text_field" name="filename" inputName="<fmt:message key='gap.authority.Upload_file' bundle='${applicationAuResources}' />" maxLength="50" /><input type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Upload' bundle='${applicationAuResources}' />" onclick="JavaScript:upload();">
	</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<logic:notEmpty name="filename">
<tr>
    <td align="right" width="10%"><font color=red><fmt:message key='gap.authority.Uploaded_' bundle='${applicationAuResources}' /></font></td>
    <td align="left" width="50%">
        <bean:write name = "filename" />
    </td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</logic:notEmpty>
</form>
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<form name="form" method="post">
<input type="hidden" name="operate" value="<bean:write name = "operate" />">
<input type="hidden" name="organize" value="<bean:write name = "organize" />">
<input type="hidden" name="relation" value="<bean:write name = "relation" />">
<tr>
	<td align="right" width="10%">Java<fmt:message key='gap.authority.Class' bundle='${applicationAuResources}' /></td>
	<td align="left">
		<input type="text" class="text_field" name="java_name" inputName="Java<fmt:message key='gap.authority.Class' bundle='${applicationAuResources}' />" validate="notNull;isSearch;" value="<logic:notEmpty name="java_name"><bean:write name = "java_name" /></logic:notEmpty>" maxLength="50" /><img src="<venus:base/>/images/icon/add.gif" class="refButtonClass" onClick="javascript:getJavaList();" >
	</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
	<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td align="left">
		<fieldset name="organize_type">
			<legend  style="font-size:13px; color:#163752;"><fmt:message key='gap.authority.Configuration_property_relations' bundle='${applicationAuResources}' /></legend>
			<br/>
			<table class="table_noFrame">
				<logic:notEmpty name="organizeRLfields">
					<logic:iterate id="rl" name="organizeRLfields">
						<tr>
							<td align="right">			
								<input type="text" class="text_field" name="<bean:write name="rl"/>" validate="isSearch" value="" maxLength="50" />
							</td>
							<td align="right">			
								<input type="checkbox" name="orgfield" value="<bean:write name="rl"/>"/>
							</td>
							<td align="left">			
								<bean:write name="rl"/>
							</td>
						</tr> 						
					</logic:iterate>
				</logic:notEmpty>
			</table>
			<br/>
		</fieldset>
	</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr><td colspan=2 align=center><input type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Next' bundle='${applicationAuResources}' />" onclick="JavasScript:nextStep();"></td><td></td></tr>
</form>
</table>

