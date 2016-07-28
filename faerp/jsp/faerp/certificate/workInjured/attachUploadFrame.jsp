<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<%
	String uploadDir = request.getParameter("uploadDir");
    String arg = request.getParameter("arg");
	if(uploadDir == null || uploadDir.length() == 0) {
		uploadDir = RmUploadHelper.DEFAULT_UPLOAD_DIALOG_DIR;
	}
	String openType = request.getParameter("openType");
	if(openType == null || openType.length() == 0) {
		openType = "WRITE";
	}
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>gap.rm upload</title>

</head>
<body><center>
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
  <tr height="40%" id="tr_uploadContent">
    <td align="center" cellSpacing="1">
		<iframe name="uploadContent" src="attachUpload.jsp?uploadDir=<%=uploadDir%>&arg=<%=arg %>" onLoad="window.setTimeout('uploadHandler.refreshInfo()',500);"  frameBorder="0" border="0" width="100%" height="100%">
		</iframe>
	</td>
  </tr>
</table>
</center>
</body>
</html>
