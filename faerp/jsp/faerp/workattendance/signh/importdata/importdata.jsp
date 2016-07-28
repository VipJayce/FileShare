<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据导入</title>
<script language="javascript">
	 function insert_onClick(){  //插入单条数据
	     var file1=document.form.file1.value.trim();
	     file1=file1.substring(file1.lastIndexOf(".")+1);
	     if(file1 == null || file1 == ""){
	         alert("上传文件不能为空！");
	         return;
	     }
	     if(checkAllForms()){
	        form.action="<%=request.getContextPath()%>/ImportdataAction.do?cmd=importData";
	        form.submit();
	     }
    }
    
    function winclose(){
        window.close() ;
    }
</script>
</head>
<body>
<form name="form" method="post" enctype="multipart/form-data" >
<div id="right">
    <div class="right_title_bg"><div class=" right_title"></div></div>
    <div class="ringht_x">
        <div class="box_xinzeng" style="height:420px">
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1">文件选择</td>
            <td class="td_2">
            	<input type="file" id="fileInput" name="file1"  validate="notNull;"  inputName="导入文件"  >
            </td>
          </tr>
          </table>
     <div style = "text-align: center;">
        <input type="button" class="icon_2" value="导入" onclick="javascript:insert_onClick();"/>
        <input type="button" class="icon_2" value="关闭" onclick="javascript:winclose() ;"/>
     </div>
    </div>
    </div>
</div>
</form>
</body>
</html>
