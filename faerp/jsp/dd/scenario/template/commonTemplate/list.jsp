<!--@@lt@?xml version="1.0" encoding="UTF-8"?>
@lt@xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://www.use.com.cn" xmlns:fn="http://www.w3.org/2005/04/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	@lt@!--导入全局定义--@gt@
	@lt@xsl:import href="../@templateName@.xsl"/>
	@lt@!--忽略xml声明--@gt@
	@lt@xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8"/>
	@lt@!--处理table--@gt@
	@lt@xsl:template match="/"> 
@-->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@page import="gap.dd.controldata.util.ControlDataHelper"%>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<!-- <fmt:bundle basename="yourresource" prefix="yourprefix"> -->
<%
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
%>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrddscenario/interface/CommonTemplateService.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<title><fmt:message key="gap.dd.common.list_template"  bundle="${dd}"></fmt:message></title>
<script>
	<%
		String userCode=request.getParameter("client");
		String multiTenant = request.getParameter("multiTenant");
		String detailView = request.getParameter("detailView");
		String tableView = request.getParameter("tableView");
		String queryView = request.getParameter("queryView");
		String toolView = request.getParameter("toolView");
		String moduleName = request.getParameter("moduleName");
		String tableName = ControlDataHelper.getView(queryView).findTableName();
		if(multiTenant!=null && multiTenant.equals("true"))
		{
			detailView=userCode+detailView;
			tableView=userCode+tableView;
			queryView=userCode+queryView;
			toolView=userCode+toolView;
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
	
	function queryAll(){
		pageVo.initAction();
	}
	
	function query_onClick(){
		actionType = "query";
		pageVo.initAction();
	}
	
	var actionType = "default";
	function getActionMap(){
		if(actionType == "default"){
			//Add your default condtion at here.
			query_data('<%=tableView%>',{});
		}else{
			query_data('<%=tableView%>',getConditions(queryView,"<%=tableName%>"));
		}
	}
	
	function reset_onClick(){
		jQuery("#ccChild0").clearForm();
	}
	
	function query_data(code,conditions){
	   var isCheckable = false;
	   if(document.getElementById("isCheckable") != null && document.getElementById("isCheckable").value == 1){isCheckable=true;}
	   var dispStyleValue = "0";
	   var checkType = "checkbox";
	   checkType = jQuery("#checkType").val();
	   if(jQuery("#dispStyle").val()){
			dispStyleValue = jQuery("#dispStyle").val();
		}
		CommonTemplateService.query(code,conditions,isCheckable,checkType,dispStyleValue ,pageVo.getOrderSortStr(),pageVo,function(data){getMapResult(data,code)});
	}

	function toModify_onClick() { 
		var ids = findSelections4Modify(false);
		if(ids == -1)return;
		form.action="<%=request.getContextPath()%>/CommonTemplateAction.do?cmd=find4update&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}
	
	function toDelete_onClick(){
		var ids = findSelections4Delete();
		if(ids == -1)return;
 		form.action="<%=request.getContextPath()%>/CommonTemplateAction.do?cmd=delete&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	    form.submit();
	}

	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/dd/scenario/template/commonTemplate/edit.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	}
	function toRefresh_onClick(){  //刷新本页
		query_onClick();
	}

	function toZoom_onClick(){  //查看数据
		var ids = findSelections4Zoom(false);
		if(ids == -1)return;
    	form.action="<%=request.getContextPath()%>/CommonTemplateAction.do?cmd=find4zoom&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
    	form.submit();
	}
	
</script>
</head>
<body onload="queryAll();">
<script language="javascript">
	writeTableTop(moduleName,'<venus:base/>/');
</script>

<form name="form" method="post" action="">
<!-- 查询开始 -->
<div id="ccParent0" class="table_div_control" style="Padding:5px;"> 
		<div style="float:left">
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key="gap.dd.common.query_by_condition"  bundle="${dd}"></fmt:message>
		</div>
		<div style="float:right"> 
			<input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:query_onClick();">
			<input type="button" name="Reset" class="button_ellipse" value='<fmt:message key="clear"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:reset_onClick();">
		</div>
</div>

<div id="ccChild0"> 
	<dd:queryView code='<%=request.getAttribute("queryView").toString()%>'/>
</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key="gap.dd.common.detail_table"  bundle="${dd}"></fmt:message>
		</td>
		<td><dd:toolBarView code='<%=request.getAttribute("toolView").toString()%>'/></td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<dd:tableView code='<%=request.getAttribute("tableView").toString()%>' pageable='true' checkable='true' dispStyle='0' checkType='checkbox' hasData='false'/>
</div>
<div id='dialogPanel'>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
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
<!--@
@lt@/xsl:template>
@lt@/xsl:stylesheet>
@-->