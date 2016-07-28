<html>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.List"%>
<%@ page import="gap.dd.util.VoHelper"%>
<%@ page import="gap.dd.util.StringHelper"%>
<%@ page import="gap.dd.metadata.vo.ColumnVo"%>
<%@ page import="gap.dd.metadata.vo.TableVo"%>
<%@ page import="gap.commons.xmlenum.EnumRepository"%>
<%@ page import="gap.commons.xmlenum.EnumValueMap"%>
<%@ page import="gap.dd.metadata.action.MetadataAction"%>
<%@ page import="venus.frames.i18n.util.LocaleHolder"%>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<%
    response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);    

	EnumRepository er = EnumRepository.getInstance();
	er.loadFromDir();
	EnumValueMap cTypeMap = er.getEnumValueMap("ColumnType");
	TableVo tableVo = (TableVo) request.getAttribute("TableVo"); //从request中取出vo, 赋值给tableVo
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="metadata.columnmgr"></fmt:message></title>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css"
	rel="stylesheet" charset='UTF-8'>
<link href="<venus:base/>/css/tabbar/tabbar.css" type="text/css"
	rel="stylesheet">
<script type="text/javascript" src="<venus:base/>/css/tabbar/tabbar.js"></script>

<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<script type='text/javascript'
	src='<venus:base/>/dwrdd/interface/MetadataAjax.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<script language="javascript">
	jQuery.noConflict();
function doDblClick(event) {  //处理鼠标双击事件
	var thisObj = event.srcElement?event.srcElement:event.target;
	var thisTag = undefined;
	var thisTr = thisObj.parentNode;
	var editObj;
	if(jQuery(thisObj).attr("classname")=="editlistCss"){
		editObj =  document.createElement("INPUT"); 
		if(thisObj.onkeyup!=null)
		{
			editObj.onkeyup=function(e){eval(thisObj.onkeyup);};
		}	
	}else if(jQuery(thisObj).attr("classname")=="editSelectCss"){
		return;
		//editObj = createSelect();
	}else if(jQuery(thisObj).attr("classname")=="editRefrenceCss"){
		return;
		//var refrenceObj = getRefrenceObj();
		//editObj = createRefrence(thisObj,refrenceObj);
	}else if(jQuery(thisObj).attr("classname")=="editYesNoSelectCss"){
		editObj = document.createElement("SELECT");
     	editObj.options.add(new Option("是","1")); 
     	editObj.options.add(new Option("否","0")); 
	}else if(jQuery(thisObj).attr("classname")=="editNoYesSelectCss"){
		editObj = document.createElement("SELECT");
     	editObj.options.add(new Option("否","0")); 
     	editObj.options.add(new Option("是","1")); 
	}else if(jQuery(thisObj).attr("classname")=="disabledCss"){
		thisObj.style.backgroundColor = "DDDDDD";
		alert("该值不允许修改");
		return thisObj;
	}else {
		return thisObj;
	}
	editObj.style.height = (thisObj.offsetHeight-(4)) + "px"; 
	editObj.style.width = thisObj.offsetWidth; 
	editObj.className = "text_field_reference"; 
	editObj.wrap = "soft"; 
	editObj.style.textAlign = thisObj.align; 
	var inputElement = thisObj.getElementsByTagName('input')[0];
	editObj.onclick = function(e) {
		(e || event).cancelBubble = true
	};
	editObj.ondbclick = function(e) {
		(e || event).cancelBubble = true
	};  
	editObj.onmousedown = function(e) {
		(e || event).cancelBubble = true
	};
	editObj.onblur = function(e) {
		if(editObj.tagName.toLowerCase()=="input"){
			jQuery(thisObj).html(editObj.value);
		}
		if(editObj.tagName.toLowerCase()=="select"){
			inputElement.value =  editObj.value;
			jQuery(thisObj).html(editObj.options[editObj.selectedIndex].text+jQuery(inputElement).outerHTML());
		
		}
		if(editObj.tagName.toLowerCase()!="div"){
			editObj.value = "";
			editObj.style.display = "none";
		}else{
			if(getLeft(thisObj)>event.clientX||(getLeft(thisObj)+thisObj.offsetWidth)<event.clientX||getTop(thisObj)>event.clientY||(getTop(thisObj)+thisObj.offsetHeight)<event.clientY){
				jQuery(thisObj).html(jQuery(editObj.value+thisObj.childNodes[1]).outerHTML());
				editObj.value = "";
				editObj.style.display = "none";
			}
		}
	};	
	editObj.value = jQuery(thisObj).html();
	if(editObj.tagName.toLowerCase()!="div"){
		jQuery(thisObj).html(""); 
		thisObj.appendChild(editObj); 
	}else{//参照保留hidden元素
		var hiddenElement = thisObj.childNodes[1];
		jQuery(thisObj).html(""); 
		thisObj.appendChild(editObj); 
		thisObj.appendChild(hiddenElement); 
	}
	editObj.focus();
	return editObj;
}
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="common.select_one_data"></fmt:message>')
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="common.only_select_one_data"></fmt:message>')
	  		return;
		}
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=modifyColumn&column_id=" + ids;
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert(i18n.please_choose_record_to_delete)
			return;
		}
		if(confirm(i18n.confirm_to_delete_record)) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=deleteColumns&ids=" + ids + "&tableId=<%=tableVo.getId()%>";
	    	form.submit();
		}
	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/dd/metadata/insertColumn.jsp?tableId=<%=tableVo.getId()%>&tableName=<%=tableVo.getTableName()%>";
		form.submit();
	}
	function refresh_onClick(){  //刷新本页
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryColumns&&tableId=<%=tableVo.getId()%>";
		form.submit();
	}
	function create_onClick(){  //创建表
		var elementCheckbox = document.getElementsByName("checkbox_template");  
		if(elementCheckbox.length==0) {
			alert('<fmt:message key="metadata.no_column_table_can_not_be_create"></fmt:message>');
			return false;
		}
		<%
		if("1".equals(tableVo.getIsCreated())) {
		%>
			alert('<fmt:message key="metadata.table_exist_can_not_be_create"></fmt:message>');
			return false;
		<%
		}
		%>
		<%
		if("1".equals(tableVo.getIsVirtual())) {
		%>
			alert('<fmt:message key="common.noneed_create_dummytable"></fmt:message>');
			return false;
		<%
		}
		%>
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=createTable&tableId=<%=tableVo.getId()%>";
		form.submit();
	}
	function return_onClick(){  //实现转到列表页面
		jQuery("form").clearForm();
		form.action="<%=request.getContextPath()%>/MetadataAction.do?cmd=queryTables";
		form.submit();
	}
