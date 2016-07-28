<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=inputHealth" onsubmit="return insert_submit() ;">
<div id="right">
	<div class="box_xinzeng">
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
  <tr>
    <td class="td_1" width="50%">请选择数据文件</td>
    <td class="td_2" width="50%">
               <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
               <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
               <input type="hidden" id="attackAddressInput" name="attach_address" value="">
    </td>
  </tr>
  <tr>
    <td class="td_1" width="50%">下载模板</td>
    <td class="td_2" width="50%">
    <a onclick="toDownLoad_onclick()" href="#">点击下载模板</a>
    </td>
  </tr>
  </table>
<div class="xz_button">
 <input type="button" name="submitid" id="submitid" class="icon_2" onclick="return toinput() ;"  value="导入" /> 
 <input name="button" type="button" class="icon_2" onclick="javascript:closewin() ;" value="关闭" />
</div>
</div>
</form>
</fmt:bundle>
</body>
<script type="text/javascript"><!--
    //关闭窗口
    function closewin(){
        window.close() ;
    }
    //提交验证
   function insert_submit(){
        var attackAddressInput = $id("attackAddressInput").value ;
        if(attackAddressInput == null||attackAddressInput==''){
            alert("请重新导入文件，导入失败") ;
            return false ;
        }
        return true ;
   }
    
        //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/insurance/health/sscheckuphealth/attachUploadFrame.jsp','newwindow', s);
    }
    
    //消息
    if (${msg != null } && ${msg != "" }) {
        alert('${msg}');
    }
    function toDownLoad_onclick(){
          window.location="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=downLoad&inputtype=1" ;
    }
    
    
    function toinput(){
         if(getConfirm()) {  //如果用户在确认对话框中点"取消"
                var attach_address = $id("attackAddressInput").value ;
                if(attach_address == null){
                    alert("请选择文件导入") ;
                    return false ;
                }else {
                    var url="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=inputHealth&attach_address="+encodeURI(attach_address);
	                  jQuery.ajax({
	                   url: url,
	                  type: 'post',
	                  dataType: 'html',
	                  timeout: 80000,
	                  error: function(){
	                      alert('系统错误，请联系管理员');
	                  },
	                  success: function(text){
	                     alert(text);
	                     $id("attackAddressInput").value ="" ;
	                     $id("attachNameInput").value ="" ;
	                  }
	                  });
	                   
                }
                }
                
    }
</script>

</html>

