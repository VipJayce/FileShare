<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 

<title>importExcel</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
         var file1=document.form.file1.value.trim();
         file1=file1.substring(file1.lastIndexOf(".")+1);
         if(file1 == null || file1 == ""){
             alert("上传文件不能为空！");
             return;
         }
         if(file1!="xls"){
             alert("类型不正确！");
             return ;
         }
         if(checkAllForms()){
            form.action="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=importExcelForFileFees";
            form.submit();
            form.disabled="disabled";
         }
    }
    
    function openError_onClick()
    {
         var url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/filefeesmanage/errorDesc.jsp";
         showModalCenter(url, window,null,750,400,"查看错误信息");
    }
    
    function toDownLoad_onclick(){
    	window.location="<%=request.getContextPath()%>/FileFeesManageAction.do?cmd=downLoad" ;
	}
</script>
</head>
<body>
<form name="form" method="post"   enctype="multipart/form-data">
<div class="ringht_s">
<div id="ccChild0" class="box_3">
    <%
    System.out.println(request.getAttribute("FileFeesManageError"));
    if(request.getAttribute("FileFeesManageError") != null){
        List filefeesmanageerrorList = (List)request.getAttribute("FileFeesManageError");
        if(filefeesmanageerrorList.size()>0){
        %>
        <center><a style="color: red;" href="#" onClick="javascript:openError_onClick();">导入<%=filefeesmanageerrorList.size() %>处错误，点击查看！</a></center>
        <%
    }}
    %>
<table width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
         <td width="12%" class="td_1">附件上传:</td>
          <td width="20%" class="td_2">
               <input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
          </td>
    </tr>
    <tr>
        <td class="td_2" colspan="2" align="center"><a onclick="toDownLoad_onclick()" href="#" style="color: blue;">点击下载模板</a></td>
    </tr>
</table></div>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='上传'  onclick="javascript:insert_onClick();" />
<input type="button" class="foot_icon_1" value='取消'  onclick="javascript:window.close();" />
</div>
</div>
</form>
</body>
</html>
<script type="text/javascript">
if (${msg != null && msg != '' }){
    alert('${msg }');
}
</script>