//******************************************************** 以下为ajax专用 **************************************************
//************************************************************表专用*******************************************************
//**********注：在dwr中 $ 相当于document.getElementById()************
	function get_edit(id) {
		jQuery("#div_"+id).css("display","none");
		jQuery("#div_"+id+"_edit").css("display","block");
		jQuery("#em_"+id).html("<a href=\"javascript:doedit('"+id+"');\" style=\"text-decoration:underline;color:blue\">"+i18n_dd.save+"</a>&nbsp;&nbsp;<a href=\"javascript:cancel_edit('"+id+"')\" style=\"text-decoration:underline;color:blue\">"+i18n.cancel+"</a>");
	}
	function cancel_edit(id) {
		jQuery("#div_"+id+"_edit").css("display","none");
		jQuery("#div_"+id).css("display","block");
		jQuery("#em_"+id).html("<a href=\"javascript:get_edit('"+id+"')\" style=\"text-decoration:underline;color:blue\">"+i18n.modify+"</a>");
	}
	function doedit(id) {
		value = jQuery("[name='"+id+"']").val();
		jQuery("#div_"+id).css("display","block");
		jQuery("#div_"+id+"_edit").css("display","none");
		jQuery("#div_"+id).html('<fmt:message key="common.changing"></fmt:message>');
		MetadataAjax.updateTable("<%=tableVo.getId()%>", id, value,
			function(data) {
				jQuery("#div_"+id).html(data);
			}
		);
		jQuery("#em_"+id).html("<a href=\"javascript:get_edit('"+id+"')\" style=\"text-decoration:underline;color:blue\">"+i18n.modify+"</a>");
	}

//************************************************************列专用*******************************************************
	//定义全局变量
	var currentSerialNum = 1;
	
function addNewColumn() { 

	var tr=jQuery("#controlList").get(0).insertRow(-1); 		
	var td0 = tr.insertCell(0);
    td0.setAttribute("align","center");
    jQuery(td0).html("<input type=checkbox value='' name='checkbox_template' checked>");
    var td1 = tr.insertCell(1);
    td1.setAttribute("align","center");
    jQuery(td1).html(currentSerialNum+"<input type='hidden' value='' signName='hiddenId'><input type='hidden' value='0' signName='spare1'>");
    var td2 = tr.insertCell(2);
    jQuery(td2).html("<input type='text' size='20' name='displayName' signName='displayName' inputName='<fmt:message key="metadata.name_zh"></fmt:message>' value='' maxLength='64' validate='notNull;'>");
    var td3 = tr.insertCell(3);
    jQuery(td3).html("<input type='text' size='20' name='columnName' signName='columnName' inputName='列名' value='' maxLength='64' validate='notNull;'  onkeyup='this.value=this.value.replace(\/[^\\w\\.\\\/]\/ig,\"\")'>");
    var str = "<select name='columnType' style='width:80'  signName='columnType' inputName='列类型'>";
				<%
					List al = cTypeMap.getEnumList();
					for(int i=0;i<al.size();i++){%>
	str +=   		"<option value='<%=cTypeMap.getValue(al.get(i).toString())%>'><%=al.get(i)%></option>";
     			 <%}%>
	str += "</select>";
	var td4 = tr.insertCell(4);
    jQuery(td4).html(str);
    
    var td5 = tr.insertCell(5);
    jQuery(td5).html("<input type='text' size='5' name='columnLen' signName='columnLen' inputName='<fmt:message key="metadata.columnlen"></fmt:message>' value='' maxLength='5' validate='isNum;' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")'>");
    
    var td6 = tr.insertCell(6);
    jQuery(td6).html("<input type='text' size='5' name='columnPrec' signName='columnPrec' inputName='<fmt:message key="metadata.decimaldigits"></fmt:message>' value='' maxLength='5' validate='isNum;' onkeyup='this.value=this.value.replace(\/\\D\/g,\"\")'>");
    
    var td7 = tr.insertCell(7);
    jQuery(td7).html("<input type='text' size='5' name='defaultVal' signName='defaultVal' inputName='<fmt:message key="metadata.defaultvalue"></fmt:message>' value='' maxLength='64' >");
    
    var td8 = tr.insertCell(8);
    td8.setAttribute("align","center");
    jQuery(td8).html("<select name='isNullable' style='width:40' signName='isNullable' ><option value='1'><fmt:message key="common.yes"></fmt:message></option><option value='0'><fmt:message key="common.no"></fmt:message></option></select>");
    
    var td9 = tr.insertCell(9);
    jQuery(td9).html("<input type='text' size='20' name='category' signName='category' inputName='<fmt:message key="metadata.columncategory"></fmt:message>' value='' maxLength='512' >");
    
    var td10 = tr.insertCell(10);
    jQuery(td10).html("<input type='text' size='20' name='remark' signName='remark' inputName='<fmt:message key="remark"  bundle="${applicationResources}"></fmt:message>' value='' maxLength='512' >");
    currentSerialNum++;
} 

