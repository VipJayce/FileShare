<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "java.util.List,java.util.Iterator,java.util.ArrayList,java.util.HashMap"%>
<%@ page import = "venus.frames.mainframe.web.tags.PageVo"%>
<%@ page import = "gap.authority.util.VoHelperTools"%>

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
    		form.action = "<venus:base/>/SysParamsAction.do?cmd=insert";
    		form.submit();
    	}
  	}
  	function update_onClick(){
  	     if(checkAllForms()){
  		    form.action = "<venus:base/>/SysParamsAction.do?cmd=update";
  		    form.submit();
  		 }
  	}
  </script>

</head>
<body>
<script language="javascript">
	writeTableTop('<%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Modify_page"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.New_page")%>','<venus:base/>/');
</script>

<form name="form" method="post">
<input type="hidden" name="id" value="">
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Save' bundle='${applicationAuResources}' />" onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>;">
			<input name="button_cancel" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onClick="javascript:returnBack();">
		</td>
	</tr>
</table>

<div id="auDivParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<venus:base/>/')"><%=isModify?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Body_type_changes"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Add_Group_Type")%>
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="10%" nowrap><span class="style_required_red">* </span><fmt:message key='gap.authority.Parameter_name' bundle='${applicationAuResources}' /></td>
		<td align="left">
			<input name="Id" type="hidden" value="">
			<input name="propertykey" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Parameter_name' bundle='${applicationAuResources}' />" <%=isModify?"readonly":""%> maxlength=50 validate="notNull;isSearch" value="">
		</td>		
	</tr>	
	<tr>
	    <td align="right" width="10%" nowrap><span class="style_required_red">* </span><fmt:message key='gap.authority.Parameter_values' bundle='${applicationAuResources}' /></td>
	    <td align="left">
	    	<input name="value" type="text" class="text_field" inputName="<fmt:message key='gap.authority.Parameter_values' bundle='${applicationAuResources}' />" maxlength=100 validate="notNull" value="">
	    </td>	
	</tr>
	<tr>
	    <td align="right" width="10%" nowrap><fmt:message key='gap.authority.Description' bundle='${applicationAuResources}' /></td>
	    <td align="left">
			<textarea name="description" cols="60" rows="5" class="textarea_limit_words" maxLength="100"></textarea>
		</td>
	</tr>
	<tr>
			<td align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Enabled0' bundle='${applicationAuResources}' /></td>
			<td align="left">
				<input type="radio" name="enable" inputName="<fmt:message key='gap.authority.Enabled0' bundle='${applicationAuResources}' />" value="1" checked /><fmt:message key='gap.authority.Enabled' bundle='${applicationAuResources}' />
				<input type="radio" name="enable" inputName="<fmt:message key='gap.authority.Enabled0' bundle='${applicationAuResources}' />" value="0" /><fmt:message key='gap.authority.Disable' bundle='${applicationAuResources}' />
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

