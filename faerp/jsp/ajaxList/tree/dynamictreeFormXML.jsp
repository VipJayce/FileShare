<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<script src="<%=request.getContextPath()%>/dwr/interface/TreeControl.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajaxList-tree.js"></script>
 <fmt:bundle basename="gap.ajax.ajax_resource" prefix="gap.ajax.">
<STYLE TYPE="text/css" MEDIA=screen>
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
	MARGIN-LEFT: 15px;LIST-STYLE: none; MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px; VERTICAL-ALIGN: middle;
}
</STYLE>
<script>
String.prototype.trim   =   function()
{
         //   用正则表达式将前后空格
         //   用空字符串替代。
         return   this.replace(/(^\s*)|(\s*$)/g,   "");
}
	
	//用户调用的beanID
	var beanId="XmlTreeDataService";//以xml文件为数据源的树
	//新增根节点和新增节点时，记住根节点信息或者父节点信息
	var nowData;

	//显示当前节点的信息
	function displayNode(nodeId,divid){
		//隐藏新增信息
		divExtend("newTreeNodeDiv","none");
		//显示修改信息
		divExtend("treeNodeDiv","block");
		//隐藏用户页面
		divExtend('treeNodeMessageDiv',"block");
		//载入修改页面
		includeEditPage(nodeId,divid);
		
	}
	//保存修改后的节点信息
	function updateNode(){
		if(confirm(i18n4ajaxList.confirm_to_update_node)) {
			var nodeid=form_treebasic.id.value;
			var divid=form_treebasic.divid.value;
			var nodeName=form_treeNode.nodeName.value.trim();
            var locations=document.getElementById("locations");
			if(checkFormsForName("form_treeNode")==true){
				DWREngine.setErrorHandler(eh); 
				var map={"id":nodeid,"divid":divid,"name":nodeName,"nodeName":nodeName,"locations":locations.value};//属性值id,divid是map中必须有的值。
				TreeControl.updateNode(map,beanId,function(data){
					populateSpan(data);
					nowData=data;
					alert(i18n4ajaxList.update_success);
				});
				
			}
		}
	}
	//删除选中的节点
	function deleteNode(){
			var nodeid=form_treebasic.id.value;
			var divid=form_treebasic.divid.value;
			var parentId=form_treebasic.parentId.value;
			var nodeName=form_treeNode.nodeName.value.trim();
			DWREngine.setErrorHandler(eh); 
			var map={"id":nodeid,"divid":divid,"parentId":parentId};//属性值id,divid和parentId是map中必须有的值。
			
			TreeControl.deleteNode(map,beanId,function(data){
				setUlOrLiForDisabled(data);//删除节点时，使树节点隐藏
				changeNodeAttribute(data);
			});
			setButtonForNoDisabled("addButton", "addButtonTd", null, true);//设置新增按钮disabled,同时修改该按钮所在td的样式
			setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//设置删除按钮disabled,同时修改该按钮所在td的样式
	}
	//在选中的节点下增加子节点
	function addNode(){
		var nodeid=form_treebasic.id.value;
		var divid=form_treebasic.divid.value;
		var newNodeName=form_treeNode.nodeName.value.trim();
		      //获取用户的过滤条件
        var locations=document.getElementById("locations");
        var location_query=document.getElementById("location_query");
		if(checkFormsForName("form_treeNode")==true){
			DWREngine.setErrorHandler(eh); 
			var map={"parentId":nodeid,"divid":divid,"name":newNodeName,"locations":locations.value,"location_query":location_query.value};//属性值parentId和divid是map中必须有的值。
			TreeControl.addNode(map,beanId,function(data){		
			if(data.treevalue!=""){
				populateDiv(data);
				changeNodeAttribute(data);
				setForms(nowData);
			}});
			//隐藏新增信息
			divExtend('newTreeNodeDiv',"none");
			//隐藏修改信息
			divExtend('treeNodeDiv',"block");
		}
	}
	//增加根节点,方法名称+S是为了避免关键字。
	function addRoots(){
			var newNodeName=form_treeNode.nodeName.value.trim();
			if(checkFormsForName("form_treeNode")==true){
				DWREngine.setErrorHandler(eh); 
				var map={"name":newNodeName};//属性值name是map中必须有的值。
				TreeControl.addRoot(map,beanId,function(data){	
				if(data.treevalue!=""){
					populateDiv(data);
					setForms(nowData);
				}});
			}
			//隐藏新增根节点按钮信息
			divExtend('newTreeRootDiv',"none");
			//隐藏修改节点按钮信息
			divExtend('treeNodeDiv',"none");
			//隐藏用户修改信息
			divExtend('treeNodeMessageDiv',"none");
	}
	
	//载入新增节点页面
	function includeAddPage(){
		var pageobj="/jsp/ajaxList/tree/treeIncludeOfXML.jsp";///新增页面，用户修改
		TreeControl.getInclude(pageobj,function(data) {
			dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
			});
	}
	
	//载入新增根节点页面
	function includeAddRootPage(){
		var pageobj="/jsp/ajaxList/tree/treeIncludeOfXML.jsp";///新增页面，用户修改
		TreeControl.getInclude(pageobj,function(data) {
			dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
			});
	}
	
	//载入修改页面
	function includeEditPage(nodeId,divid){
		var pageobj="/jsp/ajaxList/tree/treeIncludeOfXML.jsp";//新增页面，用户修改
		TreeControl.getInclude(pageobj,function(data) {
			dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
			DWREngine.setErrorHandler(eh); 
			form_treebasic.id.value=nodeId;
			form_treebasic.divid.value=divid;
			TreeControl.getNodeMessage(nodeId,beanId,function(data){
				setForms(data);
				nowData=data;
			});
		});
	}

	
	/*
	 *往页面填充值
	 *@param data 后台往前台传的vo
	 */
	function setForms(data){
		for(var property in data){ 
           dwr.util.setValue(property, data[property], { escapeHtml:false });
        }
	}

	function checkFormsForName(formName){//校验名称为formName值的form 中的控件
		var checkResult = true;
		rmTempStatusIsAlert = false;
		rmTempStatusIsFocus = false;
		
		setAllVenusInputsDefault();
		for (var i=0;i<document.forms.length;i++) {
			if(formName!=document.forms[i].name){continue;}
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
function extendsParamsMap(paramsMap){//用户扩展过滤条件
			//获取用户的过滤条件
			var locations=document.getElementById("location_query");
			if(locations.value!=""){
				//用户自定义的过滤条件
				paramsMap["location_query"]=locations.value;
			}
}
//===========================================用户自定义方法
function simpleQuery_onClick(){
	nodeDivHide();//隐藏节点信息 
	setButtonForNoDisabled("addButton", "addButtonTd", null, true);//新增按钮失效
	setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//删除按钮失效

	var paramsMap={};
	//获取用户的过滤条件
	var locations=document.getElementById("location_query");
	if(locations.value!=""){
		//用户自定义的过滤条件
		paramsMap["location_query"]=locations.value;
	}
	initTree('root','tree',paramsMap);
}



function onLoadTree(){//用户自定义初始化树
	var paramsMap={};
	initTree('root','tree',paramsMap);
}

</script>

</head>
<!--初始化树-->
<!--<body onload="javascript:initTree('root','tree',{});">-->
<body onload="javascript:onLoadTree();">
<script language="javascript">
	writeTableTop('<fmt:message  key="tree.dynamic_tree"/>','<venus:base/>/');
</script>
<form name="form_treebasic" method="post">
<input name="divid" type="hidden" class="text_field" inputName="节点层id" value="" readonly="true">
<input name="rootFlag" type="hidden" class="text_field" inputName="是否有根节点" value="" readonly="true">
<input name="id" type="hidden" class="text_field" inputName="节点id" value="" readonly="true">	
<input name="parentId" type="hidden" class="text_field" inputName="父节点id" value="" readonly="true">
<input name="webModel" type="hidden" class="text_field" inputName="发布目录" value="<%=request.getContextPath()%>" readonly="true">

<div id="ccParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<venus:base/>/images/icon/07-0.gif" onClick="javascript:hideshow('ccChild0',this,'<venus:base/>/')">
            <fmt:message bundle='${applicationResources}' key="query_with_condition"/>
        </td>
    </tr>
</table>
</div>
    
<div id="ccChild0"> 
<table class="table_div_content">
<tr>
    <td align="right" width="10%" nowrap><fmt:message key="tree.location"/></td>
    <td>
            <select id="location_query" name="location_query" >
                <option value="" selected><fmt:message key="tree.countrywide"/></option>
                <option value="1"><fmt:message key="tree.northern"/></option>
                <option value="2"><fmt:message key="tree.southern"/></option>
            </select>
    <input type="button" name="Submit" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="query"/>" onclick="javascript:simpleQuery_onClick();">
    </td>
    </td>
</tr>
</table>

</div>

</form>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')">
		</td>
	</tr>
</table>
</div>
<div id="msg">
</div>
<div id="ccChild1"> 
<table  class="table_div_content">
	<tr>
		<td valign="top">


			<div id="tree" style="width:400; height:250;background-color:#ffffff;border :1px solid #90b3cf;; overflow:auto;">
	
				
			</div><br>

		</td>
		<td rowspan="2" style="padding-left:25" valign="top">
			<div id="treeOtherDiv"  style="display:block"> 
			<table style="width: 100%;">
				<tr > 
					<td> 
						<table align="right">
							<tr> 
									<td id="addRootButton"  class="button_ellipse" onClick="javascript:addRoot_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key="tree.add_root"/></td>
									<td id="addButtonTd" style="color:#ACA899" class="button_ellipse"><input id="addButton" type="image" disabled="true" src="<venus:base/>/images/icon/add.gif" class="div_control_image" ><fmt:message bundle='${applicationResources}'  key="add"/></td>
									<td id="deleteButtonTd" style="color:#ACA899" class="button_ellipse"><input id="deleteButton" type="image" disabled="true" src="<venus:base/>/images/icon/delete.gif" class="div_control_image" ><fmt:message bundle='${applicationResources}'  key="delete"/></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</div>
			<div id="treeNodeDiv" style="display:none"> 
				<table align="right">
					<tr>
						<td align="left"><fmt:message key="tree.details_selected_node"/></td>
						<td align="right">
							<input type="button" name="updateNodes" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:updateNode();">		
						</td>
					</tr>
				</table>
			</div>
			<div id="newTreeNodeDiv"  style="display:none">
				<table align="right">
					<tr>
						<td align="left"><fmt:message key="tree.details_additional_node"/></td>
						<td align="right">
							<input type="button" name="addNodes" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:addNode();">		
						</td>
					</tr>
				</table>	
			</div>
			<div id="newTreeRootDiv"  style="display:none">
			<table align="right">
				<tr>
					<td align="left"><fmt:message key="tree.details_additional_root"/></td>
					<td align="right">
						<input type="button" name="addRootNode" class="button_ellipse" value="<fmt:message bundle='${applicationResources}'  key="save"/>" onClick="javascript:addRoots();">		
					</td>
				</tr>
			</table>
			</div>			
			<form name="form_treeNode" method="post">
				
				<div id="treeNodeMessageDiv" style="display:block"> 
								
				</div> 
			</form>
		</td>
	</tr>
	

</table>
</div>

<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>
</fmt:bundle>