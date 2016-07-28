<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message  key="table.detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:addDetail('detail1View','factoryid');"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td class="button_ellipse" onClick="javascript:deleteDetail('masterDetailBo','detail1View','productid');"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:modifyDetail('detail1View','factoryid','productid');"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table class="listCss"  width="100%">
	<tr >
		<td>
<!--div id="tableDiv2" --> 
<table id="tableData" class="listCss" width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<thead id="tableHead">
    <tr class="listCss">
    	<th class="listCss" width="5%" ><input type='checkbox' pdType='control' control='checkbox_detail1View'/></th>
		<th class="listCss" width="5%" ><fmt:message bundle='${applicationResources}'  key="sequence"/></th>
		<th class="listCss" width="15%"><fmt:message key="ordercontent.product_name"/></th>
		<th class="listCss" width="15%"><fmt:message key="newtable.product_type"/></th>
		<th class="listCss" width="20%"><fmt:message key="newtable.product_price"/></th>
		<th class="listCss" width="20%"><fmt:message key="newtable.production_date"/></th>
		<th class="listCss" width="20%"><fmt:message key="newtable.shelf_life_date"/></th>
	</tr>
	</thead>
	<tbody id="detail1View">

	</tbody>
</table>

		</td>
	</tr>
</table>
</fmt:bundle>
