<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_content">
	<tr>
		<td align="right" width="10%" nowrap><fmt:message key="ordercontent.factory_name"/></td>
		<td>
			<input name="factoryName" type="text" class="text_field_reference" validate="notNull" inputName="<fmt:message key="ordercontent.factory_name"/>" validate="isSearch" readOnly="true" rubber_id="factoryid"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getFactoryList();" class="img_1">
			<input type="hidden" name="factoryid" id="rubber_id" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="ordercontent.product_name"/></td>
		<td align="left">
			<input name="name" type="text" class="text_field" inputName="<fmt:message key="ordercontent.product_name"/>" validate="notNull;isSearch" value="">			
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="newtable.product_price"/></td>
		<td align="left">
			<input name="price" type="text" class="text_field" inputName="<fmt:message key="newtable.product_price"/>" validate="notNull;isNumeric" value="">			
		</td>
	</tr>
		<tr>
		<td align="right"><fmt:message key="newtable.product_type"/></td>
		<td align="left">
			<select name="categoryid" id="categoryid">

			</select>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="newtable.production_date"/></td>
		<td align="left">
			<input name="beginDate" id="beginDate" type="text" class="text_field_reference" inputName="<fmt:message key="newtable.production_date"/>" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="newtable.shelf_life_date"/></td>
		<td align="left">
			<input name="endDate" id="endDate"  type="text" class="text_field_reference" inputName="<fmt:message key="newtable.shelf_life_date"/>" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate','<%=request.getContextPath()%>/')" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:insert_onClick();"></td>
		<td align="left">
			<input name="productid" id="productid" type="hidden" class="text_field" value="">
		</td>
	</tr>
</table>
</fmt:bundle>