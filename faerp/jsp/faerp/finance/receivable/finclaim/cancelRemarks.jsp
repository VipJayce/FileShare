<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
jQuery(function(_$){
    _$("#btn_cancel").click(function(){
        _$("#btn_cancel").attr("disabled", true);
        var remarks = _$("#cancel_remarks").val();//取消原因
        var incomingid =  _$("#incomingid").val();//到款id
        var claim_id =  _$("#claim_id").val();//认领id
        var verification_id =  _$("#verification_id").val();//核销id
        
        if(remarks==null || remarks==""){
            alert("请输入取消原因");
            _$("#cancel_remarks").focus();
            _$("#btn_cancel").attr("disabled", false);
            return;
        }
        
        //ajax 发起审批流程
        _$.ajax({
           type : "post",
           url : "<%=request.getContextPath()%>/FinclaimAction.do?cmd=startApproval&incomingid=" + incomingid+"&claim_id="+claim_id+"&verification_id="+verification_id+"&remarks="+encodeURI(remarks),
           dataType : "html",
           success : function(data) {
                                   alert(data);
                                   window.close();
                            } 
           });
        
        /**var arr = new Array();
        arr[0] = batchId;
        arr[1] = remarks;
        window['returnValue'] =  arr;**/
    });
});
</script>
<body>
<div class="box_xinzeng" style="margin:0px;height:250px;" >
  <input type="hidden" id="incomingid" value="${incomingid}" />
  <input type="hidden" id="claim_id" value="${claim_id}" />
  <input type="hidden" id="verification_id" value="${verification_id}" />
  <div style="margin-top:20px;">
    <p style="font-size: 12px;font-family: Tahoma,Arial,Helvetica,sans-serif;text-align: center;height: 20px;">点击提交后将发起"取消认领"审批流程</p>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
      <tr>
        <td class="td_1" style="width: 26%;font-size: 12px;font-family: Tahoma,Arial,Helvetica,sans-serif;text-align: center;"><span class="style_required_red">* </span>取消原因</td>
        <td class="td_2"><textarea id="cancel_remarks" name="cancel_remarks" rows="2" class="xText_d" style="width:300px;height:120px;"></textarea></td>
      </tr>
  </table>
    <div class="foot_button" style="margin-top:10px;">
      <input id="btn_cancel" type="button" class="foot_icon_1" value="提交"/>
    </div>
  </div>
</div>
</body>
</html>
