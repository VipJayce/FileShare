<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%String type=request.getParameter("weltype"); %>
<html>
<fmt:bundle basename="rayoo.employeepost.epwelfare.epwelfare_resource" prefix="rayoo.employeepost.epwelfare.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" />

<title>importEmpExcel</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        
	     var file1=document.form.file1.value.trim();
	     file1=file1.substring(file1.lastIndexOf(".")+1);
	     if(file1 == null || file1 == ""){
	         alert("<fmt:message key="downlord_file_not_null"/>");
	         return;
	     }
	     if(file1!="xls"){
             alert("<fmt:message key="type_not_true"/>");
             return ;
	     }
	document.getElementById("but22").disabled="disabled";     
    form.action="<%=request.getContextPath()%>/EpwelfareAction.do?cmd=ImportInfo&weltype="+<%=type%>;
    form.submit();
    }
</script>

</head>
<body>
<form name="form" method="post" enctype="multipart/form-data">
<table>
    <tr>
         <td width="12%" align="right"><fmt:message key="file_import"/>:</td>
          <td width="20%" align="left">
                <input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
          </td>
    </tr>
    <tr>
        <td align="right"><button onclick="javascript:insert_onClick()"  id="but22" ><fmt:message key="downlord"/></button></td>
        <td align="left"><button onclick="javascript:window.close();"><fmt:message key="close1"/></button></td>
    </tr>
</table>
</form>
</body>
</fmt:bundle>
</html>