<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh" prefix="rayoo.certificate.certificateTransaction.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 

<title></title>
<script language="javascript">
    function import_onClick() {
        var file1=document.form.file1.value.trim();
        file1=file1.substring(file1.lastIndexOf(".")+1);
        if (file1 == null || file1 == "") {
            alert("<fmt:message key='import_file_is_null'/>");
            return;
        }
        if (file1!="xls" && file1!="csv") {
            alert("<fmt:message key='import_file_is_type_err'/>");
            return ;
	     }
	     //yangxu 重复提交的限制
	     document.getElementById('import_button').disabled = true;
	     
        form.action="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=importFile";
        form.submit();  
    }
</script>

</head>
<body>
<form name="form" method="post" enctype="multipart/form-data">
<table>
    <tr>
         <td width="12%" align="right"><fmt:message key='import_file'/>:</td>
          <td width="20%" align="left">
                <input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
          </td>
    </tr>
    <tr>
        <td align="right"><button value="<fmt:message key='button_upload'/>" onclick="javascript:import_onClick()" id="import_button">上传</button></td>
        <td align="left"><button onclick="javascript:window.close();"><fmt:message key='button_cancel'/></button></td>
    </tr>
</table>
</form>
</body>
</fmt:bundle>
</html>