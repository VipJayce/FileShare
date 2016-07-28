<html><body>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<head>
<%
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
%>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css" rel="stylesheet" charset='UTF-8'>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/MasterDetailTemplateAjax.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/controldata/view.js"></script>
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
<title><fmt:message key="common.list_template"></fmt:message></title>
<script>
	<%
		String userCode=request.getParameter("client");
		String multiTenant = request.getParameter("multiTenant");
		String detailView = request.getParameter("detailView");
		String tableView = request.getParameter("tableView");
		String queryView = request.getParameter("queryView");
		String toolView = request.getParameter("toolView");
		String moduleName = request.getParameter("moduleName");
		if(multiTenant!=null && multiTenant.equals("true"))
		{
			detailView=userCode+detailView;
			tableView=userCode+tableView;
			queryView=userCode+queryView;
			toolView=userCode+toolView;
			moduleName=userCode+moduleName;
		}
		request.setAttribute("detailView",detailView);
		request.setAttribute("tableView",tableView);
		request.setAttribute("queryView",queryView);
		request.setAttribute("toolView",toolView);			
		request.setAttribute("moduleName",moduleName);			
	%>
	var detailView ='<%=request.getAttribute("detailView")%>';
	var tableView ='<%=request.getAttribute("tableView")%>';
	var queryView ='<%=request.getAttribute("queryView")%>';
	var toolView ='<%=request.getAttribute("toolView")%>';
	var moduleName ='<%=request.getAttribute("moduleName")%>';
	//定义翻页行为
	PageVoJs.prototype.action = getActionMap;
	//创建翻页对象
	var pageVo  = new PageVoJs();
	//设置默认排序方式
	pageVo.setOrderStr("");
	
	var actionType = "default";
	function getActionMap(){
		if(actionType == "default"){
			query_data(tableView,"");
		}else{
			getQueryCondition();
		}
	}
	
	function queryAll(){
		pageVo.initAction();
	}
	
	function query_onClick(){
		actionType = "query";
		pageVo.initAction();
	}
	
	function reset_onClick(){
		jQuery("#ccChild0").clearForm();
	}
	
	function getQueryCondition(){
		MasterDetailTemplateAjax.getViewVo($("query_code").value,function(data){
		var fields=null;
		if(null!=data) fields = data.fields;
		    var condition ="";
			if(null!=fields&&fields.length>0){
				for( var i=0;i<fields.length;i++){
					var fieldVo = fields[i];
					
					//不考虑未启用的字段
					if (fieldVo.status=="0"){
						continue;
					}
					//不考虑不显示的字段
					if (fieldVo.display=="0"){
						continue;
					}					
					if (fieldVo.columnName!=""&&null!=$(fieldVo.name)) {//非虚拟字段
						var value;
						if(fieldVo.displayType==9)
						{
							value = getRadioValue(document.getElementsByName(fieldVo.name));
						}
						else
						{
							value = $name(fieldVo.name).value;
						}
						if(value!=null && trim(value)!=""&&trim(value)!='null' && fieldVo.displayType != 12 && fieldVo.displayType != 13) {
							condition += " and "+fieldVo.columnName+" like '%"+value+"%' ";
						}
						if(fieldVo.displayType == 12 || fieldVo.displayType == 13){
								var value1 = document.getElementById("id" + fieldVo.id + "_1").value;
								var value2 = document.getElementById("id" + fieldVo.id + "_2").value;
								if(value1 != "" && value2 != ""){
									condition += " and " + fieldVo.columnName + " >= '" + value1 +"'";
									condition += " and " + fieldVo.columnName + " <= '" + value2 +"'";
								}else if(value1 != ""){
									condition += " and " + fieldVo.columnName + " < '" + value1 +"'";
								}else if(value2 != ""){
									condition += " and " + fieldVo.columnName + " > '" + value2 +"'";
								}
							}
					}
				}
				query_data(tableView,condition);
				}
		});
	}
	
	function trim (str)
	{
	    return str.replace(/(^\s*)|(\s*$)/g, '');
	}
	
	function query_data(code,condition){
	   var isCheckable = false;
	   if(document.getElementById("isCheckable") != null && document.getElementById("isCheckable").value == 1){isCheckable=true;}
		MasterDetailTemplateAjax.query(code,condition,isCheckable,pageVo.getOrderSortStr(),pageVo,function(data){getMapResult(data,code)});
	}
	
	
	function toModify_onClick() { 
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="common.select_one_data"></fmt:message>')
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="common.only_select_one_data"></fmt:message>')
	  		return;
		}
		form.action="<%=request.getContextPath()%>/MasterDetailTemplateAction.do?cmd=find4Update&id=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}
	function toDelete_onClick(){  
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="common.message_select_data"></fmt:message>')
			return;
		}
		if(confirm('<fmt:message key="whether_to_delete_the_data_completely"  bundle="${applicationResources}"></fmt:message>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/MasterDetailTemplateAction.do?cmd=delete&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	    	form.submit();
		}
	}
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				ids.push(elementCheckbox[i].value);  //加入选中的checkbox
			}
		}
		return ids;
	}
	function toAdd_onClick() {  //到增加记录页面
		//window.location="<venus:base/>/jsp/dd/template/masterdetail/edit.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView;
		form.action="<%=request.getContextPath()%>/MasterDetailTemplateAction.do?cmd=find4Insert&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}
	function toRefresh_onClick(){  //刷新本页
		query_onClick();
	}



</script>
</head>
<body onload="queryAll();">
<script language="javascript">
	writeTableTop(moduleName,'<venus:base/>/');
</script>

<form name="form" method="post" action="">
	<input type="hidden" name="query_code" value='<%=request.getAttribute("queryView").toString()%>' />
	<input type="hidden" name="table_code" value='<%=request.getAttribute("tableView").toString()%>' />
	<input type="hidden" name="sessionId" value="<%=request.getSession().getId()%>">
<!-- 查询开始 -->
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key="common.query_by_condition"></fmt:message>
		</td>
		<td>
		<table align="right">
		<input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:query_onClick();">
		<input type="button" name="Reset" class="button_ellipse" value='<fmt:message key="clear"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:reset_onClick();">
		</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
	<dd:queryView code='<%=request.getAttribute("queryView").toString()%>'/>
</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="common.detail_table"></fmt:message>
		</td>
		<td><dd:toolBarView code='<%=request.getAttribute("toolView").toString()%>'/></td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<dd:tableView code='<%=request.getAttribute("tableView").toString()%>' pageable='true' checkable='true' hasData='false' checkType='checkbox'/>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</fmt:bundle>
</body>
</html>
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>