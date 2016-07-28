<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>无标题文档</title>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
<div id="right">
    <div class="ringht_s">
     <div class="social_tab">
         <div class="box_3">
           <input type="hidden" id="bill_id" name="bill_id" value="${param.bill_id}"  />
           <input type="hidden" id="type" name="type" value="${param.type}"  />
           <table width="100%" height="140px" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1" style="width: 30%"><span class="style_required_red">* </span>申请原因</td>
               <td class="td_2">
                   <textarea id="apply_reason"  class="xText_d" style="height: 120px;" name="apply_reason"></textarea>
               </td>
             </tr>
           </table>
         </div>
     </div>
     </div>
     </div>

      <div class="foot_button">
      <input type="button" value="提交申请" class="foot_icon_2" onclick="subApply();">
      <input type="button" class="foot_icon_1" value="返回"  onclick="javascript:cancelOnClick();" />
      </div>
</form>
</body>
</html>
<script language="javascript">

function cancelOnClick() {
    window.close();
}

//提交申请
function subApply(){
    var apply_reason = _$("#apply_reason").val();
    if(apply_reason == null || apply_reason ==""){
        alert("请输入申请原因！");
        return;
    }
    
    var param = jQuery("#datacell_formid").serialize();
    var _url = "<%=request.getContextPath()%>/FinbillAction.do?cmd=startChangeBillApply&_ts="+(new Date()).getTime(); 
    _$.ajax({
        type : "post",
        url : _url,
        data : param,
        dataType : "html",
        success : function(data) {
                alert(data);
                window.close();
        }
    });
}


</script>