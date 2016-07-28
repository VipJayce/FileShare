<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_content">
	<tr>
		<td align="right" width="10%" nowrap><fmt:message key="ordercontent.factory_name"/></td>
		<td>
			<input name="name" type="text" class="text_field" onblur="javascript:checkMasterId('factoryid','factory');" onchange="javascript:changeMasterState();" validate="notNull" inputName="<fmt:message key="ordercontent.factory_name"/>" validate="isSearch" >
			<input name="factoryid" id="factoryid" type="hidden" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.unfiedsubmit.contact"/></td>
		<td align="left">
			<input name="personname" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.unfiedsubmit.contact"/>"  onchange="javascript:changeMasterState();" validate="notNull" value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.unfiedsubmit.tel"/></td>
		<td align="left">
			
			<input name="telephone" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.unfiedsubmit.tel"/>"  onchange="javascript:changeMasterState();" validate="notNull;isNumeric" value="">			
				
		
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.unfiedsubmit.created_date"/></td>
		<td align="left">
			<input name="beginDate" id="beginDate" type="text" class="text_field_reference" inputName="<fmt:message key="masterdetailtable.unfiedsubmit.created_date"/>" onchange="javascript:changeMasterState();"  validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.unfiedsubmit.factory_address"/></td>
		<td align="left">
			<input name="address" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.unfiedsubmit.factory_address"/>"  onchange="javascript:changeMasterState();" validate="notNull" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.description"/></td>
		<td align="left">
			<input name="description" type="text " class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.description"/>"  onchange="javascript:changeMasterState();" validate="notNull" value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:unifiedSubmit('masterDetailBo');"></td>
		<td align="left">
			<input type="button" name="Submit" class="button_ellipse" value="<fmt:message key="masterdetailtable.unfiedsubmit.clear_cache"/>" onClick="javascript:clearMasterDetailData_onClick();">
		</td>
	</tr>	
</table>
</fmt:bundle>
