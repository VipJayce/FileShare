<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
 

<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ajax/jquery/dialog/jquery-dialog.css" type="text/css">
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Expires" CONTENT="0"/>    
<meta http-equiv="Cache-Control" CONTENT="no-cache"/>    
<meta http-equiv="Pragma" CONTENT="no-cache"/> 


<title> 上传文件</title>
</head>

<body>
<%
    //时间处理 
    Timestamp time = new Timestamp(System.currentTimeMillis());
    SimpleDateFormat dateformatter = new SimpleDateFormat("yyyy-MM-dd");
    Date currentTime = new Date();//得到当前系统时间
    String nowDate = dateformatter.format(currentTime); //将日期时间格式化
    //登录信息处理
    //LoginSessionVo  loginvo = (LoginSessionVo)session.getAttribute("LOGIN_SESSION_VO");
%>

<form name="form" action="FileUpLoadAction.do?cmd=fileUpload" id="form1" name="form1" encType="multipart/form-data" method="post" target="hidden_frame" >
<input type="hidden" name="pkbill" id="pkbill" value="" />
<div id="ccParent0">
<table class="table_div_control">
	<tr>
		<td>上传文件</td>
		 
	</tr>
</table>
</div>
<div id="ccChild0">
<table class="table_div_content">
	<tr>
		<td>
		<table class="table_noFrame" width="100%">
			<tr>
		 
			<tr>
				<td width="15%" align="right">上传文件</td>
				<td width="35%" align="left">
				<input type="file" id="filename" name="filename">
				<input type="text" class="text_field_reference_readonly" id="fileurl" name="fileurl" inputName="附件路径" value="" /><img id="teamref" class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getref();"/><span id="msg"></span></td>
				<td width="15%" align="right"></td>
				<td width="35%" align="left"></td>
			</tr>
		 
			 
			<tr>
				<td width="15%" align="right"><iframe name='hidden_frame' id="hidden_frame" style='display: none'></iframe></td>
				<td width="35%" align="left"></td>
			</tr>
			<tr>
				<td />
				<td />
				<td />
				<td>
				<td class="button_ellipse"><input name="button_ok" class="button_ellipse" type="button" value="确定" onClick="javascript:submit_onClict();"></td>
				<td class="button_ellipse"><input name="button_cancel" class="button_ellipse" type="button" value="取消" onclick="javascript:window.close();"></td>
				 
			</tr>
		</table>

		</td>
	</tr>
</table>
</div>
</form>
</body>

<script type="text/javascript">   
var jq = jQuery.noConflict();
 jq('#fileurl').hide();
  jq('#teamref').hide();
 
function callback(msg)   
{   
  if(msg.length == 2){
    window.alert("上传失败　：　" + msg[1]);
    window.close();
  }else{
   
    window.returnValue = msg;
    window.close();
    }
 }   
    
function submit_onClict(){

 
          //检验是否选择了文件
	        if(form.filename.value==''){
	          jq.prompt('请选择要上传的文件!');//提示框
	          return;
	        }
    
     // jq("#msg").val("上传中，请稍等......");
      form.submit();
}


function getref()
{
    var returnval = RefTeamAttachments('<venus:base/>');
    
    if(returnval != null&&returnval!='undefined'){
        alert(returnval);
        jq('#fileurl').val(returnval);
    }
}

</script>

</html>