<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
   <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
   <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
   <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-page.js"></script>
<script language="javascript">
//定义翻页行为
PageVoJs.prototype.action = getActionMap;
//创建翻页对象
var pageVo  = new PageVoJs();
//设置默认排序方式
pageVo.setOrderStr("name");

function getActionMap(){
	loadDelay("<venus:base/>","tableBody");
	AjaxControl.getProductsMap(pageVo,pageVo.getOrderSortStr(),getMapResult)
};

function query_onClick(){
	pageVo.initAction();
}

var getCheckbox = function(product) { 
	var checkObj = jQuery("<input type='checkbox'  name='checkbox_template' value='' />").get(0);
	return checkObj;
 };
var getFactoryName = function(product) { return product.factoryName };
var getBeginDate = function(product) { return product.beginDate };
var getEndDate = function(product) { return product.endDate };
var getCategoryid = function(product) { return product.categoryid };
var getFactoryid = function(product) { return product.factoryid };
var getProductid = function(product) { return product.productid };
var getName = function(product) { return product.name };
var getPrice = function(product) { return product.price };

function fillTable(data){
	DWRUtil.removeAllRows("tableBody");
	DWRUtil.addRows( "tableBody", data,[buildSerial,getCheckbox,getName,getCategoryid,getPrice,getBeginDate,getEndDate]);
	var trObjs = DWRUtil.byId("tableBody").childNodes;
	var tdObjs;
	for(var i=0;i<trObjs.length;i++){
		trObjs[i].className = "listCss";
		tdObjs=trObjs[i].childNodes;
		tdObjs[1].align = "center";
	}
		//页面初始化表格的样式
	getTbodyColor();
} 

</script>
<body onload="javascript:query_onClick();">
<script language="javascript">
	writeTableTop('ajax翻页示例','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;明细表格
		</td>
		<td>
			&nbsp;
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="listCss" width="100%">
	<tr>
		<td>
<table id="tableData"  width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<thead id="tableHead">
	    <tr class="listCss">
			<th class="listCss" width="5%" ><fmt:message bundle='${applicationResources}' key="sequence"/></th>
			<th class="listCss" width="5%" ><input type='checkbox' pdType='control' control='checkbox_template'/></th>
			<th class="listCss" width="20%"><img src="<venus:base/>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}' key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'name');"><fmt:message key='ordercontent.product_name' /></th>
			<th class="listCss" width="15%"><img src="<venus:base/>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}' key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'categoryid');"><fmt:message key="newtable.product_type"/></th>
			<th class="listCss" width="15%"><img src="<venus:base/>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}' key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'price');"><fmt:message key="newtable.product_price"/></th>
			<th class="listCss" width="20%"><img src="<venus:base/>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}' key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'beginDate');"><fmt:message key="newtable.production_date"/></th>
			<th class="listCss" width="20%"><img src="<venus:base/>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}' key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'endDate');"><fmt:message key="newtable.shelf_life_date"/></th>
		</tr>
	</thead>
	<tbody id="tableBody">

	</tbody>
</table>

		</td>
	</tr>
</table>
<jsp:include page="/jsp/ajaxList/common/ajaxpage.jsp" />
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>