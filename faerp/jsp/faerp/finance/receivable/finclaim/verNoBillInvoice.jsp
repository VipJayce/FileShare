<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<!-- 
    add by Mahone:
    注意，div_1和div_3中的参与计算的小额，汇差，核销等textbox的ID,NAME都一样
    这样做是为了只用一套js，后端java也只取一个name
 -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>认领</title>
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
        
        function cancel_onClick(){  //取消后返回列表页面
            form.action=venusbase+"/FinclaimAction.do?cmd=leftbar2list";
            form.submit();
        }
    </script>
</head>
<body>
<form name="form" id="datacell_formid" method="post">
<input type="hidden" id="no_amount_flag" name="no_amount_flag" value="0" />
<input type="hidden" id="incoming_id" name="incoming_id" value="${bean.id}" />
<input type="hidden" id="invoice_id" name="invoice_id" value="" />
<div id="right">
    <div class="ringht_s">
     <div class="social_tab">
         <div class="box_3">
           <div>到款信息</div>
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
              <!-- 到款信息 start -->
                  <tr>
                   <td class="td_1">到款编号</td>
                   <td class="td_2">${bean.inc_code }</td>
                   <td class="td_1">到款金额</td>
                   <td class="td_2">${bean.inc_amout}</td>
                  </tr>
                  <tr>
                   <td class="td_1">到款日期</td>
                   <td class="td_2"><fmt:formatDate value="${bean.inc_date }" pattern="yyyy-MM-dd"/></td>
                   <td class="td_1">到款银行</td>
                   <td class="td_2">
                         <bean:define id="inc_bank" name="bean" property="inc_bank"/><%=BaseDataHelper.getNameByCode("BANK",String.valueOf(inc_bank))%>
                   </td>
                  </tr>
                  <tr>
                   <td class="td_1">上传时间</td>
                   <td class="td_2"><fmt:formatDate value="${bean.upload_date }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                   <td class="td_1">上传人</td>
                   <td class="td_2">
                         <bean:define id="create_user" name="bean" property="upload_user_id"/>
                         <%=OrgHelper.getPartyVoByID(create_user.toString()) == null ? "" : OrgHelper.getPartyVoByID(create_user.toString()).getName()%>
                   </td>
                  </tr>
                  <tr>
                   <td class="td_1">认领状态</td>
                   <td class="td_2">
                         <bean:define id="claim_status_bd" name="bean" property="claim_status_bd"/>
                         <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(claim_status_bd))%>
                   </td>
                   <td class="td_1">未认领金额</td>
                   <td class="td_2">
                        ${bean.un_claim_amout}
                        <input type="hidden" id="un_claim_amout_h" name="un_claim_amout_h" value="${bean.un_claim_amout}">
                   </td>
                  </tr>
                  <tr>
                   <td class="td_1">到款公司</td>
                   <td class="td_2">${bean.inc_cust_name }</td>
                   <td class="td_1">认领备注</td>
                   <td class="td_2"> <textarea id="claim_desc" style="width:250px; height:40px;" class="xText_d" rows="3" name="claim_desc"></textarea></td>
                  </tr>
                  <tr>
                   <td class="td_1">核销金额</td>
                   <td class="td_2" colspan="3">
                        <input type="text" id="claim_amount" name="claim_amount" value="" />
                   </td>
                  </tr>
             <!-- 到款信息 结束 -->
           </table>
         </div>
         <div class="box_3">
           <div class="button_right">
                <input class="c_1"  type="button"   value="选择发票"   style="height: 22px;" onClick="toSelectInvoice();">
           </div>
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
              <!-- 到款信息 start -->
                  <tr>
                   <td class="td_1">发票抬头</td>
                   <td class="td_2">
                        <input type="text" id="receipt_title" name="receipt_title" readonly="readonly" disabled="disabled">
                   </td>
                   <td class="td_1">发票金额</td>
                   <td class="td_2">
                        <input type="text" id="invoice_amount" name="invoice_amount" readonly="readonly" disabled="disabled">
                   </td>
                  </tr>
                  <tr>
                   <td class="td_1">发票申请人</td>
                   <td class="td_2">
                        <input type="text" id="apply_user" name="apply_user" readonly="readonly" disabled="disabled">
                   </td>
                   <td class="td_1">发票申请时间</td>
                   <td class="td_2">
                        <input type="text" id="apply_date" name="apply_date" readonly="readonly" disabled="disabled">
                   </td>
                  </tr>
                  <tr>
                   <td class="td_1">未核销金额</td>
                   <td class="td_2" colspan="3">
                        <input type="text" id="un_ver_amount" name="un_ver_amount" readonly="readonly" disabled="disabled">
                   </td>
             <!-- 到款信息 结束 -->
           </table>
         </div>
     </div>
     </div>
     </div>

      <div class="foot_button">
      <input type="button" value="确定" class="foot_icon_3" onclick="subVer();">
      <input type="button" class="foot_icon_1" value="返回"  onclick="javascript:cancel_onClick();" />
      </div>
</form>
</body>
</html>
<script language="javascript">
if(${msg != null && msg != ""}) {
    alert("${msg }");
}

function cancel_onClick() {
    window.close();
}

//跳转到选择未核销的发票
function toSelectInvoice(){
    showModalCenter("<%=request.getContextPath()%>/FinclaimAction.do?cmd=selectInvoicePage",null,selectInvoiceReturn,850,600,"选择未核销发票");
}

//选择发票返回方法
function selectInvoiceReturn(retVal){
	_$("#invoice_id").val(retVal[0]);
	_$("#receipt_title").val(retVal[1]);
	_$("#invoice_amount").val(retVal[2]);
	_$("#apply_user").val(retVal[3]);
	_$("#apply_date").val(retVal[4]);
	_$("#un_ver_amount").val(retVal[5]);
}

//提交核销信息
function subVer(){
    var invoice_amount = _$("#invoice_amount").val();//发票金额
    var invoice_id = _$("#invoice_id").val();//发票id
    var claim_amount = _$("#claim_amount").val();//核销金额
    var un_claim_amount = _$("#un_claim_amout_h").val();//未认领金额
    var un_ver_amount = _$("#un_ver_amount").val();//未核销金额
    if(invoice_id == null || invoice_id == ""){
        alert("请选择未核销的发票");
        return false;
    }
    if(claim_amount == null || claim_amount == ""){
        alert("请输入核销金额");
        return false;
    }else{
         if( isNaN(claim_amount)){
            alert("请输入正确的金额!");
            _$("#claim_amount").val("");
            return false;
        }
    }
    if(parseFloat(claim_amount)<=0){
        alert("核销金额必须大于0");
        return false;
    }
    if(parseFloat(claim_amount)>parseFloat(un_claim_amount)){
        alert("核销金额不能大于未认领金额");
        return false;
    }
     if(parseFloat(claim_amount)>parseFloat(un_ver_amount)){
        alert("核销金额不能大于发票的未核销金额");
        return false;
    }
    var param = _$("#datacell_formid").serialize();
    var _url = "<%=request.getContextPath()%>/FinclaimAction.do?cmd=verNobillInvoice&_ts="+(new Date()).getTime(); 
    _$.ajax({
        type : "post",
        url : _url,
        data : param,
        dataType : "html",
        success : function(data) {
                alert(data);
                window.close();
        }
    });
}

</script>