function refreshColumns(color) {
	MetadataAjax.queryColumns("<%=tableVo.getId()%>", function(data)  {
		while(DWRUtil.byId("controlList").rows.length>1) {
		//delete record rows,the number from 1 to n in FF and chromium
			DWRUtil.byId("controlList").deleteRow(DWRUtil.byId("controlList").rows.length-1);
		}
		currentSerialNum = 1;
		for(var i=0; i<data.length; i++) {
			var tr=DWRUtil.byId("controlList").insertRow(i+1);
			var td0 = tr.insertCell(0);
		    td0.setAttribute("align","center");
		    jQuery(td0).html("<input type='checkbox' value='"+data[i].id+"' name='checkbox_template' displayName='"+data[i].columnName+"'>");
		    
		    var td1 = tr.insertCell(1);
		    td1.setAttribute("align","center");
		    jQuery(td1).html(currentSerialNum+"<input type='hidden' value='"+data[i].id+"' signName='hiddenId'><input type='hidden' value='0' signName='spare1'>");
		    
		    var td2 = tr.insertCell(2);
		    td2.setAttribute("className","editlistCss");
		    jQuery(td2).html(data[i].displayName);
		    
		    var td3 = tr.insertCell(3);
		    td3.setAttribute("className","editlistCss");
		    td3.setAttribute("onkeyup","this.value=this.value.replace(\/[^\\w\\.\\\/]\/ig,\'\')");
		    jQuery(td3).html(data[i].columnName);
		    
			var td4 = tr.insertCell(4);
		    td4.setAttribute("className","editSelectCss");
		    jQuery(td4).html(data[i].columnTypeName + "<input type='hidden' signName='columnType' value='"+data[i].columnType+"'>");
		    
		    var td5 = tr.insertCell(5);
		    td5.setAttribute("className","editlistCss");
		    td5.setAttribute("onkeyup","this.value=this.value.replace(\/\\D\/g,\'\')");		    
		    jQuery(td5).html(data[i].columnLen);
		    
		     var td6 = tr.insertCell(6);
		    td6.setAttribute("className","editlistCss");
		    td6.setAttribute("onkeyup","this.value=this.value.replace(\/\\D\/g,\'\')");		    
		    jQuery(td6).html(data[i].columnPrec);
		    
		    var td7 = tr.insertCell(7);
		    td7.setAttribute("className","editlistCss");
		    jQuery(td7).html(data[i].defaultVal);
		    
		    var td8 = tr.insertCell(8);
		    td8.setAttribute("className","editYesNoSelectCss");
		    td8.setAttribute("align","center");
		    var yesNo = "<fmt:message key="common.no"></fmt:message>";
		    if(data[i].isNullable=="1")
		    	yesNo = "<fmt:message key="common.yes"></fmt:message>";
		    jQuery(td8).html(yesNo + "<input type='hidden' signName='isNullable' value='"+data[i].isNullable+"'>");
										      
		    var td9 = tr.insertCell(9);
		    td9.setAttribute("className","editlistCss");
		    jQuery(td9).html(data[i].category);
		    
		    var td10 = tr.insertCell(10);
		    td10.setAttribute("className","editlistCss");
		    
		    jQuery(td10).html(data[i].remark);
		    
		    currentSerialNum++;
		    
		    if(color==undefined) {
				tr.style.backgroundColor = "DEEEF8";
			}else {
				tr.style.backgroundColor = color;
			}
			//$("controlList").getTbodyColor();
		}
	});
} 

/**
 * 功能描述：构造list类型的参数对象
 * 参数描述：
 */    
