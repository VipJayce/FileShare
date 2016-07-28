<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/gap-dd.tld" prefix="dd"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ include file="/jsp/dd/include/common.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<title><fmt:message key="reference_page"  bundle="${applicationResources}"></fmt:message></title>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<link rel="stylesheet" href="<venus:base/>/css/gcm/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<venus:base/>/js/dd/jquery.ztree-2.6.beta.js"></script>

<script>
var args = dialogArguments;
var param=args[0];
var cond=args[1];
var viewCode =param.viewCode ;
var	fieldId=param.fieldId;
var type=param.type;
var multiSelect=param.multiSelect;

var curId;
	
var curTreeNode;
	
webPath='<%=request.getContextPath()%>';	
jQuery.noConflict();

var zTree;
var setting = {
    showLine: true,
    checkable: multiSelect=='1',
    editable : false,
	expandSpeed: "",	    
	keepParent:false,    
    edit_renameBtn:false,
    edit_removeBtn:false,
	nameCol : "name",	    
	isSimpleData : true,	    
    treeNodeKey : "id",
    treeNodeParentKey:"parentId",
    callback : {
		beforeAsync: beforeAsync,	
		dblclick: zTreeOnDblClick,
		expand: zTreeOnExpand
    }};
    
	function zTreeOnExpand(event, treeId, treeNode) {
		treeNode.expandStatus=true;
		zTree.reAsyncChildNodes(treeNode,"refresh");
	}
	
	function beforeAsync(treeId, treeNode) {
		return false;
	}

	function zTreeOnDblClick(event, treeId, treeNode) {
		//curTreeNode=treeNode;
		if(param.multiSelect=='1')
			return;
		confirm_onClick();
	}
		
	function setAsyncUrl(treeNode) {
		if(treeNode==undefined)
			curId="";
		else	
			curId=treeNode.id;
		tmpUrl = "<%=request.getContextPath()%>/ControlDataAction.do?cmd=getAssistTreeData&viewCode="+viewCode+"&fieldId="+fieldId+"&type="+type+"&curNode="+curId+"&condition="+cond;
		return tmpUrl;
	}
	
	function refreshTree() {
		setting.async=true;
		setting.asyncUrl = setAsyncUrl;
		zTree = jQuery("#tree").zTree(setting, zNodes);
	}
	
    zNodes=[];
    	
	jQuery(document).ready(function(){
		refreshTree();
	});	
	
	function confirm_onClick(){
		if(param.multiSelect=='1')
		{
  			window.returnValue = zTree.getCheckedNodes();
  		}
  		else
  		{
  			window.returnValue = zTree.getSelectedNode();
  		}
  		//show(window.returnValue,2);
		if(window.returnValue==null || window.returnValue.length==0)
		{
  			alert('请选择树节点！');
  			return;
  		}
		if(window.returnValue.isLeaf!='1')
		{
			alert('只能选择叶子节点！');
			return;
		}
		window.close();		
  	}
	
  	function cancel_onClick(){
  		window.close();	
  	}	
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="reference_page"  bundle="${applicationResources}"></fmt:message>','<venus:base/>/');
</script>

<form name="form" method="post"><input type="hidden" name="id"
	value="">
	<div id='search'></div>
	<table class="table_noframe">
		<tr>
			<td valign="middle">
				<input name="button_confirm" type="button"
				class="button_ellipse" value='<fmt:message key="confirm"  bundle="${applicationResources}"></fmt:message>'
				onClick="javascript:confirm_onClick();">
				<input name="button_cancel" type="button" class="button_ellipse" value='<fmt:message key="cancel"  bundle="${applicationResources}"></fmt:message>'
				onClick="javascript:cancel_onClick();">
			</td>
		</tr>
	</table>
	<ul id='tree' class='tree'></ul>
</form>
<script language="javascript">
  //1st parameter is id of DIV element to initialize tree from.
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
