<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList"%>
<%@ page import="venus.frames.mainframe.web.tags.PageVo" %>
<%@ page import = "gap.authority.au.auresource.vo.AuResourceVo"%>
<%@ page import = "gap.authority.util.VoHelperTools" %>
<%@ page import = "gap.authority.util.StringHelperTools" %>
<%@ page import = "gap.authority.au.auresource.util.IAuResourceConstants" %>

<title><fmt:message key='gap.authority.Record_level_data_permissions' bundle='${applicationAuResources}' /></title>
<script>    
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.action = "<venus:base/>/AuResourceAction.do?cmd=simpleQuery";
		form.submit();
  	}
	function findCheckbox_onClick() {  //从单选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = null;
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
				break;
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
		form.action = "<venus:base/>/AuResourceAction.do?cmd=find&id=" + id;
		form.submit();
	}
	
	function toAdd_onClick() {  //到增加记录页面
		window.location="<venus:base/>/AuResourceAction.do?cmd=initinsert&resource_type=4&forward=<%=IAuResourceConstants.REQUEST_QUERY_ALL_RECORD%>";
	}
	
	function toDefine_onClick() {  //到增加记录页面
		window.location="<venus:base/>/jsp/authority/au/auresource/insertByDefine.jsp";
	}
	
	function refresh_onClick(){  //刷新本页
		form.submit();
	}
	
	function enable_onClick() {  //从单选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
				break;
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
		
		form.action="<venus:base/>/AuResourceAction.do?cmd=enablestatus&id=" + id + "&pageFlag=4";
		form.submit();
	}   
	function disable_onClick() {  //从单选框到修改页面
		var elementCheckbox = document.getElementsByName("checkbox_template");
		var number = 0;
		var id = "";
		for(var i=0;i<elementCheckbox.length;i++){
			if(elementCheckbox[i].checked) {
				number += 1;
				id = elementCheckbox[i].value;
				break;
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
					
		form.action="<venus:base/>/AuResourceAction.do?cmd=disablestatus&id=" + id + "&pageFlag=4";
		form.submit();
	}  
	
	function initFocus(){ 
		var ctrl=document.getElementById("name"); 
		ctrl.focus(); 
	}  
</script>

</head>
<body onload="initFocus()">
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Check_list' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>

<form name="form" method="post">
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
	<td><input name="name" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Name' bundle='${applicationAuResources}' />" validate="isSearch"><input type="button" name="Submit" class="button_ellipse" value="<fmt:message key='gap.authority.Inquiry' bundle='${applicationAuResources}' />" onClick="javascript:simpleQuery_onClick();">
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
					<td class="button_ellipse" onClick="javascript:toDefine_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.User_defined_new' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<venus:base/>/images/icon/add.gif" class="div_control_image"><fmt:message key='gap.authority.According_to_the_physical_form_new' bundle='${applicationAuResources}' /></td>
					<!-- td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<venus:base/>/images/icon/delete.gif" class="div_control_image">删除</td -->
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<venus:base/>/images/icon/modify.gif" class="div_control_image"><fmt:message key='gap.authority.Modify' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:refresh_onClick();"><img src="<venus:base/>/images/icon/refresh.gif" class="div_control_image"><fmt:message key='gap.authority.Refresh' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:enable_onClick();"><img src="<venus:base/>/images/icon/enable.bmp" class="div_control_image"><fmt:message key='gap.authority.Enabled' bundle='${applicationAuResources}' /></td>
					<td class="button_ellipse" onClick="javascript:disable_onClick();"><img src="<venus:base/>/images/icon/disable.bmp" class="div_control_image"><fmt:message key='gap.authority.Disable' bundle='${applicationAuResources}' /></td>
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
		<layout:collection name="beans" id="wy1" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0" >
			<layout:collectionItem width="20" title="" style="text-align:center;">
				<bean:define id="wy3" name="wy1" property="id"/>
					<input type="radio" name="checkbox_template" value="<%=wy3%>"/>
			</layout:collectionItem>
			<layout:collectionItem width="20"  title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Sequence") %>' style="text-align:center;">
				<venus:sequence/>
			</layout:collectionItem>
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Resource_Name") %>' property="name" />    
			<layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Field_name") %>' property="field_name" />
            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Table_Chinese_name") %>' property="table_chinesename" />    
            <layout:collectionItem title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Table_name") %>' property="table_name" /> 
			<layout:collectionItem width="60" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Filters") %>' property="value" /> 
            <layout:collectionItem width="40" title='<%=venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Status") %>' sortable="false" style="text-align:center;">
			<bean:define id="enable_status" name="wy1" property="enable_status"/>
		    <%="1".equals(enable_status)?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Enabled"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Disable")%>
		    </layout:collectionItem>
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

