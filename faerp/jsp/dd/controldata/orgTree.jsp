<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ page import="venus.pub.util.VoHelper"%>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<title><fmt:message key="reference_page"  bundle="${applicationResources}"></fmt:message></title>
<link rel="STYLESHEET" type="text/css"
	href="<venus:base/>/js/dhtmlxTree/dhtmlxtree.css">
<script src="<%=request.getContextPath()%>/dwr/interface/TreeControl.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js"
	type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/dd/basedata/basedata.js"></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/dd/gap-ajaxList-tree.js"></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/dhtmlxTree/ext/dhtmlxtree_start.js"></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/dhtmlxTree/dhtmlxcommon.js"></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/dhtmlxTree/dhtmlxtree.js"></script>

<script>
var args = dialogArguments;

var myTree;

function setData(){
	var str = args[0];
	var divobj = document.getElementById("treeboxbox_tree");
	divobj.innerHTML=str;
	
	myTree = dhtmlXTreeFromHTML('treeboxbox_tree');
    //myTree=new dhtmlXTreeObject("treeboxbox_tree","100%","100%",0);
    myTree.setImagePath("<venus:base/>/js/dhtmlxTree/imgs/csh_gaptree/");
    //myTree.loadXML("tree.xml");
    //myTree.enableCheckBoxes(1);
	//myTree.setOnClickHandler(tonclick);
	myTree.setOnDblClickHandler(tonclick);
	myTree.setOnCheckHandler(tonclick);//
	myTree.enableThreeStateCheckboxes(true);//级联选中下级节点
	/*
	//check item
	myTree.setCheck(id,true);
	//uncheck item
	myTree.setCheck(id,false); 
	//check branch
	myTree.setSubChecked(id,true);
	//uncheck branch
	myTree.setSubChecked(id,false); 
	//check item
	myTree.setCheck(id,true);
	//return ids of checked items
	var list=myTree.getAllChecked();//取得所有选中的，不包括父
	var list=myTree.getAllCheckedBranches() //取得所有选中的父。父的父。。。。
	var list= myTree.getAllPartiallyChecked() //取得所有选中的，包括父，父的父。。。
	*/
}
</script>

</head>
<body onload="javascript:setData();">
<script language="javascript">
	writeTableTop('<fmt:message key="reference_page"  bundle="${applicationResources}"></fmt:message>','<venus:base/>/');
</script>

<form name="form" method="post"><input type="hidden" name="id"
	value="">
<div id="treeboxbox_tree"
	setImagePath="<venus:base/>/js/dhtmlxTree/imgs/csh_gaptree/"
	xclass="dhtmlxTree"
	style="width: 250px; height: 218px; background-color: #f5f5f5; border: 1px solid Silver;">
</div>
</form>
<script language="javascript">
	function tonclick(id){
		//alert(dwr.util.toDescriptiveString(myTree.getItemToArray(id),4))
		window.returnValue = myTree.getItemToArray(id);
		window.close();
	};
  //1st parameter is id of DIV element to initialize tree from.
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
<%
    //表单回写
    if (request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelper.writeBackMapToForm((java.util.Map) request
			.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
    }
%>