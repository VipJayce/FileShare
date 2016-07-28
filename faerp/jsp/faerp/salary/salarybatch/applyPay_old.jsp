<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salarybatch.salarybatch_resource" prefix="rayoo.salary.salarybatch.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='title_salarybatch'/></title>
</head>
<script type="text/javascript">
jQuery(function(){
    //设置16:15时间点
    var timePoint = new Date();
    timePoint.setHours(16);
    timePoint.setMinutes(15);
    timePoint.setSeconds(0);
    
    //给申请发放日期设置默认值
    _now = new Date();
    if(_now.getTime() > timePoint.getTime()){
        _now.setDate(_now.getDate()+1)
        $id("w_apply_pay_date").setValue(_now);
    }else{
        $id("w_apply_pay_date").setValue(_now);
    }
    
    //验证申请发放日期的可修改范围
	$id("w_apply_pay_date").onValidate=function(hiddenValue,TextValue)
	{
	    checkApplyPayDay();
	};
	//提交时验证
	$id("btn_submit").onclick = function(){
	    if(checkApplyPayDay() && checkGenMoneyCode()){
	       param = jQuery("#applyForm").serialize();
	       jQuery.post("<%=request.getContextPath()%>/SalarybatchAction.do?cmd=update&"+param,function(data){
	           if(data > 0){
	               alert("<fmt:message key='alert_applypay_complete'/>");
	               window.close();
	           }else{
	               alert("<fmt:message key='alert_applypay_fail'/>");
	           }
           });
	    }
	};
	//验证申请发放日期
	function checkApplyPayDay(){
	     now = new Date();
	     hiddenValue = $id("w_apply_pay_date").getValue();
	     //当天16:15分前，默认是当天日期，可修改当天后的任意日期；
	     //16:15分后（注：包括16:15）默认为当天＋1天，可修改当天+1天后的任意日期
	     if(now < timePoint){
	        now.setHours(0);
            now.setMinutes(0);
            now.setSeconds(0);
            now.setMilliseconds(0);
	        if(stringToDate(hiddenValue).getTime() < now.getTime()){
	            f_alert($id("w_apply_pay_date").text,"<fmt:message key='alert_w_apply_pay_date'/>");
	            return false;
	        }else{
	             return true;
	        }
	     }else{
	        now.setDate(now.getDate() + 1);
	        now.setHours(0);
	        now.setMinutes(0);
	        now.setSeconds(0);
	        now.setMilliseconds(0);
	        tomorrow = now;
	        if(stringToDate(hiddenValue).getTime() < tomorrow.getTime()){
	            f_alert($id("w_apply_pay_date").text,"<fmt:message key='alert_w_apply_pay_date_1'/>");
	            return false;
	        }else{
	             return true;
	        }
	     }
	};
	//check到款编号
	function checkGenMoneyCode(){
	    type = $id("s_pay_salary_type").value;
	    code = $id("t_gen_money_code").value;
	    if(type == 0 && !code){
	        alert("<fmt:message key='alert_money_code_null'/>");
	        return false;
	    }
	    return true;
	};
	
});


//下拉选项，固定垫付时check
function onkeycheck() {
   var type = document.getElementById("pay_salary_type").value;//固定垫付时校验
   if(type=='2'){
        var code = "${bean.customer_code}";
        if(code!=null&&code!=''){
             jQuery.ajax({
               url: '<%=request.getContextPath()%>/SalarybatchAction.do?cmd=vailCustByCode&code='+code,
               type: 'POST',
               dataType: 'html',
               async: false,
               timeout: 10000,
                   error: function(){
                      alert("<fmt:message key='no_paylater_property'/>");
                      document.getElementById("pay_salary_type").value="1";
                      return;
                   },
                    success: function(data){
                        if(data=='false'){
                           alert("<fmt:message key='no_paylater_property'/>");
                           document.getElementById("pay_salary_type").value="1";
                           return;
                       }
                   }
               });
           }
           }
    }

//上传附件
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

