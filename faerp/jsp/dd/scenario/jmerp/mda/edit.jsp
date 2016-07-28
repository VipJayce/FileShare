<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="venus.frames.i18n.util.LocaleHolder"%>
<%@page import="gap.dd.scenario.jmerp.mda.util.IConstants"%>
<!-- <fmt:bundle basename="yourresource" prefix="yoourprefix"> -->
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrddscenario/interface/JmmdaService.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<%@ include file="/jsp/dd/include/common.jsp" %>	
<%
	boolean isModify = false;
	if(request.getParameter("isModify") != null) {
		isModify = true;
	}
	boolean isZoom = false;
	if(request.getAttribute("isZoom") != null) {
		isZoom = true;
	}
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
	String primary = (String) request.getAttribute("primary");
	if(primary==null) {
		primary = "";
	}
	String primary_value = (String) request.getAttribute("primary_value");
	if(primary_value==null) {
		primary_value = "";
	}
	
	String subCondition = " and TYPEID = '" + primary_value + "'";
	//注：多子表情况需要定义第二个subCondition2
	//String subCondition2 = " and foreignkey = '" + primary_value + "'";
	String ds = (String) request.getAttribute("dispStyle");
	int dispStyle=0;
	if(ds!=null) {
		dispStyle =new Integer(ds).intValue();
	}	
%>
<script>
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var toolView ='<%=request.getParameter("toolView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';

	function insert_onClick(){
		updateAjax();
  	}
  	function update_onClick(){
  		updateAjax();
  	}
  	
	function updateAjax(){
		if(checkAllForms()){
			//点击页面保存按钮触发事件
			JmmdaService.update(
				//主表数据
				getMasterDataFromPageWithCode("<%=IConstants.MTABLE_EDITVIEW_CODE%>","<%=IConstants.MTABLE_TABLENAME%>",<%=isModify%>),
				//子表数据
				getSubDataFromPage("<%=IConstants.STABLE_LISTVIEW_CODE%>","<%=IConstants.STABLE_NAME%>",<%=isModify%>),
				//回调函数
				function(data){
					alert(data);
					if(i18n_dd.success == data)gotoListPage();
				}
			);
		}
  	}
  	
  	 function gotoListPage(){
  		window.location="<venus:base/>/jsp/dd/scenario/jmerp/mda/list.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
  	}
  	
  	//eg.getTemplateRef(this,'moduleName=模板功能&tableView=custom_list&detailView=custom_edit&queryView=custom_query&toolView=custom_tool');
  	function getTemplateRef(element,paramsStr){
 		var refPath = "/web/jsp/dd/template/common/reflist.jsp?"+encodeURI(paramsStr);
		var data = window.showModalDialog(refPath, new Object(),'dialogHeight=660px;dialogWidth=810px;resizable:no;status:no;scroll:auto;');
		var objs = getSelectedData();
		getTemplateRefCallBack(objs);
  	}
  	
  	//实现参照回写逻辑
  	function getTemplateRefCallBack(objs){
		show(objs,3);
  	}
  	
  	//点击页面增行按钮触发事件
	function add_onClick(viewCode){
			var dataMap;
			//获得列表对象
			var $tableBody = jQuery("#"+viewCode+" tbody[id=viewBody]");
			//增行
			JmmdaService.getTableRow(
				//视图Code
				viewCode,
				//行数
				$tableBody.children().size()+1,
				//是否有checkbox
				true,
				//回调函数
				function(data){
					addRowToTable(data,dataMap,viewCode)
				}
			);
		}
		
				//点击页面删行按钮触发事件
		function delete_onClick(viewCode){
			//获得列表对象并删行
			jQuery("#"+viewCode).find('[name=checkbox_template]:checkbox:[checked=true]').parent().parent().remove();
			refreshTableSeq(viewCode);
		}
		//实现增行回写
		function addRowToTable(data,dataMap,viewCode){
			//获得列表对象并增行
			var appendDom = jQuery(data.tableRow);
			//根据数据和HTML结构进行组装
			//var idEle = appendDom.find("[name='checkbox_template']");
			//添加带数据的HTML到页面
			jQuery("#"+viewCode+" tbody[id=viewBody]").append(appendDom);
			initTableColor(jQuery("table[viewtype=tableView] table"));
		}

</script>

</head>
<body onload='initTableColor(jQuery("table[viewtype=tableView] table"))'">
<script language="javascript">
	writeTableTop('Title','<venus:base/>/');
</script>

<form name="form"  enctype="multipart/form-data"method="post">
<input type="hidden" name="primary" value="<%=primary%>">
<input type="hidden" name="primary_value" value="<%=primary_value%>">
<input type="hidden" name="id" value='<%=primary_value%>'>
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<%
				if(isZoom == false){
			%>
				<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
			<%
				}
			%>
			<input name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"/>'  onClick="javascript:gotoListPage()">
		</td>
	</tr>
</table>

<!-- 主表编辑标题 -->
<div id="ccParent1"> 
<table class="table_div_control">
	<tbody><tr> 
		<td>
			<img onclick="javascript:hideshow('ccParent2',this,'<venus:base/>/')" class="div_control_image" src="<venus:base/>/images/icon/07-0.gif">Title2
		</td>
	</tr>
</tbody></table>
</div>
<!-- 主表编辑部分 -->
<div id="ccParent2">
<dd:editView code='<%=request.getParameter("detailView")%>' condition="<%=condition%>" dispStyle="<%=dispStyle%>"/>
<input type="hidden" name="code" value='<%=request.getParameter("detailView")%>' />
</div>
<!-- 注：多子表情况需要定义第二个tableView和toolBarView -->
<!-- 子表编辑标题 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">Title3
		</td>
		<td>
		<dd:toolBarView code='<%=IConstants.STABLE_TOOLVIEW_CODE%>'/>
		</td>
	</tr>
</table>
</div>

<table class="table_div_content">
<tr><td>
<div id="ccChild1" style="WIDTH: 1230; HEIGHT: 140;OVERFLOW: scroll">
<dd:tableView code='<%=IConstants.STABLE_LISTVIEW_CODE%>' pageable='false' checkable='true' dispStyle='<%=dispStyle%>' condition='<%=subCondition%>'/></div>
</td></tr>
</table>
</form>

<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
<%  
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>
