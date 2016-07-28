<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
	String loginId = gap.authority.helper.LoginHelper.getLoginId(request);
	if( loginId == null ) {
		loginId = "";
	}
%>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Change_Password' bundle='${applicationAuResources}' /></title>
<script language="javascript">
<!--
  	function update_onClick(){  //保存修改后的单条数据
  	    var re = /([a-zA-Z]{1,20}[0-9]{1,20}[!$#%]{0,20}|[0-9]{1,20}[a-zA-Z]{1,20}[!$#%]{0,20}|[!$#%]{0,20}[a-zA-Z]{1,20}[0-9]{1,20})/;
  	    if(form.new_password.value.length<8){
  	     alert("密码必须大于8位，请重新输入!");
  	     form.new_password.focus();
  	     return false;
  	    }
  	    if(!re.test(form.new_password.value)){
  	       alert("新密码必须包含至少一位字符和数字!");
  	       form.new_password.focus();
  	       return false;
  	    }
		if(form.cfm_password.value != form.new_password.value) {
			alert("<fmt:message key='gap.authority.Enter_your_password_and_new_password_confirmation_inconsistent' bundle='${applicationAuResources}' />");
			form.cfm_password.focus();
			return false;
		}
	    form.action="<%=request.getContextPath()%>/AuUserAction.do?cmd=modifyPassword";
    	form.submit();
	}
	function notChinese(s,thisInput) {  //不含中文
		if(s.length==0) 
			return true;
		if(ischinese(s)){
			writeValidateInfo("<fmt:message key='gap.authority.Can_not_input_Chinese' bundle='${applicationAuResources}' />",thisInput);
			return false;
		}
		return true;
	}
//-->
</script>
</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Change_Password' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td>
			<input name="button_save" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Save' bundle='${applicationAuResources}' />" onClickto="javascript:update_onClick()">
			<input name="button_cancel" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Cancel' bundle='${applicationAuResources}' />"  onClick="javascript:parent.window.close()" >
		</td>
	</tr>
</table>

<div id="auDivParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.Change_Password' bundle='${applicationAuResources}' />
		</td>
	</tr>
</table>
</div>

<div id="auDivChild1"> 
<table class="table_div_content">
	<tr>
		<td> 
			<table class="table_div_content_inner">
				<tr>
					<td width="80" align="right" nowrap>&nbsp;</td>
					<td align="left">&nbsp;</td>
				</tr>
				<tr>
					<td align="right"><span class="style_required_red"></span><fmt:message key='gap.authority.User_name' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="text" class="text_field" name="login_id" inputName="<fmt:message key='gap.authority.User_name' bundle='${applicationAuResources}' />" value="<%=loginId%>" maxLength="24" validate="notChinese;notNull;" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Old_Password' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="password" class="text_field" name="old_password" inputName="<fmt:message key='gap.authority.Old_Password' bundle='${applicationAuResources}' />" value="" maxLength="24" validate="notChinese;notNull;"/>
					</td>
				</tr>
				<tr>
					<td align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.New_Password' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="password" class="text_field" name="new_password" inputName="<fmt:message key='gap.authority.New_Password' bundle='${applicationAuResources}' />" value="" maxLength="24" validate="notChinese;notNull;"/>
					</td>
				</tr>
				<tr>
					<td align="right"><span class="style_required_red">* </span><fmt:message key='gap.authority.Confirm_New_Password' bundle='${applicationAuResources}' /></td>
					<td align="left">
						<input type="password" class="text_field" name="cfm_password" inputName="<fmt:message key='gap.authority.Confirm_New_Password' bundle='${applicationAuResources}' />" value="" maxLength="24" validate="notChinese;notNull;"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</form>		
<script language="javascript">
	//writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

