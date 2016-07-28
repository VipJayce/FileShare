<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import = "gap.ajax.util.ReferenceFilter"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import="gap.ajax.function.core.AjaxControl" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<%
	AjaxControl ajaxControl = new AjaxControl();
	List list = ajaxControl.getProductsList(1,15);
	request.setAttribute("wy", list);
%>
<html>
<link href="<venus:base/>/css/ajax/gap-edittable-css.jsp" type="text/css" rel="stylesheet" charset='UTF-8'>

  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
  <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList-editTable4htc.js"></script>
<script language="javascript">
function getFactoryList() {
    var event = window.event?window.event:getFactoryList.caller.arguments[0];
	var obj = window.showModalDialog('<venus:base/>/jsp/ajaxList/singletable/reference.jsp?flag=factory','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
	if(obj) {
		document.form.factoryName.value = obj[1];
		document.form.factoryid.value = obj[0];
	}
}

function getFactoryList2(compentObj) {
    var event = window.event?window.event:getFactoryList2.caller.arguments[0];
	var obj = window.showModalDialog('<venus:base/>/jsp/ajaxList/singletable/reference.jsp?flag=factory','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
	if(obj) {
		//马啸更改
		if(compentObj.length==12){
		var name = document.getElementsByName("factoryName"+compentObj.charAt(compentObj.length-1));
		var id = document.getElementsByName("factoryid"+compentObj.charAt(compentObj.length-1));
		name[0].value = obj[1];
		id[0].value = obj[0];
		}else{
		var name = document.getElementsByName("factoryName"+compentObj.substring(compentObj.length-2));
		var id = document.getElementsByName("factoryid"+compentObj.substring(compentObj.length-2));
		name[0].value = obj[1];
		id[0].value = obj[0];
		}
	}
}

function displayProduct(selectObject){
	include('/jsp/ajaxList/product.jsp','forward');
	AjaxControl.findProductById(selectObject,function(data) {
	     if (data != null && typeof data == 'object') {
		     	//alert(dwr.util.toDescriptiveString(data, 2));
		     	setForms(data);
	     } 
	  });
}

/**
 * 功能描述：将表中的行数据填充表单
 * 参数：	thisid --行数据的键值id;
 */    
function rowDataToForm(thisId){
	AjaxControl.findProductById(thisId,setForms);
}

function setRefrenceId(refrenceShow,refrenceParentElement){
	if(refrenceShow.className=="text_field_reference"){
		var inputElements = document.getElementsByTagName("input");
		for(i=0;i<inputElements.length;i++){
			if(refrenceShow.name == inputElements[i].name){
				if(refrenceShow.parentElement==inputElements[i+1].parentElement){
					inputElements[(i+1)].value = refrenceParentElement.childNodes[1].value;
				}
			}
		}
	}
}

function initElements(selectId){
    if(jQuery("select[name='"+selectId+"'] option").size()==0){
	        var enumData = AjaxControl.getEnumList("ProductType",function(data){
	        setSelect(data,selectId)
	    });
    }
}

/**
 * 功能描述：动态编辑表格时创造下拉列表
 * 参数描述：
 */
function createSelect(){
    var selectId = "productType";
	var selectElement = document.createElement("SELECT");
	selectElement.setAttribute("id",selectId);
	//设置为同步执行
	DWREngine.setAsync(false);
	AjaxControl.getEnumList("ProductType",function(data){
		//setSelect(data,selectId)
        var sel = jQuery(selectElement).val();
         jQuery(selectElement).empty();
        for(var i=0; i<data.length; i++){
           if(data[i].value==sel){
               jQuery(selectElement).append("<option selected='true'  value='"+data[i].value+"'>"+data[i].label+"</option>");
           }else{
               jQuery(selectElement).append("<option value='"+data[i].value+"'>"+data[i].label+"</option>");
           }
        }
	});
	//再设置成异步执行
    DWREngine.setAsync(true);
	
	return selectElement;
}

/**
 * 功能描述：生成参照数组，供动态编辑时创建参照对象使用
 * 参数描述：
 */ 
function getRefrenceObj(){
	 var refrenceObj = [
		'<input name="factoryName" type="text" class="text_field_reference" validate="notNull" inputName="工厂名称" readOnly="true">',
		'<img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getFactoryList3(this);" class="img_1">',
		'<input type="hidden" signName="factoryid" value=""/>'
	 ];
	 return refrenceObj;
 }
 
/**
 * 功能描述：综合模式动态编辑时获取参照
 * 参数描述：
 */ 
function getFactoryList3(imageObj) {
    var event = window.event?window.event:getFactoryList3.caller.arguments[0];
	var obj = window.showModalDialog('<venus:base/>/jsp/ajaxList/singletable/reference.jsp?flag=factory','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
	setRefrenceTd(obj, imageObj)
}
 

/**
 * 功能描述：构造list类型的参数对象
 * 参数描述：
 */    
function buildProducts(){
	var checkboxall = document.getElementsByName("checkbox_template");
    var checkbox = new Array();
	var num = 0;
	for(var i=0;i<checkboxall.length;i++){
		if(checkboxall[i].checked==false){
			continue;
		}
		else{
			checkbox[num]=i+1;//记录被选中的行记录号
			num++;
		}
	}
	var data = new Array();//对象集合
	for(var i=0;i<checkbox.length;i++){
		var product= {
			productid:"",
			categoryid:"",
			name:"",
			price:0,
			beginDate:"",
			endDate:"",
			factoryid:"",
			factoryName:""
		} ;
		product.productid = "";
		product.categoryid = jQuery("select[name='categoryid"+checkbox[i]+"']").val();
		product.name = jQuery("input[name='name"+checkbox[i]+"']").val();
		product.price = jQuery("input[name='price"+checkbox[i]+"']").val();
		product.beginDate = jQuery("input[name='beginDate"+checkbox[i]+"']").val();
		product.endDate = jQuery("input[name='endDate"+checkbox[i]+"']").val();
		product.factoryid = jQuery("input[name='factoryid"+checkbox[i]+"']").val();
		product.factoryName = jQuery("input[name='factoryName"+checkbox[i]+"']").val();
		data[i]=product;
	}
	return data;
}

/**
 * 功能描述：增加产品数据
 * 参数描述：
 */    
function save_onClick(tableId){  
		var products=buildProducts();
		AjaxControl.insertProducts(products);  //批量添加
		var cellObjects = getCellObjects();
		insertRow(tableId,cellObjects,10); 
		//页面初始化表格的样式
		getTbodyColor();
		jQuery(".listCss").trigger("click");
}  	

/**
 * 功能描述：构造list类型的参数对象
 * 参数描述：
 */    
function buildModifyProducts(){
	var productproperties = ["productid","categoryid","name","price","beginDate","endDate","factoryid","factoryName"];
	var checkboxall = document.getElementsByName("checkbox_template");
    var checkbox = new Array();
	var num = 0;
	var data = new Array();//对象集合
	for(var i=0;i<checkboxall.length;i++){
		if(checkboxall[i].checked==false){
			continue;
		}
		var trObj = checkboxall[i].parentNode.parentNode;
		var product= {
			productid:"",
			categoryid:"",
			name:"",
			price:0,
			beginDate:"",
			endDate:"",
			factoryid:"",
			factoryName:""
		} ;
		product.productid = jQuery(trObj).find("input[signName="+productproperties[0]+"]").val();//getObjectByNameRecursive(trObj,productproperties[0]).value;
		product.categoryid = jQuery(trObj).find("input[signName="+productproperties[1]+"]").val();//getObjectByNameRecursive(trObj,productproperties[1]).value;
		product.name = jQuery.trim(jQuery(trObj.cells[3]).text());
		product.price = jQuery.trim(jQuery(trObj.cells[4]).text());
		if(jQuery.trim(jQuery(trObj.cells[6]).text())==""){product.beginDate="1900-01-01" }else{product.beginDate = jQuery.trim(jQuery(trObj.cells[6]).text());}
		if(jQuery.trim(jQuery(trObj.cells[7]).text())==""){product.beginDate="1900-01-01" }else{product.endDate = jQuery.trim(jQuery(trObj.cells[7]).text());}
		product.factoryid =jQuery(trObj).find("input[signName="+productproperties[6]+"]").val();//getObjectByNameRecursive(trObj,productproperties[6]).value;
		product.factoryName = jQuery.trim(jQuery(trObj.cells[2]).text());
		data[num] = product;
		num++;
	}
	return data;
}

/**
 * 功能描述：批量添加产品数据
 * 参数描述：
 */    
function add_onClick(tableId){ 
	var cellObjects = getCellObjects();
	insertRow(tableId,cellObjects,10); 
	changeButton();
	//页面初始化表格的样式
	getTbodyColor();
	jQuery(".listCss").trigger("click");
}  	

/**
 * 功能描述：批量删除产品数据
 * 参数描述：
 */    
function delete_onClick(){  
	var ids=buildDeleteIds("checkbox_template","productid"); //批量删除
	if(ids.length == 0) {
  		alert(i18n.please_choose_record_to_delete)
  		return;
	}
	if(confirm(i18n.confirm_to_delete_node)) {
		AjaxControl.deleteProducts(ids,function(data){if(data==true){ deleteRows("checkbox_template",0);}else{alert(i18n4ajaxList.delete_failure);}});
	}
}  	
	
/**
 * 功能描述：批量修改产品数据
 * 参数描述：
 */    
function modify_onClick(){  
	var products=buildModifyProducts(); //批量修改
	AjaxControl.updateProducts(products,function(data){alert(data)});
	//resetCheckbox("checkbox_template");
}  	

/**
 * 功能描述：改变按钮显示及功能
 * 参数：	;
 */    
function changeButton(){
	//jQuery("#td_addButton").hide();
	//jQuery("#td_saveButton").show();
	
	jQuery("#menu_table td:first").hide();
	jQuery("#menu_table td:eq(1)").show();
}

function getCellObjects(){
	var cellObjects = [
	'<input type="checkbox" name="checkbox_template" value="1099100400000000002"/>',
	'1',
	'<input  name="factoryName" type="text" class="text_field_reference" validate="notNull"  validate="isSearch" readOnly="true" rubber_id="factoryid"><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getFactoryList2(this.previousSibling.name);" class="img_1"><input type="hidden" name="factoryid" id="rubber_id" value="">',
	'<input name="name" type="text" class="text_field"  validate="notNull" value="">',
	'<input name="price" type="text" class="text_field"  validate="notNull;isNumeric" value="">',
	'<select  name="categoryid" onmouseover="initElements(this.name);"></select>',
	'<input name="beginDate"  type="text" class="text_field_reference"  validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDayExpand(this.previousSibling,\'<%=request.getContextPath()%>/\')" class="img_1">',
	'<input name="endDate" type="text" class="text_field_reference"  validate="notNull" readonly="true" value=""><img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:getYearMonthDayExpand(this.previousSibling,\'<%=request.getContextPath()%>/\')" class="img_1">'
	];
	return cellObjects;
}

//日期参照扩展
function getYearMonthDayExpand(textDate,path){
    var event = window.event?window.event:getYearMonthDayExpand.caller.arguments[0];
    var returnAry;
    if(path == undefined) {
        path = "../../";
    }
    var returnAry = window.showModalDialog(path + "js/calendar/calendar.jsp",i18n.date_reference,"status:1;dialogHeight:230px;dialogWidth:300px;dialogTop: "+event.screenY+"px; dialogLeft: "+event.screenX+"px");

    if (typeof(returnAry) == "undefined") {
       textDate.value = "";
    } else if (returnAry != null) {
        textDate.value = returnAry;
        //textDate.focus();
        //textDate.fireEvent("onchange");
    }
}

/**
 * 功能描述：生成参照数组，供动态编辑时创建日期参照对象使用
 * 参数描述：
 */ 
function getDateObj(){
	 var dateObj = [
		'<input id="residing_Date" name="residing_Date" type="text"  class="text_field_reference" readonly="true" value="">',
		'<img src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:referenceYearMonthDay('+"residing_Date"+',<%=request.getContextPath()%>/,this)" class="img_1">'
	 ];
	 return dateObj;
 }
</script>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="singletable.IndependentMode.single_table"/>','<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/TemplateAction.do">
<input type="hidden" name="cmd" value="">
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
			<fmt:message  key="table.detail_table"/>
		</td>
		<td>
			<table align="right" id="menu_table">
				<thead id="menu_thead">
				<tr> 
					<td id='td_addButton' style='display:block' class="button_ellipse" onClick="javascript:add_onClick('dataTable');"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td id='td_saveButton' style='display:none' class="button_ellipse" onClick="javascript:save_onClick('dataTable');"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="save"/></td>
					<td class="button_ellipse" onClick="javascript:modify_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
					<td class="button_ellipse" onClick="javascript:delete_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:document.location.reload();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="refresh"/></td>
  				</tr>
  				</thead>
			</table>
		</td>
	</tr>
</table>
</div>
			<div id="divc">
				<!--this is the autocomplete container.-->
			</div>
<div id="forward"></div>
			<div id="divf">
			</div>
<div id="ccChild1"> 
<table id="dataTable" class="table_div_content"  width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tbody id="peoplebody" >
    <tr id="pattern" >
		<td >
		<layout:collection name="wy" id="wy1" styleClass="editlistCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="5%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;" styleClass="listCss">
				<bean:define id="wy3" name="wy1" property="productid"/>
				<input type="hidden" signName="productid" value="<%=wy3%>"/>
				<input type="checkbox" name="checkbox_template" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="5%"  title='<%=LocaleHolder.getMessage("sequence")%>' style="text-align:center;" styleClass="editlistCss">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem width="20%" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.factory_name")%>' property="factoryid" styleClass="editRefrenceCss">
				<bean:define id="wy6" name="wy1" property="factoryid"/>
					<%=ReferenceFilter.get(String.valueOf(wy6))%>
					<input type="hidden" signName="factoryid" value="<%=wy6%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.ordercontent.product_name")%>' property="name"/>
			<layout:collectionItem width="5%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.product_price")%>' property="price"/>
			<layout:collectionItem width="10%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.product_type")%>' property="categoryid" styleClass="editSelectCss"> 
				<bean:define id="wy2" name="wy1" property="categoryid"/>
					<%=ReferenceFilter.get("ProductType",String.valueOf(wy2))%>
				<input type="hidden" signName="categoryid" value="<%=wy2%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.production_date")%>' property="beginDate" styleClass="editDateCss">
			<bean:define id="wy7" name="wy1" property="beginDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
			<layout:collectionItem width="15%" title='<%=LocaleHolder.getMessage("gap.ajax.newtable.shelf_life_date")%>' property="endDate"  styleClass="editDateCss">
			<bean:define id="wy7" name="wy1" property="endDate"/>
					<%
						java.text.SimpleDateFormat  format = new java.text.SimpleDateFormat("yyyy-MM-dd");
						out.print(format.format(format.parse(String.valueOf(wy7))));
					%>
			</layout:collectionItem>
		</layout:collection>
		
		</td>
	</tr>
	</tbody>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>