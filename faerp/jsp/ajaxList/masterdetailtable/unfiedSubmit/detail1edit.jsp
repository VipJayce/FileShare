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
	var enumData = AjaxControl.getEnumList("ProductType",function(data){
		initSelect(data,selectId)
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


function getItemname(obj){
	var categoryname = obj.options[obj.selectedIndex].text;
	document.getElementById("categoryname").value = categoryname;
}
</script>
</head>
<base target="_self">
<body onload="javascript:initElements('categoryid');initDetailPage('masterDetailBo','detail1View',detail,'productid');">
<!-- body onload="javascript:initElements('categoryid');"-->
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
			<input name="button_save" type="button" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:saveDetail('masterDetailBo','detail1View','factoryid','productid');">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="masterdetailtable.unfiedsubmit.add_product"/>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td align="right" width="20%" nowrap><fmt:message key="ordercontent.product_name"/></td>
		<td>
			<input name="name" type="text" class="text_field" validate="notNull" inputName="<fmt:message key="ordercontent.product_name"/>" validate="isSearch">
		</td>
	</tr>
	<!--tr>
		<td align="right">厂家名称</td>
		<td align="left">
			<input name="productFactoryName" type="text" class="text_field" inputName="厂家名称" readOnly="true"  validate="notNull;isNumeric" value="">			
		</td>
	</tr-->
	<tr>
		<td align="right" width="15%" nowrap><fmt:message key="newtable.product_type"/></td>
		<td>
	        <select id="categoryid" onchange="getItemname(this)"></select>
	     </td>
	</tr>
	<tr>
	<td align="right"><fmt:message key="newtable.product_price"/></td>
		<td align="left">
			<input name="price" type="text" class="text_field" inputName="<fmt:message key="newtable.product_price"/>" validate="notNull;isNumeric" value="">
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="newtable.production_date"/></td>
		<td align="left">
			<input name="beginDate" id="beginDate" type="text" class="text_field_reference" inputName="<fmt:message key="newtable.production_date"/>" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('beginDate',<%=request.getContextPath()%>/)" class="img_1">		
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key="newtable.shelf_life_date"/></td>
		<td align="left">
			<input name="endDate" id="endDate" type="text" class="text_field_reference" inputName="<fmt:message key="newtable.shelf_life_date"/>" validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('endDate',<%=request.getContextPath()%>/)" class="img_1">				
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
