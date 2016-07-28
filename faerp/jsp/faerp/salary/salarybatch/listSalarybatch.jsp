<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%
String user_id = RmJspHelper.getParty_idFromRequest(request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salarybatch.salarybatch_resource" prefix="rayoo.salary.salarybatch.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_salarybatch'/></title>
</head>

<body>
<form id="salarybatchForm" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_salarybatch'/></div>
    </div>
    <div class="ringht_s">
    <!--查询 -->
      <div class="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="135" rowspan="3" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div></td>
            <td width="80"><fmt:message key='apply_pay_date'/></td>
            <td width="220">
                <w:date allowInput="true" id="w_apply_pay_date_f" name="apply_pay_date_from" format="yyyy-MM-dd" style="width:81px;" value=""/>
                -
                <w:date allowInput="true" id="w_apply_pay_date_t" name="apply_pay_date_to" format="yyyy-MM-dd" style="width:81px;" value=""/>
            </td>
            <td width="80"><fmt:message key='customer_code'/></td>
            <td width="220"><input name="customer_code" class="sText" id="t_customer_code"/></td>
            <td width="60"><fmt:message key='customer_name'/></td>
            <td width="220">
                <w:lookup name="customer_name" onReturnFunc="rtnFunc" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="600"/>
                <input type="hidden" name="customer_id" id="h_customer_id"/>
            </td>
          </tr>
          <tr>
            <td><fmt:message key='apply_pay_state'/></td>
            <td>
               <select class="sSelect" name="apply_pay_state">
                   <option selected="true" value=""><fmt:message key='select_null'/></option> 
                   <option value="0" selected="true"><fmt:message key='apply_pay_state_0'/></option>
                   <option value="1"><fmt:message key='apply_pay_state_1'/></option>
               </select>
            </td>
            <td><fmt:message key='audit_state'/></td>
            <td>
               <select class="sSelect" name="audit_state">
               		<option value="" selected><fmt:message key='select_null'/></option> 
                   <option value="0"><fmt:message key='audit_state_0'/></option>
                   <option value="1"><fmt:message key='audit_state_1'/></option>
                   <option value="2"><fmt:message key='audit_state_2'/></option>
                   <option value="3" ><fmt:message key='audit_state_3'/></option>
               </select>
            </td>
                 <td width="80"><fmt:message key='pay_year_month'/></td>
            <td width="220" align="left"><input id="pay_year_month" name="pay_year_month" style="width: 172px;" class="sText" id="pay_year_month"/></td>
     
          </tr>
            <td width="80">申请人</td>
            <td width="220"><input name="submit_user" class="text_field" maxLength="50"></td>
            <td colspan="4" align="center"><input onclick="qrySalarybatch()" type="button" class="icon_1" value="<fmt:message key='button_search'/>" />
            							   <input type="reset" class="icon_1" value="重置"/>
            </td>
          </tr>
          
        </table>
      </div>
        <!--查询 end-->
        <!--按钮-->
        <div class="button">
            <div class="button_right"><!--
                <ul>
                    <li class="a_2"><a onClick="viewItem()" href="javascript:void(0);">查看详细</a></li>
                    <li class="bl_1"><a onclick="applyPay()" href="javascript:void(0);">申请发放</a></li>                    
                </ul>
                -->
                <input class="a_2" type="button"   value="<fmt:message key='button_viewItem'/>"  <au:authorityBtn code="sqff_viewItem" type="1"/>  onClick="viewItem();">
                <input class="bl_1" type="button"   value="<fmt:message key='button_applyPay'/>"  <au:authorityBtn code="sqff_sqff" type="1"/>  onClick="applyPay();">
            </div>
            <div class="clear"></div>
        </div>
        <!--按钮 end-->
        <!--表格 -->
        <div style="padding: 8 0 8 8;">
        <r:datacell 
              id="dc_salary_batch"
              queryAction="/FAERP/SalarybatchAction.do?cmd=simpleQuery"
              submitAction="/FAERP/SalarybatchAction.do?cmd=update"
              width="99%"
              height="304px"
              pageSize="100"
              xpath="SalarybatchVo"
              submitXpath="SalarybatchVo"
              paramFormId="salarybatchForm"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      
              <r:field fieldName="sa_batch_code" messagekey="sa_batch_code" >
              </r:field>
               <r:field fieldName="pay_name" messagekey="pay_name" >
              </r:field>
               <r:field fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field fieldName="customer_name" messagekey="customer_name">
              </r:field>
             
              <r:field fieldName="pay_year_month" messagekey="pay_year_month">
              </r:field>
               <r:field fieldName="must_day" messagekey="must_day" >
              </r:field>
              <r:field fieldName="payroll_type_bd" messagekey="payroll_type_bd" allowModify="false">
                <d:select dictTypeId="PAYROLL_TYPE_BD"/>
              </r:field>
              <r:field fieldName="apply_pay_date" messagekey="apply_pay_date" >
              </r:field>
              <r:field fieldName="apply_pay_state" messagekey="apply_pay_state" allowModify="false">
                <h:select name="list_apply_state" property="apply_pay_state">
                   <h:option value="0" label="未申请"></h:option>
                   <h:option value="1" label="已申请"></h:option>
                </h:select>
              </r:field>
              <r:field fieldName="submit_time" messagekey="submit_time" >
              </r:field>
              <r:field fieldName="submit_user" messagekey="submit_user" >
              </r:field>
              <r:field fieldName="verify_time" messagekey="verify_time" >
              </r:field>
              <r:field fieldName="audit_state" messagekey="audit_state"  allowModify="false">
                   <d:select dictTypeId="AUDIT_STATE"/>
              </r:field>
              <r:field fieldName="audit_user_name" messagekey="audit_user_name" >
              </r:field>
              <r:field fieldName="gen_money_code" messagekey="gen_money_code">
              </r:field>
              <r:field fieldName="not_code_reason" messagekey="not_code_reason"  allowModify="false" >
              	<d:select dictTypeId="NOT_CODE_REASON"/>
              </r:field>
              <r:field fieldName="claim_date" messagekey="claim_date" >
              </r:field>
              <r:field fieldName="real_pay_day" messagekey="real_pay_day" >
              </r:field>
              <r:field fieldName="total_amount" messagekey="total_amount" >
              </r:field>
              <r:field fieldName="total_number" messagekey="total_number" >
              </r:field>
              <r:field fieldName="icbc_number" messagekey="icbc_number" >
              </r:field>
              <r:field fieldName="cmb_number" messagekey="cmb_number" >
              </r:field>
              <r:field fieldName="fail_number" messagekey="fail_number" >
              </r:field>
              <r:field fieldName="pay_state" messagekey="pay_state" allowModify="false">
                    <h:select name="list_pay_state" property="pay_state">
                         <h:option value="0" label="待发放"/>
                         <h:option value="1" label="已发放"/>
                   </h:select>
              </r:field>
              <r:field fieldName="should_pay_date" label="应到款日" allowModify="false">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="expected_advanced_date" label="垫付后预计到款日" allowModify="false">
                <w:date format="yyyy-MM-dd" />
            </r:field>    
        </r:datacell>
        </div>
        <!--表格 end-->
    </div>
</div>
</form>
</body>
<script type="text/javascript">
jQuery(function(){
    $id("dc_salary_batch").isQueryFirst = true;
    /*
    //魏佳新增--默认工资所属月为当前日期的年月
    var myDate = new Date();
    var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
    var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
    //var day = myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
    if(month<10){
      month = "0"+month;
    }
    var ym = year+month;
    document.getElementById("pay_year_month").value=ym;*/
});

//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);        
    return false;
}
//查看明细
function viewItem(){
    dc = $id("dc_salary_batch");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    batchId = clz.getValue("id");
    showModalCenter("<%=request.getContextPath()%>/SalarybatchAction.do?cmd=detail&id=" + batchId,null,null,
                                                                                        800,500,"<fmt:message key='alert_batch_detail'/>");
}
//申请发放
function applyPay(){
    dc = $id("dc_salary_batch");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    batchId = clz.getValue("id");
    apply_pay_state = clz.getValue("apply_pay_state");
    if(apply_pay_state == 1){
        alert("<fmt:message key='alert_audit'/>");
        return;
    }
    audit_state = clz.getValue("audit_state");
    if(audit_state == 0 || audit_state == 2){
        alert("<fmt:message key='alert_un_audit'/>");
        return;
    }
    var audit_user = clz.getValue("audit_user");
    var login_id = "<%=user_id%>";
    if(audit_user == login_id){
    	alert("<fmt:message key='alert_cant_audit'/>");
        return;
    }
    showModalCenter("<%=request.getContextPath()%>/SalarybatchAction.do?cmd=applyPay&id=" + batchId,null,
                                                                            qrySalarybatch,800,430,"<fmt:message key='title_salarybatch'/>");
}
//查询
function qrySalarybatch(){
    $id("dc_salary_batch").reload();
}

</script>
</fmt:bundle>
</html>
