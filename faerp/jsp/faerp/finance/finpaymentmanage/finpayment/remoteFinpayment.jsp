<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.finance.payment.finpayment.vo.FinpaymentVo"%>
<%@ page import="rayoo.finance.payment.finpayment.util.IFinpaymentConstants"%>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
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
<fmt:bundle basename="rayoo.finance.finpaymentmanage.finpayment.finpayment_resource" prefix="rayoo.finance.finpaymentmanage.finpayment.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    var payment_month=$id("payment_month").value;
        var payment_type_bd=$id("payment_type_bd").value;
		   if(checkAllForms()){
		   var url="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=checkData&payment_month="+payment_month+"&payment_type_bd="+payment_type_bd+"&date="+new Date();
		   var flags=checkData(url); 
			   if(flags){
			           form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=remoteInsert";
			           form.submit();
			           return true ;
			   }
			}
	}
  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinpaymentAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    
    function checkData(url){
                           var flags=true;
                                jQuery.ajax({
                                url: url,
                                type: 'GET',
                                dataType: 'html',
                                async: false,
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                            if(text=="false"){
                                               alert("<fmt:message key='alert_date_exist'/>");
                                               flags=false;
                                            }
                                    }
                                }
                                });
                                return flags;
}
</script>
	</head>
	<body>
	<form name="form" method="post">
	<div id="right"><script language="javascript">
        writeTableTopFesco("<fmt:message key='page_remotefinpayment'/>",'<%=request.getContextPath()%>/');
</script> 
<script type="text/javascript">
function view_onClick(){
        var payment_month=$id("payment_month").value;
        var bill_source_bd=$id("payment_type_bd").value;
        //alert(payment_month);
        if(payment_month==null||payment_month==""){
            alert("<fmt:message key='alert_payment_month'/>");
            return;
        }
        var url="<%=request.getContextPath()%>/jsp/faerp/finance/finpaymentmanage/finpayment/remoteCostDetails.jsp?payment_month=" + payment_month+"&bill_source_bd="+bill_source_bd;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, retfun, 770,390, "<fmt:message key='page_remotefinpayment_detail'/>");  //增加子岗位
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
			<td class="td_1"><fmt:message key='apply_user_name'/></td>
			<td class="td_2"><input type="text" style="width:190px"
				class="text_field_reference_readonly" validators="isSearch"
				hiddenInputId="product_supplier" name="apply_user_name"
				inputName="申请人" maxLength="10"
				value="<%=LoginHelper.getLoginName(request)%>" /></td>
				    <td class="td_1"><fmt:message key='apply_date'/></td>
				    <td class="td_2"><w:date name="apply_date" format="yyyy-MM-dd" width="170px"/>                    </td>
				    <input type="hidden" name="apply_user_id" id="apply_user_id" value="<%=LoginHelper.getPartyId(request)%>">
			<td class="td_1"><fmt:message key='payment_type_bd'/></td>
		<td class="td_2"><d:select dictTypeId="PAYMENT_TYPE_BD" property="payment_type_bd"  id="payment_type_bd" filterOp="in" filterStr="7,8" value="7" style="width:190px" nullLabel="--请选择--"/>            </tr>
		<tr>
		  <td class="td_1"><fmt:message key='payment_month'/></td>
		  <td class="td_2"><input name="payment_month" inputName="支付年月"
				type="text" class="sText" id="payment_month" value="" /></td>
			<td class="td_1"><fmt:message key='receiver_type_bd'/></td>
			<td class="td_2"><d:select dictTypeId="RECEIVER_TYPE_BD" property="receiver_type_bd"  id="receiver_type_bd" style="width:190px" nullLabel="--请选择--"/>            </td>
			<td class="td_1"><fmt:message key='receiver_name'/></td>
			<td class="td_2"><input name="receiver_name" inputName="受款方"
				type="text" class="sText" id="receiver_name" value="" /></td>
		</tr>
		<tr>
		  <td class="td_1"><fmt:message key='apply_amount'/></td>
		  <td class="td_2"><input name="apply_amount" inputName="申请支付金额"
				type="text" class="sText" id="apply_amount" value="" maxLength="8" readonly="readonly" onKeyUp="if(isNaN(value))execCommand('undo')" validate="notNull;"/></td>
			<td class="td_2"><input type="button" class="icon_3"   <au:authorityBtn code="ydfyzf_ckydfy"  type="1"/> value="<fmt:message key='page_remotefinpayment_detail'/>" onClick="javascript:view_onClick()" /></td>
			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
		</tr>
        <tr>
            <td class="td_1"><fmt:message key='payment_purpose'/></td>
            <td colspan="5" class="td_2"><textarea name="payment_purpose"
                inputName="付款用途" rows="3" class="xText_d" id="payment_purpose"></textarea></td>
        </tr>
		<tr>
			<td class="td_1"><fmt:message key='payment_reason'/></td>
			<td colspan="5" class="td_2"><textarea name="payment_reason"
				inputName="付款原因" rows="3" class="xText_d" id="payment_reason"></textarea></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key='payment_desc'/></td>
			<td colspan="5" class="td_2"><textarea name="payment_desc"
				inputName="备注" rows="3" class="xText_d" id="payment_desc"></textarea></td>
		</tr>
	</table>
	<div class="mx_button">
	<input type="button" class="icon_2" value="<fmt:message key='button_save'/>" <au:authorityBtn code="ydfyzf_save" type="1"/>  onClick="javascript:insert_onClick()" /></div>
	</div>
	</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>


