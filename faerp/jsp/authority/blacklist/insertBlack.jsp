<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="venus.pub.util.VoHelper" %>

<%  //判断是否为修改页面
		boolean isModify = false;
		if(request.getParameter("isModify") != null) {
			isModify = true;
		}		
	%>
<title><%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Edit_Template"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.New_Template")%></title>
<script>

	function insert_onClick(){  //增加记录
		if(checkAllForms()){
    		form.action = "<venus:base/>/BlackListAction.do?cmd=insert";
    		form.submit();
    	}
  	}
  	function update_onClick(){
	  	if(checkAllForms()){
  			form.action = "<venus:base/>/BlackListAction.do?cmd=update";
  			form.submit();
  		}
  	}
  	function getBlackList() {
		var obj = window.showModalDialog('<venus:base/>/jsp/authority/blacklist/blacklistframe.jsp','','dialogTop:' + event.screenY + 'px;dialogLeft:' + event.screenX + 'px;dialogHeight:300px;dialogWidth:490px;help:no;resizable:no;scroll:no;status:0;');
        if(obj) {
            document.form.blacklistname.value = obj[1];
            document.form.blacklistid.value = obj[0];
        }
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Modify_page"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.New_page")%>','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="<layout:write name='bean' property='id'/>">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Save' bundle='${applicationAuResources}' />" onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
			<input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onClick="javascript:returnBack();">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Room_changes"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Add_room")%>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr> 
	<td>
	<table class="table_div_content_inner">
	<tr>
		<td align="right" width="10%" nowrap><font color="red">*</font><fmt:message key='gap.authority.Blacklist_Name' bundle='${applicationAuResources}' /></td>
		<td align="left">
			<input name="blacklistid" type="hidden" value="<layout:write name='bean' property='blackList.id'/>">
			<input name="blacklistname" type="text" value="<layout:write name='bean' property='blackList.name'/>" class="text_field_reference_readonly" inputName="<fmt:message key='gap.authority.Blacklist_Name' bundle='${applicationAuResources}' />" validate="notNull" readonly="true"><img src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getBlackList();" class="img_1">
		</td>
	</tr>
	<tr>
		<td align="right"><font color="red">*</font><fmt:message key='gap.authority.Blacklist' bundle='${applicationAuResources}' /></td>
		<td align="left">
			<input name="content" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Room_name' bundle='${applicationAuResources}' />" validate="notNull" value="<layout:write name='bean' property='content'/>">			
		</td>
		</tr>
	</table>
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

