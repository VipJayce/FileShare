<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<%@ include file="/jsp/dd/include/ext.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="../../../js/dd/controldata/moduleList.js"></script>
	<script type="text/javascript" src="../../../js/dd/controldata/enumerate.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/ModuleManageService.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
</head>
<body >
<script language="javascript">
	writeTableTop('<fmt:message key="controldata.modulepage_title"/>','<venus:base/>/');
<%
    response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);    
%>
</script>
<form>
	<!--下面是查询区域-->
	<div id='queryRegion'>
		<div id="ccChild0" class="table_div_content" style="Padding:5px;">	
			<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>
			<input id="query_moduleName" name="query_moduleName" type="text" class="text_field" inputName='<fmt:message key="name"  bundle="${applicationResources}"></fmt:message>' validate="isSearch">
			<fmt:message key="controldata.module_templatetype"/>
			<select id="query_templateType" name="query_templateType" >
				<option value=""><fmt:message key="common.select"/></option>
				<option value="001"><fmt:message key="controldata.common_template"/></option>
				<option value="002"><fmt:message key="controldata.md_template"/></option>
			</select>
	
			<input type="button" name="Submit" class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>' onclick="javascript:query_onClick();">
		</div>
	</div>
	<div id="center1">	
	</div>
</form>		
</body>
</fmt:bundle>
</html>