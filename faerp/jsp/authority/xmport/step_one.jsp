<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Import_Step_1' bundle='${applicationAuResources}' /></title>
</head>
<script>
function nextStep(){
	//form.action="<%=request.getContextPath()%>/XmportAction.do?cmd=step_one";
	//form.submit();
	form.action="<%=request.getContextPath()%>/jsp/authority/xmport/step_two.jsp";
	form.submit();
}
function clearSuperCode(){
    document.form.name3.value='';
    document.form.id3.value='';
}
function inValidateRL(isCheck){
    superCode(isCheck);
    if(isCheck)
        document.getElementById("relationDiv").style.visibility="hidden";
    else
        document.getElementById("relationDiv").style.visibility="visible";
}
function superCode(isCheck){
    if(!isCheck&&!document.all("relation").checked&&getRadioValue("operate")!="delete")
        document.getElementById("superCode").style.visibility="visible";
    else
        document.getElementById("superCode").style.visibility="hidden";
}
function getRadioValue(RadioName){
    var obj;   
    obj=document.getElementsByName(RadioName);
    if(obj!=null){
        var i;
        for(i=0;i<obj.length;i++){
            if(obj[i].checked){
                return obj[i].value;           
            }
        }
    }
    return null;
}
function getQueryTree(outputArray, basePath, inputType, rootCode, isSubmitAll, returnValueType, treeLevel, dataLimit){
        //回填的表单项名称
        if(outputArray==null) {
            alert("<fmt:message key='gap.authority.Set_the_single_name_of_the_table_filling' bundle='${applicationAuResources}' />");
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
            
        //参数：控制树能展示到的层次，0 全部，1 公司，2 部门，3 岗位，-3 去除岗位，默认为0
        if(treeLevel == null || treeLevel=="") {
            treeLevel = "0";
        }
        
        //参数：是否控制数据权限,0 否，1 是
        if(dataLimit == null || dataLimit=="") {
            dataLimit = "0";
        }

        var treePath = basePath+"/jsp/authority/tree/treeQueryRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&basePath="+basePath+"&parent_code="+rootCode+"&submit_all="+isSubmitAll+"&return_type="+returnValueType+"&tree_level="+treeLevel+"&data_limit="+dataLimit;
        
        var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=610px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
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
            
            jQuery("#"+textValue).val(allTextValue);
	        jQuery("#"+textValue).trigger("change");
	        jQuery("#"+textName).val(allTextName);
	        jQuery("#"+textName).trigger("change");
	        
	        if(outputArray.length>=3) {
	            var textParentName = outputArray[2];
	            jQuery("#"+textParentName).val(allParentName);
	            jQuery("#"+textParentName).trigger("change");
	        }
	        if(outputArray.length==4) {
	            var nodeType = outputArray[3];
	            jQuery("#"+nodeType).val(detailedType);
	            jQuery("#"+nodeType).trigger("change");
	        }
        } 
    }
</script>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Import_Step_1' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_back" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Next' bundle='${applicationAuResources}' />"  onclick="javascript:nextStep();" >
		</td>
	</tr>
</table>
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.Import_Step_1' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="auDivChild0"> 
<table class="table_div_content">
<tr>
<td><br/></td>
</tr>
<tr><td>
	<table class="table_div_content_inner">
		<tr>
			<td width=60>&nbsp;<td>
			<td>
				<fieldset name="operate_type">
					<legend><font color=black><fmt:message key='gap.authority.Action_Type' bundle='${applicationAuResources}' /></font></legend>
					<br/>
					<input name="operate" value="add" type="radio" >&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Added' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
				  	<br/>
				  	<input name="operate" value="delete" type="radio" onpropertychange="JavaScript:superCode(this.checked);">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Delete' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
				  	<br/>
				  	<input name="operate" value="update" type="radio" onpropertychange="JavaScript:inValidateRL(this.checked);">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
				  	<br/>
				</fieldset>
			</td>
			<td width=60>&nbsp;<td>
			<td>
				<fieldset name="organize_type">
					<legend><font color=black><fmt:message key='gap.authority.Operation_object' bundle='${applicationAuResources}' /></font></legend>
					<br/>
					<input name="organize" value="company" type="radio">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Company0' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
				  	<br/>
				  	<input name="organize" value="department" type="radio">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Department0' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
				  	<br/>
				  	<input name="organize" value="employee" type="radio">&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key='gap.authority.Staff' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/>
				  	<br/>
				</fieldset>
			</td>
			<td width=60>&nbsp;<td>
			<td>
			     <div id = "relationDiv">
			     <fieldset name="organize_type">
                    <legend><font color=black><fmt:message key='gap.authority.Whether_the_relationship' bundle='${applicationAuResources}' /></font></legend>
                            <br/>
                            <input name="relation" value="relation" id="relation" " type="checkbox" onclick="JavaScript:superCode(this.checked);"><span id="relationtext"><fmt:message key='gap.authority.Relational_Operations' bundle='${applicationAuResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				           <br/><br/><br/><br/><br/><br/>
				    </fieldset>
				</div>
			</td>
			<td width=30>&nbsp;<td>
			<td>
			     <div id = "superCode">
			     <fieldset name="organize_type">
                    <legend><font color=black><fmt:message key='gap.authority.Parent_node' bundle='${applicationAuResources}' /></font></legend>
                    <br/>
                        &nbsp;&nbsp;<fmt:message key='gap.authority.Parent_node' bundle='${applicationAuResources}' /><input type="text" class="text_field_reference_readonly" validators="isSearch" id="name3" name="name3" inputName="<fmt:message key='gap.authority.Organization_Tree' bundle='${applicationAuResources}' />" 
                        maxlength="50" hiddenInputId="id3"/><input type="hidden" id="id3" name="id3"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getQueryTree(new Array('id3','name3'),'<venus:base/>','radio','','1','','2','');"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <br/><br/>
                       <center><input  class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Empty' bundle='${applicationAuResources}' />" onclick="JavaScript:clearSuperCode();"></center>
                       <br/><br/>
                    </fieldset>
                  </div> 
            </td>                    
		</tr>
	</table>
</td>
</tr>
<tr>
<td><br/></td>
</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

