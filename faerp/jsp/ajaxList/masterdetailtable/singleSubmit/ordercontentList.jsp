<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import="gap.ajax.util.VoHelperTools" %>
<%@ page import="gap.ajax.util.StringHelperTools" %>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<!--tag页签需要的css和js-->
<link href="<venus:base/>/css/ajax/tabbar/tabbar.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<venus:base/>/css/ajax/tabbar/tabbar.js"></script>
	
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SingleSubmitAjax.js'></script>  
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>  
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script> 
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script> 
	
<script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList.js"></script>
<!--翻页标签需要的js-->
<script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList-page.js"></script>
<!--主子表事务分别提交模块需要的js-->
<script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList-masterdetail-singleSubmit.js"></script>

<script>
/***********************************注册子表的修改页面，默认js方法，不建议修改(begin)***************************/
	var masterId='<%=request.getAttribute("orderNo")%>';//定义主键值
	
	function getMasterId(){
		return document.getElementById("masterId").value;
	}
	
	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;
	//创建翻页对象
	var pageVo  = new PageVoJs();
	function queryAll(){
		pageVo.initAction();
	}
	
	function getActionMap(){
		//loadDelay("<venus:base/>","viewBody");//更新表数据时延时等待图片显示
		query_data(document.getElementById("detailView").value);
	}
	function query_data(detailView){//查询子表数据
		SingleSubmitAjax.queryAllForDetail(detailView,getMasterId(),pageVo,getMapResult);
	}
	function fillTable(data){//更新子表表格内容
		dataTable=document.getElementById("d"+document.getElementById("detailView").value);
		dataTable.innerHTML="";
	    dataTable.innerHTML = data;
	    
        //页面初始化表格的样式
        getTbodyColor();
        
	} 

	 
	function onTabChange(tabId)//点击tab时候触发
	{
		var detailView=tabId;
		document.getElementById("detailView").value=detailView;
		var detailEdit=document.getElementById("detailEdit");
		//勾选掉前一个页签中被选中的记录
		var elementCheckbox = document.getElementsByName("checkbox_template");
			for(var i=0;i<elementCheckbox.length;i++){
				if(elementCheckbox[i].checked) {
					elementCheckbox[i].checked=false;
				}
			}
		detailEdit.innerHTML="";
		queryAll();
	}
	
	function initMasterDetail(detailView){//页面初始化时触发
		includeMasterEdit(getMasterId());
		query_data(detailView);
	}
	
	function includeDetailEdit(handler){//载入子表新增\修改页面
		if(getMasterId()=="null" || getMasterId()==""){
			alert(i18n.please_fill_the_main_table);
			return;
		}
		var div=document.getElementById("detailEdit");
		//div.innerHTML="";
		if(handler=='add'){//载入子表新增页面
			SingleSubmitAjax.getInclude(getPageobj(document.getElementById("detailView").value),function(data) {
												dwr.util.setValue('detailEdit', data, { escapeHtml:false });
											});
		}else{//载入子表修改页面
			var ids = null;
			var elementCheckbox = document.getElementsByName("checkbox_template");
			var number = 0;
			for(var i=0;i<elementCheckbox.length;i++){
				if(elementCheckbox[i].checked) {
					number += 1;
					ids = elementCheckbox[i].value;
				}
			}
			if(number == 0) {
		  		alert(i18n.please_select_a_record);
		  		return ;
			}
			if(number > 1) {
		  		alert(i18n.can_only_select_a_record);
		  		return ;
			}
			SingleSubmitAjax.getInclude(getPageobj(document.getElementById("detailView").value),function(data) {
												dwr.util.setValue('detailEdit', data, { escapeHtml:false });
												SingleSubmitAjax.findDetailForId(document.getElementById("detailView").value,ids,setForms);
											});
		}

	}

	function detailEdit_onClick(){  //子表修改页面点击“保存”按钮时触发
		if(checkFormsForName("childform")==true){
			var detailView=document.getElementById("detailView").value;
			SingleSubmitAjax.editDetail(detailView,getMasterId(),getDestailObj(detailView),function(data){
																									query_data(detailView);
																									var detailEdit=document.getElementById("detailEdit");
																									detailEdit.innerHTML="";});
		}
	}

	function deleteMulti_onClick(){  //选择子表数据进行删除
 		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids += "'" + elementCheckbox[i].value + "',";
			}
		}
		if(ids.length>0) {
			ids = ids.substr(0,ids.length-1);	
		}
		if(number == 0) {
	  		alert(i18n.please_choose_record_to_delete);
	  		return;
		}
		if(confirm(i18n.confirm_to_delete_record)) {
	    	SingleSubmitAjax.deleteDetail(document.getElementById("detailView").value,ids,function(data){
																									query_data(document.getElementById("detailView").value);
																									var detailEdit=document.getElementById("detailEdit");
																									detailEdit.innerHTML="";});
		}
	}

	function checkFormsForName(formName){//校验名称为formName值的form 中的控件
		var checkResult = true;
		
		rmTempStatusIsAlert = false;
		rmTempStatusIsFocus = false;
		
		setAllVenusInputsDefault();
		
		for (var i=0;i<document.forms.length;i++) {
			if(formName!=document.forms[i].name){continue;}
				for (var j=0;j<document.forms[i].elements.length;j++) {
				var thisInput = document.forms[i].elements[j];
				if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
					var rtValue = check(thisInput);
					if(checkResult && rtValue == false) {
						checkResult = false;
					}
				}
			}
		}
		return checkResult;
	}
