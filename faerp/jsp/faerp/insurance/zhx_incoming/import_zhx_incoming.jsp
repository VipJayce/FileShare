<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 

<title></title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
         var file1=document.form.file1.value.trim();
         file1=file1.substring(file1.lastIndexOf(".")+1);
         if(file1 == null || file1 == ""){
             alert("上传文件不能为空！");
             return;
         }
         if(file1!="xls" && file1!="csv"){
             alert("类型不正确！");
             return ;
         }
                form.action="<%=request.getContextPath()%>/Zhx_incomingAction.do?cmd=uploadExcelForBatchInsertFinincoming";
                form.submit();
    }
</script>

</head>
<body>
<form name="form" method="post" enctype="multipart/form-data">
<table>
    <tr>
         <td width="12%" align="right">附件上传:</td>
          <td width="20%" align="left">
                <input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
          </td>
    </tr>
    <tr>
        <td align="right"><button value="上传" onclick="javascript:insert_onClick()">上传</button></td>
        <td align="left"><button onclick="javascript:window.close();">取消</button></td>
    </tr>
</table>
</form>
</body>
</html>