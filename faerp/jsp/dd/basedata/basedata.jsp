<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.dd.dd_resource" prefix="gap.dd.">
<script src="<%=request.getContextPath()%>/dwr/interface/TreeControl.js" type="text/javascript"></script>
<%@ include file="/jsp/dd/include/dwr.jsp" %>
<%@ include file="/jsp/dd/include/jquery.jsp" %>
<script type="text/javascript" src="<venus:base/>/js/dd/common.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/js/dd/basedata/basedata.js"></script>
 <script language="javascript" src="<venus:base/>/js/dd/gap-ajaxList-tree.js"></script>
 <STYLE TYPE="text/css" >
.tree_node_onfocus{
  TEXT-DECORATION: none;
  background-color: highlight;
  color:white;
}
ul.rootNode{
	CURSOR: default; MARGIN-LEFT: 5px; MARGIN-RIGHT: 5px; MARGIN-TOP: 5px;padding-top:0px; padding-left:0px;
}
ul.baseNode{
	MARGIN-LEFT: 0px; MARGIN-RIGHT: 0px; MARGIN-TOP: 0px;MARGIN-BOTTOM: 0px;padding-top:0px; padding-left:0px;
}
LI {
	MARGIN-LEFT: 15px;LIST-STYLE: none; MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px; VERTICAL-ALIGN: middle
}
</STYLE>

<script>
	jQuery.noConflict();
	/*
	 *校验名称为formName值的form 中的控件
	 *form控件
	 */
	function checkFormsForName(formName){
		var checkResult = true;
		rmTempStatusIsAlert = false;
		rmTempStatusIsFocus = false;
		setAllVenusInputsDefault();
		for (var i=0;i<document.forms.length;i++) {
			if(formName!=document.forms[i].formName.value){continue;}
				for (var j=0;j<document.forms[i].elements.length;j++) {
				var thisInput = document.forms[i].elements[j];
				if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
					
					var rtValue = check(thisInput);
					if(checkResult && rtValue == false) {
						checkResult = false;
					}
				}
			}
		}
		return checkResult;
	}
	//用户调用的beanID
	var beanId="baseDataService";
	//保存当前节点的数据
	var curData;
	//当前编辑状态
	var editFlag="modify";
	/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－----------------------------------------
	-----------------------------下面是业务信息相关的方法（由二次开发人员实现）----------------------
	---------------------------------------------------------------------------------------------*/
	//保存修改后的节点信息
	function updateNode(){
		var nodeid=document.getElementById("id").value;
		var divid=document.getElementById("divid").value;
		var nodeName = form_treeNode.name.value;
		var nodeName_En=form_treeNode.name_en.value;
		if(checkFormsForName("form_treeNode")==true){
				DWREngine.setErrorHandler(eh); 
				var code=form_treeNode.code.value;
				var status=getRadioValue(form_treeNode.status);
				var isLeaf=form_treeNode.isLeaf.value;
				var description=form_treeNode.description.value;
				var typeId=form_treeNode.typeId.value;
				var typeCode=form_treeNode.typeCode.value;
				var isbnCode=form_treeNode.isbnCode.value;
				var hintCode=form_treeNode.hintCode.value;
				var seqNo=form_treeNode.seqNo.value;
				var startDate=form_treeNode.startDate.value;
				var endDate=form_treeNode.endDate.value;
				var parentId=document.getElementById("parentId").value;
				
				var map={"id":nodeid,"divid":divid,"code":code,"name":nodeName,"name_en":nodeName_En,
				"description":description,"typeId":typeId,"typeCode":typeCode,"isbnCode":isbnCode,"hintCode":hintCode,"seqNo":seqNo,"status":status,"isLeaf":isLeaf,"startDate":startDate,
				"endDate":endDate,"parentId":parentId};
				TreeControl.updateNode(map,beanId,function(data){
				populateSpan(data);
				curData=data;
				alert('<fmt:message key="operation_successful_update_records"  bundle="${applicationResources}"><fmt:param  value="1"/></fmt:message>');
				jQuery("[name=updateNodes]:first").attr("disabled",true);
			});
		}
	}
	//删除选中的节点
	function deleteNode(){
			var nodeid=document.getElementById("id").value;
			var divid=document.getElementById("divid").value;
			var parentId=document.getElementById("parentId").value;
			var typeId=document.getElementById("typeId").value;
			var typeCode=document.getElementById("typeCode").value;
			var treeCode=document.getElementById("treeCode").value;
			var nodeName=form_treeNode.name.value;
			DWREngine.setErrorHandler(eh); 
			var map={"id":nodeid,"divid":divid,"parentId":parentId,"treeCode":treeCode,"typeId":typeId,"typeCode":typeCode};//属性值id,divid和parentId是map中必须有的值。
			
			TreeControl.deleteNode(map,beanId,function(data){
				setUlOrLiForDisabled(data);//删除节点时，使树节点隐藏
				changeNodeAttribute(data);
				//document.getElementById("span_"+parentId).focus();
				//document.getElementById("span_"+parentId).click();	
				jQuery("#span_"+parentId).trigger("click");
				alert('<fmt:message key="operation_successful_delete_records"  bundle="${applicationResources}"><fmt:param  value="1"/></fmt:message>');
			});
	}
	//在选中的节点下增加子节点
	function addNode(){
		var nodeid=document.getElementById("id").value;
		var divid=document.getElementById("divid").value;
		var code=form_treeNode.code.value;
		var status=getRadioValue(form_treeNode.status);
		var description=form_treeNode.description.value;
		var isbnCode=form_treeNode.isbnCode.value;
		var hintCode=form_treeNode.hintCode.value;
		var seqNo=form_treeNode.seqNo.value;
		var startDate=form_treeNode.startDate.value;
		var endDate=form_treeNode.endDate.value;
		var newNodeName=form_treeNode.name.value;
		var newNodeName_En=form_treeNode.name_en.value;
		if(checkFormsForName("form_treeNode")==true){
			DWREngine.setErrorHandler(eh); 
			var map={"parentId":nodeid,"divid":divid,"name":newNodeName,"name_en":newNodeName_En,"code":code,
			"status":status,"description":description,"isbnCode":isbnCode,"hintCode":hintCode,"seqNo":seqNo,
			"startDate":startDate,"endDate":endDate};//属性值parentId和divid是map中必须有的值。
			TreeControl.addNode(map,beanId,function(data){		
			if(data.treevalue!=""){
				populateDiv(data);
				changeNodeAttribute(data);
				setForms(curData);
				editFlag="modify";
				alert('<fmt:message key="operation_successful_add_new_records"  bundle="${applicationResources}"><fmt:param  value="1"/></fmt:message>');
				jQuery("[name=updateNodes]:first").attr("disabled",true);
			}});
		}
	}
	//载入编辑页面
	function getDetailPage(){
		var pageObj="/jsp/dd/basedata/baseDataDetail.jsp";///业务信息页面（用于新增页面，用户修改）
		return pageObj;
	}
	/*－－－－－－－－－－－－－－－－－－－－－－－－－－－－----------------------------------------
	-----------------------------上面是业务信息相关的方法（由二次开发人员实现）----------------------
	---------------------------------------------------------------------------------------------*/	
   rootId='<%=request.getAttribute("typeId").toString()%>';
   
