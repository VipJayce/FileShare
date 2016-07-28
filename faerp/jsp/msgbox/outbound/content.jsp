<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<bean:parameter id="returnflag" name="rt"/>
<title><fmt:message key='gap.message.View_messages' bundle='${applicationMessageResources}' /></title>
<script language="javascript" src="<%=request.getContextPath()%>/js/im/gap-message.js"></script>
<script>
  	function return_onClick(){
  	<%if("new".equals(returnflag)){%>
	  	form.action = "<venus:base/>/MessageAction.do?cmd=receivenew";
	  	form.submit();
	 <%}else if("receive".equals(returnflag)){%>
  		form.action = "<venus:base/>/MessageAction.do?cmd=receivebox";
  		form.submit();
  	 <%}else{%>
  	 	history.go(-1);
  	 <%}%>
  	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.message.View_messages' bundle='${applicationMessageResources}' />",'<venus:base/>/');
</script>
<form name="form" method="post">
<input type="hidden" name="id" value="">
<!--查看-->
<table class="table_noframe">
	<tr>
		<td valign="middle">
			<input name="button_save" type="button" class="button_ellipse" value=<fmt:message key='gap.message.Return' bundle='${applicationMessageResources}' /> onClick="javascript:return_onClick();">
		</td>
	</tr>
</table>
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key='gap.message.View_messages' bundle='${applicationMessageResources}' />
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr> 
	<td>
			<table border="1" bordercolorlight="#7EBAFF"
	cellpadding="5" cellspacing="0" width="80%" align="center">
				<tr>
					<td width="15%" align="right"><fmt:message key='gap.message.SMS_Title_' bundle='${applicationMessageResources}' /></td>
		<td width="85%" align="left">
			<layout:write name='wy' property='msgTitle'/>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.Hair' bundle='${applicationMessageResources}' /> <fmt:message key='gap.message.Pieces' bundle='${applicationMessageResources}' /> <fmt:message key='gap.message.Person_' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<layout:write name='wy' property='from'/>		
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.Income' bundle='${applicationMessageResources}' /> <fmt:message key='gap.message.Pieces' bundle='${applicationMessageResources}' /> <fmt:message key='gap.message.Person_' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<input id="msgToUser" type="hidden" name="msgToUser" />
			<layout:write name='wy' property='msgTo'/>
		</td>
	</tr>
		<tr>
		<td align="right"><fmt:message key='gap.message.Send_by_' bundle='${applicationMessageResources}' /></td>
		<td align="left">
		<bean:define id="wy8" name="wy" property="properties" type= "java.util.Map" /> 
		<bean:define id="wy10" name="wy8" property='msnmessage' type="java.lang.String"/>
		<bean:define id="wy11" name="wy8" property='webmessage' type="java.lang.String"/>
		<bean:define id="wy12" name="wy8" property='mailmessage' type="java.lang.String"/>
			<input name="sendChannel" type="checkbox" inputName=<fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /> disabled value="msnmessage" <%=wy10.equals("true")?"checked":""%>>MSN&nbsp;&nbsp;
			<input name="sendChannel" type="checkbox" inputName=<fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /> disabled value="mailmessage" <%=wy12.equals("true")?"checked":""%>>Email&nbsp;&nbsp;
			<input name="sendChannel" type="checkbox" inputName=<fmt:message key='gap.message.Send_method' bundle='${applicationMessageResources}' /> disabled value="webmessage" <%=wy11.equals("true")?"checked":""%>><fmt:message key='gap.message.Post_a_New_Message' bundle='${applicationMessageResources}' />
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.Sent_' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<layout:write name='wy' property='sendTime'/>
		</td>
	</tr>
	<tr>
		<td align="right"><fmt:message key='gap.message.SMS_content_' bundle='${applicationMessageResources}' /></td>
		<td align="left">
			<layout:write name='wy' property='msgContent' filter="false"/>
		</td>
	</tr>
	</table>
	</td>
	</tr>
</table>
</div>
</form>
<jsp:include page="/jsp/msgbox/outbound/recevie.jsp" />
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>

