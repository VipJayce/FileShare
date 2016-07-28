<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
    <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
	<head>
		<title><fmt:message key="export_form_title"/></title>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Expires" CONTENT="0">
		<meta http-equiv="Cache-Control" CONTENT="no-cache">
		<meta http-equiv="Pragma" CONTENT="no-cache">
		<script language="javascript">
		<!--
		function submitExport() {
			if (txtFile.value == "" || txtFile.length < 0) {
				alert('<fmt:message key="pls_input_export_filename"/>');
				txtFile.focus();
			} else {
			//	var frm = window.dialogArguments.frmDesigner;
				var frm = window.opener.frmDesigner;
				frm.txtFileName.value = txtFile.value;
				frm.cmd.value = "exportFile";
				frm.submit();
				window.close();
			}
		}
		//-->
		</script>
	</head>
	<body scroll="no" style="OVERFLOW: hidden" style="background-color: #EBE9ED;">
		<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td>
					<table cellSpacing="0" cellPadding="0" align="center" border="0">
						<tr>
							<td>
								<fmt:message key="export_file_name"/><input id="txtFile" type="text"/>
								<input type="button" value='<fmt:message key="submit" bundle="${applicationResources}"/>' onclick="javascript:submitExport();"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
	</fmt:bundle>
</html>