</script>
</head>
<body onload="javascript:initTree(rootId,'tree');">
<script language="javascript">
	writeTableTop('<fmt:message key="basedata.detailpage_title"/>','<venus:base/>/');
</script>
<form name="form_treebasic" method="post">
	<input id="formName" name="formName" type="hidden" value="form_treebasic"/>			
	<input id="divid" name="divid" type="hidden" class="text_field" value="" readonly="true"><!-- 节点层id -->
	<input id="rootFlag" name="rootFlag" type="hidden" class="text_field" value="" readonly="true"><!-- 是否有根节点 -->
	<input id="id" name="id" type="hidden" class="text_field"  value="" readonly="true">	
	<input id="webModel" name="webModel" type="hidden" class="text_field" value="<%=request.getContextPath()%>" readonly="true"><!-- 发布目录 -->
</form>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="common.dynamic_tree" ></fmt:message>
		</td>
	</tr>
</table>
</div>
<div id ='ccChild1' class="table_div_content">
		<!--树控件页面-->
		<div id="tree" style="width:25%; float:left;height:500;background-color:#ffffff;border :1px solid #90b3cf;; overflow:auto;">
		</div>
		<!--编辑页面-->
		<div id="rightPanel" style="width:74%;float:right;display:none">
			<form id="form_treeNode" name="form_treeNode" method="post">
				<input name="formName" type="hidden" value="form_treeNode"/>			
				<!--操作信息-->
				<div id="toolBarDiv-1"  class="table_div_control" style="width: 100%;display:block"> 
						<div style="float:right" class="button_ellipse" onClick="javascript:history.go(-1);"><img src="<venus:base/>/images/icon/return.gif" class="div_control_image"><fmt:message key="return"  bundle="${applicationResources}"></fmt:message></div>
						<div id="deleteButton" style="float:right" class="button_ellipse"></div>
						<!-- 
						<div id="deleteButton" style="float:right" class="button_ellipse" onClick="javascript:deleteNode_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"  bundle="${applicationResources}"></fmt:message></div>
						 -->
						<div id="addButton" style="float:right" class="button_ellipse" onClick="javascript:addNode_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="add"  bundle="${applicationResources}"></fmt:message></div>
				</div>
				<!--详细信息-->
				<div id="treeNodeMessageDiv" style="display:block"> 			
				</div> 				
				<!--保存按钮-->
				<div id="toolBarDiv-2" style="display:block"> 
					<div class="table_div_content" >
						<input type="button" id="updateNodes" name="updateNodes" class="button_ellipse" value='<fmt:message key="save"  bundle="${applicationResources}"></fmt:message>' onClick="javascript:saveNode_onClick();">		
					</div>
				</div>
			</form>	
		</div>
		<!--缺省页面-->
		<div id="default" style="display:block;width:59%;float:right">
			<br>
			<br>
			<table class="table_noFrame" width="96%" align="center"> 
		        <tr> 
					<td align="left"><img src="<%=request.getContextPath()%>/images/dd/yq_bt.jpg" width="73" height="14"> <br> <br>
						请点击左边的节点树选择您要操作的基础数据。 <br> <br>
						[修改] 在详细信息页面修改数据后，点击保存按钮，改变当前节点信息。<br><br>
						[新增] 弹出新增页面，录入数据后点击保存按钮，在当前选中节点下增加子节点。<br><br>
						[删除] 删除当前选中节点及所有子节点。<br><br>
						[返回]返回到上一页面。<br><br>
					</td> 
				</tr> 
		    </table>
		</div>
</div>

<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</fmt:bundle>
</html>
