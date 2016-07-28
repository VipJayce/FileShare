<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.refundinfo.refundinfo_resource" prefix="rayoo.salary.refundinfo.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='title_xz_xixi1'/></title>
<script type="text/javascript">
jQuery(function(){
	
    _today = new Date();
    $id("w_refund_date").setValue(_today);
    /*
    custId = $id("h_customer_id").value;
    $id("cbs_emp_id").addParam("cust_id",custId);
    $id("cbs_refund_num").addParam("cust_id",custId);*/
});
/*
//选择客服
function rtnFuncCS(arg){
    var lookup = $id("lk_cs");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    return false;
}*/
function addRefund(){
 
    if(!$id("refund_amount").value ){
	    alert("<fmt:message key='alert_isDecimal_null'/>");
	    return;
	}
	if(!isDecimal($id("refund_amount").value)){
	   alert("<fmt:message key='alert_isDecimal'/>");
	   return;
	}
	/*if(!isNumberOrLetter($id("refund_code").value)){
       alert("退票编号必需为数字和字母");
       return;
    }*/
	_param = jQuery("#formAddRefund").serialize();
	jQuery.post("<%=request.getContextPath()%>/RefundInfoAction.do?cmd=addRefund&"+_param,function(data){
           if(data > 0){
            window.returnValue = data;
            window.close();
           }else{
           	alert(data);
           }
    });
	
}
</script>
</head>
<body>
<form id="formAddRefund" action="<%=request.getContextPath()%>/RefundInfoAction.do" method="post">
<input type="hidden" name="cmd" value="addRefund"/>
<!-- 
<input type="hidden" id="h_customer_id" name="customer_id" value='<b:write property="custId" propertyType="parameter"/>'/> 
<input type="hidden" name="customer_code" value='<b:write property="custCode" propertyType="parameter"/>'/> 
<input type="hidden" name="customer_name" value='<b:write property="custName" propertyType="parameter"/>'/>  
 -->
<div class="box_xinzeng_sa">
  <div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" style="font-size:12px;">
      <tbody>
        
        <tr>
          <td class="td_1"><fmt:message key='refund_num_'/>：</td>
          <td class="td_2">
          	<h:text name="refund_num" id="refund_num" validateAttr="type=number;maxLength=19"/>
          </td>
          
          <td class="td_1"><span style="color:red;">*</span><fmt:message key='refund_amount'/>：</td>
          <td class="td_2" >
            <h:text name="refund_amount" id="refund_amount" validateAttr="type=number;allowNull=false;maxLength=18"/>
          </td>
        </tr>
        <tr>
          <td class="td_1"><fmt:message key='refund_name'/>：</td>
          <td class="td_2">
          	<h:text name="refund_name" id="refund_name" validateAttr="maxLength=50"/>
          </td>
          <td class="td_1"><fmt:message key='refund_type'/>：</td>
          <td class="td_2">
	          <select name="refund_type" style="width:160px;">
	            <option value="1"><fmt:message key='refund_type_1'/></option>
	            <option value="0"><fmt:message key='refund_type_0'/></option>
	          </select>
          </td>
        </tr>
        <!-- 
        <tr>
          <td class="td_1"><span style="color:red;">*</span>补发时间：</td>
          <td class="td_2" >
            <w:date allowInput="false" id="w_re_pay_time" name="re_pay_time" format="yyyy-MM-dd"  style="width:140px;"/>
          </td>
         <td class="td_1"><span style="color:red;">*</span>添加日期：</td>
          <td  class="td_2">
            <w:date allowInput="false" id="w_create_date" name="create_date" format="yyyy-MM-dd" style="width:140px;"/>
          </td>
        </tr>
         -->
        <tr><!--
          <td class="td_1"><span style="color:red;">*</span>退票编号：</td>
          <td class="td_2">
            <h:text name="refund_code" id="refund_code" validateAttr="allowNull=false;maxLength=19"/>
          </td>
          -->
          <td class="td_1"><fmt:message key='refund_cause'/>：</td>
          <td class="td_2">
          	<select name="refund_cause">
	          	<option value=""><fmt:message key='please_select'/></option>
	          	<option value="账号户名不符"><fmt:message key='refund_cause_1'/></option>
	          	<option value="账号校验错"><fmt:message key='refund_cause_2'/></option>
	          	<option value="开户行不清"><fmt:message key='refund_cause_3'/></option>
	          	<option value="地区代码错"><fmt:message key='refund_cause_4'/></option>
	          	<option value="他行交易失败"><fmt:message key='refund_cause_5'/></option>
	          	<option value="卡状态不正常"><fmt:message key='refund_cause_6'/></option>
	          	<option value="缓发"><fmt:message key='refund_cause_7'/></option>
	          	<option value="指令处理失败"><fmt:message key='refund_cause_8'/></option>
	          	<option value="账号不存在"><fmt:message key='refund_cause_9'/></option>
	          	<option value="其他错误"><fmt:message key='refund_cause_10'/></option>
	          	<option value="被银行拒绝"><fmt:message key='refund_cause_11'/></option>
	          	<option value="旧账号"><fmt:message key='refund_cause_12'/></option>
          	</select>

          </td>
          <td class="td_1"><fmt:message key='refund_date'/>：</td>
          <td class="td_2" >
            <w:date allowInput="false" id="w_refund_date" name="refund_date" format="yyyy-MM-dd"  style="width:140px;"/>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
  <div class="foot_button">
     <input type="button" onclick="addRefund()" class="foot_icon_1" value="<fmt:message key='button_submit'/>"/>
  </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
