<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<br />
<table class="table_div_content">
	<tr>
		<td align="right"><fmt:message bundle='${applicationResources}'  key="node_name"/>:</td>
		<td align="left">
			<input name="nodeName" type="text" class="text_field" inputName="<fmt:message bundle='${applicationResources}'  key="node_name"/>" validate="notNull" value="">			
		</td>
	</tr>	
	<tr>
		<td align="right"><fmt:message key="tree.location"/>:</td>
		<td align="left">
			<select id="locations" name="locations" >
				<option value="" selected><fmt:message key="tree.countrywide"/></option>
				<option value="1"><fmt:message key="tree.northern"/></option>
				<option value="2"><fmt:message key="tree.southern"/></option>
			</select>	
		</td>
	</tr>	
</table>
</fmt:bundle>