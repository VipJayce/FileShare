<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>tree example</title>
<script language="javascript">
<!--
	function getTree(outputArray, basePath, inputType, rootCode, isSubmitAll, returnValueType, treeLevel, dataLimit){
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

		//返回值是哪个字段，可以选择partyrelation表的id、party_id和code三者之一，默认为code
		if(returnValueType==null || returnValueType=="")
			returnValueType = "code";
			
		//参数：控制树能展示到的层次，0 全部，1 公司，2 部门，3 岗位，默认为0
		if(treeLevel == null || treeLevel=="") {
			treeLevel = "0";
		}
		
		//参数：是否控制数据权限,0 否，1 是
		if(dataLimit == null || dataLimit=="") {
			dataLimit = "0";
		}

		var treePath = basePath+"/jsp/authority/tree/treeRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&rootXmlSource="
				+basePath+"/jsp/authority/tree/orgTree.jsp?parent_code%3D"+rootCode+"%26submit_all%3D"+isSubmitAll+"%26return_type%3D"+returnValueType+"%26tree_level%3D"+treeLevel+"%26data_limit%3D"+dataLimit;
		
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
                <tr align="left"> 
                    <td colspan="4" align="left">
                    调用方法getTree(outputArray,basePath,inputType,rootCode,isSubmitAll,returnValueType,treeLevel,dataLimit)获取组织机构树<br>
                    该方法在全局的js里有，可直接调用;该方法也可以参考本jsp的javascript方法:getTree自己定制<br>
                    具体参数说明如下：<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;outputArray——回填的表单项数组，可以是id，name或者id，name，parentName，partyType<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;basePath——项目的路径，即request.getContextPath()<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;inputType——节点的类型，分checkbox和radio<br>
                    &nbsp;&nbsp;&nbsp;&nbsp;rootCode——根节点编号，如果为空则显示全部组织机构<br>
					&nbsp;&nbsp;&nbsp;&nbsp;isSubmitAll——控制树的节点是否全带checkbox（radio），1全带，0只有树的最末尾一层带，默认为0<br>
					&nbsp;&nbsp;&nbsp;&nbsp;returnType——返回值是哪个字段，可以选择aupartyrelation表的id、party_id和code三者之一，默认为code<br>
					&nbsp;&nbsp;&nbsp;&nbsp;treeLevel——控制树展示的层次，0 全部，1 公司，2 部门，3 岗位，默认为0<br>
					&nbsp;&nbsp;&nbsp;&nbsp;dataLimit——是否控制数据权限，0 否，1 是，默认为0<br>
					下面举例说明如何调用:
					<br>
					</td> 
                </tr>
                <tr align="left" bgcolor="#FFFFFF"> 
                    <td colspan="4" align="left">返回的节点全名称：<input type="text"  name="parentName" size="100"/></td> 
                </tr>
                <tr align="left" bgcolor="#FFFFFF"> 
                    <td colspan="4" align="left">返回的节点类型ID：<input type="text"  name="textType" size="100"/></td>
                </tr>
                <tr>
                    <td width="20%" align="right">【全部组织，单选框的例子】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name1" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id1"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id1, name1, parentName, textType),'<venus:base/>','radio','','','','','');"/> </td> 
                    <td width="20%" align="right">【全部组织，多选框的例子】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name2" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id2"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id2, name2, parentName, textType),'<venus:base/>','checkbox','','','','','');"/> </td> 
                </tr> 
                                <tr>
                    <td width="20%" align="right">【全部组织，全部节点可选】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name3" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id3"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id3, name3, parentName, textType),'<venus:base/>','radio','','1','','','');"/> </td> 
                    <td width="20%" align="right">【全部组织，控制数据权限】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name4" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id4"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id4, name4, parentName, textType),'<venus:base/>','checkbox','','','','','1');"/> </td> 
                </tr> 
                <tr>
                    <td width="20%" align="right">【不控制权限，只展示公司】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name5" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id5"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id5, name5, parentName, textType),'<venus:base/>','radio','','','','1','');"/> </td> 
                    <td width="20%" align="right">【控制权限，只展示公司】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name6" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id6"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id6, name6, parentName, textType),'<venus:base/>','checkbox','','','','1','1');"/> </td> 
                </tr> 
                <tr>
                    <td width="20%" align="right">【不控制权限，展示到部门】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name7" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id7"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id7, name7, parentName, textType),'<venus:base/>','radio','','','','2','');"/> </td> 
                    <td width="20%" align="right">【控制权限，展示到部门】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name8" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id8"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id8, name8, parentName, textType),'<venus:base/>','checkbox','','','','2','1');"/> </td> 
                </tr>  
                <tr>
                    <td width="20%" align="right">【不控制权限，展示到岗位】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name9" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id9"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id9, name9, parentName, textType),'<venus:base/>','radio','','','','3','');"/> </td> 
                    <td width="20%" align="right">【控制权限，展示到岗位】</td>
                    <td width="30%" align="left">
                        <input type="text" class="text_field_reference_readonly" validators="isSearch" name="name10" inputName="组织机构树" 
						maxlength="50"/><input type="hidden" name="id10"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree(new Array(id10, name10, parentName, textType),'<venus:base/>','checkbox','','','','3','1');"/> </td> 
                </tr>
                <tr> 
                    <td colspan="4">iframe的例子：
	                     <table class="table_noFrame" width="100%"> 
			                <tr>
			                    <td width="20%" align="right">&nbsp;</td>
			                    <td width="30%" align="left"><iframe name="myTree" width="200" height="150" src="deeptree_iframe.jsp?inputType=radio&rootXmlSource=<venus:base/>/jsp/authority/tree/orgTree.jsp?submit_all%3D1%26return_type%3Did%26tree_level%3D0%26data_limit%3D0"></iframe>
			                        </td> 
			                    <td width="20%">
			                        <input type="button" name="Submit1" value="提交" onClick="myTree.returnValueName();alert(myTree.nameStrList);alert(myTree.codeStrList);" class="button_ellipse">
			                    </td>
			                    <td width="30%" align="left">&nbsp;</td> 
			                </tr> 
			            </table> 
					</td> 
                </tr>  
            </table> 
        </td> 
    </tr> 
</table> 
</body>
</html>