function buildModifyColumns(){
	var checkboxall = document.getElementsByName("checkbox_template");
	var count = 0;
	var recordarray= new Array();//对象集合
	for(var i=0;i<checkboxall.length;i++){
		if(checkboxall[i].checked==false){
			continue;
		}
		var trObj = checkboxall[i].parentNode.parentNode;
		var tbObj = trObj.parentNode.parentNode;
		if(tbObj.id=="controlList") {
			var record= {
				id:"",
				tableId:"",
				tableName:"",
				displayName:"",
				columnName:"",
				columnType:"",
				columnLen:"",
				columnPrec:"",
				defaultVal:"",
				isNullable:"",
				category:"",
				remark:"",
				spare1:""
			} ;
			record.id = getObjectByNameRecursive(trObj,"hiddenId").value;
			record.tableId = "<%=tableVo.getId()%>";
			record.tableName = "<%=tableVo.getTableName()%>";
			if(record.id=="") {//新增记录
				record.displayName = getObjectByNameRecursive(trObj,"displayName").value;
				record.columnName = getObjectByNameRecursive(trObj,"columnName").value;
				record.columnType = getObjectByNameRecursive(trObj,"columnType").value;
				record.columnLen = getObjectByNameRecursive(trObj,"columnLen").value;
				record.columnPrec = getObjectByNameRecursive(trObj,"columnPrec").value;
				record.defaultVal = getObjectByNameRecursive(trObj,"defaultVal").value;
				record.isNullable = getObjectByNameRecursive(trObj,"isNullable").value;
				record.category = getObjectByNameRecursive(trObj,"category").value;
				record.remark = getObjectByNameRecursive(trObj,"remark").value;
				record.spare1 = getObjectByNameRecursive(trObj,"spare1").value;
			}else {//修改记录
				record.displayName = jQuery(trObj).children("td:eq(2)").text();
				record.columnName = jQuery(trObj).children("td:eq(3)").text();
				record.columnType = getObjectByNameRecursive(trObj,"columnType").value;
				record.columnLen = jQuery(trObj).children("td:eq(5)").text();
				record.columnPrec = jQuery(trObj).children("td:eq(6)").text();
				record.defaultVal = jQuery(trObj).children("td:eq(7)").text();
				record.isNullable = getObjectByNameRecursive(trObj,"isNullable").value;
				record.category = jQuery(trObj).children("td:eq(9)").text();
				record.remark = jQuery(trObj).children("td:eq(10)").text();
				record.spare1 = getObjectByNameRecursive(trObj,"spare1").value;
			}
			recordarray[count] = record;
			count++;
		}
	}
	return recordarray;
}

function submit_column() {
	var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	if(ids == null)	{  //如果ids为空
		alert('<fmt:message key="common.select_one_data"></fmt:message>');
		return false;
	}
	var records=buildModifyColumns();
	MetadataAjax.updateColumns(records,function(data) { //新增或修改
			alert(data);
			refreshColumns("FFFFFF");//刷新列表
		});
	return false;
}

function submit_key() {
	var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
	if(ids == null)	{  //如果ids为空
		alert('<fmt:message key="common.select_one_data"></fmt:message>');
		return false;
	}
	var records=buildModifyKeyRecords(); 
	
	//alert(dwr.util.toDescriptiveString(records,3));
	MetadataAjax.updateKeys(records,function(data) { //新增或修改
			alert(data);
			refreshKeyTable("FFFFFF");//刷新列表
		});
	
	return false;
}

function reset_column() {
	refreshColumns("FFFFFF");
}

function deleteColumns() {
	
	var checkboxall = document.getElementsByName("checkbox_template");
	var count = 0;
	var delIndex = new Array(0);
	for( var i=checkboxall.length-1; i>=0; i-- ){
		if(checkboxall[i].checked){
			count ++;
			var trObj = checkboxall[i].parentNode.parentNode;
			var tbObj = trObj.parentNode.parentNode;
			if(tbObj.id=="controlList") {
				var id = getObjectByNameRecursive(trObj,"hiddenId").value;
				if(id != "") { //非新增记录，置标志位并把行隐藏
					getObjectByNameRecursive(trObj,"spare1").value = "1";//删除标志
					trObj.style.display = "none";
				}else {//新增的记录，直接删除行
					delIndex.push(trObj.rowIndex);
				}
			}
		}
	}
	
	if(count==0) {
		alert('<fmt:message key="common.select_one_data"></fmt:message>');
		return false;
	}else {
		for(var i=0; i<delIndex.length; i++) {
			DWRUtil.byId("controlList").deleteRow(delIndex[i]);//删除html行
		}
	}
}

//************************************************************键专用*******************************************************
var currentKeyNum = 1;
/**
 * 功能描述：动态编辑表格时创造下拉列表
 * 参数描述：
 */
function createTableSelect(tableName){
	if(tableName==null || tableName=="") {
		tableName = "tableName";
	}
	var selectElement = document.createElement("SELECT");
	selectElement.setAttribute("id",tableName+currentKeyNum);
	selectElement.setAttribute("name",tableName);
	selectElement.setAttribute("signName",tableName);
	DWREngine.setAsync(false);   
	MetadataAjax.queryTables(function(data)  {
		for(var i=0; i<data.length; i++) {
			var item = new Option(data[i].displayName,data[i].tableName);       
     		selectElement.options.add(item);
		}
	});
	DWREngine.setAsync(true);   
	return selectElement;
}
/**
 * 功能描述：动态编辑表格时创造下拉列表
 * 参数描述：
 */
function createKeysSelect(tableName,columnName) {
	if(tableName==null || tableName=="") {
		tableName = "<%=tableVo.getTableName()%>";
	}
	if(columnName==null || columnName=="") {
		columnName = "columnName";
	}
	var selectElement = document.createElement("SELECT");
	selectElement.setAttribute("id",columnName+currentKeyNum);
	selectElement.setAttribute("name",columnName);
	selectElement.setAttribute("signName",columnName);
	DWREngine.setAsync(false);  
	MetadataAjax.queryKeysByTableName(tableName, function(data)  {
		for(var i=0; i<data.length; i++) {
			if(data[i].constraintType=='P' || data[i].constraintType=='U'){
				var item = new Option(data[i].columnName,data[i].columnName);       
	     		selectElement.options.add(item);
	     	}
		}
	});
	DWREngine.setAsync(true);   
	return selectElement;
}

