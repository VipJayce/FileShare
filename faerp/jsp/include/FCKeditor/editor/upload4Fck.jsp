<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>File Upload Example</title>
</head>
<body>
</body>
</html>
<script language="javascript">
	if(window.parent != null && (typeof window.parent.OnUploadCompleted) == "function") {
<%  //取出List
	String[] myResultImage = {"", ""};
try{
	Object[] aResult = RmUploadHelper.uploadRequestFiles(request, RmUploadHelper.getConfigurationInstance(new java.io.File(this.getServletContext().getRealPath("/upload/FCKeditor"))));
	for(int i=1; i<aResult.length; i++) {
		String[] fileInfo = (String[])aResult[i];
		if("".equals(myResultImage[0])) {
			myResultImage[0] = request.getContextPath() + "/upload/FCKeditor/" + fileInfo[0];
			myResultImage[1] = fileInfo[1];
		}
	}
%>
		window.parent.OnUploadCompleted(0, '<%=myResultImage[0]%>', '<%=RmUploadHelper.encode2Encode(myResultImage[1], "GBK", "UTF-8")%>', '成功上传文件！');
<%
} catch(Exception e) {
%>
		window.parent.OnUploadCompleted(1, '<%=myResultImage[0]%>', '<%=RmUploadHelper.encode2Encode(myResultImage[1], "GBK", "UTF-8")%>', '上传文件失败！\n' + '<%=e.getMessage()%>');
<%
	e.printStackTrace();
}
%>
	}
</script>
