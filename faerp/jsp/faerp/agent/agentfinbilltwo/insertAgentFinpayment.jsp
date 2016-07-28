<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%
    String paymoney = request.getAttribute("paymoney").toString();
    AgentVo avo = (AgentVo) request.getAttribute("agentvo");
    String bill_ids = request.getAttribute("bill_ids").toString();
%>
<%@page import="rayoo.sales.agent.vo.AgentVo"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>供应商账单申请支付</title>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	 if(testDate()){
	var action="<%=request.getContextPath()%>/AgentFinBillTwoAction.do?cmd=insertAgentPayInfo";
	var myAjax = new Ajax(action);
	var form=document.getElementById("form");
	if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
   myAjax.submit();
  var returnNode = myAjax.getResponseXMLDom();
  if(returnNode) {
        if(myAjax.getProperty("returnValue")) {
            alert(myAjax.getValue("root/data/returnValue"));
            window.close();
        } else {
            alert('提交失败');
        }
    } else {
        alert('提交失败');
    }
         }
}

function    testDate(){
      var payment_month = document.form.payment_month.value;
              if(payment_month ==null || payment_month == ""){
           alert("请填写支付年月,如“201203”！");
           document.getElementById("payment_month").focus();
           return false;
        }else{
           if(payment_month.length != 6){
               alert("支付年月必须为6位数字,如“201203”！");
               document.getElementById("payment_month").focus();
               return  false;
           }
           var year = payment_month.substring(0,4);
           var month = payment_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("请正确输入支付年月查，年份在2000~2030之间，月份在01~12之间，如“201203”！");
               document.getElementById("payment_month").focus();
               return false;
           }
        }
       var  apply_date=document.form.apply_date.value;
       if(apply_date==null || apply_date==""){
       alert("请选择申请日期");
       return false;
       }
       return true;
    }


</script>
	</head>
	<body>
	<form name="form" method="post" id="form"><input type="hidden"
		name="bill_ids" id="bill_ids" value="<%=bill_ids %>">
	<div id="right"><script language="javascript">
        writeTableTopFesco('申请支付','<%=request.getContextPath()%>/');
</script>
	<div class="ringht_x">
	<div id="ccChild1" class="box_xinzeng">
	<table width="100%" height="35" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">申请人</td>
			<td class="td_2"><input type="text" style="width: 190px"
				class="text_field_reference_readonly" validators="isSearch"
				hiddenInputId="product_supplier" name="apply_user_name"
				inputName="申请人" maxLength="10"
				value="<%=LoginHelper.getLoginName(request)%>" /></td>
			<input type="hidden" name="apply_user_id" id="apply_user_id"
				value="<%=LoginHelper.getPartyId(request)%>" />
			<td class="td_1">受款方类型</td>
			<td class="td_2"><d:select dictTypeId="RECEIVER_TYPE_BD"
				property="receiver_type_bd" id="receiver_type_bd" value="4"
				style="width:190px" nullLabel="--请选择--" /></td>
			<td class="td_1">受款方</td>
			<td class="td_2"><input name="receiver_name" inputName="受款方"
				type="text" class="sText" id="receiver_name"
				value="<%=avo.getAgent_name() %>" readonly="readonly" /> <input
				id="cust_id" name="cust_id" value="<%=avo.getId()%>" type="hidden">
			</td>
		</tr>
		<tr>
			<td class="td_1"><span class="style_required_red">* </span>支付年月(YYYYMM)</td>
			<td class="td_2"><input name="payment_month" inputName="支付年月"
				type="text" class="sText" id="payment_month" value=""/></td>
			<td class="td_1">付费类型</td>
			<td class="td_2"><d:select dictTypeId="PAYMENT_TYPE_BD"
				property="payment_type_bd" id="payment_type_bd" value="6"
				style="width:190px" nullLabel="--请选择--" />
			<td class="td_1">单据数量</td>
			<td class="td_2"><input name="invoice_num" inputName="单据数量"
				type="text" class="sText" id="invoice_num" value="1" /></td>
		</tr>
		<tr>
			<td class="td_1">支付金额</td>
			<td class="td_2"><input name="apply_amount" inputName="支付金额"
				type="text" class="sText" id="apply_amount" value="<%=paymoney %>"
				maxLength="15" readonly="readonly" /></td>
			<td class="td_1"><span class="style_required_red">* </span>申请日期</td>
			<td class="td_2"><w:date name="apply_date" format="yyyy-MM-dd"
				width="170px" /></td>
			<td class="td_1">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
		</tr>
		<tr>
			<td class="td_1">付款用途</td>
			<td colspan="5" class="td_2"><textarea name="payment_purpose"
				inputName="付款用途" rows="3" class="xText_d" id="payment_purpose"></textarea></td>
		</tr>
		<tr>
			<td class="td_1">付款原因</td>
			<td colspan="5" class="td_2"><textarea name="payment_reason"
				inputName="付款原因" rows="3" class="xText_d" id="payment_reason"></textarea></td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="5" class="td_2"><textarea name="payment_desc"
				inputName="备注" rows="3" class="xText_d" id="payment_desc"></textarea></td>
		</tr>
	</table>
	<div class="mx_button"><input type="button" class="icon_2"
		value='<fmt:message key="save"/>'
		onClick="javascript:insert_onClick()" /> <input type="button"
		class="icon_2" value='<fmt:message key="go_back"/>'
		onClick="javascript:window.close()" /></div>
	</div>

	<input type="hidden" name="id" value=""> <input type="hidden"
		name="create_date" />
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