</script>
<body>
<form id="applyForm" action="" method="post">
<h:hidden name="id" property="bean/id"/> 
<div class="box_xinzeng_sa">
  <div><strong><fmt:message key='customer_info'/></strong></div>
  <div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" style="font-size:12px;">
      <tbody>
        <tr>
          <td width="13%" class="td_1"><fmt:message key='customer_code'/>：</td>
          <td width="35%" class="td_2"><b:write property="bean/customer_code"/></td>
          <td width="10%" class="td_1"><fmt:message key='must_day'/>：</td>
          <td width="42%" class="td_2"><b:write property="bean/must_day"/></td>
          </tr>
        <tr>
          <td class="td_1"><fmt:message key='customer_name'/>：</td>
          <td class="td_2"><b:write property="bean/customer_name"/></td>
          <td class="td_1"><fmt:message key='payroll_type_bd'/>：</td>
          <td class="td_2"><d:select property="bean/payroll_type_bd" dictTypeId="PAYROLL_TYPE_BD" disabled="true"/></td>
          </tr>
        <tr>
          <td class="td_1"><fmt:message key='sa_batch_code'/>：</td>
          <td class="td_2"><b:write property="bean/sa_batch_code"/></td>
          <td class="td_1">&nbsp;</td>
          <td class="td_2">&nbsp;</td>
        </tr>
        </tbody>
    </table>
    <div><strong><fmt:message key='batch_audit_state'/></strong></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" style="font-size:12px;">
      <tbody>
        <tr>
          <td width="13%" class="td_1"><fmt:message key='submit_time'/>：</td><!-- 提交审核时间 -->
          <td width="35%" class="td_2"><b:write property="bean/submit_time"/></td>
          <td width="10%" class="td_1"><fmt:message key='verify_time'/>：</td><!-- 确认时间 -->
          <td width="42%" class="td_2"><b:write property="bean/verify_time"/></td>
        </tr>
        <tr>
          <td class="td_1"><fmt:message key='audit_state'/>：</td>
          <td class="td_2">
               <d:select property="bean/audit_state" dictTypeId="AUDIT_STATE" disabled="true"/>
          </td>
          <td class="td_1"><fmt:message key='audit_user_name'/>：</td>
          <td class="td_2"><b:write property="bean/audit_user_name"/></td>
          <!--<td class="td_1">认领时间：</td>
          <td class="td_2"><b:write property="bean/claim_date"/></td>-->
        </tr>
      </tbody>
    </table>
    <div><strong><fmt:message key='audit_info'/></strong></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" style="font-size:12px;">
      <tbody>
        <tr>
          <td width="13%" class="td_1"><fmt:message key='gen_money_code'/>：</td>
          <td width="35%" class="td_2">
            <h:text id="t_gen_money_code" name="gen_money_code" property="bean/gen_money_code"/>
          </td>
          <td width="10%" class="td_1"><span style="color:red;">*</span><fmt:message key='apply_pay_date'/>：</td>
          <td width="42%" class="td_2">
            <w:date allowInput="false" id="w_apply_pay_date" name="apply_pay_date" format="yyyy-MM-dd"/>
          </td>
        </tr>
        <tr>
          <td class="td_1"><span style="color:red;">*</span><fmt:message key='pay_salary_type'/>：</td>
          <td class="td_2">
            <h:select id="s_pay_salary_type" property="pay_salary_type" onchange="onkeycheck();">
                       <h:option value="1" label="无到款编号"></h:option>
                       <h:option value="0" label="有到款编号"></h:option>
                       <h:option  value="2" label="固定垫付"/>
             </h:select>
          </td>
          <td class="td_1"><fmt:message key='not_code_reason'/>：</td>
          <td class="td_2">
            <d:select name="not_code_reason" dictTypeId="NOT_CODE_REASON"/>
          </td>
        </tr>
        <tr>
        <td class="td_1"><fmt:message key='attachName'/>：</td>
        <td class="td_2">
        <input type="text"   value=""   id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"  /><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"  />
        <input type="hidden" id="attackAddressInput" name="attach_address" >
        </td>
         <td class="td_1"><fmt:message key='verification_amount'/>：</td>
          <td class="td_2"><b:write property="bean/verification_amount"/></td>
        </tr>
      </tbody>
    </table>
    </div>
    <div class="foot_button">
      <input id="btn_submit" type="button" class="foot_icon_1" value="<fmt:message key='button_submit'/>"/>
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
