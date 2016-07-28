<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%
    //判断是否为修改页面
    FinpaymentVo resultVo = null; //定义一个临时的vo变量
    boolean isModify = false; //定义变量,标识本页面是否修改(或者新增)
    if (request.getParameter("isModify") != null) { //如果从request获得参数"isModify"不为空
        isModify = true; //赋值isModify为true
        if (request.getAttribute(IFinpaymentConstants.REQUEST_BEAN) != null) { //如果request中取出的bean不为空
            resultVo = (FinpaymentVo) request
                    .getAttribute(IFinpaymentConstants.REQUEST_BEAN); //从request中取出vo, 赋值给resultVo
        }
    }
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
            //返回待办任务页面
    function backTask_onClick() { //返回到列表页面
        form.action="<%=request.getContextPath()%>/dynamicQueryTaskByPersonIDAction.do?done=false";
        form.submit();
    }
    //审批操作
    function appOperate_onClick(){
      var message =addAppReason("<%=request.getContextPath()%>");
      if(message==null)return;
        form.action="<venus:base/>/AgentFinBillTwoAction.do?message="+message[0];
        document.getElementById("cmd").value="appOperate";
        form.submit();
         
    }
    
    //驳回操作
    function backOperate_onClick(){
        //驳回原因
        var message =addBackReason("<%=request.getContextPath()%>");
        if(message==null)return;
        form.action="<venus:base/>/AgentFinBillTwoAction.do?message="+message[0];
        document.getElementById("cmd").value="backOperate";
        form.submit();
    }
</script>
	</head>
	<body>
	<form name="form" method="post">
    <input type="hidden" name="taskuid" value="${taskuid}">
    <input type="hidden" name="cmd">
	<div id="right"><script language="javascript">
        writeTableTopFesco('异地费用支付申请','<%=request.getContextPath()%>/');
</script> 
<script type="text/javascript">
function view_onClick(){
        var payment_month=$id("payment_month").value;
        var bill_source_bd=$id("payment_type_bd").value;
        //alert(payment_month);
        if(payment_month==null||payment_month==""){
            alert("支付年月不能为空！");
            return;
        }
        var url="<%=request.getContextPath()%>/jsp/faerp/finance/finpaymentmanage/finpayment/remoteCostDetails.jsp?payment_month=" + payment_month+"&bill_source_bd="+bill_source_bd;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, retfun, 770,390, "查看异地费用");  //增加子岗位
}

function retfun(arg){
$id("apply_amount").value=arg;
}
</script> 
	<div class="ringht_x">
	<div id="ccChild1" class="box_xinzeng">
	<table width="100%" height="35" border="0" cellpadding="0"
		cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">申请人</td>
			<td class="td_2"><input type="text" style="width:190px"
				class="text_field_reference_readonly" validators="isSearch"
				hiddenInputId="product_supplier" name="apply_user_name"
				inputName="申请人" maxLength="10"
				value="<%=LoginHelper.getLoginName(request)%>" /></td>
				    <td class="td_1">申请日期</td>
				    <td class="td_2"><w:date name="apply_date" format="yyyy-MM-dd" property="bean/apply_date" width="170px"/>                    </td>
				    <input type="hidden" name="apply_user_id" id="apply_user_id" value="<%=LoginHelper.getPartyId(request)%>">
			<td class="td_1">付费类型</td>
		<td class="td_2"><d:select dictTypeId="PAYMENT_TYPE_BD" property="payment_type_bd"  id="payment_type_bd" value="${bean.payment_type_bd}" style="width:190px" nullLabel="--请选择--"/>            </tr>
		<tr>
		  <td class="td_1">支付年月</td>
		  <td class="td_2"><input name="payment_month" inputName="支付年月"
				type="text" class="sText" id="payment_month" value="${bean.payment_month}" /></td>
			<td class="td_1">受款方类型</td>
			<td class="td_2"><d:select dictTypeId="RECEIVER_TYPE_BD" property="receiver_type_bd"  value="${bean.receiver_type_bd}"  id="receiver_type_bd" style="width:190px" nullLabel="--请选择--"/>            </td>
			<td class="td_1">受款方</td>
			<td class="td_2"><input name="receiver_name" inputName="受款方"
				type="text" class="sText" id="receiver_name" value="${bean.receiver_name}" /></td>
		</tr>
		<tr>
		  <td class="td_1">申请支付金额</td>
		  <td class="td_2">
		  <input name="apply_amount" inputName="申请支付金额" value="${bean.apply_amount}"
				type="text" class="sText" id="apply_amount" value="" maxLength="8" readonly="readonly" onKeyUp="if(isNaN(value))execCommand('undo')" validate="notNull;"/></td>
			<td class="td_2">
			</td>
			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
		</tr>
        <tr>
            <td class="td_1">付款用途</td>
            <td colspan="5" class="td_2"><textarea name="payment_purpose"
                inputName="付款用途" rows="3" class="xText_d" id="payment_purpose">${bean.payment_purpose}</textarea></td>
        </tr>
		<tr>
			<td class="td_1">付款原因</td>
			<td colspan="5" class="td_2"><textarea name="payment_reason"
				inputName="付款原因" rows="3" class="xText_d" id="payment_reason">${bean.payment_reason}</textarea></td>
		</tr>
		<tr>
			<td class="td_1">备注</td>
			<td colspan="5" class="td_2"><textarea name="payment_desc"
				inputName="备注" rows="3" class="xText_d" id="payment_desc">${bean.payment_desc}</textarea></td>
		</tr>
	</table>
			<div class="foot_button">
	        <input name="button_back" class="foot_icon_2" type="button" value="返回"  onclick="javascript:backTask_onClick();" >
	        <input name="button_app" class="foot_icon_2" type="button" value="审批"  onclick="javascript:appOperate_onClick();" >
	        <input name="button_back" class="foot_icon_2" type="button" value="驳回"  onclick="javascript:backOperate_onClick();" >
	      </div>
      
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>


