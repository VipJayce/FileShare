<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_content">
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="ordercontent.product_name"/></td>
		<td>
			<input name="productName" type="text" class="text_field_reference" validate="notNull" inputName="<fmt:message key="ordercontent.product_name"/>" validate="isSearch" readOnly="true" rubber_id="factoryid"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getProductList();" class="img_1">
			<input type="hidden" name="productId" id="rubber_id" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="ordercontent.products_at_a_discount"/></td>
		<td align="left">
			<input name="price" type="text" class="text_field" inputName="<fmt:message key="ordercontent.products_at_a_discount"/>" validate="notNull;isNumeric" value="">			
		</td>
	</tr>
	<tr>
	<td align="right"><fmt:message key="ordercontent.number_of_products"/></td>
		<td align="left">
			<input name="productCount" type="text" class="text_field" inputName="<fmt:message key="ordercontent.number_of_products"/>" validate="notNull;isNumeric" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="ordercontent.the_total_amount_of_products"/></td>
		<td align="left">
			<input name="amount" type="text" class="text_field" inputName="<fmt:message key="ordercontent.the_total_amount_of_products"/>" validate="notNull;isNumeric" value="">			
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