function createColumnsSelect(tableName,columnName) {
	if(tableName==null || tableName=="") {
		tableName = "<%=tableVo.getTableName()%>";
	}
	if(columnName==null || columnName=="") {
		columnName = "columnName";
	}
	var selectElement = document.createElement("SELECT");
	selectElement.setAttribute("id",columnName+currentKeyNum);
	selectElement.setAttribute("name",columnName);
	selectElement.setAttribute("signName",columnName);
	DWREngine.setAsync(false);  
	MetadataAjax.queryColumnsByTableName(tableName, function(data)  {
		for(var i=0; i<data.length; i++) {
			var item = new Option(data[i].columnName,data[i].columnName);       
     		selectElement.options.add(item);
		}
	});
	DWREngine.setAsync(true);   
	return selectElement;
}

function getTableSelectHtm(tableName,keyNum) {
	var obj = createTableSelect(tableName);
	obj.style.width="100";
	obj.onchange="refreshRKeysSelect('"+keyNum+"')";
	return jQuery(obj).outerHTML();
}
function refreshRKeysSelect(keyNum) {
	var cTableName = DWRUtil.byId("rTableName"+keyNum).value;
	jQuery("changeTd"+keyNum).html(getKeysSelectHtm(cTableName,"rColumnName"));
}
function getColumnSelectHtm(tableName,columnName) {
	var obj = createColumnsSelect(tableName,columnName);
	obj.style.width="100";
	return jQuery(obj).outerHTML();
}
function getKeysSelectHtm(tableName,columnName) {
	var obj = createKeysSelect(tableName,columnName);
	obj.style.width="100";
	return jQuery(obj).outerHTML();
}
function addNewKeyRow() { 
	var tr=jQuery("#keyList").get(0).insertRow(-1);
	var td0 = tr.insertCell(0);
    td0.setAttribute("align","center");
    jQuery(td0).html("<input type=checkbox value='' name='checkbox_template' checked>");
    var td1 = tr.insertCell(1);
    td1.setAttribute("align","center");
    jQuery(td1).html(currentKeyNum+"<input type='hidden' value='' signName='hiddenId'><input type='hidden' value='0' signName='spare1'>");
    var td2 = tr.insertCell(2);
    jQuery(td2).html(getColumnSelectHtm());
    var td3 = tr.insertCell(3);
    jQuery(td3).html("<input type='text' size='20' name='constraintName' signName='constraintName' inputName='<fmt:message key="metadata.key_name"></fmt:message>' value='' maxLength='64' validate='notNull;'>");
    var strKeyType = "<select name='constraintType' style='width:80'  signName='constraintType'><option value='P'><fmt:message key="metadata.pk_name"></fmt:message></option><option value='R'><fmt:message key="metadata.fk_name"></fmt:message></option><option value='U'><fmt:message key="metadata.uk_name"></fmt:message></option></select>";
	var td4 = tr.insertCell(4);
    jQuery(td4).html(strKeyType);
    var td5 = tr.insertCell(5);
    jQuery(td5).html(getTableSelectHtm("rTableName",currentKeyNum));
    var td6 = tr.insertCell(6);
    td6.setAttribute("id","changeTd"+currentKeyNum);
    var cTableName = jQuery(getObjectByNameRecursive(tr,"rTableName")).val();
    jQuery(td6).html(getKeysSelectHtm(cTableName,"rColumnName"));
    
    currentKeyNum++;
} 

