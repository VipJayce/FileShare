<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd" %>
<%@ include file="/jsp/dd/include/common.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="../../../js/ext/adapter/ext/ext-base.js"></script>
    <script type="text/javascript" src="../../../js/ext/js/ext-all.js"></script>
    <script type="text/javascript" src="../../../js/ext/js/ext-lang-zh.js"></script>
    <script type="text/javascript" src="../../../js/ext/js/dwrproxy.js"></script>
	<script type="text/javascript" src="../../../js/dd/codegen/codegenMgr.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/ModuleManageService.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/ControlDataService.js'></script>	
	<script type="text/javascript" src="../../../js/dd/controldata/enumerate.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/CodegenService.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<link rel="stylesheet" type="text/css" href="../../../js/ext/resources/css/ext-all.css"/>
	
</head>
<body >
<script language="javascript">
<%
    response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);    
%>
</script>
</body>
</html>