<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "gap.msg.util.IConstants"%>
<%  
		String userId=(String)session.getAttribute(IConstants.VENUS_PARTY_ID);
		String delayTime=(String)session.getAttribute("delayTime");
		String delayShowType=(String)session.getAttribute("delayShowType");
		String MSN=(String)session.getAttribute("MSN");
		String MSNPWD=(String)session.getAttribute("MSNPWD");
%>
<title><fmt:message key='gap.message.User_configuration_parameters' bundle='${applicationMessageResources}' /></title>
<script language="javascript" src="<%=request.getContextPath()%>/js/im/gap-message.js"></script>
<script>

	function insert_onClick(){  //增加记录
		var userMap ="{\"USERID\":\"<%=userId%>\""+
		",\"delayTime\":\""+document.form.delayTime.value+"\""+
		",\"delayShowType\":\""+document.form.delayShowType.value+"\""+
		",\"MSN\":\""+document.form.MSN.value+"\""+
		",\"MSNPWD\":\""+document.form.MSNPWD.value+"\""+
		"}";
		window.location.href = "<venus:base/>/ManageAction.do?cmd=save&userMap="+userMap;
   	}
  	function return_onClick(){
	  	if(checkAllForms()){
  			form.action = "<venus:base/>/MessageAction.do?cmd=receive";
  			form.submit();
  		}
  	}
  	function changeShowType(avalue){
		document.form.delayShowType.value=avalue;
	}
	function changeDelayTime(avalue){
		document.form.delayTime.value=avalue;
	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.message.User_configuration_parameters' bundle='${applicationMessageResources}' />",'<venus:base/>/');
</script>
<form name="form" method="post">
<input type=hidden name=delayTime value="<%=delayTime%>">
<input type=hidden name=delayShowType value="<%=delayShowType%>">
<!--创建-->
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value=<fmt:message key='gap.message.Save' bundle='${applicationMessageResources}' /> onClick="javascript:insert_onClick();">
			<input name="button_cancel" type="button" class="button_ellipse" value=<fmt:message key='gap.message.Cancel' bundle='${applicationMessageResources}' />  onClick="javascript:history.go(-1);">
		</td>
	</tr>
</table>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key='gap.message.User_configuration_parameters' bundle='${applicationMessageResources}' />
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr> 
		<td align="right" width="10%" nowrap><fmt:message key='gap.message.SMS_polling_interval' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<select name=delaySet onclick="changeDelayTime(this.value)">
<option value="2">2<fmt:message key='gap.message.Second' bundle='${applicationMessageResources}' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--<fmt:message key='gap.message.Test' bundle='${applicationMessageResources}' />--</option><!--测试用，实际使用时建议注释掉-->
				<option value="10" <%="10".equals(delayTime)?"selected":""%>>10<fmt:message key='gap.message.Second' bundle='${applicationMessageResources}' /></option>
				<option value="30" <%="30".equals(delayTime)?"selected":""%>>30<fmt:message key='gap.message.Second' bundle='${applicationMessageResources}' /></option>
				<option value="60" <%="60".equals(delayTime)?"selected":""%>>1<fmt:message key='gap.message.Point' bundle='${applicationMessageResources}' /></option>
				<option value="600" <%="600".equals(delayTime)?"selected":""%>>10<fmt:message key='gap.message.Point' bundle='${applicationMessageResources}' /></option>
				<option value="1800" <%="1800".equals(delayTime)?"selected":""%>>30<fmt:message key='gap.message.Point' bundle='${applicationMessageResources}' /></option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.Message_displayed' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<input type=radio name=showType value=0 onclick="changeShowType(this.value)" <%="0".equals(delayShowType)?"checked":""%>><fmt:message key='gap.message.Disable' bundle='${applicationMessageResources}' /><input type=radio name=showType value=1 onclick="changeShowType(this.value)" <%="1".equals(delayShowType)?"checked":""%>><fmt:message key='gap.message.Cycle' bundle='${applicationMessageResources}' /><input type=radio name=showType value=2 onclick="changeShowType(this.value)" <%="2".equals(delayShowType)?"checked":""%>><fmt:message key='gap.message.Leak' bundle='${applicationMessageResources}' />
		</td>
	</tr>
	<tr>
		<td align="right">MSN<fmt:message key='gap.message.Account' bundle='${applicationMessageResources}' /></td>
		<td align="left"><input type=text name=MSN  class="text_field" value="<%=null==MSN?"":MSN%>"></td>
	<tr>
		<tr>
		<td align="right">MSN<fmt:message key='gap.message.Password' bundle='${applicationMessageResources}' /></td>
		<td align="left"><input type=password name=MSNPWD  class="text_field" value="<%=null==MSNPWD?"":MSNPWD%>"></td>
	<tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>

