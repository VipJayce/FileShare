<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<script>
function nextStep(){
	if(document.form.xml_name.value.trim()==""){
        alert("<fmt:message key='gap.authority.Enter' bundle='${applicationAuResources}' />XML<fmt:message key='gap.authority.Content_' bundle='${applicationAuResources}' />");
        return; 
    }
    form.action="<venus:base/>/XmportAction.do?cmd=step_three4XML";
    form.submit();
}
</script>
<table class="table_noFrame" width="100%">
<form name="form" method="post">
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td align="center">XML<fmt:message key='gap.authority.Content' bundle='${applicationAuResources}' /></td></tr>
<tr>
	<td align=center>
        <textarea class="textarea_limit_words" cols="160" rows="30" name="xml_name" maxLength="4000" id="xml_id"></textarea>
    </td>
</tr>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td align=center><input type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Next' bundle='${applicationAuResources}' />" onclick="JavaScript:nextStep();"></td></tr>
</form>
</table>

