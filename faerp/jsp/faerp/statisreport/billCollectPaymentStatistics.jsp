<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    //简单的模糊查询
    function simpleQuery(){
        //工资所属年月
        var bill_year_month = _$("#bill_year_month").val();
        if(null == bill_year_month || "" == bill_year_month){
            alert("请输入账单所属年月");
            return;
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    //导出账单代收付项统计
    function download(){
        //工资所属年月
        var bill_year_month = _$("#bill_year_month").val();
        //客户id
        var cust_code = _$("#cust_code").val();
        
        if(null == bill_year_month || "" == bill_year_month){
            alert("请输入账单所属年月");
            return;
        }
        var url = "<%=request.getContextPath()%>/SalaryStatisticsAction.do?cmd=expBillPaymentdoc&bill_year_month="+bill_year_month+"&cust_code="+cust_code;
        form.action=url;
        form.submit();
    }
</script>
 

</head>
<body>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/SalaryStatisticsAction.do">
<div id="right">
<script language="javascript">
    writeTableTopFesco('账单代收付项统计','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="174" rowspan="10" style="padding-top:0;" height="40px;"><div class="search_title">查询条件</div> </td>
          </tr>
          <tr>
            <td align="left">客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="cust_code"  name="cust_code" value="" inputName="客户编号"/>
            </td>
            <td align="left">账单年月</td>
            <td class="td_2">
             <input name="bill_year_month" class="text_field" id="bill_year_month" type="text" inputName="账单年月"/>
            </td>
            <td align="left">开票状态</td>
            <td class="td_2">
                <select id="bill_invoice_status_bd" name="bill_invoice_status_bd" style="width:204px;">
                    <option>--请选择--</option>
                    <option value="1">未开票</option>
                    <option value="2">已预开票</option>
                    <option value="3">已开票</option>
                    <option value="4">作废(预开)</option>
                    <option value="5">作废(实收)</option>
                    <option value="6">部分开票</option>
                    <option value="7">待开票</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="left">开票属性</td>
            <td align="left">
                <select id="open_invoice" name="open_invoice" style="width:204px;">
                    <option>--请选择--</option>
                    <option value="0">系统开票</option>
                    <option value="1">手动开票</option>
                </select>
            </td>
            <td align="left">实收状态</td>
            <td class="td_2">
                <select id="bill_gather_status_bd" name="bill_gather_status_bd" style="width:204px;">
                    <option>--请选择--</option>
                    <option value="1">部分实收</option>
                    <option value="2">实收完成</option>
                    <option value="3">未实收</option>
                    <option value="4">财务确认实收</option>
                </select>
            </td>
            <td align="left">凭证状态</td>
            <td class="td_2">
                <d:select name="voucher_satus_bd" id="voucher_satus_bd" dictTypeId="VOUCHER_STATUS" nullLabel="--请选择--" />
            </td>
        </tr>
        <tr>
            <td align="left">凭证属性</td>
            <td align="left">
                <select id="voucher_class" name="voucher_class" style="width:204px;">
                    <option>--请选择--</option>
                    <option value="0">系统凭证</option>
                    <option value="1">手工凭证</option>
                </select>
            </td>
            <td align="left">红冲凭证状态</td>
            <td class="td_2">
                <d:select name="is_createvoucher_bd" id="is_createvoucher_bd" dictTypeId="TrueOrFalse" nullLabel="--请选择--" />
            </td>
            <td>&nbsp;</td>
            <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='查询' onClick="simpleQuery();">
                <input type="reset" class="icon_1"  />
            </td>
        </tr>

</table>
</div>

                    
<div id="ccParent1" class="button">
    <div class="button_right">
         <input class="bl_3" type="button"   value="导出"   onClick="download();" />
     </div>
     <div class="clear"></div>
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/SalaryStatisticsAction.do?cmd=searchBillPaymentData"
 width="100%" height="318px" xpath="BillCollectPaymentStatisticsVo" paramFormId="datacell_formid" readonly="true" pageSize="200">
  <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="cust_code" label="客户编号"   > </r:field>
 <r:field fieldName="cust_name" label="客户名称" ></r:field>
 <r:field fieldName="bill_year_month" label="账单年月"   ></r:field>
 <r:field fieldName="supplementary_pension" label="补充养老保险"  ></r:field>
 <r:field fieldName="medical_insurance" label="医疗保险" ></r:field>
 <r:field fieldName="pension_insurance" label="养老保险" ></r:field>
  <r:field fieldName="shiye_insurance" label="失业保险" ></r:field>
  <r:field fieldName="maternity_insurance" label="生育保险"  ></r:field>
 <r:field fieldName="injury_insurance" label="工伤保险"   ></r:field>
 <r:field fieldName="housing_fund" label="住房公积金"   ></r:field>
 <r:field fieldName="buchong_housing_fund" label="补充住房公积金"   ></r:field>
 <r:field fieldName="dabing_insurance" label="大病保险"   ></r:field>
 <r:field fieldName="buchong_medical_insurance" label="补充医疗保险"  >  </r:field>
 <r:field fieldName="pay" label="工资"  ></r:field>
  <r:field fieldName="collection_payment_wage" label="工资代收代付"  ></r:field>
 <r:field fieldName="once_social_security" label="一次性社保"  ></r:field>
 <r:field fieldName="once_social_security_old" label="一次性社保旧"  ></r:field>
 <r:field fieldName="transfer_tax" label="个调税"  ></r:field>
 <r:field fieldName="shiye_insurance_fee" label="工本费失业保险"  ></r:field>
 <r:field fieldName="injury_insurance_fee" label="工本费工伤保险"  ></r:field>
 <r:field fieldName="other_pension" label="其他养老保险"  ></r:field>
 <r:field fieldName="other_health_insurance" label="其他医疗保险"  ></r:field>
 <r:field fieldName="other_shiye_insurance" label="其他失业保险"  ></r:field>
 <r:field fieldName="other_injury_insurance" label="其他工伤保险"  ></r:field>
 <r:field fieldName="other_maternity_insurance" label="其他生育保险"  ></r:field>
 <r:field fieldName="other_dabing_insurance" label="其他大病保险"  ></r:field>
 <r:field fieldName="other_residues_premium" label="其他残保金"  ></r:field>
 <r:field fieldName="other_fund" label="其他公积金"  ></r:field>
 <r:field fieldName="other_supplement_fund" label="其他补充公积金"  ></r:field>
 <r:field fieldName="other_supplementary_pension" label="其他补充养老保险"  ></r:field>
 <r:field fieldName="qita_buchong_yiliao_insurance" label="其他补充医疗保险"  ></r:field>
 <r:field fieldName="other_zonghe_insurance" label="其他综合保险"  ></r:field>
 <r:field fieldName="other_social_security" label="其他社保"  ></r:field>
 <r:field fieldName="other_union_fee" label="其他工会费"  ></r:field>
 <r:field fieldName="dai_shoufu_wage" label="代收付工资-代收付工资"  ></r:field>
 <r:field fieldName="dai_shoufu_socialsecurity" label="代收付社保-代收代付社保"  ></r:field>
 <r:field fieldName="alien_dai_shoufu_wage" label="代收付工资-外籍人管理代收付工资"  ></r:field>
 <r:field fieldName="residual_premium_national" label="残保金-全国"  ></r:field>
 <r:field fieldName="gelei_daigou_daishoufu" label="代收代付-各类代购代收付"  ></r:field>
 <r:field fieldName="caiwai_daifoufu_wage" label="代收代付工资-财外代收代付工资"  ></r:field>
 <r:field fieldName="government_visa_fee" label="代收代付-签证政府规费[辛必达]"  ></r:field>
 <r:field fieldName="government_visa_fee_center" label="代收代付-签证政府规费[商务中心]"  ></r:field>
 <r:field fieldName="collection_payment_fund" label="代收付公积金-代收代付公积金"  ></r:field>
 <r:field fieldName="daishoufu_fund_yilian" label="代收代付-代收付工资社保公积金[依恋项目]"  ></r:field>
 <r:field fieldName="wage_guarantee_fund" label="代收代付工资-欠薪保障金"  ></r:field>
 <r:field fieldName="deposit" label="押金"  ></r:field>
 <r:field fieldName="user_name" label="客服"  ></r:field>
 <r:field fieldName="dept_name" label="部门"  ></r:field>
 <r:field fieldName="bill_gather_status_bd_name" label="实收状态"  ></r:field>
 <r:field fieldName="bill_invoice_status_bd_name" label="开票状态"  ></r:field>
 <r:field fieldName="voucher_status_name" label="凭证状态"  ></r:field>
 <r:field fieldName="is_createvoucher_name" label="红冲凭证状态"  ></r:field>
 </r:datacell>
</div>

</div>
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
