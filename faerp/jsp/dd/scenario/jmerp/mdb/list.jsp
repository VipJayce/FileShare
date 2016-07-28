<!--@@lt@?xml version="1.0" encoding="UTF-8"?>
@lt@xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://www.use.com.cn" xmlns:fn="http://www.w3.org/2005/04/xpath-functions" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	@lt@!--导入全局定义--@gt@
	@lt@xsl:import href="../JMmdbTemplate.xsl"/>
	@lt@!--忽略xml声明--@gt@
	@lt@xsl:output method="text" omit-xml-declaration="yes" encoding="UTF-8"/>
	@lt@!--处理table--@gt@
	@lt@xsl:template match="/">
@-->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="venus.pub.util.VoHelper" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@page import="gap.dd.scenario.jmerp.mdb.util.IConstants"%>
<!-- <fmt:bundle basename="yourresource" prefix="yoourprefix"> -->
<%
	String condition = (String) request.getAttribute("condition");
	if(condition==null) {
		condition = "";
	}
%>
<link href="<venus:base/>/css/dd/gap-edittable-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrddscenario/interface/JmmdbService.js'></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-page.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/controldata/controldata.js"></script>
<script>
	var detailView ='<%=request.getParameter("detailView")%>';
	var tableView ='<%=request.getParameter("tableView")%>';
	var queryView ='<%=request.getParameter("queryView")%>';
	var toolView ='<%=request.getParameter("toolView")%>';
	var moduleName ='<%=request.getParameter("moduleName")%>';
	
	PageVoJs.prototype.action = getActionMap;
	var pageVo  = new PageVoJs();
	pageVo.setOrderStr("");
	//pageVo.setPageSize(15);
	
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
			query_data('<%=request.getParameter("tableView")%>',{});
		}else{
			query_data('<%=request.getParameter("tableView")%>',getConditions(queryView,"<%=IConstants.MTABLE_TABLENAME%>"));
		}
	}
	
	function reset_onClick(){
		clearForm("ccChild0");
	}
	
	function query_data(code,conditions){
	   var isCheckable = false;
	   if(document.getElementById("isCheckable") != null && document.getElementById("isCheckable").value == 1){isCheckable=true;}
	   var dispStyleValue = "0";
	   if(jQuery("#dispStyle").val()){
			dispStyleValue = jQuery("#dispStyle").val();
		}
		JmmdbService.query(code,conditions,isCheckable,dispStyleValue ,pageVo.getOrderSortStr(),pageVo,function(data){getMapResult(data,code)});
	}
	


	function toModify_onClick() { 
		var ids = findSelections4Modify(false);
		if(ids == -1)return;
		form.action="<%=request.getContextPath()%>/JmmdbAction.do?cmd=find4update&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
		form.submit();
	}
	function toDelete_onClick(){  
		var ids = findSelections4Delete();
		if(ids == -1)return;
		//You can use prepareDelete method for logic delete operation.
	    form.action="<%=request.getContextPath()%>/JmmdbAction.do?cmd=delete&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	    form.submit();
	}

	function toAdd_onClick() {
		window.location="<venus:base/>/jsp/dd/scenario/jmerp/mdb/edit.jsp?moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
	}
	function toRefresh_onClick(){
		query_onClick();
	}
	
	function toZoom_onClick(){
		var ids = findSelections4Zoom(false);
		if(ids == -1)return;
    	form.action="<%=request.getContextPath()%>/JmmdbAction.do?cmd=find4zoom&ids=" + ids+"&moduleName="+moduleName+"&detailView="+detailView+"&tableView="+tableView+"&queryView="+queryView+"&toolView="+toolView;
    	form.submit();
	}
</script>
</head>
<body onload="queryAll();">
<script language="javascript">
	writeTableTop(moduleName,'<venus:base/>/');
</script>

<form name="form" method="post" action="">

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
			<fmt:message key="gap.dd.common.query_by_condition"  bundle="${dd}"/>
		</td>
		<td>
		<table align="right">
		<input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"/>' onClick="javascript:query_onClick();">
		<input type="button" name="Reset" class="button_ellipse" value='<fmt:message key="clear"  bundle="${applicationResources}"/>' onClick="javascript:reset_onClick();">
		</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
	<dd:queryView code='<%=request.getParameter("queryView")%>'/>
</div>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">&nbsp;明细表格
		</td>
		<td><dd:toolBarView code='<%=request.getParameter("toolView")%>'/></td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<dd:tableView code='<%=request.getParameter("tableView")%>' pageable='true' checkable='true' dispStyle='0'/>
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
<%
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