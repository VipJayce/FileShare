<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "gap.authority.util.VoHelperTools" %>
<%@ page import = "gap.authority.util.StringHelperTools" %>
<%@ include file="/jsp/include/global.jsp" %>
<%
    String partyTypes = request.getParameter("partyTypes");
    if( partyTypes==null || "".equals(partyTypes) ) {
    	partyTypes = (String)request.getAttribute("partyTypes");
    }
%>
<title><fmt:message key='gap.authority.Query_Template' bundle='${applicationAuResources}' /></title>
<script>
<!--
	function simpleQuery_onClick(){  //简单的模糊查询
		form.action = "<venus:base/>/AuVisitorAction.do?cmd=simpleQueryByTypes";
    	form.submit();
  	}
  	function role_onButton(){
  		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		
		var treePath = "<venus:base/>/jsp/authority/tree/treeRef4RoRel.jsp?inputType=checkbox&nodeRelationType=noRelation&rootXmlSource="
                +"<venus:base/>/jsp/authority/au/aurole/xmlData.jsp?has_checkbox%3Dyes%26partyId%3D"+ids;
                
		var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
		
		if(rtObj != undefined){// && rtObj.length > 0){//20100528人寿需求
            var submitObjectArray = rtObj["submitObjectArray"];
            var del_array = rtObj["del_array"];
            var parentRelIds = "";
            for(var i=0; i<submitObjectArray.length-1; i++) {
                parentRelIds += submitObjectArray[i]['returnValue'] + ",";
            }
            if(submitObjectArray.length > 0)
                parentRelIds += submitObjectArray[submitObjectArray.length-1]['returnValue'];
            
            var delRelIds = "";
            for(var i=0; i<del_array.length-1; i++) {
                delRelIds += del_array[i] + ",";
            }
            if(del_array.length > 0)
                delRelIds += del_array[del_array.length-1]; 
            form.action="<venus:base/>/AuVisitorAction.do?cmd=addMultiRole&partyId="+ids+"&parentRelIds="+parentRelIds+"&delRelIds="+delRelIds;
            form.submit();
        }
	}
	
	function auth_onClick(id){
		var types = form.partyTypes.value;
		window.location="<venus:base/>/AuPartyAction.do?cmd=detailList&pageFlag="+types+"&id="+id;
	}
	
	function auth_onButton(){
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		auth_onClick(ids);
	}
	
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				var thisTr = jQuery(elementCheckbox[i]).parent().parent().get(0);  //定义本行的tr对象
				var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
				if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
					ids.push(thisHidden.value);  //加入选中的checkbox
				} 
				//ids.push(elementCheckbox[i].value);  //因为页面回写的缘故，从下一级页面返回时会覆盖该checkbox_template的值，故这个方法无效
			}
		}
		return ids;
	}
	
	function getRowHiddenId() {  //从事件取得本行的id
		var thisA = event.srcElement;  //定义事件来源对象
		var thisTr = thisA.parentElement.parentElement.parentElement;  //定义本行的tr对象
		var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
		if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
			return thisHidden.value;
		} else {
			return null;
		}
	}
	function initFocus(){ 
		var ctrl=document.getElementById("name"); 
		ctrl.focus(); 
	}  
//-->
</script>
</head>
<body onload="initFocus()">
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Check_list' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>
<form name="form" method="post" action="<venus:base/>/AuVisitorAction.do?cmd=simpleQueryByTypes">
<input type="hidden" name="partyTypes" value="<%=partyTypes%>">
<!-- 查询开始 -->
<div id="auDivParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<venus:base/>/')">
			<fmt:message key='gap.authority.Conditional_Query' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="auDivChild0"> 
<table class="table_div_content">
<tr>

<td align="right" width="10%" nowrap><fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' /></td>
	<td><input name="name" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' />" validate="isSearch">	
	<input type="button" name="Submit" class="button_ellipse" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onClickto="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>

</div>
<div id="auDivParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Query_Results' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
				<%
				if("1".equals(partyTypes)) {%>
					<td class="button_ellipse" onClick="javascript:role_onButton();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Distribution_of_roles' bundle='${applicationAuResources}' /></td>
				<%}%>
					<td class="button_ellipse" onClick="javascript:auth_onButton();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.Authorization_Management' bundle='${applicationAuResources}' /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1"> 
<table class="table_div_content">
	<tr>
		<td>
		<layout:collection name="wy" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="30" title="" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="id"/>
					<input type="radio" name="checkbox_template" value="<%=wy3%>"/>
					<input type="hidden" signName="hiddenId" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="30" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<%="<a ondblclick='javascript:auth_onClick(getRowHiddenId())'>"%>
			<layout:collectionItem width="160" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Number") %>' property="id" />	
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Name") %>' property="name" />	
				<layout:collectionItem width="400" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Organization") %>' sortable="false">
					<logic:notEmpty name="wy1" property="owner_org">
						<bean:define id="owner_org" name="wy1"  property="owner_org"/>
						 <%=StringHelperTools.replaceStringToHtml(owner_org)%>
					 </logic:notEmpty>
				</layout:collectionItem>		
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Notes") %>' property="remark" />
			<%="</a>"%>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
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
<%  //表单回写
	if(request.getAttribute("writeBackFormValues") != null) {
		out.print("<script language=\"javascript\">\n");
		out.print(VoHelperTools.writeBackMapToForm((java.util.Map)request.getAttribute("writeBackFormValues")));
		out.print("writeBackMapToForm();\n");
		out.print("</script>");
	}
%>

