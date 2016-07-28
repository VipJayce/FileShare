<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ taglib uri="/WEB-INF/gap-authority.tld" prefix="au" %>
<%@page import="rayoo.finance.receivable.finincoming.vo.FININCOMINGVo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<h:script src="/js/CookieUtil.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
window.onbeforeunload = function() {
	var runClaimType = cookieUtil.getCookie("runClaimType");
	if (!!runClaimType && runClaimType === "background") {
		return;
	}
    var inc_codes = new Array(0)
    _$("input[name='incoming_code']").each(function(){
         inc_codes.push(jQuery(this).val());
    });
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=unLockFinIncomingAndBillByPage&inc_codes=" + inc_codes,
        dataType : "text",
        success : function(data) {
            if (data != "" || data != null) {
            }
        }
    });
}
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%List<FININCOMINGVo> list=  (List<FININCOMINGVo>)request.getAttribute("listbean"); %>
<!--
    add by Mahone:
    注意，div_1和div_3中的参与计算的小额，汇差，核销等textbox的ID,NAME都一样
    这样做是为了只用一套js，后端java也只取一个name
 -->
 <fmt:bundle basename="rayoo.finance.receivable.finclaim.finclaim_resource" prefix="rayoo.finance.receivable.finclaim.">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key='title_singlefinclaim'/></title>

    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
        var _now ="${requestScope.currentDate}";
        function cancel_onClick(){  //取消后返回列表页面
		    //form.action=venusbase+"/FinclaimAction.do?cmd=leftbar2list";
		    //form.submit();
		    window.close();
		}



    </script>
