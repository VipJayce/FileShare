<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<script src="<venus:base/>/js/jquery/ui.core.js"></script>
<script src="<venus:base/>/js/jquery/ui.dialog.js"></script>
<script src="<venus:base/>/js/jquery/ui.draggable.js"></script>
<script src="<venus:base/>/js/jquery/ui.resizable.js"></script>
<link rel="stylesheet" href="<venus:base/>/css/jquery/flora.all.css" type="text/css">

<title>EXCEL<fmt:message key='gap.authority.Import' bundle='${applicationAuResources}' /></title>

<script>
	function upload_onClick() {
		if (form.file.value == null || form.file.value == "") {
			alert("<fmt:message key='gap.authority.Please_select_a_file_' bundle='${applicationAuResources}' />");
			return;
		}

    form.action = '<venus:base/>/ExcelImportAction.do?cmd=excelImport';
    form.submit();
	}
</script>

<body>
<form name="form" method="post" enctype="multipart/form-data">
	<table class="file" width="700em">
		<tr>
			<td align="right"  width="100em"><fmt:message key='gap.authority.Import_File' bundle='${applicationAuResources}' /></td>
						
			<td>
                <input name="file" class="text_field_reference"  type="file" inputName="<fmt:message key='gap.authority.Import_File' bundle='${applicationAuResources}' />"/>    
  			</td>
					
			<td align="right">
				<input name="upload"  class="button_ellipse" type="button" onClickTo="javascript:upload_onClick();" value="<fmt:message key='gap.authority.Import' bundle='${applicationAuResources}' />"/>
			</td>
		</tr>
	</table>
</form>
</body>

