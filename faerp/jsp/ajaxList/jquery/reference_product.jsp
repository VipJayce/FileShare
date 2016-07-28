<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<table>
	<tr>
		<td>
			<input type="button" name="Submit" value="<fmt:message bundle='${applicationResources}'  key="confirm"/>" class="button_ellipse" onclick="returnValue('referenceDetail','product_Id','product_name');">
			<input type="button" name="cancel" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>" class="button_ellipse" onclick="closed('referenceDetail');" >
		</td>
	</tr>
</table>


<div id="ccChild1">			
<table class="listCss" width="100%">
	<tr >
		<td>
<table id="tableData" class="listCss" width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<thead id="tableHead">
    <tr class="listCss">
    	<th class="listCss" width="5%" ><fmt:message bundle='${applicationResources}'  key="sequence"/></th>
    	<th class="listCss" width="5%" >&nbsp;</th>
		<th class="listCss" width="40%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'factoryid');">ID</th>
		<th class="listCss" width="40%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'name');"><fmt:message key="ordercontent.product_name"/></th>
	</tr>
	</thead>
	<tbody id="productTableBody">

	</tbody>
</table>
</div>
		</td>
	</tr>
</table>
<jsp:include page="/jsp/ajaxList/common/jquerypage.jsp" />
</div>
</fmt:bundle>
