<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/gap-i18n.tld" prefix="i18n" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
<script>
     function returnNeedValue(dialogDivId,input_id,input_name,objectName){
        if((jQuery("input:checked[name='checkbox_template']")).size()==0 || (jQuery("input:checked[name='checkbox_template']")).size()>1){
            alert(i18n.please_select_a_record);
            return ;
        }
        var elementCheckbox=jQuery("input:checked[name='checkbox_template']");
        var ids = elementCheckbox[0].value;
        var paret_tr = jQuery(elementCheckbox).parent('td').parent('tr');
        var temp = jQuery(jQuery('td:eq(2)',paret_tr)).html();
        jQuery("input[name='"+input_id+"']").val(ids.substring(0,ids.indexOf(":")));
         jQuery("input[name='"+objectName+"']").val(temp);
         setOperators(ids.substring(ids.indexOf(":")+1));
        closed(dialogDivId);
  }
</script>
<table>
	<tr>
		<td>
			<input type="button" name="Submit" value="<fmt:message bundle='${applicationResources}'  key="confirm"/>" class="button_ellipse" onclick="returnNeedValue('referenceDetail','warnObjectId','returnType','objectName');">
			<input type="button" name="cancel" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>" class="button_ellipse" onclick="closed('referenceDetail');" >
		</td>
	</tr>
</table>


<div id="ccChild1">			
<table class="listCss"  width="100%">
	<tr >
		<td>
<!--div id="tableDiv1"--> 
<table id="tableData" class="listCss" width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<thead id="tableHead">
    <tr class="listCss">
    	<th class="listCss" width="5%" ><fmt:message bundle='${applicationResources}'  key="sequence"/></th>
    	<th class="listCss" width="5" >&nbsp;</th>
		<th class="listCss" width="40%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'objectName');"><fmt:message key="jsp.warning_object_name"/></th>
		<th class="listCss" width="40%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'functionName');"><fmt:message key="jsp.method_name"/></th>
	</tr>
	</thead>
	<tbody id="objectTableBody">

	</tbody>
</table>
</div>
<!--/div-->	
<jsp:include page="/jsp/ajaxList/common/jquerypage.jsp" />
		</td>
	</tr>
</table>
</div>
</fmt:bundle>
