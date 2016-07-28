<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/ext.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="<venus:base/>/js/dd/controldata/enumerate.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/ModuleManageService.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/ControlDataService.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/DataTransService.js'></script>
	<script type="text/javascript" src="<venus:base/>/js/dd/controldata/viewList.js"></script>
</head>
<body >
<script language="javascript">
	var i=0;
<%
    response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);    
%>
</script>
<form id="form" name="form" method="post" action="<venus:base/>/ControlDataAction.do">
	<!--下面是查询区域-->
	<div id='queryRegion'>
		<div id="ccChild0" class="table_div_content" style="Padding:5px;">	
			<fmt:message key="common.code"/>
			<input id="query_viewCode" name="query_viewCode" type="text" class="text_field" inputName='<fmt:message key="common.code"/>' validate="isSearch" style="width: 120px">
			<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>
			<input id="query_viewName" name="query_viewName" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>' validate="isSearch" style="width: 120px">
			<fmt:message key="controldata.viewtype"/>
			<select id="query_viewType" name="query_viewType" style="width: 120px">
				<option value=""><fmt:message key="common.select"/></option>
				<option value="1"><fmt:message key="controldata.list_view"/></option>
				<option value="2"><fmt:message key="controldata.edit_view"/></option>
				<option value="3"><fmt:message key="controldata.query_view"/></option>
				<option value="4"><fmt:message key="controldata.toolbar_view"/></option>
			</select>
			<input id="clear_btn" type="button" name="Submit" class="button_ellipse" value='<fmt:message key="clear"  bundle="${applicationResources}"></fmt:message>'>
		</div>
	</div>
</form>		
</body>
</fmt:bundle>
</html>