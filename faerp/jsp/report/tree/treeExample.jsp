<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tree example</title>
<script language="javascript">
<!--
	function getTree(outputArray, basePath, inputType, rootCode, isSubmitAll, returnValueType, returnNodeType){
		//回填的表单项名称
		if(outputArray==null) {
			alert("请设置回填的表单项名称");
			return false;
		}
		//树结点的类型，分radio和checkbox两种，默认radio
		if(inputType==null || inputType=="")
			inputType = "radio";

		//控制树的节点是否全带checkbox（radio），yes全带，no只有树的最末尾一层带
		if(isSubmitAll==null || isSubmitAll=="")
			isSubmitAll = "no";

		//返回值的类型，分id、code和party_id三种，默认为id
		if(returnValueType==null || returnValueType=="")
			returnValueType = "id";
			
		//返回节点的类型，分is_leaf（是否叶子节点）、party_type（团体类型ID）
		//和relation_type（团体关系类型ID）三种，默认为party_type
		if(returnNodeType==null || returnNodeType=="")
			returnNodeType = "party_type";

		var treePath ="";
		//根节点编号，如果为空则显示全部团体关系类型
		if(rootCode==null || rootCode=="") {
			treePath = basePath+"/jsp/authority/tree/treeRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&rootXmlSource="
				+basePath+"/jsp/authority/tree/treeRoot.jsp?submit_all%3D"+isSubmitAll+"%26return_type%3D"+returnValueType+"%26node_type%3D"+returnNodeType;
		}else {
			treePath = basePath+"/jsp/authority/tree/treeRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&rootXmlSource="
				+basePath+"/jsp/authority/tree/treeData.jsp?parent_code%3D"+rootCode+"%26submit_all%3D"+isSubmitAll+"%26return_type%3D"+returnValueType+"%26node_type%3D"+returnNodeType;
		}
		var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
		if(rtObj != undefined && rtObj.length > 0){
			var allTextValue = "";
			var allTextName = "";
			var allParentName = "";
			var detailedType = "";
			for(var i=0; i<rtObj.length-1; i++) {
				allTextValue += rtObj[i]['returnValue'] + ",";
				allTextName += rtObj[i]['childName'] + ",";
				allParentName += rtObj[i]["parentName"] + ",";
				detailedType += rtObj[i]["detailedType"] + ",";
			}
			allTextValue += rtObj[rtObj.length-1]['returnValue'];
			allTextName += rtObj[rtObj.length-1]['childName'];
			allParentName += rtObj[rtObj.length-1]['parentName'];
			detailedType += rtObj[rtObj.length-1]['detailedType'];
			
			var textValue = outputArray[0];
			var textName = outputArray[1];
			
			textValue.value = allTextValue;
			textName.value = allTextName;
			if(outputArray.length>=3) {
				var textParentName = outputArray[2];
				textParentName.value = allParentName;
			}
			if(outputArray.length==4) {
				var nodeType = outputArray[3];
				nodeType.value = detailedType;
			}
		} 
	}
//-->
</script>
</head>
<body> 
<table class="table_div_content" height="100%"> 
    <tr> 
        <td valign="top"> 
            <table class="table_noFrame" width="100%"> 
             	<!--tr bgcolor="#FFFFFF">
                    <td colspan="4" align="left">
                        根据登陆人所拥有的数据权限过滤后的树的例子(多选)
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name1" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id1"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" 
						onClick="javascript:getLimitTree(new Array(id1, name1),'','','','');"/> 
					</td> 
                </tr--> 
                <tr align="left" bgcolor="#FFFFFF"> 
                    <td colspan="4" align="left">父节点名称：<input type="text"  name="parentName" size="100"/></td> 
                </tr>
                <tr align="left" bgcolor="#FFFFFF"> 
                    <td colspan="4" align="left">节点类型ID：<input type="text"  name="textType" size="100"/></td>
                </tr>
                <tr>
                    <td width="20%" align="right">【全部组织，单选】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="tree_name_radio" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="tree_id_radio"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(tree_id_radio, tree_name_radio, parentName, textType),'<venus:base/>','radio','','yes','');"/> </td> 
                    <td width="20%" align="right">【全部组织，多选】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="tree_name_checkbox" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="tree_id_checkbox"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(tree_id_checkbox, tree_name_checkbox, parentName, textType),'<venus:base/>','checkbox','','yes','');"/> </td> 
                </tr> 
                <tr> 
                    <td colspan="4">iframe的例子：
	                     <table class="table_noFrame" width="100%"> 
			                <tr>
			                    <td width="20%" align="right">&nbsp;</td>
			                    <td width="30%" align="left"><iframe name="myTree" width="200" height="300" src="deeptree_iframe.jsp?inputType=radio&rootXmlSource=<venus:base/>/jsp/authority/tree/treeRoot.jsp?submit_all%3Dno%26return_type%3Dparty_id"></iframe>
			                        </td> 
			                    <td width="20%">
			                        <input type="button" name="Submit1" value="提交" onClick="myTree.returnValueName();alert(myTree.nameStrList);alert(myTree.codeStrList);" class="button_ellipse">
			                    </td>
			                    <td width="30%" align="left">&nbsp;</td> 
			                </tr> 
			            </table> 
					</td> 
                </tr> 
                <tr align="left"> 
                    <td colspan="4" align="left">
                    方法getTree(outputArray,basePath,inputType,rootCode,isSubmitAll,returnValueType,returnNodeType)在全局的js里有，可直接调用<br>
                    具体参数说明如下：<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;outputArray——回填的表单项数组，可以是id，name或者id，name，parentName<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;basePath——项目的路径，即request.getContextPath()<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;inputType——节点的类型，分checkbox和radio<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;rootCode——根节点编号，如果为空则显示全部团体关系类型<br>
					&nbsp;&nbsp;&nbsp;&nbsp;isSubmitAll——控制树的节点是否全带checkbox（radio），yes全带，no只有树的最末尾一层带，默认为no<br>
					&nbsp;&nbsp;&nbsp;&nbsp;returnType——返回值的类型，分id、code和party_id三种，默认为id<br>
					&nbsp;&nbsp;&nbsp;&nbsp;returnNodeType——返回节点的类型，分is_leaf（是否叶子节点）、party_type（团体类型ID）和relation_type（团体关系类型ID）三种，默认为party_type<br>
					<br>
					</td> 
                </tr> 
            </table> 
        </td> 
    </tr> 
</table> 
</body>
</html>
