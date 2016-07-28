<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper"%>
<%@ page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="java.util.Date"%>
<%@include file="/common/common.jsp"%>
<fmt:bundle basename="rayoo.common.system.system_resource" prefix="rayoo.common.system.">
<html>
<head>
<%@ include file="/jsp/include/global.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script language="javascript" src="<%=request.getContextPath()%>/js/common/fesco.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/dd/jquery/jquery.js"></script>
<title><fmt:message key="uplourd_file"/></title>
</head>
<body class="uploadPage" onload="javascript:test();"><center>
<div style="height:50px;"></div>
<form name="form" method="post" enctype="multipart/form-data">
<input type="file" id="fileInput" name="file1">
<input type="button" value="<fmt:message key="import"/>" onclick="javascript:upload_onClick();">
</form>
</center>
</body>
</html>
<%
    String uploadDir = request.getParameter("uploadDir");
    if (uploadDir == null || uploadDir.length() == 0) {
        uploadDir = RmUploadHelper.DEFAULT_UPLOAD_DIALOG_DIR;
    }
%>
<script language="javascript">
    function upload_onClick() {
        var ss = document.getElementById("fileInput").value;
        if(ss==""){
            alert("<fmt:message key="import_file_not_null"/>");
            return;
        }
        
        form.action = "attachUpload.jsp?uploadDir=<%=uploadDir%>";
        try {
              form.submit();
        } catch(e) {
              alert(e.message);
        }
    }
    var myResultFile = new Array();
    
    if(window.parent != null && (typeof window.parent.onUploadDone) == "function") {
<%  //取出List
    String[] myResultFile = null;
try
{

    Object[] aResult = RmUploadHelper.uploadRequestFiles(request, RmUploadHelper.getConfigurationInstance(new java.io.File(this.getServletConfig().getServletContext().getRealPath(uploadDir))));
    for(int i=1; i<aResult.length; i++) {
        String[] fileInfo = (String[])aResult[i];
        if(myResultFile == null || myResultFile.length == 0 || myResultFile[0] == null || myResultFile[0].trim().length() == 0) {
            myResultFile = fileInfo;
            if(myResultFile.length >= 4 ) {
                myResultFile[3] = myResultFile[3];
            }
        }
    }
    if(myResultFile != null) {
        for(int j=0; j<myResultFile.length; j++) {
            out.println("myResultFile.push('" + myResultFile[j] + "');");
        }
        if(myResultFile.length < 6) {
            for(int k=0; k<6-myResultFile.length; k++) {
                out.println("myResultFile.push('');");  //补齐位置
            }
        }
    
        String formatUpload_remark = RmStringHelper.replaceStringToScript(((java.util.Map)aResult[0]).get("upload_remark"));
        
        formatUpload_remark = RmStringHelper.replaceStringByRule(formatUpload_remark, new String[][]{{",", "，"}});
        out.println("myResultFile.push('" + formatUpload_remark + "');");
        out.println("window.parent.onUploadDone(0, myResultFile);");
    }
} catch(Exception e) {
        e.printStackTrace();
        out.print("window.parent.onUploadDone(1, myResultFile, '上传文件失败，原因是：' + '" + e.getMessage() + "');");
}
%>
    }
    
    function test(){
        <%if(myResultFile!=null){ %>
        var address="<%=myResultFile[0].toString()%>";
        var name="<%=myResultFile[1].toString()%>";
        window.parent.opener.document.getElementById("attachNameInput").value=name;
        window.parent.opener.document.getElementById("attackAddressInput").value=address;
        window.parent.window.close();
		<%} %>
    }
</script>
</fmt:bundle>
