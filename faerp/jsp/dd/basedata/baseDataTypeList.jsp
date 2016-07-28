<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ include file="/jsp/dd/include/common.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css"	rel="stylesheet" charset='UTF-8'>
<script type='text/javascript'	src='<%=request.getContextPath()%>/dwrdd/interface/BaseDataService.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/basedata/basedata.js"></script>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<script language="javascript">
	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;
	//创建翻页对象
	var pageVo  = new PageVoJs();
	//设置默认排序方式
	pageVo.setOrderStr("name");
	var actionType = "default";
	function getActionMap(){
		loadDelay("<venus:base/>","baseDataTypeBody");
		if(actionType=="default"){
			BaseDataService.getBaseDataTypes(pageVo,pageVo.getOrderSortStr(),getMapResult);
		}else{
			BaseDataService.getBaseDataTypesByName($name("name").value,$name("code").value,pageVo,pageVo.getOrderSortStr(),getMapResult);
		}
	}
	
	function queryAll(){
		//清除列表框复选状态。
		jQuery("[control=checkbox_template]").attr("checked",false);
		pageVo.initAction();
	}
	
	function simpleQuery_onClick(){
		actionType = "query";
		pageVo.initAction();
	}
		
	var getCheckbox = function(baseDataType){
		var checkObj = document.createElement("td");
		checkObj.innerHTML = "<input type='checkbox' name='checkbox_template' signName='checkbox_template'  value='"+baseDataType.id+"' />";
		return checkObj;
	};

	var getCode = function(baseDataType) { return baseDataType.code};
	var getName = function(baseDataType) { return baseDataType.name };

	function fillTable(data){
		fillTableById("baseDataTypeBody",data);
		initTableColor(jQuery("#baseDataType"));
	} 

	function fillTableById(tableId,data){
		DWRUtil.removeAllRows(tableId);
		DWRUtil.addRows(tableId, data,[getCheckbox,buildSerial,getCode,getName],
			{rowCreator:function(options) {
			    var row = document.createElement("tr");
			    row.className="listCss";
			    return row;
			},cellCreator:function(options) {
			    var td = document.createElement("td");
			    td.className = "listCss";
			    return td;},
			    escapeHtml:false
	  	});
	}

	/**
	 * 功能描述：添加基础数据类型
	 * 参数描述：
	 */    
	function add_onClick(tdObj,tableId){ 
		var baseDataType = getBaseDataType();
		baseDataType.sessionId =  "<%=request.getSession().getId()%>";//$name("sessionid").value;
		baseDataType.state = "insert";
		var obj = window.showModalDialog('<venus:base/>/BaseDataAction.do?cmd=goToEditPage',[baseDataType],'dialogHeight:300px;dialogWidth:490px;center=yes;help:no;resizable:no;scroll:no;status:0;');
		//alert(dwr.util.toDescriptiveString(obj, 2));
		if(obj == null || obj == undefined ){
			return;
		}
		var cellObjects = getBaseDataTypeObject(obj);
		insertEndRow("baseDataTypeBody",cellObjects); 	
		queryAll();
		alert('<fmt:message key="operation_successful_add_new_records"  bundle="${applicationResources}"><fmt:param  value="1"/></fmt:message>	');
	}  	
	
	function clear_onClick(){  //实现转到详细页面
		jQuery("#form").clearForm();
	}
		
	function insertCell(tableObj,rowObj,cells){
		rowObj.className="listCss";
		var irow=tableObj.rows;
		var icell=tableObj.rows[0].cells;
		for(i=0;i<icell.length;i++){
			rowObj.insertCell();
		}
		for(var i=0;i<icell.length;i++){
			rowObj.cells[i].innerHTML=cells[i];
		}
	}
	
	function getBaseDataTypeObject(data){
		var checkObj = getCheckbox(data).outerHTML;//"<input type='checkbox' name='checkbox_template' value='' />";
		var cellObjects = [checkObj,
			data.serial+1,
			data.code,
			data.name];
		return cellObjects;
	}
	
	function zoom_onClick(){
		var ids = findSelections4Zoom();
		if(ids == -1)return;
		goToZoom(ids[0]);
		
	}
	function zoom_onTableClick(event){
		var srcElement = event.srcElement?event.srcElement:event.target;
		var selectElements = jQuery(srcElement).parent().find("[signname='checkbox_template']");
		if(selectElements.size() <=0)return;
		goToZoom(selectElements.val());
	}
	function goToZoom(id){
		form.action = "<venus:base/>/BaseDataAction.do?cmd=editBaseData&ids=" + id;
		form.submit();
	}
	
	
	/**
	 * 功能描述：删除基础数据类型
	 * 参数描述：
	 */    
	 
	function delete_onClick(){
		var ids = findSelections4Delete();
	 	if(ids == -1)return;
		var baseDataTypeArray = new Array();
		for(var i=0;i<ids.length;i++){
			baseDataTypeArray[i]=ids[i];
		}
		BaseDataService.deleteBaseDataType(baseDataTypeArray,function(data){
			queryAll();
		});
	}  
		
	/**
	 * 功能描述：修改基础数据类型
	 * 参数描述：
	 */    
	function modify_onClick(){
		var ids = findSelections4Modify();
	 	if(ids == -1)return;
		var baseDataType = getBaseDataType();
		baseDataType.sessionId =  "<%=request.getSession().getId()%>";//$name("sessionid").value;
		baseDataType.state = "update";
		var num = 1;
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var tableElement=elementCheckbox[0].parentNode.parentNode.parentNode;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				var trElement = elementCheckbox[i].parentNode.parentNode.parentNode;
				num = trElement.rowIndex;
				baseDataType.id = elementCheckbox[i].value;
				if(baseDataType.id==""){
					baseDataType.state = "insert";
				}
				baseDataType.serial = jQuery(trElement).children("td:eq(1)").text();;
				baseDataType.code = jQuery(trElement).children("td:eq(2)").text();;
				baseDataType.name = jQuery(trElement).children("td:eq(3)").text();;
				break;
			}
		}
		var obj = window.showModalDialog('<venus:base/>/BaseDataAction.do?cmd=goToEditPage',[baseDataType],'dialogHeight:300px;dialogWidth:490px;center=yes;help:no;resizable:no;scroll:no;status:0;');
		if(obj == null || obj == undefined){
			resetCheckbox("checkbox_template");
			return;
		}
		var cellObjects = getBaseDataTypeObject(obj);
		changeRow("baseDataTypeBody",cellObjects,num); 
		alert('<fmt:message key="operation_successful_update_records"  bundle="${applicationResources}"><fmt:param  value="1"/></fmt:message>	');
		resetCheckbox("checkbox_template");
	}  	
	
	function refresh_onClick(){
		queryAll();
	}
