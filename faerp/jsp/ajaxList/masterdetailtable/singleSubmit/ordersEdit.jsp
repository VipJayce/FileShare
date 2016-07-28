<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_content">
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="masterdetailtable.singlesubmit.order_type"/></td>
		<td>
			<select name="type" id="type">

			</select>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.the_total_amount_of_orders"/></td>
		<td align="left">
			<input name="totalamount" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.the_total_amount_of_orders"/>" validate="notNull;isNumeric" value="">			
			<input name="orderNo" type="hidden" class="text_field"  value="">			
		</td>
	</tr>
	<tr>
	<td align="right"><fmt:message key="masterdetailtable.singlesubmit.order_created_date"/></td>
		<td align="left">
			<input name="beginDate" id="beginDate" type="text" class="text_field_reference" inputName="<fmt:message key="masterdetailtable.singlesubmit.order_created_date"/>" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.order_number_of_products"/></td>
		<td align="left">
			<input name="count" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.order_number_of_products"/>" validate="notNull;isNumeric" value="">			
		</td>
	</tr>
		<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.agents"/></td>
		<td align="left">
			<input name="buyer" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.agents"/>" validate="notNull;isSearch" value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.suppliers"/></td>
		<td align="left">
			<input name="vendor" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.suppliers"/>" validate="notNull;isSearch" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="masterdetailtable.singlesubmit.order_descriptions"/></td>
		<td align="left">
			<input name="description" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.order_descriptions"/>" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:ordersInsert_onClick();"></td>
		<td align="left">
			<input type="button" name="cancel" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="return"/>" onClick="javascript:goBack()">
		</td>
	</tr>
</table>
</fmt:bundle>