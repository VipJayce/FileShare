<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>


<%@page pageEncoding="UTF-8"%>

<html>

	<head>
		<title>Title</title>
	</head>

	<body>

		<script>

function getParam()

{
	return "<queryOrg><orgid>0</orgid></queryOrg>"
}

</script>

		<r:rtree id="tree1">

			<r:treeRoot
				action="server_tree.jsp"
				childEntities="f1;f2" display="公司"   initParamFunc="getParam"/>

			<r:treeNode nodeType="f1" submitXpath="queryOrg" showField="name"
				childEntities="out1;out2"
				action="server_tree_s.jsp" preload="true">

		</r:treeNode>			
					<r:treeNode nodeType="out1" submitXpath="queryOrg" showField="name" preload="true">	
					
					</r:treeNode>	
					
					<r:treeNode nodeType="out2" submitXpath="queryOrg" showField="name" >					
					</r:treeNode>	
			<r:treeNode nodeType="f2" submitXpath="queryOrg" showField="name"
				childEntities="out1;out2"
				action="server_tree_s.jsp" />

		</r:rtree>

	</body>

</html>

