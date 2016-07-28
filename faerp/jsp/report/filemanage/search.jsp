<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/include/global.jsp"%>
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<script>    
	function simpleQuery_onClick(){  //简单的模糊查询
		parent.document.all.detailReportFile.src="<venus:base/>/ReportFileAction.do?cmd=simpleQuery&name="+document.all.name.value+"&total_code="+document.all.total_code.value+"&author="+document.all.author.value+"&enable_status="+document.all.enable_status.value;
  	}
	function initFocus(){ 
		var ctrl=document.getElementById("name"); 
		ctrl.focus(); 
	}  
</script>

</head>
<body onload="initFocus()">

<!-- 查询开始 -->
<table id='ccChild0' class="table_div_content">
	<tr>
		<td align="left" width="20%" nowrap><fmt:message key="filemanage.report_name"/></td>
		<td width="30%"><input name="name" type="text" class="text_field"
			validate="isSearch"></td>
		<td align="left" width="20%" nowrap><fmt:message key="filemanage.report_code"/></td>
		<td width="30%"><input name="total_code" type="text"
			class="text_field" validate="isSearch"></td>
	</tr>
	<tr valign="middle">
		<td align="left" width="20%" nowrap><fmt:message key="filemanage.report_author"/></td>
		<td width="30%"><input name="author" type="text" class="text_field"
			validate="isSearch"></td>
		<td align="left" width="20%" nowrap><fmt:message key="filemanage.status"/></td>
		<td width="30%"><select id="enable_status" name="enable_status">
			<option value=1><fmt:message key="filemanage.enable"/></option>
			<option value=0><fmt:message key="filemanage.disable"/></option>
		</select></td>
		<td align="left"><input type="button" name="Submit"
			class="button_ellipse" value='<fmt:message key="query"  bundle="${applicationResources}"></fmt:message>'
			onclick="javascript:simpleQuery_onClick();"></td>
	</tr>
</table>
</body>
</fmt:bundle>
</html>
