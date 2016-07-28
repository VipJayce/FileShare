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
	<script type="text/javascript" src="../../../js/dd/codegen/codegen.js"></script>
	<script type="text/javascript" src="../../../js/dd/controldata/enumerate.js"></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwrdd/interface/CodegenService.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/common/gap-waiting.js'></script>
	<link rel="stylesheet" type="text/css" href="../../../js/ext/resources/css/ext-all.css"/>
</head>
<body >
<script language="javascript">
	writeTableTop('','<venus:base/>/');
<%
    response.setHeader("Pragma","no-cache");    
    response.setHeader("Cache-Control","no-cache");    
    response.setDateHeader("Expires",   0);    
%>
</script>
</body>
<dd:refControl type="8"  refSourceClass="gap.dd.codegen.service.ModuleDataSource" printLabel="false" keySource="0"   dispValue="hehe"  label="复杂参照"   name='module' id='module' />
<dd:refControl type="8"  refSourceClass="gap.dd.codegen.service.ModuleDataSource" printLabel="false" keySource="0"   dispValue="hehe"  label="复杂参照"   name='WFListModule' id='WFListModule' />
<dd:refControl type="8"  refSourceClass="gap.dd.codegen.service.ModuleDataSource" printLabel="false" keySource="0"   dispValue="hehe"  label="复杂参照"   name='WFHistoryListModule' id='WFHistoryListModule' />
<select id="idtemplateType" name="templateType">
<option value="CommonTemplate">标准普通模板</option>
<option value="MDTemplate">标准主子模板</option>
<option value="JMATemplate">加贸主子模板A</option>
<option value="JMBTemplate">加贸主子模板B</option>
</select>
</html>