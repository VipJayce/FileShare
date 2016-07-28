<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">
			<fmt:message bundle='${applicationResources}' key="query_with_condition"/>
		</td>
	</tr>
</table>
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="ordercontent.factory_name"/></td>
	<td>
		<input name="factoryName" type="text" class="text_field_reference" inputName="<fmt:message key="ordercontent.factory_name"/>" validate="isSearch" readOnly="true" rubber_id="factoryid"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getFactoryList();" class="img_1">
		<input type="hidden" name="factoryid" id="rubber_id" value="">
	</td>
</tr>
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="ordercontent.product_name"/></td>
	<td><input name="name" type="text" class="text_field" inputName="<fmt:message key="ordercontent.product_name"/>" validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onClick="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>
</fmt:bundle>