/***********************************注册子表的修改页面，默认js方法，不建议修改(end)***************************/
	
/***********************************注册子表的修改页面，用户自定义js (begin)***************************/
	function includeMasterEdit(masterId){//载入主表信息页面
		var div=document.getElementById("masterEdit");
		div.innerHTML="";
		var pageobj="/jsp/ajaxList/masterdetailtable/singleSubmit/ordersEdit.jsp";
		AjaxControl.getInclude(pageobj,function(data) {
											dwr.util.setValue('masterEdit', data, { escapeHtml:false });
											AjaxControl.getEnumList("OrderType",function(data){setSelect(data,"type");AjaxControl.findOrder(masterId,setForms);});
										});
	}
	 
	function ordersInsert_onClick() {  //增加主表记录
		if(checkFormsForName("masterform")==true){
			var addValueMap={
			orderNo:"",
			type:"",
			totalamount:"",
			beginDate:"",
			count:"",
			buyer:"",
			vendor:"",
			description:""
			};
			if(document.childform.masterId.value=="null" || document.childform.masterId.value==""){
				AjaxControl.insertOrders(getForms(addValueMap),function(data){document.childform.masterId.value=data;alert(i18n4ajaxList.add_the_main_table_records_success);})
			}else{
				AjaxControl.updateOrders(getForms(addValueMap),function(data){alert(i18n4ajaxList.modify_the_main_table_records_success);})
			}
		}
		
	}
	 
	function getProductList(){//表Product的参照 
	   var event = window.event?window.event:getProductList.caller.arguments[0];
		var obj = window.showModalDialog('<venus:base/>/jsp/ajaxList/singletable/reference.jsp?flag=product','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:500px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
		if(obj) {
			document.childform.productId.value = obj[0];
			document.childform.productName.value = obj[1];
		}
	}
	 
	function goBack(){
		window.location.href='<venus:base/>/SingleSubmitAction.do?cmd=queryAllOrders';
	}
	 
/***********************************注册子表的修改页面，用户自定义js (end)***************************/

</script>

</head>
<body onload=initMasterDetail('ordercontent')>
<script language="javascript">
	writeTableTop('主子表列表','<venus:base/>/');
</script>

<form name="masterform" method="post" action="<venus:base/>/SingleSubmitAction.do">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="detailView" id="detailView" value="ordercontent">
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('masterEdit',this,'<venus:base/>/')"><fmt:message key="masterdetailtable.main_table_information"/>
		</td>
	</tr>
</table>
</div>
<div id="masterEdit">

</div>
</form>
<form name="childform" method="post" action="<venus:base/>/SingleSubmitAction.do">
	<input name="masterId" id="masterId" type="hidden" class="text_field" value=<%=request.getAttribute("orderNo")%>>
<div id="ccParent2"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('detailEdit',this,'<venus:base/>/')"><fmt:message key="masterdetailtable.sub_table_information"/>
		</td>
	</tr>
</table>
</div>
<div id="detailEdit">
	
</div>
</form>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message  key="table.detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:includeDetailEdit('add');"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="add"/></td>
					<td class="button_ellipse" onClick="javascript:includeDetailEdit('edit');"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="modify"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message bundle='${applicationResources}'  key="delete"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
<form name="form" method="post" action="<venus:base/>/SingleSubmitAction.do">
<div id="ccChild1"> 
				<div id='tabPanel'> 
					<ul  class='TabBarLevel1' id='TabPage1'>
					<li id='ordercontent' class='Selected'><a href='#' onclick=javascript:switchTab('TabPage1','ordercontent');><fmt:message key="masterdetailtable.singlesubmit.order_details_table"/></a></li>   
					<li id='orderadvice' ><a href='#' onclick=javascript:switchTab('TabPage1','orderadvice');><fmt:message key="masterdetailtable.singlesubmit.order_feedback"/></a></li>   
					</ul> 
					<div id='cnt'>
						<div id='dordercontent' class='HackBox' style='display:block'>
						
						</div>
						<div id='dorderadvice' class='HackBox'>
							
						</div>
					</div>
				</div>
				<jsp:include page="/jsp/ajaxList/common/ajaxpage.jsp" />
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>