<script language="javascript" src="<venus:base/>/jsp/faerp/finance/receivable/finclaim/finclaimNew.js"></script>
</head>
<body>
<form name="form" method="post" action="<%=request.getContextPath()%>/FinclaimAction.do">
<input type="hidden" name="rate_amount" id="rate_amount" value="${rate_amount}"/>
<input type="hidden" name="tokename" value="${tokenname}">
<input type="hidden" name="bill_whether_write_off" id="bill_whether_write_off" value="${bill_whether_write_off}">
<input type="hidden" name="inc_name" id="inc_name" value="<%=list.get(0).getInc_amout()%>">
<input type="hidden" id="cmd" name="cmd" value = "showClaimingPageByIncomingID">
<input type="hidden" value="${requestScope.balanceflag}" name="balanceflag" id="balanceflag">
<input type="hidden" value="${requestScope.balanceAmount}" name="balanceAmount" id="balanceAmount"/>
<input  type="hidden" value="<%=list.size()%>" id="incoming_count_s"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_singlefinclaim'/></div></div>
    <div class="ringht_s">
     <div class="social_tab">
         <div style="margin-top:10px;" class="xz_title"><fmt:message key='finclaim_info'/></div>

         <!-- 多到款列表 -->
         <div style="margin-left:0;margin-right:0;width:100%;height: 150; overflow: auto;" id="values_div99" class="box">
                 <table width="100%" cellspacing="0" class="datagrid1" id="table99_1">
                   <tr>
                     <th><fmt:message key='inc_code'/></th>
                     <th><fmt:message key='inc_cust_name'/></th>
                     <th><fmt:message key='inc_date'/></th>
                     <th><fmt:message key='inc_amout'/></th>
                     <th><fmt:message key='inc_bank'/></th>
                     <th><fmt:message key='last_claim_date_'/></th>
                     <th><fmt:message key='claim_user_name'/></th>
                     <th><fmt:message key='claim_status_bd'/></th>
                     <th><fmt:message key='un_claim_amout'/></th>
                   </tr>
                        <%for(int i=0;i<list.size();i++){%>
                         <tr class="<%=i%2==0?"odd":"even" %>" id="table9_t<%=i%>" >
                        <td>&nbsp;<%=list.get(i).getInc_code() %>
                        <input  type=hidden  name="incoming_id" value="<%=list.get(i).getId() %>" />
                        <input  type=hidden  name="incoming_code" value="<%=list.get(i).getInc_code() %>" />
                        </td>
                        <td>&nbsp;<%=list.get(i).getInc_cust_name()%></td>
                        <td>&nbsp; <fmt:formatDate value="<%=list.get(i).getInc_date() %>" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                        <td>&nbsp;<%=list.get(i).getInc_amout()%> </td>
                        <td>&nbsp;<%=BaseDataHelper.getNameByCode("BANK",String.valueOf(list.get(i).getInc_bank()))%></td>
                        <td>&nbsp; <fmt:formatDate value="<%=list.get(i).getUpload_date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>&nbsp; <%=OrgHelper.getPartyVoByID(list.get(i).getUpload_user_id().toString()) == null ? "" : OrgHelper.getPartyVoByID(list.get(i).getUpload_user_id().toString()).getName()%> </td>
                        <td>&nbsp; <%=BaseDataHelper.getNameByCode("CLAIM_STATUS_BD",String.valueOf(list.get(i).getClaim_status_bd()))%></td>
                        <td>&nbsp;<%=list.get(i).getUn_claim_amout()%> </td>
                        </tr>
                        <%}%>
                   </table>
               </div>

        <div class="box_3">
           <table  width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
            <td class="td_1"><fmt:message key='inc_amout_all'/></td>
               <td class="td_2"><label id="inc_amout"><fmt:formatNumber value="${inc_amountall }" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                  <input type="hidden" id="inc_amout_h" name="inc_amout_h" value="${inc_amountall }"/>
               </td>
                 <td class="td_1"><fmt:message key='un_claim_amout_all' /></td>
               <td class="td_2" id="td_unc">
                <label id="un_claim_amout"><fmt:formatNumber value="${un_claimamountall }" pattern="###,###,###,###.##"  minFractionDigits="2"/></label>
                <input type="hidden" id="un_claim_amout_h" name="un_claim_amout_h" value="${un_claimamountall }">
                </td>
             <tr>
               <td class="td_1"><fmt:message key='select_cost_center'/></td>
               <td class="td_2">
                    <table>
                        <tr>
                            <td style="height: 20px;"><fmt:message key='cust_name'/>
                                <c:choose>
                                    <c:when test="${custVo != null }">
                                        <w:lookup readonly="true" id="lk_cust_id"
                                        lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                        messagekey="select_cust" height="450" width="550" style="width:223px" displayValue="${custVo.customer_name }" readOnly="true"/>
                                        <input type="hidden" name="cust_name" id="cust_name" value="${custVo.customer_name }" />
                                        <input type="hidden" name="cust_code" id="cust_code" value="${custVo.customer_code }" />
                                        <input type="hidden" name="cust_id" id="cust_id" value="${custVo.id }">
                                        <input type="hidden" name="is_zhongliang" id="is_zhongliang" value="${custVo.is_zhongliang }"><!-- 2015-10 27 yangyuting add  -->
                                        <input type="hidden" name="is_remittance" id="is_remittance" value="${requestScope.is_remittance_error}"/>
                                        <input type="hidden" name="is_finance_invoice" id="is_finance_invoice" value="${requestScope.is_finance_invoice}"/>
                                    </c:when>
                                    <c:otherwise>
                                        <w:lookup readonly="true" id="lk_cust_id"
                                        lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                        messagekey="select_cust" height="450" width="550" style="width:223px" displayValue="${custVo.customer_name }"/>
                                        <input type="hidden" name="cust_name" id="cust_name" value="${custVo.customer_name }" />
                                        <input type="hidden" name="cust_code" id="cust_code" value="${custVo.customer_code }" />
                                        <input type="hidden" name="cust_id" id="cust_id" value="${custVo.id }">
                                        <input type="hidden" name="is_zhongliang" id="is_zhongliang" value="${custVo.is_zhongliang }"><!-- 2015-10 27 yangyuting add  -->
                                        <input type="hidden" name="is_remittance" id="is_remittance" value="${custVo.is_remittance_error }"/>
                                        <input type="hidden" name="is_finance_invoice" id="is_finance_invoice" value="${requestScope.is_finance_invoice}"/>
                                    </c:otherwise>
                                </c:choose>

                            </td>
                        </tr>
                        <tr>
                            <td style="height: 20px;">
               <fmt:message key='cost_center'/>
                               <c:choose>
                                    <c:when test="${custVo != null }">
		                             <r:comboSelect id="cost_center_id" name="cost_center_id"
		                                queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
		                                textField="cost_center_name" valueField="id" xpath="CostcenterVo"
		                                width="240">
		                             </r:comboSelect>
                                    </c:when>
                                    <c:otherwise>
                                    <r:comboSelect id="cost_center_id" name="cost_center_id"
                                        queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                                        textField="cost_center_name" valueField="id" xpath="CostcenterVo" messagekey="please_select"
                                        width="240">
                                     </r:comboSelect>
                                    </c:otherwise>
                                </c:choose>
                             <input type="hidden" name="cost_center_name" id="cost_center_name" value="${requestScope.cost_center_id}">
                            </td>
                        </tr>
                    </table>
                    <!-- <input type="submit" value="选择公司和成本中心" id="button2" name="button2"> -->
               </td>
                  <input type="hidden" name="BPO" id="BPO">
               <td class="td_1"><!--<fmt:message key='inc_cust_name_'/>--></td>
               <td class="td_2"></td>
             </tr>
             <tr>
               <td class="td_1"><fmt:message key='last_claim_year_month_'/></td>
               <td class="td_2"><input type="text" id="bill_year_month" class="text_field" name="bill_year_month">（格式如：201301）</td>
               <td class="td_1"><fmt:message key='claim_desc'/></td>
               <td class="td_2"><textarea id="text" style="width:250px; height:30px;" class="xText_d" rows="3" name="claim_desc"></textarea></td>
             </tr>
          </table>
         </div>
         <!-- 到款表 结束================到款表 结束=====================到款表 结束 -->
        <div>
          <div style="margin-top:10px;" class="xz_title"><fmt:message key='title_finclaim_detail'/><input type="hidden" id="adv_h" name="adv_h" value="0"/></div>
          <div style="margin-left:10px;margin-right:0; height:150px;" id="values_div3" class="box" style="overflow-y:scroll;">
            <table width="100%" cellspacing="0" class="datagrid1" id="advancestable" >
              <tr>
                <th width="4%"> <input type="checkbox" value="checkbox" name="checkbox7" id="chk_adv_all">
                </th>
                <th><fmt:message key='into_date'/></th>
                <th><fmt:message key='into_amout'/></th>
                <th><fmt:message key='receivable_in_advance'/></th>
                <th><fmt:message key='last_after_verification'/></th><!-- 更好的为“已核销” -->
              </tr>
            </table>
          </div>
          <div class="foot_button"></div>
        </div>

         <div class="reserve_tab">
         <div class="xz_title"><fmt:message key='button_rl'/></div>
           <!--
           <div class="xixi1" id="bg">
             <div id="font1" class="tab1" onMouseDown="setTab_fin(1);document.getElementById('bg').className='xixi1'">全部认领</div>
             <div id="font3" class="tab2" onMouseDown="setTab_fin(3);document.getElementById('bg').className='xixi2'">明细认领</div>
          </div>
          -->

           <div id="TabCon1">
             <!--表格1====================表格1===========================表格1 BEGIN 此数据为FIN_BILL中的数据 -->
             <div class="box_3_new" id="div_1">
              <!--  应收金额+小额调整+汇差=核销金额 -->
               <table width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
                 <tr>
                   <td width="7%" style="background:#f1f7f9; text-align:right;"><fmt:message key='amount_total'/></td>
                   <td width="6%" class="td_2" >
                        <label id="sumv">0.00</label>
                        <input type="hidden" id="sumv_h" name="sumv_h" value="0.00"/>
                   </td>
                   <td width="49%" class="td_1"><fmt:message key='v_yu_e'/><label id="v_yu_e"></label></td>
                   <td width="35%" class="td_2"><input type="hidden" id="v_txt_odd" value="0"><!-- 页面存小额-->  <input type="hidden" id="v_txt_rem" value="0"><!-- 页面存汇差 -->
                        <label id="lbl_sumv"></label>&nbsp;+
                        <input type="text" id="txt_odd" name="txt_odd"  value="0" class="text_field" style="width: 100px;"> +
                        <input type="text" id="txt_rem" name="txt_rem"  value="0"  class="text_field" style="width: 100px; background:#f0f0f0;" readonly="readonly"> =
                        <input type="text" id="txt_ver" name="txt_ver"  value="0"  readonly="readonly" class="text_field" style="width: 100px;"> <!-- border:1px; -->
                        <label id="v_yu_e_input"></label>
                   </td>
                 </tr>
                 <tr>
                   <td style="background:#f1f7f9; text-align:right;"><font color="red"><fmt:message key='v_n_sumv_h'/></font></td>
                   <td class="td_2"><input type="text" id="v_n_sumv_h" name="v_n_sumv_h"  value="0"  class="text_field" style="width: 100px;" onkeyup="onKey_Up(this.value)"> </td>
                   <td class="td_1"><label id="resultbt"></label></td>
                   <td class="td_2">
                   <label id="resultv"></label>
                   <input type="hidden" id="lbl_unclaim">
                   <input type="hidden" id="lbl_balance">
                   <input type="hidden" id="lbl_ver">
                   <input type="hidden" id="lbl_difference">
                         <!--
                        !-- <label id="resultv"></label>  --
                        !-- 到款未认领 --
                        <label id="lbl_unclaim"></label>&nbsp;+
                        !-- 预收 --
                        <label id="lbl_balance"></label>&nbsp;-
                        !-- 核销 --
                        <label id="lbl_ver"></label>&nbsp;=
                        !-- 差额 lbl_outstanding--
                        <label id="lbl_difference"></label>
                        !-- 差额，可认为预收，或未认领 ，只有为正数时，才能走到ACTION
                        txt_outstanding
                         --
                        -->
                        <input type="hidden" value="0" name="txt_difference" id="txt_difference"><!-- 把计算的结果记录下来，传到后端 -->
                   </td>
                 </tr>
               </table>
               <input type="hidden" value="" name="v_bill_id" id="v_bill_id">
               <div style="margin-left:0;margin-right:0;width:100%;height:auto;min-height:330px" id="values_div" class="box">
                 <table width="100%" cellspacing="0" class="datagrid1" id="table1">
                   <tr>
                     <th width="4%">
                     </th>
                     <c:if test="${bill_whether_write_off=='1'}">
                        <th><fmt:message key='table0_0'/></th>
                        <th><fmt:message key='table0_1'/></th>
                        <th><fmt:message key='table0_2'/></th>
                     </c:if>
                     <th><fmt:message key='table1_0'/></th>
                     <th><fmt:message key='table1_1'/></th>
                     <th><fmt:message key='table1_2'/></th>
                     <th><fmt:message key='table1_3'/></th>
                     <th><fmt:message key='table1_4'/></th>
                     <th><fmt:message key='table1_5'/></th>
                     <th><fmt:message key='table1_6'/></th>
                     <th><fmt:message key='table1_7'/></th>
                   <c:if test="${bill_whether_write_off=='1'}">
                        <th><fmt:message key='table0_3'/></th>
                    </c:if>
                   </tr>
                 </table>
               </div>
               <div style="width:100%; text-align:center; margin-top:10px;">
                 <input type="radio" value="1" id="claimingall1" name="claimingall" ><label for="claimingall1"><fmt:message key='claimingall1'/></label>
                 <input type="radio" value="2" id="claimingall2" name="claimingall" checked="checked"><label for="claimingall2"><fmt:message key='claimingall2'/></label>
               </div>
               <div class="foot_button">
                 <input type="button" value="<fmt:message key='button_subclaim'/>" class="foot_icon_2" onclick="subclaim(this);" id="savaclaim_button" name="savaclaim_button">
                <input type="button"  value="<fmt:message key='button_subclaim_bcak'/>" class="foot_icon_2" onclick="subclaim_back(this);" <au:authorityBtn code="subclaim_back_but" type="1"/>  id="subclaim_back_button" name="subclaim_back_button">
                 <input type="button" class="foot_icon_1" value="<fmt:message key='button_go_back'/>"  onclick="javascript:cancel_onClick();" />
               </div>
             </div>
           </div>
            <!--表格1====================表格1===========================表格1 END -->


           <!-- 表格2====================表格2===========================表格2 BEGIN -->
           <div style="display:none; " id="TabCon2">
             <div class="box_3_new">
               <table ID="table2" width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
                 <tr>
                   <td width="16%" class="td_1"><fmt:message key='table2_0'/></td>
                   <td width="23%" class="td_2"><label id="sumempsalary">0</label><fmt:message key='table2_'/></td>
                   <td width="24%" class="td_1"><fmt:message key='table2_1'/></td>
                   <td width="37%" class="td_2">
                    <label id="sumsalary">0.00</label>
                    <input id="sumsalary_hid" type="hidden" value="0.00">
                   </td>
                 </tr>
                 <tr>
                   <td class="td_1"><fmt:message key='table2_2'/></td>
                   <td class="td_2"><label id="sumempfax">0</label><fmt:message key='table2_'/></td>
                   <td class="td_1"><fmt:message key='table2_3'/></td>
                   <td class="td_2">
                    <label id="sumtax">0.00</label>
                    <input id="sumtax_hid" type="hidden" value="0.00">
                   </td>
                 </tr>
                 <tr>
                   <td class="td_1">&nbsp;</td>
                   <td class="td_2">
                    <label id="t2_sumv"></label>
                    <!-- 工资+个税 -->
                    <input type="hidden" id="t2_sumv_h" name="t2_sumv_h" value="0.00" />
                    <!-- 人数合计 -->
                    <input type="hidden" id="t2_sumemp_h" name="t2_sumemp_h" value="0" />
                    <!--SALARY_TAX_BD 工资报税属性：0:发工资且报税 1:只发工资 2:只报税-->
                    <input type="hidden" id="taxbd" name="taxbd">
                   </td>
                   <td class="td_1"><fmt:message key='table2_4'/></td>
                   <td class="td_2">
                     <label id="t2_resultv"></label>
                     <input type="hidden" value="0" name="t2_cal_res_h" id="t2_cal_res_h">
                   </td><!--500+100-600 = 0  -->
                 </tr>
               </table>
               <p></p>
               <div>
               <div style="width:47%; float:left; margin-left:15px; font-weight:bold; margin-top:10px;"><fmt:message key='table2_5'/></div>
               <div style="width:48%; float:left; margin-left:25px; font-weight:bold; margin-top:10px;"><fmt:message key='table2_6'/></div>
                <div style="float:left; width:48%;" id="values_div2" class="box">
                  <table width="100%" cellspacing="0" class="datagrid1" id="table2_1">
                    <tr>
                      <th width="4%"></th>
                      <th width="24%"><fmt:message key='table2_1_0'/></th>
                      <th width="24%"><fmt:message key='table2_1_1'/></th>
                      <th width="24%"><fmt:message key='table2_1_2'/></th>
                      <th width="24%"><fmt:message key='table2_1_3'/></th>
                    </tr>
                    </tr>
                  </table>
                </div>
                 <div style="float:right; width:48%;" id="values_div4" class="box">
                   <table width="100%" cellspacing="0" class="datagrid1" id="table2_2">
                     <tr>
                       <th width="4%"></th>
                       <th width="15%"><fmt:message key='table2_2_0'/></th>
                       <th width="15%"><fmt:message key='table2_2_1'/></th>
                       <th width="15%"><fmt:message key='table2_2_2'/></th>
                       <th width="10%"><fmt:message key='table2_2_3'/></th>
                       <th width="10%"><fmt:message key='table2_2_4'/></th>
                       <th width="10%"><fmt:message key='table2_2_5'/></th>
                       <th width="10%"><fmt:message key='table2_2_6'/></th>
                       <th width="11%"><fmt:message key='table2_2_7'/></th>
                     </tr>
                   </table>
                </div>
                </div>
                 <div style="width:100%; text-align:center; margin-top:10px;">
                   <input type="radio" value="3" id="claimingall3" name="claimingall"><label for="claimingall3"><fmt:message key='claimingall3'/></label>
                   <input type="radio" value="4" id="claimingall4" name="claimingall"><label for="claimingall4"><fmt:message key='claimingall4'/></label>
                 </div>
                 <div class="foot_button">
                   <input type="button" value="<fmt:message key='button_subclaim'/>" class="foot_icon_2" onclick="subclaim(this);" >
                   <input type="button" class="foot_icon_1" value="<fmt:message key='button_go_back'/>"  onclick="javascript:cancel_onClick();" />
                 </div>
             </div>
           </div>
             <!--表格2 ==========================表格2 ===========================表格2 END -->


           <!--表格3 ==========================表格3  应收金额+小额调整+汇差=核销金额 ===========================表格3  BEGIN  -->
           <div style="display:none;" id="TabCon3">
             <div class="box_3_new" id="div_3">
               <table width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
                 <tr>
                   <td width="10%" class="td_1"><fmt:message key='table3_0'/></td>
                   <td width="10%" class="td_2" >
                        <label id="sumv" value="0">0.00</label>
                        <input type="hidden" id="sumv_h" name="sumv_h" value="0.00" />
                   </td>
                   <td width="41%" class="td_1"><fmt:message key='table3_1'/></td><!-- 应收=核销-(小额+汇差) -->
                   <td width="39%" class="td_2"><input type="hidden" id="v_txt_odd" value="0"><!-- 页面存小额-->  <input type="hidden" id="v_txt_rem" value="0"><!-- 页面存汇差 -->
                        <label id="lbl_sumv"></label>&nbsp;+
                        <input type="text" id="txt_odd" name="txt_odd" value="0" class="text_field" style="width: 100px;"> +
                        <input type="text" id="txt_rem" name="txt_rem" value="0" class="text_field" style="width: 100px; background:#f0f0f0;" readonly="readonly"> =
                        <input type="text" id="txt_ver" name="txt_ver" value="0" class="text_field" style="width: 100px;">
                   </td>
                 </tr>
                 <tr>
                   <td class="td_1"></td>
                   <td class="td_2"></td>
                   <!--<td class="td_1">到款未认领+预收款-核销金额=差额</td>-->
                   <td class="td_1"><label id="resultbt3"></label></td>
                   <td class="td_2">
                        <!-- <label id="resultv"></label>  -->
                        <!-- 到款未认领
                        <label id="lbl_unclaim"></label>&nbsp;+
                        -- 预收 --
                        <label id="lbl_balance"></label>&nbsp;-
                        -- 核销 --
                        label id="lbl_ver"></label>&nbsp;=
                        -- 余额 --
                        <label id="lbl_difference"></label>
                        -- 余额，可认为预收，在全部认领时，只有为正数时，才能走到ACTION
                        负数为余额，在全部认领时，有负数不予提交
                         -->
                       <label id="resultv3"></label>
	                   <input type="hidden" id="lbl_unclaim">
	                   <input type="hidden" id="lbl_balance">
	                   <input type="hidden" id="lbl_ver">
	                   <input type="hidden" id="lbl_difference">
                        <input type="hidden" value="0" name="txt_difference" id="txt_difference"><!-- 把计算的结果记录下来，传到后端 -->
                   </td>
                 </tr>
               </table>
               <div style="margin-left:0;margin-right:0;width:100%;height: 200; overflow: auto;" id="values_div5" class="box">
                 <table width="100%" cellspacing="0" class="datagrid1" id="table3_1">
                   <tr>
                     <th width="4%">&nbsp;<input type="hidden" name="billid" id="billid"/></th>
                     <th><fmt:message key='table3_1_0'/></th>
                     <th><fmt:message key='table3_1_1'/></th>
                     <th><fmt:message key='table3_1_2'/></th>
                     <th><fmt:message key='table3_1_3'/></th>
                     <th><fmt:message key='table3_1_4'/></th>
                     <th><fmt:message key='table3_1_5'/></th>
                     <th><fmt:message key='table3_1_6'/></th>
                     <th><fmt:message key='table3_1_7'/></th>
                   </tr>
                   </table>
               </div>

               <div class="xixi1" id="bg2" style="margin-top: 20px;">
                     <div id="font5" class="tab1" onMouseDown="setTabSyn_fin_detail(5);document.getElementById('bg2').className='xixi1'"><fmt:message key='xixi1'/></div>
                     <div id="font6" class="tab2" onMouseDown="setTabSyn_fin_detail(6);document.getElementById('bg2').className='xixi2'"><fmt:message key='xixi2'/></div>
               </div>
               <div id="TabCon5" >
                   <div style="margin-top:10px;" class="xz_title"></div>
                   <div id="values_div6" class="box" style="margin:5px 10px 0px 0px;height: 300px; overflow: scroll;width:100%">
                    <div style="width: 2000px; ">
                        <table cellspacing="0" class="datagrid1" id="table3">
                           <tr><th></th></tr>
                        </table>
                    </div>
                   </div>
               </div>
               <div id="TabCon6" style="display: none;">
                   <div style="margin-top:10px;" class="xz_title"></div>
                   <div id="values_div7" class="box" style="margin:5px 10px 0px 0px;height: 300px; overflow: scroll;width:100%">
                     <table cellspacing="0" class="datagrid1" id="table4" width="100%">
                        <tr>
                            <th width="2%">
                               <!-- 用于存放传到后端去的一次性收费ID -->
                               <input type="hidden" name="oneofffeeids" id="oneofffeeids">
                               <input type="checkbox" name="checkall_oneOfffee" id="checkall_oneOfffee"/>
                            </th>
                            <th width="30%"><fmt:message key='table3_2'/></th>
                            <th width="20%"><fmt:message key='table3_3'/></th>
                            <th width="38%"><fmt:message key='table3_4'/></th>
                            <th width="10%"><fmt:message key='table3_5'/></th>
                        </tr>
                     </table>
                   </div>
               </div>


               <div style="width:100%; text-align:center; margin-top:10px;">
                 <div id="pageinfo" style="color:red;float:left;"></div>
                 <input type="radio" value="5" id="claimingall5" name="claimingall"><label for="claimingall5"><fmt:message key='claimingall5'/></label>
                 <input type="radio" value="6" id="claimingall6" name="claimingall"><label for="claimingall6"><fmt:message key='claimingall6'/></label>
               </div>
               <div class="foot_button">
                 <input type="button" value="<fmt:message key='button_subclaim'/>" class="foot_icon_2" onclick="subclaim(this);" >
                 <input type="button" value="<fmt:message key='button_go_back'/>"  onclick="javascript:cancel_onClick();" />
               </div>
                <p></p>
             </div>
            <!--表格3 ==========================表格3 ===========================表格3  END  -->
           </div>
        </div>
     </div>
     </div>
     </div>
     <input type="hidden" name="claimval" id="claimval" value="">
</form>
</body>
</html>
<script language="javascript">
if(${msg != null && msg != ""}) {
    alert("${msg }");
}

///汇差可输入
if(${custVo != null && custVo != ""}) {
    var is_remittance_error = "${requestScope.is_remittance_error}";
    //alert(is_remittance_error);
    if (is_remittance_error == '1') {
            //有汇差，显示汇差，把汇差的只读属性去掉
            _$("#div_1 input[id='txt_rem']").removeAttr("readonly");
            _$("#div_1 input[id='txt_rem']").css({background: "white" });
        } else {
            //无汇差，显示小额
            _$("#div_1 input[id='txt_rem']").attr("readonly", true);
            _$("#div_1 input[id='txt_rem']").css({background: "#f0f0f0" });
        }

}
</script>
</fmt:bundle>