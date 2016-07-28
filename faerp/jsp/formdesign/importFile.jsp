<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
    <fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
	<head>
		<title><fmt:message key="import_form_title"/></title>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Expires" CONTENT="0">
		<meta http-equiv="Cache-Control" CONTENT="no-cache">
		<meta http-equiv="Pragma" CONTENT="no-cache">
		<script language="javascript">
		<!--
		function submitImport() {
			var frm = document.frmUpload;

			if (frm.txtFile.value.length == 0) {
				alert('<fmt:message key="pls_select_form_file"/>');
			} else {
				frm.hidFileName.value = frm.txtFile.value;
				frm.action = "<%=request.getContextPath()%>/formDesign.do?cmd=upload";
				frm.submit();
			}
		}
		//-->
		</script>
	</head>
	<body scroll="no" style="OVERFLOW: hidden" style="background-color: #EBE9ED;">
	<form name="frmUpload" method="post" enctype="multipart/form-data">
		<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td>
					<table cellSpacing="0" cellPadding="0" align="center" border="0">
						<tr>
							<td>
								<input type="hidden" name="hidFileName" />
								<fmt:message key="import_file_name"/><input name="txtFile" id="txtFile" type="file"/><br/><br/>
								<input type="button" value='<fmt:message key="submit" bundle="${applicationResources}"/>' onclick="javascript:submitImport();"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	</body>
	</fmt:bundle>
</html>