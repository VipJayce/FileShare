<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<title>动态树例子</title>
<script src="<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwrsample/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwrsample/util.js" type="text/javascript"></script> 
<STYLE TYPE="text/css" MEDIA=screen>
ul.rootNode{
	CURSOR: default; MARGIN-LEFT: 5px; MARGIN-RIGHT: 5px; MARGIN-TOP: 5px;padding-top:0px; padding-left:0px;
}
ul.baseNode{
	MARGIN-LEFT: 15px; MARGIN-RIGHT: 0px; MARGIN-TOP: 0px;MARGIN-BOTTOM: 0px;padding-top:0px; padding-left:0px;
}
LI {
	MARGIN-LEFT: 15px;LIST-STYLE: none; MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px; VERTICAL-ALIGN: middle
}
</STYLE>
<script>
var webModel=null;
	function eh(msg) { 
		alert("错误信息："+msg); 
		var div_msg=document.getElementById("msg");
  		div_msg.innerHTML=msg;
	} 
	function initTree(node,divid){
		//获取当前的发布目录
		obj=document.getElementById("webModel");
		webModel=obj.value;
		DWREngine.setErrorHandler(eh); 
		AjaxControl.initTree(node,divid,populateRootDiv);
	}
	
	function populateRootDiv(data){
	   var divTree=document.getElementById(data.divid);
	   divTree.innerHTML=data.treevalue;
	}
	
	

	function populateDiv(data){   
		var divTree=document.getElementById(data.divid);
		if(data.treevalue!=""){
			divTree.innerHTML="<ul class='baseNode'>"+data.treevalue+"</ul>";
		}else{
			divTree.innerHTML=data.treevalue;
		}
	//	divTree.inneHTML=data.treevalue;
	} 

	function onExtend(node,imgid){
		var divTree=document.getElementById(node);
		if(jQuery(divTree).attr("open")=='false'&& jQuery(divTree).attr("data")=='true') {
			extendImages(jQuery(divTree).attr("type"),imgid);
			jQuery(divTree).show();
			jQuery(divTree).attr("open","true");
			return;
		}
		if(jQuery(divTree).attr("open")=='false'&& jQuery(divTree).attr("data")=='false'){
			DWREngine.setErrorHandler(eh); 
			AjaxControl.extendTree(node,node,populateDiv);
			extendImages(jQuery(divTree).attr("type"),imgid);
			jQuery(divTree).attr("open","true");
			jQuery(divTree).attr("data","true");
			if(jQuery(divTree).attr("type")=='base'){divTree.style.display="block";}
			return;
		}
		if(jQuery(divTree).attr("open")=='true'&& jQuery(divTree).attr("data")=='true'){
			callbackImages(jQuery(divTree).attr("type"),imgid);
			jQuery(divTree).hide();
			jQuery(divTree).attr("open","false");
			return;
		}
	}
	//节点展开
	function extendImages(type,imgid){
		if(type=='base'){
			var img=document.getElementById(imgid);
			img.src=webModel+"/images/tree/folderopen.gif";
		}
	}
	//节点回收
	function callbackImages(type,imgid){
		if(type=='base'){
			var img=document.getElementById(imgid);
			img.src=webModel+"/images/tree/folder.gif";
		}
	}
</script>

</head>
<body onload="javascript:initTree('root','tree');">
<script language="javascript">
	writeTableTop('动态树页面','<venus:base/>/');
</script>

<form name="form" method="post">
<input id="webModel" name="webModel" type="hidden" class="text_field" inputName="发布目录" value="<%=request.getContextPath()%>" readonly="true">
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">动态树
		</td>
	</tr>
</table>
</div>
<div id="ccChild1"> 
<table class="table_div_content">
<tr>
<td>

<div id="msg">
</div>
<div id="tree">
</div>
</td>
</tr>
</table>
</div>
	
	</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
