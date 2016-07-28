<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.finance.receivable.finincoming.finincoming_resource" prefix="rayoo.finance.receivable.finincoming.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 

<title></title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
    
	     var file1=document.form.file1.value.trim();
	     file1=file1.substring(file1.lastIndexOf(".")+1);
	     if(file1 == null || file1 == ""){
	         alert("<fmt:message key='alert_updatefile_isnull'/>");
	         return;
	     }
	     if(file1!="xls" && file1!="csv"){
             alert("<fmt:message key='alert_type_err'/>");
             return ;
	     }
	     //yangxu 重复提交的限制
	     document.getElementById('import_button').disabled = true;
	     
	     
	     if(checkAllForms()){
	        var type = '<%=request.getParameter("type") %>';
	        if(type == '1'){
		        form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=1";
		        form.submit();
		    }else if(type == '2'){
		        form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=2";
                form.submit();
		    }else if(type == '3'){
                form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=3";
                form.submit();
            }else if(type == '4'){
                form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=4";
                form.submit();
            }
            //add  by sqp 
            else if(type == '5'){//建行
                form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=5";
                form.submit();
            }
            else if(type == '6'){//浦发
                form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=6";
                form.submit();
            }
            else if(type == '7'){//农行
                form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming&type=7";
                form.submit();
            }
	    }
    }
</script>

</head>
<body>
<form name="form" method="post" enctype="multipart/form-data">
<table>
    <tr>
         <td width="12%" align="right"><fmt:message key='updateFile'/>:</td>
          <td width="20%" align="left">
                <input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
          </td>
    </tr>
    <tr>
        <td align="right"><button value="<fmt:message key='button_upload'/>" onclick="javascript:insert_onClick()" id="import_button">上传</button></td>
        <td align="left"><button onclick="javascript:window.close();"><fmt:message key='button_cancel'/></button></td>
    </tr>
</table>
</form>
</body>
</fmt:bundle>
</html>