<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.finance.receivable.MyUtils" %>
<%@ page import="java.sql.Timestamp" %>
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
<form name="datacell_formid" method="post" id="datacell_formid"   action="<%=request.getContextPath()%>/SpmonthstatAction.do?cmd=inputMonthStatData" >
<input  name="period_id"  id="period_id"  type="hidden"  value="<%=request.getParameter("period_id") %>"/>
<div id="right">
    <div class="box_xinzeng" style="height: 260px">
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <tr>
    <td class="td_2">请选择数据文件</td>
    <td class="td_2">
               <input type="text" id="attachNameInput" class="text_field_reference_readonly" id="attachNameInput" name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
               <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
               <input type="hidden" id="attackAddressInput" name="attach_address" value="">
    </td>
  </tr>
  <tr>
    <td class="td_2" colspan="2" align="center"><a href="#"  onclick="toDownLoad_onclick();">点击下载模板</a></td>
  </tr>
  </table>
<div class="xz_button">
 <input type="button" name="submitid" id="submitid" class="icon_2"  value="导入" onclick="javascript:insert_submit() ;" /> 
 <input name="button" type="button" class="icon_2" onclick="javascript:closewin() ;" value="关闭" />
</div>
</div>
</form>
</fmt:bundle>
</body>
<script type="text/javascript">
    //关闭窗口
    function closewin(){
        window.close() ;
    }
    //提交验证
   function insert_submit(){
        var attackAddressInput = $id("attackAddressInput").value ;
        if(attackAddressInput == null||attackAddressInput==''){
            alert("请选择要导入的文件！") ;
            return false ;
        }
        var attachNameInput = $id("attachNameInput").value;
        if(attachNameInput.indexOf(".xls")==-1){
            alert("导入文件必须为Excel 文件！") ;
            $id("attachNameInput").value="";
            $id("attackAddressInput").value=""
            return false ;
        }
        document.getElementById("submitid").disabled="false";
        $("datacell_formid").submit() ;
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
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
    
    function toDownLoad_onclick(){
        $id("datacell_formid").action = "<%=request.getContextPath()%>/SpmonthstatAction.do?cmd=downLoadExcel" ;
        $id("datacell_formid").submit();
    }
     //消息
    if (${msg != null } && ${msg != "" }) {
        alert('${msg}');
        document.getElementById("submitid").disabled="true";
        window.close();
    }
</script>

</html>

