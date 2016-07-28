<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<%@page import="rayoo.salary.salarybatch.vo.SalarybatchVo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salarybatch.salarybatch_resource" prefix="rayoo.salary.salarybatch.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='title_salarybatch_detail'/></title>
</head>
<body>
<form name="form1" action="" method="post"> 
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
          <td class="td_1"><fmt:message key='customer_code'/>：</td>
          <td class="td_2"><b:write property="bean/customer_name"/></td>
          <td class="td_1"><fmt:message key='payroll_type_bd'/>：</td>
          <td class="td_2"><d:select property="bean/payroll_type_bd" dictTypeId="PAYROLL_TYPE_BD" disabled="true"/></td>
          </tr>
        <tr>
          <td class="td_1"><fmt:message key='sa_batch_code'/>：</td>
          <td class="td_2"><b:write property="bean/sa_batch_code"/></td>
          <td class="td_2">&nbsp;</td>
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
          <td class="td_1"><fmt:message key='submit_user'/>：</td>
          <td class="td_2"><b:write property="bean/submit_user"/></td>
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
          <td width="35%" class="td_2"><b:write property="bean/gen_money_code"/></td>
          <td width="10%" class="td_1"><fmt:message key='apply_pay_date'/>：</td>
          <td width="42%" class="td_2"><b:write property="bean/apply_pay_date"/></td>
        </tr>
        <tr>
          <td class="td_1"><fmt:message key='pay_salary_type'/>：</td>
          <td class="td_2">
            <h:select property="bean/pay_salary_type" disabled="true" >
                       <h:option value="1" label="未到款"></h:option>
                       <h:option value="0" label="已到款"></h:option>
                        <h:option value="2" label="固定垫付"></h:option>
             </h:select>
          </td>
          <%
          SalarybatchVo bean=(SalarybatchVo)request.getAttribute("bean");
          String pay_salary_type=bean.getPay_salary_type();
          if(pay_salary_type!=null&&pay_salary_type.equals("1")){ 
          %>
          <td class="td_1"><fmt:message key='not_code_reason'/>：</td>
          <td class="td_2">
            <d:select property="bean/not_code_reason" dictTypeId="NOT_CODE_REASON" disabled="true"/>
          </td>
          <%}else{%>
          <td class="td_1">&nbsp;</td>
          <td class="td_2">&nbsp;</td>
          <%}%>
        </tr>
      </tbody>
    </table>
    <div><strong><fmt:message key='audit_applyPay'/></strong></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2" style="font-size:12px;">
      <tbody>
        <tr>
          <td width="13%" class="td_1"><fmt:message key='real_pay_day'/>：</td>
          <td width="35%" class="td_2"><b:write property="bean/real_pay_day"/></td>
          <td width="10%" class="td_1"><fmt:message key='icbc_number'/>：</td>
          <td width="42%" class="td_2"><b:write property="bean/icbc_number" formatPattern="##,###,###.00" /></td>
        </tr>
        <tr>
          <td class="td_1"><fmt:message key='total_amount'/>：</td>
          <td class="td_2"><b:write property="bean/total_amount"  formatPattern="##,###,###.##" /></td>
          <td class="td_1"><fmt:message key='cmb_number'/>：</td>
          <td class="td_2"><b:write property="bean/cmb_number" formatPattern="##,###,###.##" /></td>
        </tr>
        <tr>
          <td class="td_1"><fmt:message key='total_number'/>：</td>
          <td class="td_2"><b:write property="bean/total_number"  /></td>
          <td class="td_1"><fmt:message key='cmb_other_number'/>：</td>
          <td class="td_2"><b:write property="bean/cmb_other_number" formatPattern="##,###,###.##"/></td>
        </tr>
        <tr>
          <td class="td_1"><fmt:message key='payroll_state_bd'/>：</td>
          <td class="td_2"><d:select property="bean/payroll_state_bd" dictTypeId="PAYROLL_STATE_BD" disabled="true"/></td>
          <td class="td_1"><fmt:message key='fail_number'/>：</td>
          <td class="td_2"><b:write property="bean/fail_number" formatPattern="##,###,###.##" /></td>
        </tr>
      </tbody>
    </table>
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
