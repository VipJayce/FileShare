<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/DataTransService.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/util.js'></script>
<script language="javascript">

function eh(msg) { 
	alert(i18n.error_message+msg); 
	fillTable();
} 
function getTableMap(){
	var tableMap={
	tableName:"",
	displayName:""
	};
	return tableMap;
}

function fillTable(){
	DataTransService.getTablesFromUser(function(data){
		fillMDListPage("tablesbody",data)
		//initTableColor(jQuery("#tableData"));
	});
}

function toAdd_onClick(){
	var tables=new Array();
	var elementCheckbox = document.getElementsByName("checkbox_template");
	var number = 0;
	var ids = null;
	for(var i=0;i<elementCheckbox.length;i++){
		if(elementCheckbox[i].checked) {
			number += 1;
			ids = elementCheckbox[i].value;
			var data=getTableMap();
			data["tableName"]=elementCheckbox[i].value;
			data["displayName"]=document.getElementById(elementCheckbox[i].value).value;
			tables.push(data);
		}
	}
	if(number == 0) {
  		alert(i18n.please_select_a_record)
  		return;
	}

	loadDelay("<venus:base/>","tablesbody");
	DWREngine.setErrorHandler(eh); 
	DataTransService.importData(tables,function(data){
		fillMDListPage("tablesbody",data)
		alert(i18n_dd.table_import_success(number));
	});
	
	
}

function loadDelay(path,tbodyid){
	DWRUtil.removeAllRows(tbodyid);
	var thead = DWRUtil.byId(tbodyid).parentNode.getElementsByTagName("thead")[0];
	var span = thead.rows[0].cells.length
	var rowObj= DWRUtil.byId(tbodyid).insertRow(0);
	var cell = rowObj.insertCell(0);
	cell.colSpan = span;
	cell.align = "center";
	cell.bgColor = "#FFFFFF";
	cell.innerHTML = '<img src="'+path+'/images/ajaxList/ajax-loader2.gif">'+i18n_dd.loading;
}

/**
 * 功能描述：利用dwr.util 填充主表或者子表的列表内容数据
 * 参数描述：MDTypeId:主子表列表显示的类型id：MasterListData,Detail1ListData,Detail2ListData,Detatil3ListData....
 *					  data:利用dwr请求服务器端函数，回调返回的结果，一般为map或者list
 */  
function fillMDListPage(mdView,tempdata){
    dwr.util.removeAllRows(mdView);
	//填充主表或子表的列表内容到页面中去，主要使用getFieldValue函数，来加载不同的主子表列表页面
	dwr.util.addRows(mdView, tempdata,getTableFields());
	var trObjs = dwr.util.byId(mdView).childNodes;
	var tdObjs;
	for(var i=0;i<trObjs.length;i++){
		trObjs[i].className = "listCss";
		tdObjs=trObjs[i].childNodes;
		tdObjs[0].align = "center";
	}
	getTbodyColor();
}

/**
* 功能描述：返回子表1列表页面要显示的对象集合。此处为product表的信息
*   				 data:是利用dwr请求服务器端函数，回调返回的结果，一般为map或者list
*/
function getTableFields(){
    //获得公共的checkbox的输出代码
	var column0 = function(data){
		var checkObj = jQuery("<input type='checkbox' id='checkbox_template' name='checkbox_template' value='"+data+"' />").get(0);
		return checkObj;
	};
	var column1 = function(data) { return dwr.util.byId("tablesbody").rows.length+1;}; 
	var column2 = function(data) { return data};
	var column3 = function(data){
		var inputObj = jQuery("<input type='text' id='"+data+"' value='"+data+"' class='text_field'/>").get(0);
		return inputObj;
	};
  return [column0,column1,column2,column3];
}

 </script>
<body onLoad="fillTable()">
<script language="javascript">
	writeTableTop(i18n_dd.query_list,'<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="metadata.tablelist"></fmt:message>
		</td>
		<td> 
			<table align="right">
				<tr>
						<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="trans.import"></fmt:message></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="listCss" width="100%">
	<tr>
		<td>
<table id="tableData" class="listCss" width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<thead id="tableHead">
    <tr class="listCss">
    	<th class="listCss" width="10%" ><input type='checkbox' pdType='control' control='checkbox_template'/></th>
		<th class="listCss" width="10%" ><fmt:message key="sequence"  bundle="${applicationResources}"></fmt:message></th>
		<th class="listCss" width="40%"><fmt:message key="metadata.tablename"></fmt:message></th>
		<th class="listCss" width="40%"><fmt:message key="metadata.table_name_zh"></fmt:message></th>
	</tr>
	</thead>
	<tbody id="tablesbody">

	</tbody>
</table>
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