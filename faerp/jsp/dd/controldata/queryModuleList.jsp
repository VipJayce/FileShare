<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/ext.jsp" %>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<%@ include file="/jsp/dd/include/jquery-ui.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<venus:base/>/js/dd/controldata/controldata.js"></script>	
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/ModuleManageService.js'></script>
	<script type='text/javascript' src="<venus:base/>/js/dd/change.js"></script>
	<script type="text/javascript" src="<venus:base/>/js/dd/controldata/queryModuleList.js"></script>
	<style>
		.column {width: 380px;height:280px;float: left;padding-bottom: 100px;margin:2px;background-color:#F1F5FA}
		.widget{background-color: #ffe;border:#665555 solid 1px;cursor: move;margin: 0 0 2px;width: 198px;}
		.widget-header {background-color: #94cbec;position:relative;border:#665555 solid 1px;margin: 1px;padding-bottom: 4px;padding-left: 0.2em;}
		.widget-content { padding: 0.4em; }
		.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important;}
		.ui-sortable-placeholder * { visibility: hidden; }
		.widget-zoomlink {position:absolute;right:14px}	
		.widget-closelink {position:absolute;right:1px}	
		.rightPanel {width:400px;background-color:#d9e8fb;float:left}	
		.leftPanel {width:160px;background-color:#d9e8fb;float:left}	
			
	</style>
</head>
<body >
<script language="javascript">
	writeTableTop('<fmt:message key="controldata.page_field_edit"/>','<venus:base/>/');
</script>
<%
    response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);    
%>
<form>
	<!--下面是查询区域-->
	<div id='queryRegion'>
		<!--div id="ccParent0" class="table_div_control" style="Padding:5px;">
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="common.query_by_condition"/>
		</div-->
		<div id="ccChild0" class="table_div_content" style="Padding:5px;">	
			<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>
			<input id="query_moduleName" name="query_moduleName" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>' validate="isSearch">
			<input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>' onclick="javascript:query_onClick();">
		</div>
	</div>
	<div id="center">	
	</div>
</form>		
</body>
</fmt:bundle>
</html>