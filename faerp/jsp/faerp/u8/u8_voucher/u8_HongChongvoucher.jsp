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
<%@page import="rayoo.u8.vo.VoucherVO"%>
<%@page import="rayoo.finance.receivable.finbill.vo.FinbillVo"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.u8.voucher.voucher_resource" prefix="rayoo.u8.voucher.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key='title_voucher'/></title>
<script type="text/javascript">
jQuery(function(){
    var _date = new Date();
    var _year = _date.getYear();
    var _last_year = _year-1;
    var _month = _date.getMonth()+1;
    //alert(_month);
    jQuery("#fiscal_year").append('<option selected value="'+_year+'">'+_year+'</option>');
    jQuery("#fiscal_year").append('<option value="'+_last_year+'">'+_last_year+'</option>');

    for(var i=1;i<=12;i++){
        if(_month==i){
            jQuery("#accounting_period").append('<option selected value="0'+i+'">'+i+'</option>');
        }else{
            jQuery("#accounting_period").append('<option value="0'+i+'">'+i+'</option>');
        }
    }
    var voucher_status = jQuery("#voucher_status").val();
    //凭证已生成，不让重复生成
    //if(voucher_status==1){
    //       jQuery("#btn_cv").hide();
    //}
});


//生成凭证
function createVoucher(){
	 
    var _p = jQuery("#form_v").serialize();
    showProgressBar();
    jQuery.post("<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=createHongChongVoucher&"+_p,function(data){
           if(data){
               if (data.indexOf("凭证号") > 0)	jQuery("#btnVoucher").attr("disabled", true);
            hideProgressBar();
            alert(data);
           }
    });
}


function closePage(){
    window.close();
}
</script>
</head>
<body style="background-color: #cce8cf ;">
<form id="form_v">
<div class="box_xinzeng" >
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="" style="font-size:12px;">
    <tr>
        <td class="" colspan="3" align="center" style="font-size:32px;font-weight: bold;"><bean:write name="voucher" property="title"/> </td>
    </tr>
    <tr>
            <td class="" style="width:20%;"><bean:write name="voucher" property="voucheHead.voucher_type"/> </td>
        <td style="width:10%;">

        </td>

        <td class="" style="width:20%;" align="right"><fmt:message key='voucheHead_date'/>：</td>
        <td class="" style="width:30%;" align="left">
        <w:date format="yyyy-MM-dd" id="date" name="date" width="70px"  property="voucher/voucheHead/date"/>
         </td>
        <td style="width:20%;">

        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="" style="font-size:12px;">
    <tr>
        <td class="td_2" align="center"><fmt:message key='abstract_demo'/></td>
        <td class="td_2" align="center"><fmt:message key='u8_cust_name'/></td>
        <td class="td_2" align="center"><fmt:message key='account_name'/></td>
        <td class="td_2" align="center"><fmt:message key='natural_debit'/></td>
        <td class="td_2" align="center"><fmt:message key='natural_credit'/></td>
    </tr>
    <logic:iterate id="subj" name="voucher" property="voucherBodyList">
        <tr>
            <td class="td_2"><bean:write name="subj" property="abstract_demo"/></td>
            <td class="td_2"><bean:write name="subj" property="u8_cust_name"/></td>
            <td class="td_2"><bean:write name="subj" property="account_name"/></td>
            <td class="td_2" align="right"><bean:write name="subj" property="natural_debit"/></td>
            <td class="td_2" align="right"><bean:write name="subj" property="natural_credit"/></td>
        </tr>
    </logic:iterate>


    <!--<tr>
        <td class="td_2"></td>
        <td class="td_2"></td>
        <td class="td_2" align="right"></td>
        <td class="td_2" align="right"></td>
    </tr>-->

    <tr>
        <td class="td_2" colspan="3" align="right"><fmt:message key='sum'/></td>
        <td class="td_2" align="right"><bean:write name="bill" property="bill_amount"/> </td>
        <td class="td_2" align="right"><bean:write name="bill" property="bill_amount"/> </td>
    </tr>
</table>

<div class="xz_button">

<input type="hidden" name="vtype" id="vtype" value='<bean:write name="voucher" property="voucheHead.voucher_type"/>'/>
<input type="hidden" name="vtitle" id="vtitle" value='<bean:write name="voucher" property="title"/>'/>
<input type="hidden" name="bill_id" id="bill_id" value='<bean:write name="bill" property="id"/>'/>
<input type="hidden" name="voucher_status" id="voucher_status" value='<bean:write name="bill" property="is_createvoucher"/>'/>
<%
VoucherVO  voucher =(VoucherVO)request.getAttribute("voucher");
FinbillVo   billvo=(FinbillVo)request.getAttribute("bill");
if( billvo.getVoucher_status().equals("1") && (billvo.getIs_createvoucher()==null?"0":billvo.getIs_createvoucher()).equals("0") ){
%>
<input class="icon_2" id="btnVoucher" value="<fmt:message key='button_voucher'/>" onclick="createVoucher();"/>
<input class="icon_2" value="<fmt:message key='button_close'/>" onclick="closePage();" />
<%}%>
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
