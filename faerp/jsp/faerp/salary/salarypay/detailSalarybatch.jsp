<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>查看详细</title>
</head>
<body>
<form name="form1" action="" method="post"> 
<div class="box_xinzeng">
  <div><strong>客户信息</strong></div>
  <div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
      <tbody>
        <tr>
          <td width="13%" class="td_1"> 客户编号：</td>
          <td width="35%" class="td_2"><b:write property="bean/customer_code"/></td>
          <td width="10%" class="td_1">应到账日：</td>
          <td width="42%" class="td_2"><b:write property="bean/must_day"/></td>
          </tr>
        <tr>
          <td class="td_1">客户名称：</td>
          <td class="td_2"><b:write property="bean/customer_name"/></td>
          <td class="td_1">工资单类型：</td>
          <td class="td_2"><d:select dictTypeId="PAYROLL_TYPE_BD"/></td>
          </tr>
        <tr>
          <td class="td_1">批次号：</td>
          <td class="td_2"><b:write property="bean/sa_batch_code"/></td>
          <td class="td_2">&nbsp;</td>
          <td class="td_2">&nbsp;</td>
        </tr>
        </tbody>
    </table>
    <div><strong>工资申请审核信息</strong></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
      <tbody>
        <tr>
          <td width="13%" class="td_1">申请时间：</td><!-- 提交审核时间 -->
          <td width="35%" class="td_2"><b:write property="bean/submit_time"/></td>
          <td width="10%" class="td_1">审核通过时间：</td><!-- 确认时间 -->
          <td width="42%" class="td_2"><b:write property="bean/verify_time"/></td>
        </tr>
        <tr>
          <td class="td_1">审核情况：</td>
          <td class="td_2">
               <d:select dictTypeId="AUDIT_STATE"/>
          </td>
          <td class="td_1">审核人：</td>
          <td class="td_2"><b:write property="bean/submit_user"/></td>
          <!--<td class="td_1">认领时间：</td>
          <td class="td_2"><b:write property="bean/claim_date"/></td>-->
        </tr>
      </tbody>
    </table>
    <div><strong>申请信息</strong></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
      <tbody>
        <tr>
          <td width="13%" class="td_1">到款编号：</td>
          <td width="35%" class="td_2"><b:write property="bean/gen_money_code"/></td>
          <td width="10%" class="td_1">申请发放日期：</td>
          <td width="42%" class="td_2"><b:write property="bean/apply_pay_date"/></td>
        </tr>
        <tr>
          <td class="td_1">申请工资发放类型：</td>
          <td class="td_2">
            <h:select property="pay_salary_type">
                       <h:option value="1" label="无到款编号"></h:option>
                       <h:option value="0" label="有到款编号"></h:option>
             </h:select>
          </td>
          <td class="td_1">无到款编号原因：</td>
          <td class="td_2">
            <d:select dictTypeId="NOT_CODE_REASON"/>
          </td>
        </tr>
      </tbody>
    </table>
    <div><strong>审核发放工资</strong></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
      <tbody>
        <tr>
          <td width="13%" class="td_1">实际发放日：</td>
          <td width="35%" class="td_2"><b:write property="bean/real_pay_day"/></td>
          <td width="10%" class="td_1">工行本行：</td>
          <td width="42%" class="td_2"><b:write property="bean/icbc_number"/></td>
        </tr>
        <tr>
          <td class="td_1">实发工资总额：</td>
          <td class="td_2"><b:write property="bean/total_amount"/></td>
          <td class="td_1">招行本行：</td>
          <td class="td_2"><b:write property="bean/cmb_number"/></td>
        </tr>
        <tr>
          <td class="td_1">实发工资人数：</td>
          <td class="td_2"><b:write property="bean/total_number"/></td>
          <td class="td_1">招行它行：</td>
          <td class="td_2"><b:write property="bean/cmb_other_number"/></td>
        </tr>
        <tr>
          <td class="td_1">工资单情况：</td>
          <td class="td_2"><d:select dictTypeId="PAYROLL_STATE_BD"/></td>
          <td class="td_1">无生成：</td>
          <td class="td_2"><b:write property="bean/fail_number"/></td>
        </tr>
        <tr>
          <td class="td_1">审核情况：</td>
          <td class="td_2"><d:select dictTypeId="AUDIT_STATE"/></td>
          <td class="td_1">&nbsp;</td>
          <td class="td_2">&nbsp;</td>
        </tr>
      </tbody>
    </table>
    </div>
</div>
</form>
</body>
</html>
