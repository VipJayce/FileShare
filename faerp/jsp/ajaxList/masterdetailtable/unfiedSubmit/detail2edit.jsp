<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import="gap.ajax.function.core.AjaxControl" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<head>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/UnifiedSubmitAjax.js'></script>  
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-masterdetail-unifiedSubmit.js"></script> 

<script language="javascript">
var params = dialogArguments;
var detail = params[0];
function initElements(selectId){
	AjaxControl.getEnumList("ProductType",function(data){
		initSelect(data,selectId)
	});
	
	AjaxControl.findProductById(detail.productId,function(data){
	if (data != null && typeof data == 'object') {
			dwr.util.setValue($("agentProductName"), data.name, { escapeHtml:false });
		}
	});
}


function saveDetail(mdBoName,mdView,masteridName,pkid){
	var detailVo = getMasterDetailVo(mdView);
	detailVo = getForms(detailVo);
	detailVo['serial'] = detail['serial'];
	detailVo['sessionId'] = detail['sessionId'];
	detailVo['state'] = detail['state'];
	detailVo[masteridName] = detail[masteridName];
	detailVo[pkid] = detail[pkid];
	UnifiedSubmitAjax.insertCache(mdBoName,mdView,detailVo);
	parent.window.returnValue = detailVo;
	parent.window.close();
}
/**
 * 功能描述：动态生成下拉菜单的内容
 * 参数：	selectId --下拉框id;
 *				key -- 填充时作为option value的对象属性
 *				value -- 填充时作为option展示的对象属性
 */    
function getProductRefrence(name,id){
    var event = window.event?window.event:getProductRefrence.caller.arguments[0];
	var obj = window.showModalDialog('<%=request.getContextPath()%>/jsp/ajaxList/masterdetailtable/unfiedSubmit/product.jsp','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;status:0;');
	if(obj) {
		jQuery("input[name='agentProductName']").val(obj[1]);
		jQuery("input[name='productId']").val(obj[0]);
	}
}

function getItemname(obj){
	var categoryname = obj.options[obj.selectedIndex].text;
	document.getElementById("categoryname").value = categoryname;
}
</script>
</head>
<base target="_self">
<body onload="javascript:initElements('categoryId');initDetailPage('masterDetailBo','detail2View',detail,'agentid');">
<script language="javascript">
	writeTableTop('<fmt:message key="masterdetailtable.single_table"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="sessionId" value="<%=request.getSession().getId()%>">
<input type="hidden" id="categoryname" name="categoryname" value="鞋类">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:saveDetail('masterDetailBo','detail2View','factoryId','agentid');">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="masterdetailtable.unfiedsubmit.add_agent"/>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="masterdetailtable.singlesubmit.agents"/></td>
		<td align="left">
			<input name="agentName" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.singlesubmit.agents"/>" validate="notNull;isNumeric" value="">			
		</td>
	</tr>
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="newtable.product_type"/></td>
		<td>
	        <select id="categoryId" name="categoryId" onchange="getItemname(this)">
	            <option value="000">--------</option>
	        </select>
	     </td>
	</tr>
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="ordercontent.product_name"/></td>
		<td>
			<input name="agentProductName" type="text" class="text_field_reference" validate="notNull" inputName="<fmt:message key="ordercontent.product_name"/>" validate="isSearch" readOnly="true" rubber_id="productId"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getProductRefrence('agentProductName','productId');" class="img_1">
			<input type="hidden" name="productId" id="productId" value="">
		</td>
	</tr>
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="masterdetailtable.unfiedsubmit.level"/></td>
		<td align="left">
			<input name="agentLevel" type="text" class="text_field" inputName="<fmt:message key="masterdetailtable.unfiedsubmit.level"/>" validate="notNull;isNumeric" value="" maxlength="1">			
		</td>
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>