</script>
<body onload="javascript:queryAll();">
<script language="javascript">
	writeTableTop('<fmt:message key="basedata.typepage_title"/>','<venus:base/>/');
</script>

<form id="form" name="form" method="post"
	action="<venus:base/>/BaseDataAction.do">
	<input type="hidden" name="cmd" value=""> 
<!--下面是查询区域-->
<div id="ccParent0" class="table_div_control" style="Padding: 5px;">
<div style="float: left"><img
	src="<%=request.getContextPath()%>/images/icon/07-0.gif"
	class="div_control_image"
	onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="common.query_by_condition"></fmt:message>
</div>
<div style="float: right"><input type='button'
	style="float: right" class="button_ellipse"
	onClick="javascript:clear_onClick();" value='<fmt:message key="clear"  bundle="${applicationResources}"></fmt:message>'></input> <input
	type='button' style="float: right" class="button_ellipse"
	onClick="javascript:simpleQuery_onClick();" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>'></input></div>
</div>
<div id="ccChild0" class="table_div_content" style="Padding: 5px;">
<fmt:message key="basedata.type_name"  ></fmt:message> <input name="name" type="text" class="text_field" inputName='<fmt:message key="basedata.type_name"  ></fmt:message>'	validate="isSearch">
<fmt:message key="basedata.type_code"  ></fmt:message> <input name="code" type="text" class="text_field" inputName='<fmt:message key="basedata.type_code"  ></fmt:message>'	validate="isSearch">
</div>

<!--下面是主表数据-->
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="common.detail_table"></fmt:message>
		</td>
		<td> 
			<table align="right">
				<tr>
						<td class="button_ellipse" onClick="javascript:add_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="add"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:delete_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:modify_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:zoom_onClick();"><img src="<%=request.getContextPath()%>/images/icon/preview.gif" class="div_control_image"><fmt:message key="view"  bundle="${applicationResources}"></fmt:message></td>
						<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<%=request.getContextPath()%>/images/icon/refresh.gif" class="div_control_image"><fmt:message key="refresh"  bundle="${applicationResources}"></fmt:message></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div id="ccChild1">
<table class="table_div_content">
	<tr>
		<td>
		<table id="baseDataType" class="listCss" ondblclick="zoom_onTableClick(event)"
			width="100%" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<thead id="baseDataTypeHead">
				<tr class="listCss">
					<th class="listCss" width="2%"><input type='checkbox'
						pdType='control' control='checkbox_template' /></th>
					<th class="listCss" width="6%"><fmt:message key="sequence"  bundle="${applicationResources}"></fmt:message></th>
					<th class="listCss" width="46%"><img
						src="<%=request.getContextPath()%>/images/layout/sort.gif"
						border="0" alt='<fmt:message key="desc"  bundle="${applicationResources}"></fmt:message>'
						onclick="javascript:pageVo.sortOrder(this,'code');"><fmt:message key="basedata.type_code"  ></fmt:message></th>
					<th class="listCss" width="46%"><img
						src="<%=request.getContextPath()%>/images/layout/sort.gif"
						border="0" alt='<fmt:message key="asce"  bundle="${applicationResources}"></fmt:message>'
						onclick="javascript:pageVo.sortOrder(this,'name');"><fmt:message key="basedata.type_name"  ></fmt:message></th>
				</tr>
			</thead>
			<tbody id="baseDataTypeBody">

			</tbody>
		</table>
		<jsp:include page="/jsp/dd/include/ajaxpage.jsp" /></td>
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

