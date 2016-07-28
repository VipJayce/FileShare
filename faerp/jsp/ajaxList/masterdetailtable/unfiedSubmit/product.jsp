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
<script language="javascript">
//定义翻页行为
PageVoJs.prototype.action = getActionMap;
//创建翻页对象
var pageVo  = new PageVoJs();
pageVo.pageSize = 5;
//设置默认排序方式
pageVo.setOrderStr("name");

function getActionMap(){
	loadDelay("<venus:base/>","tableBody");
	UnifiedSubmitAjax.getProductsMap(pageVo,pageVo.getOrderSortStr(),getMapResult)
};

function query_onClick(){
	pageVo.initAction();
}

var getRadio = function(product) { 
	var radioObj = jQuery("<input type='radio' name='checkbox_template' value=''/>").val(product.productid+':'+product.name);//document.createElement('<input type="radio" name="checkbox_template" value=""/>');
	//radioObj.value = product.productid+':'+product.name;
	return radioObj.get(0); 
};
var getName = function(product) { return product.name };
var getProductid = function(product) { return product.productid };

function fillTable(data){
	DWRUtil.removeAllRows("tableBody");
	DWRUtil.addRows( "tableBody", data,[getRadio,buildSerial,getName]);
	var trObjs = DWRUtil.byId("tableBody").childNodes;
	//alert(trObjs.length+" "+trObjs[0].tagName);
	for(var i=0;i<trObjs.length;i++){
		trObjs[i].className = "listCss"
	}
			//页面初始化表格的样式
	getTbodyColor();
} 

function returnvalue() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert(i18n.please_select_a_record);
	  		return;
		}
		if(number > 1) {
	  		alert(i18n.can_only_select_a_record);
	  		return;
		}
		var returnArray = new Array();
		returnArray[0] = ids.substring(0,ids.indexOf(":"));
		returnArray[1] = ids.substring(ids.indexOf(":")+1);
		window.returnValue = returnArray;
		window.close();
	}  
	function checkAllList_onClick(thisObj){  //全选，全不选
		var elementCheckbox = document.getElementsByName("checkbox_template");
		for(var i=0;i<elementCheckbox.length;i++){
			elementCheckbox[i].checked = thisObj.checked;
		}
	}
	
	
</script>
<base target="_self">
<body onload="javascript:query_onClick();">
<script language="javascript">
	writeTableTop('主子表列表','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<table>
	<tr>
		<td>
			<input type="button" name="Submit" value="<fmt:message bundle='${applicationResources}'  key="confirm"/>" class="button_ellipse" onClick="javascript:returnvalue();">
			<input type="button" name="cancel" value="<fmt:message bundle='${applicationResources}'  key="cancel"/>" class="button_ellipse" onClick="javascript:window.close();">
		</td>
	</tr>
</table>

<table class="listCss" width="100%">
	<tr>
		<td>
<table id="tableData" class="listCss" width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<thead id="tableHead">
    <tr class="listCss">
    	<th class="listCss" width="20" ></th>
		<th class="listCss" width="20" ><fmt:message bundle='${applicationResources}'  key="sequence"/></th>
		<th class="listCss" width="180"><img src="<venus:base/>/images/layout/sort.gif" border="0" alt="<fmt:message bundle='${applicationResources}'  key="asce"/>" onclick="javascript:pageVo.sortOrder(this,'name');"><fmt:message key="ordercontent.product_name"/></th>
	</tr>
	</thead>
	<tbody id="tableBody">

	</tbody>
</table>

		</td>
	</tr>
</table>
<jsp:include page="/jsp/ajaxList/common/ajaxpage.jsp" />
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>