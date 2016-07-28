<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
	<%String reason=(String)request.getAttribute("reason");%>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<title><fmt:message key="view_the_reasons_for_rollback"/></title>
<script>

	function close_onClick(){  //关闭页面
		window.close();
  	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="view_the_reasons_for_rollback"/>','<venus:base/>/');
</script>
<form name="form" method="post">
<table class="table_noframe">
	<tr>
		<td valign="right">
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="close" bundle="${applicationResources}" />' onClick="close_onClick()">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="view_the_reasons_for_rollback"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td align="right" width="15%"><fmt:message key="reasons_for_rollback"/></td>
		<td align="left" width="85%">
			<textarea name="textfield3" cols="60" rows="8"><%=reason%></textarea>		
		</td>
	</tr>
</table>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>
</html>