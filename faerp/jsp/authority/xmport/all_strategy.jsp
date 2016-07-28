<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<script>
function nextStep(){
	form.action="<venus:base/>/XmportAction.do?cmd=step_three4ALLXML";
    form.submit();
}
</script>
<table class="table_noFrame" width="100%">
<form name="form" method="post">
<input type="hidden" name="superCode" value="<bean:write name = "superCode" />">
<input type="hidden" name="operate" value="<bean:write name = "operate" />">
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td align=center>
        <layout:collection name="files" id="wy1" styleClass="listCss" width="98%"  align="center">
            <layout:collectionItem width="50" title=" " style="text-align:center;">
                <bean:define id="wy3" name="wy1" property="name"/>
                <input type="radio" name="checkbox_template" value="<%=wy3.toString()%>"/>
            </layout:collectionItem>
            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Alternative_Strategies") %>' property="name" sortable="false"/>
        </layout:collection>
    </td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr><td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<tr>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td align=center><input type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Next' bundle='${applicationAuResources}' />" onclick="JavaScript:nextStep();"></td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</form>
</table>

