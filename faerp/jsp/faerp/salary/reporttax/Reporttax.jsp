<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<html>
<fmt:bundle basename="rayoo.salary.reporttax.reporttax_resource" prefix="rayoo.salary.reporttax.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
function submit_onclick(){
	var reimburse_amount = $id("reimburse_amount").value ;
	if(reimburse_amount<=0){
		alert("<fmt:message key='alert_reimburse_amount'/>");
		return false;
	}
	if(reimburse_amount == ''){
	   alert("<fmt:message key='alert_reimburse_amount_null'/>") ;
	   return false ;
	}
    var payment_month = $id("payment_month").value ;
	if(payment_month == ''){
	   alert("<fmt:message key='alert_payment_month_null'/>") ;
	   return false ;
	}
    var apply_user_name = $id("apply_user_name").value ;
	if(apply_user_name == ''){
	   alert("<fmt:message key='alert_apply_user_name_null'/>") ;
	   return false ;
	}
    var receiver_type_bd = $id("receiver_type_bd").value ;
	if(receiver_type_bd == ''){
	   alert("<fmt:message key='alert_receiver_type_bd_null'/>") ;
	   return false ;
	}
    var receiver_name = $id("receiver_name").value ;
	if(receiver_name == ''){
	   alert("<fmt:message key='alert_receiver_name_null'/>") ;
	   return false ;
	}
    var payment_type_bd = $id("payment_type_bd").value ;
	if(payment_type_bd == ''){
	   alert("<fmt:message key='alert_payment_type_bd_null'/>") ;
	   return false ;
	}
    var invoice_num = $id("invoice_num").value ;
	if(invoice_num == ''){
	   alert("<fmt:message key='alert_invoice_num_null'/>") ;
	   return false ;
	}
    
    var apply_amount = $id("apply_amount").value ;
	if(apply_amount == ''){
	   alert("<fmt:message key='alert_apply_amount_null'/>") ;
	   return false ;
	}
    var payment_purpose = $id("payment_purpose").value ;
	if(payment_purpose == ''){
	   alert("<fmt:message key='alert_payment_purpose_null'/>") ;
	   return false ;
	}
	var param = "&" + jQuery("#paymentformid").serialize();
	showProgressBar();
	jQuery.post("<%=request.getContextPath()%>/ReporttaxAction.do?cmd=createFinPayment"+param,function(data){
           if(data && data.length > 0){
           	hideProgressBar();
            alert("<fmt:message key='alert_apply_success'/>");
            window.close() ;
           }else{
           	hideProgressBar();
           	alert("<fmt:message key='alert_apply_fail'/>");
           	window.close() ;
           }
    });
	
}

</script>
</head>
<body>
<form action="<%=request.getContextPath()%>/ReporttaxAction.do?cmd=createFinPayment" id="paymentformid" method="post">
<input type="hidden" name="tax_flag" id="tax_flag" value="${tax_flag}"/>
<div id="right" class="search"> 
<div class="box_xinzeng">
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
  <tr>
    <td class="td_1"><span style="color: red">*</span><fmt:message key='payment_month'/></td>
    <td class="td_2"><input type="text" value="${tax_month}" class="xText" id="payment_month" name="payment_month"/></td>
    <td class="td_1"><fmt:message key='apply_user'/></td>
    <td class="td_2">
    <input type="text" value="<%=LoginHelper.getLoginName(request)%>" class="xText" name="apply_user_name" id="apply_user_name" readonly/>
    <input type="hidden" value="<%=LoginHelper.getPartyId(request)%>" class="xText" name="apply_user_id" id="apply_user_id"/>
    </td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='receiver_type_bd'/></td>
    <td class="td_2">
    <d:select dictTypeId="RECEIVER_TYPE_BD" name="receiver_type_bd" id="receiver_type_bd" value="4" style="width:190px" />
    </td>
    <td class="td_2">&nbsp;</td>
    <td class="td_2">&nbsp;</td>
  </tr>
  <tr>
    <td class="td_1"><span style="color: red">*</span><fmt:message key='receiver_name'/></td>
    <td colspan="3" class="td_2"><input class="xText" name="receiver_name" id="receiver_name" value="税局"/></td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='payment_type_bd'/></td>
    <td class="td_2">
    <d:select dictTypeId="PAYMENT_TYPE_BD" name="payment_type_bd" disabled="true" value="5" id="payment_type_bd" style="width:190px" />
    </td>
    <td class="td_1"><span style="color: red">*</span><fmt:message key='invoice_num'/></td>
    <td class="td_2"><input type="text" class="xText" id="invoice_num" name="invoice_num" value="1"/></td>
  </tr>
  <tr>
    <td class="td_1"><fmt:message key='reimburse_amount'/></td>
    <td class="td_2"><input type="text" value="${tax}" class="xText" id="reimburse_amount" name="reimburse_amount" readonly/></td>
    <td class="td_1"><span style="color: red">*</span><fmt:message key='apply_amount'/></td>
    <td class="td_2"><input type="text" class="xText" id="apply_amount" name="apply_amount" value="${tax}"/></td>
  </tr>
  <tr>
    <td class="td_1"><span style="color: red">*</span><fmt:message key='payment_purpose'/></td>
    <td colspan="3" class="td_2"><textarea name="payment_purpose" rows="3" class="xText_d" id="payment_purpose">代扣税金</textarea></td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='payment_reason'/></td>
    <td colspan="3" class="td_2"><textarea name="payment_reason" rows="3" class="xText_d" id="payment_reason"></textarea></td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key='payment_desc'/></td>
    <td colspan="3" class="td_2"><textarea name="payment_desc" rows="3" class="xText_d" id="payment_desc"></textarea></td>
  </tr>
  <tr>
    <td colspan="4" class="td_2"><div class="foot_button">
      <input type="button" class="icon_3" value="<fmt:message key='button_jfsh'/>" onclick="return submit_onclick();"/>

      <!--表格 end-->
    </div></td>
    </tr>
  </table>
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
