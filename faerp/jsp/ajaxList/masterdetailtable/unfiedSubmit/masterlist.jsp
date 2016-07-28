<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
   <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/UnifiedSubmitAjax.js'></script>
   <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
   <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-page.js"></script>
   <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-masterdetail-unifiedSubmit.js"></script>
   
<script language="javascript">
//定义翻页行为
PageVoJs.prototype.action = getActionMap;
//创建翻页对象
var pageVo  = new PageVoJs();
//设置默认排序方式
pageVo.setOrderStr("name");

var actionType = "default";
function getActionMap(){
	loadDelay("<venus:base/>","masterView");
	if(actionType=="default"){
		UnifiedSubmitAjax.getFactorysMap(pageVo,pageVo.getOrderSortStr(),getMapResult);
	}else{
		UnifiedSubmitAjax.getFactorysByName($name("factoryName").value,pageVo,pageVo.getOrderSortStr(),getMapResult);
	}
}

function queryAll(){
	pageVo.initAction();
}

function query_onClick(){
	actionType = "query";
	pageVo.initAction();
}

function fillTable(data){
	fillMDListPage("masterView",data);
} 
/**
 * 功能描述：批量添加产品数据
 * 参数描述：
 */    
function add_onClick(tdObj,tableId){ 
	form.action = "<venus:base/>/MasterDetailAction.do?cmd=insertMasterDetail";
	form.submit();
}  	
/**
 * 功能描述：批量删除产品数据
 * 参数描述：
 */    
function delete_onClick(){ 
	var ids=getSelectIds("checkbox_master"); 
	if(ids.length == 0) {
  		alert(i18n.please_choose_record_to_delete)
  		return;
	}
	/*马啸注释
	if(confirm("是否彻底删除该数据？")) {
		var factoryArray = new Array();
		for(var i=0;i<ids.length;i++){
			var factory = getFactory();
			factory.factoryid = ids[i];
			factoryArray[i]=factory;
		}
		UnifiedSubmitAjax.deleteFactorys(factoryArray,function(data){
			if(data>=0){ 
				deleteRows(checkboxname,1);
				alert("删除"+data+"条记录！");
			}else{
				alert("删除失败，可能违反约束条件！");
			}
		});
	}
	*/
	if(confirm(i18n.confirm_to_delete_record)) {
		UnifiedSubmitAjax.deleteFactorys(ids,function(data){
			if(data>=0){ 
				deleteRows(checkboxname,1);
				alert(i18n4ajaxList.remove_records(data));
			}else{
				alert(i18n4ajaxList.delete_failure);
			}
		});
	}

}  
/**
 * 功能描述：修改工厂数据
 * 参数描述：
 */    
function modify_onClick(){  
	var ids=getSelectIds("checkbox_master"); 
	if(ids.length == 0) {
  		alert(i18n.please_select_a_record);
  		return;
	}else if(ids.length > 1) {
	 	alert(i18n.can_only_select_a_record);
  		return;
	}else{
		form.action = "<venus:base/>/MasterDetailAction.do?cmd=modifyMasterDetail&ids=" + ids[0];
		form.submit();
	}
}  	
function refresh_onClick(){
	queryAll();
}
</script>
<body onload="javascript:queryAll();">
<script language="javascript">
	writeTableTop('<fmt:message key="masterdetailtable.single_table"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<div id="master2">
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">
			<fmt:message bundle='${applicationResources}' key="query_with_condition"/>
		</td>
	</tr>
</table>
<div id="ccChild0">
<table class="table_div_content">
<tr>
	<td align="right" width="10%" nowrap><fmt:message key="ordercontent.factory_name"/></td>
	<td>
		<input name="factoryName" type="text" class="text_field" inputName="<fmt:message key="ordercontent.factory_name"/>" validate="isSearch">
		<input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onclick="javascript:query_onClick();">
	</td>
</tr>
</table>
</div>
</div>
<div id="masterList"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="table.detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:add_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td class="button_ellipse" onClick="javascript:delete_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:modify_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<%=request.getContextPath()%>/images/icon/refresh.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="refresh"/></td>
				</tr>
			</table>
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
    	<th class="listCss" width="5%" ><input type='checkbox' pdType='control' control='checkbox_master'/></th>
		<th class="listCss" width="5%" ><fmt:message bundle='${applicationResources}'  key="sequence"/></th>
		<th class="listCss" width="20%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'name');"><fmt:message key="ordercontent.factory_name"/></th>
		<th class="listCss" width="10%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'personname');"><fmt:message key="masterdetailtable.unfiedsubmit.contact"/></th>
		<th class="listCss" width="15%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'telephone');"><fmt:message key="masterdetailtable.unfiedsubmit.tel"/></th>
		<th class="listCss" width="15%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'begindate');"><fmt:message key="masterdetailtable.unfiedsubmit.created_date"/></th>
		<th class="listCss" width="30%"><img src="<%=request.getContextPath()%>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'address');"><fmt:message key="masterdetailtable.unfiedsubmit.factory_address"/></th>
	</tr>
	</thead>
	<tbody id="masterView">
    <tr class="listCss">
    	<td  ><input type="checkbox" name="checkbox_template" value="1099100500000000001"/></td>
		<td  >序</td>
		<td  >产品名称</td>
		<td >产品类型</td>
		<td  >产品价格</td>
		<td  >生产日期</td>
		<td  >保质日期</td>
	</tr>
	</tbody>
</table>
<jsp:include page="/jsp/ajaxList/common/ajaxpage.jsp" />
</div>
<!--/div-->	
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
