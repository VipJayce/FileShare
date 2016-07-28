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
    <title>延后报税申请</title>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
<div id="right">
    <div class="ringht_s">
     <div class="social_tab">
         <div class="box_3">
           <input type="hidden" id="custId" name="custId" value="${customerVo.id}"  />
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1">客户编号</td>
               <td class="td_2">${customerVo.customer_code}</td>
               <td class="td_1">客户名称</td>
               <td class="td_2">${customerVo.customer_name}</td>
              </tr>
             <tr>
               <td class="td_1"><span class="style_required_red">* </span>工资发放日</td>
               <td class="td_2"><input name="pay_day" type="text" class="text_field" id="pay_day" value="" /></td>
               <td class="td_1"><span class="style_required_red">* </span>报税延后原因</td>
               <td class="td_2">
                   <textarea id="apply_reason" style="width:250px; height:80px;" class="xText_d" rows="3" name="apply_reason"></textarea>
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
    var custId = _$("#custId").val();
    var pay_day = _$("#pay_day").val();
    var apply_reason = _$("#apply_reason").val();
    if(pay_day == null || pay_day ==""){
        alert("请输入工资发放日");
        return;
    }
    if(apply_reason == null || apply_reason ==""){
        alert("请输入报税延后原因");
        return;
    }
    
    var param = jQuery("#datacell_formid").serialize();
    var _url = "<%=request.getContextPath()%>/SalaryclassAction.do?cmd=startTaxDelayApply&_ts="+(new Date()).getTime(); 
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