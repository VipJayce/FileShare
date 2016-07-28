<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<title><fmt:message key="edit_the_reasons_for_rollback"/></title>
<script>
	function save_onClick(){  //提交页面
		var elementReason = document.getElementById("reason_text");
		if(elementReason.value == "") {
	  		alert('<fmt:message key="please_write_the_reasons_for_rollback"/>')
	  		return;
		}
		var returnArray = new Array();
		returnArray[0] = elementReason.value;
		window.returnValue = returnArray;
		window.close();
  	}
	function close_onClick(){  //关闭页面
		window.close();
  	}
</script>

</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="edit_the_reasons_for_rollback"/>','<venus:base/>/');
</script>
<form name="form" method="post">
<table class="table_noframe">
	<tr>
		<td valign="right">
			<input name="button_save" type="button" class="button_ellipse" value='<fmt:message key="confirm" bundle="${applicationResources}" />'  onClick="save_onClick()">
			<input name="button_close" type="button" class="button_ellipse" value='<fmt:message key="close" bundle="${applicationResources}" />' onClick="close_onClick()">
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<venus:base/>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<venus:base/>/')"><fmt:message key="edit_the_reasons_for_rollback"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
	<tr>
		<td align="right" width="15%"><fmt:message key="reasons_for_rollback"/></td>
		<td align="left" width="85%">
			<textarea id="reason_text" name="reason_text" cols="60" rows="8"></textarea>		
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