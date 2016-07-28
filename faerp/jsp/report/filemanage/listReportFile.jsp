<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ include file="/jsp/include/global.jsp"%>
<fmt:bundle basename="gap.report.report_resource" prefix="gap.report.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="filemanage.file_manage"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>&nbsp;&nbsp;</td>
				<td width="100%" valign="middle">
				<table width="98%" height="60" border="0" align="center"
					cellpadding="0" cellspacing="1" bgcolor="#7EBAFF">
					<tr valign="middle">
						<td bgcolor="#FFFFFF" valign="middle"><iframe id="leftTree"
							name="leftTree" width="100%" height="100%" frameborder="0"
							src="<%=request.getContextPath()%>/jsp/report/filemanage/search.jsp"></iframe>
						</td>
					</tr>
				</table>
				<td>&nbsp;&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>&nbsp;&nbsp;</td>
				<td width="270" valign="top">
				<table width="100%" height="460" border="0" align="center"
					cellpadding="0" cellspacing="1" bgcolor="#7EBAFF">
					<tr>
						<td bgcolor="#FFFFFF"><iframe id="funcTree" name="funcTree"
							width="100%" height="100%" frameborder="0"
							src="<%=request.getContextPath()%>/jsp/report/tree/deeptree.jsp?rootXmlSource=<%=request.getContextPath()%>/jsp/report/filemanage/rootXmlData.jsp?root_code=101"></iframe>
						</td>
					</tr>
				</table>
				</td>
				<td valign="top">
				<table width="95%" height="460" border="0" align="center"
					cellpadding="0" cellspacing="1" bgcolor="#7EBAFF">
					<tr>
						<td bgcolor="#FFFFFF" align="center"><iframe id="detailReportFile"
							name="detailReportFile"
							style="HEIGHT:100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 2"
							scrolling=auto frameborder=0
							src="<%=request.getContextPath()%>/jsp/report/filemanage/default.jsp"></iframe>
						</iframe></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>