function refreshKeyTable(color) {
	MetadataAjax.queryKeysByTableName("<%=tableVo.getTableName()%>", function(data)  {
		while(DWRUtil.byId("keyList").rows.length>1) {
			DWRUtil.byId("keyList").deleteRow(DWRUtil.byId("keyList").rows.length-1);
		}
		currentKeyNum = 1;     
		for(var i=0; i<data.length; i++) {
			if(data[i].constraintType=="P") {
				var tr=DWRUtil.byId("keyList").insertRow(i+1);
				var td0 = tr.insertCell(0);
			    td0.setAttribute("align","center");
			    jQuery(td0).html("<input type='checkbox' value='"+data[i].id+"' name='checkbox_template' displayName='"+data[i].columnName+"'>");
			    var td1 = tr.insertCell(1);
			    td1.setAttribute("align","center");
			    jQuery(td1).html(currentKeyNum+"<input type='hidden' value='"+data[i].id+"' signName='hiddenId'><input type='hidden' value='0' signName='spare1'>");
			    var td2 = tr.insertCell(2);
			    jQuery(td2).html(data[i].columnName);
			    var td3 = tr.insertCell(3);
			    jQuery(td3).html(data[i].constraintName);
				var td4 = tr.insertCell(4);
			    jQuery(td4).html('<fmt:message key="metadata.pk_name"></fmt:message>'+"<input type='hidden' signName='constraintType' value='P'>");
			    var td5 = tr.insertCell(5);
			    jQuery(td5).html("");
			     var td6 = tr.insertCell(6);
			    jQuery(td6).html("");
			    currentKeyNum ++;
			    if(color==undefined) {
					tr.style.backgroundColor = "DEEEF8";
				}else {
					tr.style.backgroundColor = color;
				}
			}
			if(data[i].constraintType=="R") {
				var tr=DWRUtil.byId("keyList").insertRow(i+1);
				var td0 = tr.insertCell(0);
			    td0.setAttribute("align","center");
			    jQuery(td0).html("<input type='checkbox' value='"+data[i].id+"' name='checkbox_template' displayName='"+data[i].columnName+"'>");
			    var td1 = tr.insertCell(1);
			    td1.setAttribute("align","center");
			    jQuery(td1).html(currentKeyNum+"<input type='hidden' value='"+data[i].id+"' signName='hiddenId'><input type='hidden' value='0' signName='spare1'>");
			    var td2 = tr.insertCell(2);
			    jQuery(td2).html(data[i].columnName);
			    var td3 = tr.insertCell(3);
			    jQuery(td3).html(data[i].constraintName);
				var td4 = tr.insertCell(4);
			    jQuery(td4).html('<fmt:message key="metadata.fk_name"></fmt:message>'+"<input type='hidden' signName='constraintType' value='R'>");
			    var td5 = tr.insertCell(5);
			    jQuery(td5).html(data[i].refTableName);
			     var td6 = tr.insertCell(6);
			    jQuery(td6).html(data[i].refColumnName);
			    currentKeyNum ++;
			    if(color==undefined) {
					tr.style.backgroundColor = "DEEEF8";
				}else {
					tr.style.backgroundColor = color;
				}
			}
			if(data[i].constraintType=="U") {
				var tr=DWRUtil.byId("keyList").insertRow(i+1);
				var td0 = tr.insertCell(0);
			    td0.setAttribute("align","center");
			    jQuery(td0).html("<input type='checkbox' value='"+data[i].id+"' name='checkbox_template' displayName='"+data[i].columnName+"'>");
			    var td1 = tr.insertCell(1);
			    td1.setAttribute("align","center");
			    jQuery(td1).html(currentKeyNum+"<input type='hidden' value='"+data[i].id+"' signName='hiddenId'><input type='hidden' value='0' signName='spare1'>");
			    var td2 = tr.insertCell(2);
			    jQuery(td2).html(data[i].columnName);
			    var td3 = tr.insertCell(3);
			    jQuery(td3).html(data[i].constraintName);
				var td4 = tr.insertCell(4);
			    jQuery(td4).html('<fmt:message key="metadata.uk_name"></fmt:message>'+"<input type='hidden' signName='constraintType' value='U'>");
			    var td5 = tr.insertCell(5);
			    jQuery(td5).html("");
			     var td6 = tr.insertCell(6);
			    jQuery(td6).html("");
			    currentKeyNum ++;
			    if(color==undefined) {
					tr.style.backgroundColor = "DEEEF8";
				}else {
					tr.style.backgroundColor = color;
				}
			}
		}
		//$("keyList").getTbodyColor();
	});
} 

/**
 * 功能描述：构造list类型的参数对象
 * 参数描述：
 */    
function buildModifyKeyRecords(){

	var checkboxall = document.getElementsByName("checkbox_template");
	var count = 0;
	var recordarray= new Array();//对象集合
	for(var i=0;i<checkboxall.length;i++){
		if(checkboxall[i].checked==false){
			continue;
		}
		var trObj = checkboxall[i].parentNode.parentNode;
		var tbObj = trObj.parentNode.parentNode;
		if(tbObj.id=="keyList") {
			var record= {
				id:"",
				constraintName:"",
				constraintType:"",
				tableName:"",
				columnName:"",
				conditionStr:"",
				refTableName:"",
				refColumnName:"",
				status:"1"
			} ;
			record.id = getObjectByNameRecursive(trObj,"hiddenId").value;
			record.spare1 = getObjectByNameRecursive(trObj,"spare1").value;
			if(record.id!="" && record.spare1==0)
				continue;
			record.tableName = "<%=tableVo.getTableName()%>";
			if(record.id=="") {//新增记录
				record.columnName = getObjectByNameRecursive(trObj,"columnName").value;
				record.constraintName = getObjectByNameRecursive(trObj,"constraintName").value;
				record.constraintType = getObjectByNameRecursive(trObj,"constraintType").value;
				if(record.constraintType=='R')
				{
					record.refTableName = getObjectByNameRecursive(trObj,"rTableName").value;
					record.refColumnName = getObjectByNameRecursive(trObj,"rColumnName").value;
				}
			}else {//删除记录
				record.columnName =  trObj.cells[2].innerText;
				record.constraintName = trObj.cells[3].innerText;
				record.constraintType = getObjectByNameRecursive(trObj,"constraintType").value;
			}
			recordarray[count] = record;
			count++;
		}
	}
	return recordarray;
}

function reset_key() {
	refreshKeyTable("FFFFFF");
}

function deleteKeyRow() {
	var checkboxall = document.getElementsByName("checkbox_template");
	var count = 0;
	var delIndex = new Array(0);
	for( var i=checkboxall.length-1; i>=0; i-- ){
		if(checkboxall[i].checked){
			count ++;
			var trObj = checkboxall[i].parentNode.parentNode;
			var tbObj = trObj.parentNode.parentNode;
			if(tbObj.id=="keyList") {
				var id = getObjectByNameRecursive(trObj,"hiddenId").value;
				if(id != "") { //非新增记录，置标志位并把行隐藏
					getObjectByNameRecursive(trObj,"spare1").value = "1";//删除标志
					trObj.style.display = "none";
				}else {//新增的记录，直接删除行
					delIndex.push(trObj.rowIndex);
				}
			}
		}
	}
	if(count==0) {
		alert(i18n.please_choose_record_to_delete)
		return false;
	}else {
		for(var i=0; i<delIndex.length; i++) {
			DWRUtil.byId("keyList").deleteRow(delIndex[i]);//删除html行
		}
	}
}

