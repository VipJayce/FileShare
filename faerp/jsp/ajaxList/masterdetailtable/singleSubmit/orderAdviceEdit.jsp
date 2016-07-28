<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_content">
	<tr>
		<td align="right" width="10%" nowrap><fmt:message key="masterdetailtable.singlesubmit.feedback_person"/></td>
		<td align="left">
			<input name="person" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.feedback_person"/>" validate="notNull" value="" maxlength="10">			
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.feedback_time"/></td>
		<td align="left">
			<input name="adviseDate" id="adviseDate" type="text" class="text_field_reference" inputName="<fmt:message key="masterdetailtable.singlesubmit.feedback_time"/>" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adviseDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.description"/></td>
		<td align="left">
			<!--<input name="remark" type="text" class="text_field" value="">-->
			<textarea name="remark" rows="3" cols="30">
			这里是文本域中的文本 ... ... ... ...
			</textarea>
			
		</td>
	</tr>
	<tr>
		<td align="right"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:detailEdit_onClick();"></td>
		<td align="left">
			<input name="id" type="hidden" class="text_field" value="">
		</td>
	</tr>
</table>
</fmt:bundle>