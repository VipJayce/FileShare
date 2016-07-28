<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import = "gap.authority.org.aupartyrelationtype.vo.AuPartyRelationTypeVo"%>
<%@ page import = "gap.authority.util.VoHelperTools" %>
<%@ page import = "gap.authority.util.StringHelperTools" %>
<%
	String partyTypeId = (String)request.getAttribute("typeId");
%>
<title><fmt:message key='gap.authority.Query_Template' bundle='${applicationAuResources}' /></title>
<script>
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "queryAll";
    	form.submit();
  	}
	function findCheckbox_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		form.action = "<venus:base/>/AuPartyAction.do?cmd=find&id=" + ids;
		form.submit();
	}
	function view_onClick(thisId){
		if(thisId==null || thisId=="") {
		    var elementCheckbox = document.getElementsByName("checkbox_template");
			var number = 0;
			
			for(var i=0;i<elementCheckbox.length;i++){
				if(elementCheckbox[i].checked) {
					number += 1;
					thisId = elementCheckbox[i].value;
				}
			}
			if(number == 0) {
		  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
		  		return;
			}
			if(number > 1) {
		  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
		  		return;
			}
		}
		form.action = "<venus:base/>/AuPartyAction.do?cmd=detailList&id=" + thisId;
		form.submit();
	}
	
	function toAdd_onClick(typeId) {  //到增加记录页面
		form.action = "<venus:base/>/AuPartyAction.do?cmd=addPage&typeId="+typeId;
		form.submit();
	}
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
		
	function enable_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		
		form.action="<venus:base/>/AuPartyAction.do?cmd=enable&id=" + ids;
		form.submit();
	}   
	function disable_onClick() {  //从多选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var ids = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				ids = elementCheckbox[i].value;
			}
		}
		if(number == 0) {
	  		alert("<fmt:message key='gap.authority.Please_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(number > 1) {
	  		alert("<fmt:message key='gap.authority.Can_only_select_a_record' bundle='${applicationAuResources}' />!")
	  		return;
		}
		if(confirm("<fmt:message key='gap.authority.It_completely_remove_the_data_' bundle='${applicationAuResources}' />")) {			 
			form.action="<venus:base/>/AuPartyAction.do?cmd=disable&id=" + ids;
			form.submit();
		}
	}  	
	function reference_onClick() { 
	
	    if (window.parent.pageFlag.value=="1") {
			var elementCheckbox = document.getElementsByName("checkbox_template");  //通过name取出所有的checkbox
			var ids = null;  //定义id值的数组
			for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
				if(elementCheckbox[i].checked) {  //如果被选中
					if(ids == null) {
						ids = new Array(0);
					}
					ids.push(elementCheckbox[i].value);  //加入选中的checkbox
				}
			}
			if(ids == null)	{  //如果ids为空
				alert("<fmt:message key='gap.authority.Please_Select_Records' bundle='${applicationAuResources}' />!")
				return;
			}
			//if(ids.length > 1) {  //如果ids有2条以上的纪录
		  	//	alert("只能选择一条记录!")
		  	//	return;
			//}
			window.returnValue = ids;
			window.close();
		}		
	} 
	function initFocus(){ 
		var ctrl=document.getElementById("name"); 
		ctrl.focus(); 
	}  
</script>

</head>
<body onload="initFocus()">
<form name="form" method="post" action="<venus:base/>/AuPartyAction.do">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="typeId" value="<%=partyTypeId%>">

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
	<td width="40%"><input name="name" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' />" validate="isSearch"></td>
	<td align="left"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onclickto="javascript:simpleQuery_onClick();">
	</td>
</tr>
</table>

</div>

<div id="auDivParent1"> 
<table class="table_div_control">
	<tr > 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')">&nbsp;<fmt:message key='gap.authority.Details_Form' bundle='${applicationAuResources}' />
		</td>
		<td> 
			<table align="right">
				<tr> 
					<td class="button_ellipse" onClick="javascript:toAdd_onClick('<%=(String) request.getAttribute("typeId")%>');"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.Added' bundle='${applicationAuResources}' /></td>
					<!-- td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image">删除</td -->
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' /></td>		
					<td class="button_ellipse" onClick="javascript:view_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.View' bundle='${applicationAuResources}' /></td>							
					<!-- td class="button_ellipse" onClick="javascript:enable_onClick();"><img src="<venus:base/>/images/icon/enable.bmp" class="div_control_image">启用</td-->
					<td class="button_ellipse" onClick="javascript:disable_onClick();"><img src="<venus:base/>/images/icon/disable.bmp" class="div_control_image"><fmt:message key='gap.authority.Delete' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message key='gap.authority.Refresh' bundle='${applicationAuResources}' /></td>					
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
					<input type="radio"  name="checkbox_template" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="30" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
				<bean:define id="pId" name="wy1" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=pId%>"/>
			</layout:collectionItem>	
			<%="<a onDblClick='javascript:view_onClick(getRowHiddenId())'>"%>
			<layout:collectionItem width="160" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Number") %>' property="id" />	
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Name") %>' property="name" />	
			<%if(gap.authority.util.GlobalConstants.isPerson(partyTypeId)) { //判断是否人员 %>
			<layout:collectionItem  title="Email" property="email" />	
			<%}%>
			<layout:collectionItem  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Notes") %>' property="remark" />	
			<%="</a>"%>
		</layout:collection>
		
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>
</form>
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