</script>
</head>
<body>
	<script language="javascript">
	writeTableTop('<fmt:message key="metadata.tablemgr_page"></fmt:message>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
	<form id="form" name="form" method="post">

		<table class="table_noFrame">
			<tr>
				<td>
					<input name="button_save" class="button_ellipse" type="button"
						value='<fmt:message key="metadata.create_table"></fmt:message>' onClickTo="javascript:create_onClick()">
					<input name="button_cancel" class="button_ellipse" type="button"
						value='<fmt:message key="return"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:return_onClick()">
				</td>
			</tr>
		</table>

		<div id="ccParent0">
			<table class="table_div_control">
				<tr>
					<td>
						<img src="<%=request.getContextPath()%>/images/icon/07-0.gif"
							class="div_control_image"
							onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')">
						<fmt:message key="metadata.table_detail_info"></fmt:message>
					</td>
				</tr>
			</table>
		</div>

		<div id="ccChild0">
			<table class="table_div_content" width="100%">
				<tr>
					<td>
						<table class="table_div_content_inner" width="100%">
							<tr>
								<td width="20%" align="right"><fmt:message key="metadata.table"></fmt:message>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="metadata.name"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td width="30%" align="left">
									<%=StringHelper.prt(tableVo.getTableName())%>
								</td>
								<td width="20%" align="right">
									&nbsp;
								</td>
								<td width="30%" align="left">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="metadata.table_name_zh"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<DIV id=div_displayName>
										<%=StringHelper.prt(tableVo.getDisplayName())%>
									</DIV>
									<DIV id="div_displayName_edit" style="display:none">
										<input type="text" class="text_field" name="displayName"
											inputName='<fmt:message key="metadata.table_name_zh"></fmt:message>'
											value="<%=StringHelper.prt(tableVo.getDisplayName())%>"
											maxLength="64" validate="notNull;" />
									</DIV>
								</td>
								<td colspan="2">
									<EM id="em_displayName" style="display:block"><A
										href="javascript:get_edit('displayName')" style="text-decoration:underline;color:blue"><fmt:message key="modify"  bundle="${applicationResources}"></fmt:message></A> </EM>
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="metadata.isdummy"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<%=StringHelper.prtYesNo(tableVo.getIsVirtual())%>
								</td>
								<td align="right"><fmt:message key="metadata.iscreated"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<%="1".equals(tableVo.getIsCreated()) ? LocaleHolder.getMessage("gap.dd.metadata.created") : LocaleHolder.getMessage("gap.dd.metadata.uncreated")%>
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="metadata.creator_nbsp"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<%=StringHelper.prt(tableVo.getCreatedBy())%>
								</td>
								<td align="right"><fmt:message key="metadata.create_date"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<%=StringHelper.prt(tableVo.getCreated(), 19)%>
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="metadata.mender_nbsp"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<%=StringHelper.prt(tableVo.getUpdatedBy())%>
								</td>
								<td align="right"><fmt:message key="metadata.modify_date"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<%=StringHelper.prt(tableVo.getUpdated(), 19)%>
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="metadata.remark_nbsp"></fmt:message><fmt:message key="metadata.colon"></fmt:message></td>
								<td align="left">
									<DIV id=div_remark>
										<%=StringHelper.prt(tableVo.getRemark())%>
									</DIV>
									<DIV id="div_remark_edit" style="display:none">
										<textarea class="textarea_limit_words" cols="50" rows="5"
											name="remark" inputName='<fmt:message key="remark"  bundle="${applicationResources}"></fmt:message>' maxLength="256" align="left"><%=StringHelper.prt(tableVo.getRemark())%></textarea>
									</DIV>
								</td>
								<td colspan="2" align="left">
									<EM id="em_remark" style="display:block"><A
										href="javascript:get_edit('remark')"  style="text-decoration:underline;color:blue"><fmt:message key="modify"  bundle="${applicationResources}"></fmt:message></A> </EM>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>

		<div>
			<ul class="TabBarLevel1" id="TabPage1">
				<li id="Tab1" class="Selected">
					<a href="#" onclick="javascript:switchTab('TabPage1','Tab1');"><fmt:message key="metadata.column"></fmt:message></a>
				</li>
				<li id="Tab2">
					<a href="#" onclick="javascript:switchTab('TabPage1','Tab2');"><fmt:message key="metadata.key"></fmt:message></a>
				</li>
				<!--li id="Tab3"><a href="#" onclick="javascript:switchTab('TabPage1','Tab3');">约束</a></li>   
	  <li id="Tab4"><a href="#" onclick="javascript:switchTab('TabPage1','Tab4');">索引</a></li-->
			</ul>
			<div id="cnt">
				<div id="dTab1" class="HackBox" style="display:block">
					<table class="table_div_control">
						<tr>
							<td>
								<fmt:message key="metadata.columnlist_nbsp"></fmt:message>
							</td>
							<td>
								<table align="right">
									<tr>
										<td class="button_ellipse" id="td_toAdd_onClick"
											onClick="javascript:addNewColumn();" title='<fmt:message key="metadata.add_record"></fmt:message>'>
											<img src="<%=request.getContextPath()%>/images/icon/add.gif"
												class="div_control_image">
											<fmt:message key="add"  bundle="${applicationResources}"></fmt:message>
										</td>
										<td class="button_ellipse" id="td_deleteMulti_onClick"
											onClick="javascript:deleteColumns();" title='<fmt:message key="delete"  bundle="${applicationResources}"></fmt:message>'>
											<img
												src="<%=request.getContextPath()%>/images/icon/delete.gif"
												class="div_control_image">
											<fmt:message key="delete"  bundle="${applicationResources}"></fmt:message>
										</td>
										<td class="button_ellipse" id="td_refresh_onClick"
											onClick="javascript:refreshColumns();" title='<fmt:message key="refresh"  bundle="${applicationResources}"></fmt:message>'>
											<img
												src="<%=request.getContextPath()%>/images/icon/refresh.gif"
												class="div_control_image">
											<fmt:message key="refresh"  bundle="${applicationResources}"></fmt:message>
										</td>
										<!--td class="button_ellipse" id="td_toAdd_onClick" onClick="javascript:toAdd_onClick();" title="跳转到新增页面"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image">高级新增</td>
							<td class="button_ellipse" id="td_findCheckbox_onClick" onClick="javascript:findCheckbox_onClick();" title="跳转到修改所选的某条记录"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image">高级修改</td-->
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<table class="table_div_content2">
						<tr>
							<td>
								<TABLE class="editlistCss" cellSpacing=1 cellPadding=1
									width="100%" border=0 id="controlList">
									<TR vAlign=top>
										<TH class="listCss" width="5%"></TH>
										<TH class="listCss" width="5%"><fmt:message key="sequence"  bundle="${applicationResources}"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.name_zh"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.columnname"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="type"  bundle="${applicationResources}"></fmt:message></TH>
										<TH class="listCss" width="60"><fmt:message key="metadata.length"></fmt:message></TH>
										<TH class="listCss" width="60"><fmt:message key="metadata.decimaldigits"></fmt:message></TH>
										<TH class="listCss" width="60"><fmt:message key="metadata.defaultvalue"></fmt:message></TH>
										<TH class="listCss" width="60"><fmt:message key="metadata.whether_null"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.columncategory"></fmt:message></TH>
										<TH class="listCss"><fmt:message key="remark"  bundle="${applicationResources}"></fmt:message></TH>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<tr>
							<td>
								<input name="column_submit" class="button_ellipse" type="button"
									value='<fmt:message key="submit"  bundle="${applicationResources}"></fmt:message>' onClickTo="javascript:submit_column()">
								<input name="column_reset" class="button_ellipse" type="button"
									value='<fmt:message key="common.undo"></fmt:message>' onClick="javascript:reset_column()">
							</td>
						</tr>
					</TABLE>
				</div>
				<div id="dTab2" class="HackBox">
					<table class="table_div_control">
						<tr>
							<td>
								<fmt:message key="metadata.keylist_nbsp"></fmt:message>
							</td>
							<td>
								<table align="right">
									<tr>
										<td class="button_ellipse" id="td_toAdd_onClick"
											onClick="javascript:addNewKeyRow();" title='<fmt:message key="add"  bundle="${applicationResources}"></fmt:message>'>
											<img src="<%=request.getContextPath()%>/images/icon/add.gif"
												class="div_control_image">
											<fmt:message key="add"  bundle="${applicationResources}"></fmt:message>
										</td>
										<td class="button_ellipse" id="td_deleteMulti_onClick"
											onClick="javascript:deleteKeyRow();" title='<fmt:message key="delete"  bundle="${applicationResources}"></fmt:message>'>
											<img
												src="<%=request.getContextPath()%>/images/icon/delete.gif"
												class="div_control_image">
											<fmt:message key="delete"  bundle="${applicationResources}"></fmt:message>
										</td>
										<td class="button_ellipse" id="td_refresh_onClick"
											onClick="javascript:refreshKeyTable();" title='<fmt:message key="refresh"  bundle="${applicationResources}"></fmt:message>'>
											<img
												src="<%=request.getContextPath()%>/images/icon/refresh.gif"
												class="div_control_image">
											<fmt:message key="refresh"  bundle="${applicationResources}"></fmt:message>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<table class="table_div_content2">
						<tr>
							<td>
								<TABLE class="editlistCss" cellSpacing=1 cellPadding=1
									width="100%" border=0 id="keyList">
									<TR vAlign=top>
										<TH class="listCss" width="5%"></TH>
										<TH class="listCss" width="5%"><fmt:message key="sequence"  bundle="${applicationResources}"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.matchcolumn"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.key_name"></fmt:message></TH>
										<TH class="listCss" width="100"><fmt:message key="metadata.key_type"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.ref_table"></fmt:message></TH>
										<TH class="listCss" width="120"><fmt:message key="metadata.ref_column"></fmt:message></TH>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<tr>
							<td>
								<input name="key_submit" class="button_ellipse" type="button"
									value='<fmt:message key="submit"  bundle="${applicationResources}"></fmt:message>' onClickTo="javascript:submit_key()">
								<input name="key_reset" class="button_ellipse" type="button"
									value='<fmt:message key="common.undo"></fmt:message>' onClick="javascript:reset_key()">
							</td>
						</tr>
					</TABLE>
				</div>
			</div>
		</div>

	</form>
<script>
	reset_column();
	reset_key();
	jQuery(".table_div_content2 td").bind("dblclick",doDblClick);
</script>	
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>

</body>
</fmt:bundle>
</html>
