<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
   <title>codegen</title>
    <script language="javascript">
   function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="FinbillAction.do?cmd=list2item4approval2">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<div class="xz_title">账单基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1"   width="23%">账单编号</td>
            <td class="td_2 "  width="27%">
                <input type="text" readonly="true"  class="text_field" name="bill_code" id="bill_code" inputName="账单编号"  value="${bean.bill_code}"/>
            </td>
            <td class="td_1"  width="23%">账单年月</td>
            <td class="td_2"  width="27%">
                 <input type="text" readonly="true" class="text_field" name="bill_year_month" id="bill_year_month" inputName="账单年月"   value="${bean.bill_year_month}"/>
            </td>
           
            
        </tr>
        <tr>
          <td class="td_1" > 账单金额</td>
            <td class="td_2"  >
                 <input type="text" readonly="true" class="text_field" name="bill_amount" id="bill_amount" inputName="账单金额"   value="${bean.bill_amount}"/>
            </td>
            <td  class="td_1"  >实收核销金额</td>
            <td  class="td_2" >
            <input type="text" readonly="true" class="text_field" name="verification_amount" id="verification_amount" inputName="实收核销金额"   value="${bean.verification_amount}"/>
            </td>
        </tr>
        <tr>
             <td  class="td_1"   >客户唯一号</td>
            <td  class="td_2 "  >
              <input type="text" readonly="true" class="text_field" name="cust_code" id="cust_code" inputName="客户唯一号"   value="${bean.cust_code}"/>
            </td>
            <td  class="td_1"  >客户名称</td>
            <td  class="td_2" >
                <input type="text" class="text_field" readonly="true" name="cust_name" id="cust_name" inputName="客户名称"   value="${bean.cust_name}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >成本中心名称</td>
            <td class="td_2 " >
                <input type="text" readonly="true"  class="text_field" name="cost_center_name" id="cost_center_name" inputName="成本中心名称"   value="${bean.cost_center_name}"/>
            </td>
            <td class="td_1" >合同编码</td>
            <td class="td_2"  >
                 <input type="text" readonly="true" class="text_field" name="contract_code" id="contract_code" inputName="合同编码"   value="${bean.contract_code}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"   >合同名称</td>
            <td class="td_2 " width="28%">
                <input type="text" readonly="true"  class="text_field" name="contract_name" id="contract_name" inputName="合同名称"    value="${bean.contract_name}"/>
            </td>
            <td class="td_1" >付款日期</td>
            <td class="td_2"  >
                 <input type="text" readonly="true" class="text_field" name="paymentdate" id="paymentdate" inputName="付款日期"   value="${bean.paymentdate}"/>
            </td>
          
       <tr>
            <td class="td_1" >订单编号</td>
            <td class="td_2"  >
                 <input type="text" readonly="true" class="text_field" name="order_code" id="order_code" inputName="订单编号"    value="${bean.order_code}"/>
            </td>
                       <td class="td_1"   >订单名称</td>
            <td class="td_2 " >
                <input type="text" readonly="true"  class="text_field" name="order_name" id="order_name" inputName="订单名称"    value="${bean.order_name}"/>
            </td>
            </tr>
            <tr>
            <td class="td_1"  >实收状态</td>
            <td class="td_2 " colspan="3">
               <d:select dictTypeId="GATHER_STATUS_BD" value="${bean.bill_gather_status_bd}" disabled="true"></d:select>
             
        </tr>
         <tr>
                       <td class="td_1" nowrap="nowrap" >招聘账单公式备注</td>
    
            <td colspan="3" class="td_2" ><textarea style="width: 500px" rows="2" name="formula" inputName="备注" readonly="readonly">${bean.formula}</textarea>
            </td>
           </tr>
             <tr>
            <td class="td_1" >招聘账单备注</td>
        <td colspan="3" class="td_2" ><textarea style="width: 500px" rows="2" name="formula" inputName="备注" readonly="readonly">${bean.remark}</textarea>
             </td>
             </tr>          
    </table>
    <p></p>
</div>
	<div class="xz_title" style="margin-top:10px;">收费项目表</div>
  	 <r:datacell id="celllist1"
			queryAction="/FAERP/FinbillAction.do?cmd=queryBillOther&bill_id=${bean.id}"
			paramFormId="datacell_formid" width="100%" height="150px"
			xpath="BillOthersVo" readonly="true">
			
			<r:field fieldName="charge_item_bd" messagekey="charge_item_bd" width="430px">
				<d:select dictTypeId="CHARGE_ITEM_BD"/>
			</r:field>
			<r:field fieldName="amount" messagekey="amount" width="200px">
			</r:field>
            <r:field fieldName="consultantName" messagekey="consultant_Name" width="200px">
                <h:text />
            </r:field>
			<r:field fieldName="charge_desc" messagekey="charge_desc" width="300px">
				<h:text />
			</r:field>
			<r:field fieldName="last_update_date" messagekey="last_update_date" width="200px">
				<w:date format="yyyy-MM-dd"/>
			</r:field>
		</r:datacell>
	
</div>
</div>
<div class="mx_button" align="center">
        <input type="button" class="icon_2" value="关闭"  onClick="javascript:cancel_onClick()"/>
   </div>
</form>
</fmt:bundle>
</body>
</html>

 
