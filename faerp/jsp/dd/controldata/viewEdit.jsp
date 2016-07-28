<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<venus:base/>/css/tabbar/tabbar.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<venus:base/>/css/tabbar/tabbar.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/controldata.js"></script>
<script type='text/javascript' src="<venus:base/>/js/dd/change.js"></script>
<script type='text/javascript' src='<venus:base/>/dwrdd/interface/ControlDataService.js'></script>
</head>
<body onload="init()">
<script language="javascript">
	writeTableTop('<fmt:message key="common.edit_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<script language="javascript">
	var params = dialogArguments;
	var view = params[0];
	var changeObj1;
	var changeObj2;
	function init()
	{
		changeObj1=new changeObject("dTab2","changeObj1");
		changeObj1.setLeftTitle('<fmt:message key="controldata.available_table"/>');
		changeObj1.setRightTitle('<fmt:message key="controldata.selected_table"/>');
		changeObj1.setMultiSelect(true);
		changeObj2=new changeObject("dTab3","changeObj2");
		changeObj2.seperator=".";
		changeObj2.fullName=true;
		changeObj2.setLeftTitle("<select id='leftTitleSelect' onchange='onTableChange(this)'></select>");
		changeObj2.setRightTitle('<fmt:message key="controldata.selected_column"/>');
		changeObj2.setMultiSelect(true);
		ControlDataService.getTables(fillTable);
		if(params[1]=='update')
		{
			jQuery("#code").val(view.code);
			jQuery("#name").val(view.name);
			jQuery("#type").val(view.viewType);
			jQuery("#condition").val(view.conditionstr);
			jQuery("#businessClass").val(view.businessClass);
			jQuery("#pageSize").val(view.pageSize);
			jQuery("#extParam").val(view.extParam);
			changeObj1.setRightData(view.tables,'tableName','tableId');
			//alert(dwr.util.toDescriptiveString(view.fields,3));
			changeObj2.setRightData(view.fields,'name','id');
		}		
	}
	
	function fillTable(data){
		//alert(dwr.util.toDescriptiveString(data,3));
		changeObj1.setLeftData(data,'tableName','id');			
	}
	
	function blockTabs(selectElement){
		return;
		var tab2 = "<a href='#' onclick='javascript:switchTab('TabPage1','Tab2');'><fmt:message key='controldata.table'/></a>";
		var tab3 = "<a href='#' onclick='javascript:switchTab('TabPage1','Tab3');'><fmt:message key='controldata.column'/></a>";
		element2 = document.getElementById("Tab2");
		element3 = document.getElementById("Tab3");
		if(4 == selectElement.value){
			element2.childNodes(0).style.display="none";
			element3.childNodes(0).style.display="none";
		}else{
			if(element2.childNodes(0).style.display != "none")return;
			element2.childNodes(0).style.display="block";
			element3.childNodes(0).style.display="block";
		}
	}
	

</script>
<form name="form" method="post" >	
	<div id="controlPanel" style="padding:5px">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:save_onClick();">
		<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:cancel_onClick();">
	</div>
	<div id="tabPanel">   
		  <ul  class="TabBarLevel1" id="TabPage1">   
			  <li id="Tab1" class="Selected"><a href="#" onclick="javascript:switchTab('TabPage1','Tab1');"><fmt:message key='common.base_info'/></a></li>   
			  <li id="Tab2"><a href="#" onclick="javascript:switchTab('TabPage1','Tab2');"><fmt:message key='controldata.table'/></a></li>   
			  <li id="Tab3"><a href="#" onclick="javascript:switchTab('TabPage1','Tab3');"><fmt:message key='controldata.column'/></a></li>   
		  </ul>   
		  <div id="cnt">   
			  <div id="dTab1" class="HackBox" style="display:block">
				  	<div id="ccParent1"> 
						<table class="table_div_control">
							<tr> 
								<td>
									<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key="edit"  bundle="${applicationResources}"></fmt:message>
								</td>
							</tr>
						</table>
					</div>
					<div id="ccChild1"> 
						<table class="table_div_content">
							<tr>
								<td align="right" ><fmt:message key="common.code"/></td>
								<td align="left" width="360px">
									<input id="code" name="code" type="text" class="text_field" inputName='<fmt:message key="common.code"/>'   validate="notNull;isSearch" value="">			
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="name"  bundle="${applicationResources}"></fmt:message></td>
								<td align="left">
									<input id="name" name="name" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>'   validate="notNull;isSearch" value="">			
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="controldata.view_viewtype"/></td>
								<td align="left">
									<select id="type" name="type" onchange="blockTabs(this);">
										<option value="1"><fmt:message key="controldata.list_view"/></option>
										<option value="2"><fmt:message key="controldata.edit_view"/></option>
										<option value="3"><fmt:message key="controldata.query_view"/></option>
										<option value="4"><fmt:message key="controldata.toolbar_view"/></option>
									</select>
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="controldata.view_condition"/></td>
								<td colspan="3" align="left">
									<textarea id="condition" class="textarea_limit_words" cols="36" rows="5" name="condition" inputName='<fmt:message key="controldata.view_condition"/>' maxLength="512" ></textarea>
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="controldata.view_businessclass"/></td>
								<td align="left">
									<input id="businessClass" name="businessClass" type="text" class="text_field" inputName='<fmt:message key="controldata.view_businessclass"/>'   validate="" value="">			
								</td>
							</tr>
							<tr>
								<td align="right"><fmt:message key="controldata.view_pagesize"/></td>
								<td align="left">
									<input id="pageSize" name="pageSize" type="text" class="text_field" inputName='<fmt:message key="controldata.view_pagesize"/>'   validate="isNum,notNull" value="0" maxLength='3'>			
								</td>
							</tr>
						<tr>
                    <td align="right" ><fmt:message key="controldata.field_extparam"/></td>
                    <td align="left" >
                        <input id="extParam" name="extParam" type="text" class="text_field" inputName='<fmt:message key="controldata.field_extparam"/>'   validate="" value="">         
                    </td>
                </tr>
							
						</table>
					</div>
			  </div> 
		  	  <div id="dTab2" class="HackBox">
		      </div>   
			  <div id="dTab3" class="HackBox">
			  </div>   
		  </div>   
	</div>  
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
<script>
	function save_onClick(){
		if(checkForm(form)==true)
		{
			var viewData= getView();
			if(params[1]=='update')
				viewData.id=view.id;
			viewData.name = jQuery("#name").val();
			viewData.code = jQuery("#code").val();
			viewData.viewType = jQuery("#type").val();
			viewData.conditionstr = jQuery("#condition").val();
			viewData.businessClass = jQuery("#businessClass").val();
			viewData.pageSize = jQuery("#pageSize").val();
			viewData.extParam = jQuery("#extParam").val();
			var tableData = changeObj1.getRightData(getTable,'tableId');
			if(viewData.viewType=='1')
				var fieldData= changeObj2.getRightData(getFieldForTableView,'id','name');
			else	
				var fieldData= changeObj2.getRightData(getField,'id','name');
//			alert(dwr.util.toDescriptiveString(fieldData,3));
			if(params[1]=="insert")
			{
				ControlDataService.insertView(viewData,tableData,fieldData,function(data){
					window.returnValue = data;
					window.close();
				});
			}
			else
			{
				ControlDataService.updateView(viewData,tableData,fieldData,function(){
					window.returnValue = viewData;
					window.close();
				});
			}
		}
	}
	function cancel_onClick()
	{
		window.returnValue=null;
		window.close();
	}
	
	function onTabChange(tabId)
	{
		if(tabId=="Tab3")
		{	
			rightSelect = changeObj1.getRightSelect();
			leftTitle=document.getElementById("leftTitleSelect");
			leftTitle.options.length=0;
			for(var i=0;i<rightSelect.options.length;i++)
			{
				var no = new Option();
				no.value = rightSelect.options[i].value;
				no.text = rightSelect.options[i].text;
				leftTitle.options[leftTitle.options.length]=no;
			}
			onTableChange(leftTitle);
			
		}
	}
	
	function onTableChange(select)
	{
		ControlDataService.getColumns(select.value,fillColumn);
	}
	
	function fillColumn(data)
	{
		changeObj2.setLeftData(data,'columnName','id');
	}
	
	function rightToLeft(obj)
	{	
		if(obj==changeObj1)
		{
			rightSelect1 = changeObj1.getRightSelect();
			rightSelect2 = changeObj2.getRightSelect();
			//判断右侧是否有选中的表名称，如果没有则不进行处理
			if(rightSelect2.length == 0)return;
			tableName=rightSelect1.options[rightSelect1.selectedIndex].text;
			for(var i=0;i<rightSelect2.options.length;i++)
			{
				if(rightSelect2.options[i].text.indexOf(tableName)>=0)
				{
					alert(i18n_dd.relate_column);
					return false;
				}				
			}
		}
		return true;
	}
	if(params[1]=='update'){
		jQuery("#type").attr("disabled",true);
	}
</script>
</fmt:bundle>
</html>