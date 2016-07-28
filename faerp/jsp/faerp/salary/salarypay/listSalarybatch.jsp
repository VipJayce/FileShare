<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.finance.receivable.MyUtils" %>
<%@ page import="java.sql.Timestamp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%
      String loadData = request.getParameter("loadData");
      request.setAttribute("loadData",loadData);
%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%
String strdate=MyUtils.Timestamp2String(new Timestamp(System.currentTimeMillis()), MyUtils.DEFAULT_DATE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<fmt:bundle basename="rayoo.salary.salarypay.salarypay_resource" prefix="rayoo.salary.salarypay.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_salarypay'/></title>
</head>
<script type="text/javascript">
jQuery(function(){
    //$id("dc_salary_batch").isQueryFirst = false;
    $id("dc_ebank").isQueryFirst = false;
    //申请发放日期默认为当天
    var _now = new Date();
    if("${loadData}" == "true"){
        $id("dc_salary_batch").loadData();
        $id("dc_salary_batch").refresh();
    }else{
        $id("w_from").setValue(_now);
        $id("w_to").setValue(_now);
    }
});

//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    //jQuery("#h_customer_id").val(arg[0]);        
    return false;
}
//选择客服
function rtnFuncCS(arg){
    var lookup = $id("lk_cs");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#h_submit_user_id").val(arg[0]);        
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
                                                                                        800,500,"<fmt:message key='title_salarypay_detail'/>");
}
//导出
function expBatch(){
    $id("salarybatchForm").action = "<%=request.getContextPath()%>/SalarybatchAction.do";
    $id("h_cmd").value = "expSalaryBatch";
    $id("salarybatchForm").submit();
}
//查询
function qrySalarybatch(){
	if(qryCheck()){
		$id("dc_salary_batch").reload();
	}
    
}
//验证查询条件
function qryCheck(){
    f = $id("txt_total_amount_f").value;
    t = $id("txt_total_amount_t").value;
    if((f && !isInteger(f)) || (t && !isInteger(t))){
        alert("<fmt:message key='alert_amount_num'/>");
        return false;
    }
    if(f && t && (t < f)){
        alert("<fmt:message key='alert_amount_fail'/>");
        return false;
    }
    var must_day = $id("t_must_day").value;
    if(must_day && (must_day<1 || must_day>31)){
      alert("<fmt:message key='alert_must_day_fail'/>");
      return false;
    }
    return true;
}
//发放
function doPaySalary(){
    dc = $id("dc_salary_batch");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    if(clz.getValue("is_verify") != 1){
        alert("<fmt:message key='alert_no_verify'/>");
        return;
    }
    batchId = clz.getValue("id");
    if(clz.getValue("pay_state") == 1){
        alert("<fmt:message key='alert_pay_state'/>");
        return;
    }
    if(clz.getValue("apply_pay_state") == 0){
        alert("<fmt:message key='alert_earlier_apply'/>");
        return;
    }
    var sa_class_id = clz.getValue("sa_class_id");
    if(window.confirm("<fmt:message key='alert_is_provide'/>")){
    	showProgressBar();
    	jQuery.post("<%=request.getContextPath()%>/SalarybatchAction.do?cmd=doPaySalary&batchId="+batchId+"&clzId="+sa_class_id,function(data){
	       if(data){
	       	hideProgressBar();
	       	alert(data);
	        dc.reload();
	       }else{
	       	hideProgressBar();
	        alert("<fmt:message key='alert_provide_fail'/>");
	       }
    	});
    }
    
    return false;
}
//显示一般的链接
function showLink(){
    return "<a href='#' onclick='doPaySalary()' " +
    "style='color: #0033CC; font-weight: bold; text-decoration: underline;'><fmt:message key='button_provide'/></a>";
}
//网银接口选择客户
function rtnFunc2(arg){
    var lookup = $id("lk_clz2");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    jQuery("#h_customer_id2").val(arg[0]);        
    return false;
}
//网银接口查询
function qrySalarybatch_ebank(){
    if(qryCheck()){
        $id("dc_ebank").reload();
    }
    return;
}
//验证查询条件
function qryCheck(){
    f = $id("n_total_amount_f").value;
    t = $id("n_total_amount_t").value;
    if((f && !isInteger(f)) || (t && !isInteger(t))){
        alert("<fmt:message key='alert_amount_num'/>");
        return false;
    }
    if(f && t && (t < f)){
        alert("<fmt:message key='alert_amount_fail'/>");
        return false;
    }
    return true;
}
//查看失败员工
function viewFail(){
    obj = choose_row("dc_ebank");
    if(!obj)return;
    batchId = obj.getValue("id");
    showModalCenter("<%=request.getContextPath()%>/jsp/faerp/salary/salaryPayAudit/viewFail.jsp?batchId=" + batchId,null,null,
                                                                                        800,500,"<fmt:message key='title_view_erremp'/>");
}
//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
    } else {
        jQuery(":checkbox").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id' value='" + entity.getProperty("id") + "' />";
}
//获得选中的记录
function getChkedRecord(){
	var ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    var len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return "";
    }
    return len;
}

/***************获取选中批次的发放状态*****************/
    function  getPayState() {                   
       var ds1 = $id("dc_ebank").dataset;
       var fields = $id("dc_ebank").fields;
       var flag="true";//未发放
       var paystate =null;
       var j=0;
       jQuery("input[name='chk_id']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
           var curEnt = ds1.get(i);
           var  paystate_new =  curEnt.getValue("pay_state")
            if(j==0){//第一次进来赋值
            paystate=paystate_new;
            j=1;
            }
            if(paystate!=paystate_new){//和第一个比对，如果有不一直的则把标志改为false
                flag="false";
            }
          }
        });
       return flag;                
    } 

//下载网银
function downEbankfile(bankType){
    var ids = getChkedRecord();
    var state=getPayState();
    if(ids.length<=0){
    	return;
    }
    if(state=="false"){
          alert("批次发放状态不一致，不能下载网银！");
          $id("dc_ebank").dataset()="";
          return;
    }
    $id("h_batchId_ebank").value = ids;
            $id("h_bankType_ebank").value = bankType;
            $id("h_cmd_ebank").value = "downEbankfile";
            $id("ebankForm").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
            $id("ebankForm").submit();
    
}
//datacell 选中一行返回entity
function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
    if(!obj){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    return obj;
}

//格式化页面显示金额 add by sqp2013年12月9日 
function toformatnumber(value,entity,rowNo,cellNo){
    return formatNumber(value,"#,###.00'");
}

//add by sqp  2013年12月11日 
 //审批详细操作
    function spinto_onClick(){
    dc = $id("dc_salary_batch");
    clz = dc.getActiveEntity();
    if(!clz){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
        var  finpaymentid = clz.getValue("pay_audit_id");
        var wfname="SheBaoGongJiJinPayWorkFlow<%=   rayoo.common.filter.UserInfoFilter.geCompanyId()%>";//此业务对应合同审批名称  
        //检查此单据是否正在走流程
        WfCommonAjax.checkCurrentWf(wfname,finpaymentid,function(reData){
                if(reData=='0'){
                    //没有进行发起过审批
                    alert("<fmt:message key="no_operation"/>");
                    return;
                }   
                else{
                //跳转到流程详细信息页面
                var url = "/FAERP/jsp/faerp/salary/salarypay/processdetailpage.jsp?finpaymentid=" + finpaymentid+"&wfname="+wfname+"&_ts="+(new Date()).getTime();
                showModalCenter(url, window, callBack,740, 360, "<fmt:message key="examine_info"/>"); 
                }   
            }
         );        
    
    }
    
        function callBack(reg){
            $id("dc_salary_batch").loadData();
            $id("dc_salary_batch").refresh();
    }


</script>
<body>
<div id="right">
    <div class="ringht_s">
    <div class="social_tab">
    	<div id="bg" class="social_xixi1">
	      <div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'"><fmt:message key='title_salarypay'/></div>
	      <div id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'"><fmt:message key='title_ebank'/></div>
        </div>
      <!--查询 -->
      <div id="TabCon1">
      <form id="salarybatchForm" method="post">
	  <input type="hidden" id="h_cmd" name="cmd"/>
	  <!--默认查询条件，申请发放状态：已申请 -->
	  <input type="hidden" id="h_apply_pay_state" name="apply_pay_state" value="1"/>
	  <input type="hidden" id="h_is_verify" name="is_verify" value="1"/>
	  <input type="hidden" id="h_audit_status" name="audit_status" value="4"/>
	  	<div class="box_tab">
        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='customer_code'/></td>
            <td class="td_2"><input name="customer_code" class="sText" id="t_customer_code"/></td>
            <td class="td_1"><fmt:message key='customer_name'/></td>
            <td class="td_2">
                <w:lookup name="customer_name" onReturnFunc="rtnFunc" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
                messagekey="select_cust" height="500" width="600" style="width: 170px"/>
                <input type="hidden" name="customer_id" id="h_customer_id"/>
            </td>
            <td class="td_1"><fmt:message key='submit_user'/></td>
            <td class="td_2">
            	<r:comboSelect id="combo_cs" name="submit_user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="190px" 
                       messagekey="please_select"/>
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='must_day'/></td>
            <td class="td_2"><input name="must_day" class="sText" id="t_must_day"/></td>
            <td class="td_1"><fmt:message key='audit_user'/></td>
            <td class="td_2">
                <input name="audit_user_name" class="sText" id="t_audit_user"/>
            </td>
            <td class="td_1"><fmt:message key='sa_batch_code'/></td>
            <td class="td_2">
                <input name="sa_batch_code" class="sText" id="t_sa_batch_code"/>
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='total_amount'/></td>
            <td class="td_2">
                <input name="total_amount_f" id="txt_total_amount_f" class="sText"  style="width:91px;"/>
                <input name="total_amount_t" id="txt_total_amount_t" class="sText"  style="width:91px;"/>
            </td>
            <td class="td_1"><fmt:message key='pay_state'/></td>
            <td class="td_2">
               <select class="sSelect" name="pay_state">
                   <option value=""><fmt:message key='please_select'/></option> 
                   <option selected="true" value="0"><fmt:message key='pay_state_0'/></option>
                   <option value="1"><fmt:message key='pay_state_1'/></option>
               </select>
            </td>
            <td class="td_1"><fmt:message key='apply_pay_date'/></td>
            <td class="td_2">
            <w:date allowInput="false" id="w_from" name="apply_pay_date_from" format="yyyy-MM-dd" style="width:76px;"/>
            <w:date allowInput="false" id="w_to" name="apply_pay_date_to" format="yyyy-MM-dd" style="width:76px;"/>
            </td>
          </tr>

        </table>
        <div class="mx_button" style="text-align: center;margin-top: 5px;">
        <input type="button" class="icon_2" value="<fmt:message key='button_search'/>" onClick="javascript:qrySalarybatch();" />
        </div> 
        
        </div>
        <div class="button">
            <div class="button_right">
                <!--<ul>
                    <li class="a_2"><a onClick="viewItem()" href="javascript:void(0);">查看详细</a></li>
                    <li class="e"><a onclick="expBatch()" href="javascript:void(0);">导出</a></li>                    
                </ul>
                -->
                <input class="a_2" type="button"   value="<fmt:message key='button_viewItem'/>"  <au:authorityBtn code="gzff_viewItem" type="1"/>  onClick="viewItem();">
                <input class="g_1" type="button"   value="<fmt:message key='button_provide'/>"  <au:authorityBtn code="gzff_ffang" type="1"/>  onClick="doPaySalary();">
                <input class="e" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="gzff_exp" type="1"/>  onClick="expBatch();">
                <input class="approdetial" type="button"   value="<fmt:message key="examine_info"/>"    onClick="spinto_onClick();">
            </div>
            <div class="clear"></div>
        </div>
        <div style="margin-top: 5px;">
        <r:datacell 
              id="dc_salary_batch"
              queryAction="/FAERP/SalarybatchAction.do?cmd=simpleQuery"
              submitAction="/FAERP/SalarybatchAction.do?cmd=update"
              width="100%"
              pageSize="100"
              xpath="SalarybatchVo"
              submitXpath="SalarybatchVo"
              paramFormId="salarybatchForm"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      		  <r:field  fieldName="rid" label="NO." width="30px">
              </r:field>
              <r:field  fieldName="sa_batch_code" messagekey="sa_batch_code" >
              </r:field>
               <r:field  fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field  fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field  fieldName="pay_year_month" messagekey="pay_year_month">
              </r:field>
              <r:field  fieldName="total_amount" messagekey="total_amount"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="total_number" messagekey="total_number" >
              </r:field>
              <r:field  fieldName="icbc_number" messagekey="icbc_number" onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="cmb_number" messagekey="cmb_number" onRefreshFunc="toformatnumber" >
              </r:field>
              <r:field  fieldName="fail_number" messagekey="fail_number"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="pay_state" messagekey="pay_state" allowModify="false">
                <h:select name="list_pay_state" property="pay_state">
                   <h:option value="0" label="待发放"></h:option>
                   <h:option value="1" label="已发放"></h:option>
                </h:select>
              </r:field>
              <r:field  fieldName="payroll_type_bd" messagekey="payroll_type_bd" allowModify="false">
                   <d:select dictTypeId="PAYROLL_TYPE_BD"/>
              </r:field>
              <r:field  fieldName="verify_time" messagekey="verify_time" >
              </r:field>
              <r:field  fieldName="audit_user_name" messagekey="audit_user" >
              </r:field>
              <r:field  fieldName="pay_salary_type" messagekey="pay_salary_type" allowModify="false"><!-- sqp  修改为到款状态 2013年12月5日   fieldName="gen_money_code"-->
              <d:select  dictTypeId="PAY_SALARY_TYPE"   />
              </r:field>
              <r:field  fieldName="apply_pay_date" messagekey="apply_pay_date" >
              </r:field>
              <r:field  fieldName="submit_user" messagekey="submit_user" >
              </r:field>
              <r:field  fieldName="cs_dept" messagekey="cs_dept" width="100px">
                </r:field>                    
              <r:field  fieldName="real_pay_day" messagekey="real_pay_day" allowModify="false" width="150px">
              	<w:date format="yyyy-MM-dd HH:mm:ss" property="real_pay_day"/>
              </r:field>
              
              <!--<r:field fieldName="pay_state" label="发放" onRefreshFunc="showLink">
              </r:field>-->
        </r:datacell>
        </div>
        <!--表格 end-->
    	</form>
	</div>
	<div id="TabCon2" style="display:none;">
        <form id="ebankForm">
          <input type="hidden" name="batchId" id="h_batchId_ebank"/>
          <input type="hidden" name="bankType" id="h_bankType_ebank"/>
          <input type="hidden" name="cmd" id="h_cmd_ebank"/>
	      <div class="box_tab">
	        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	          <tr>
                <td class="td_1"><fmt:message key='w_apply_pay_date'/></td>
	            <td class="td_2"><w:date allowInput="false" id="w_apply_pay_date" name="apply_pay_date" format="yyyy-MM-dd" style="width:170px;"/></td>
	            <td class="td_1"><fmt:message key='customer_code'/></td>
	            <td class="td_2"><input id="t_cust_cd" name="customer_code" class="sText" /></td>
	            <td class="td_1"><fmt:message key='customer_name'/></td>
	            <td class="td_2">
	               <w:lookup name="customer_name" onReturnFunc="rtnFunc2" id="lk_clz2" 
	               lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="600"/>
                    <input type="hidden" name="customer_id" id="h_customer_id2"/>
	            </td>
              </tr>
	          <tr>
	            <td class="td_1"><fmt:message key='sa_batch_code'/></td>
	            <td class="td_2"><input id="t_batch_cd" name="sa_batch_code" class="sText" /></td>
	            <td class="td_1"><fmt:message key='n_total_amount'/></td>
	            <td class="td_2"><input id="n_total_amount_f" name="total_amount_f" class="sText_1" />
                  <input id="n_total_amount_t" name="total_amount_t" class="sText_1" /></td>
	            <td class="td_1"><fmt:message key='audit_user'/></td>
	            <td class="td_2">
	                <input name="audit_user_name" class="sText" id="t_audit_user"/>
	            </td>
              </tr>
	          <tr>
	          	<td class="td_1"><fmt:message key='submit_user'/></td>
	            <td class="td_2">
	            	<r:comboSelect id="combo_cs2" name="submit_user_id"
	                       queryAction="CustServiceAction.do?cmd=getListData&id=1099100700000000105"
	                       textField="name"
	                       valueField="partyId"
	                       xpath="CustServiceVo"
	                       width="190px" 
	                       messagekey="please_select" />
	            </td>
	            <td class="td_1"><fmt:message key='verify_pass_time'/></td>
	            <td class="td_2">
	            <w:date allowInput="false" id="v_from" name="verify_time_from" format="yyyy-MM-dd" style="width:76px;"/>
	            <w:date allowInput="false" id="v_to" name="verify_time_to" format="yyyy-MM-dd" style="width:76px;"/>
	            </td>
	            <td class="td_1"></td>
	            <td class="td_2">
	               <input id="btn_q" onclick="qrySalarybatch_ebank()" type="button" class="icon_3" value="<fmt:message key='button_search'/>" />
	            </td>
	          </tr>
            </table>
          </div>
          <r:datacell 
              id="dc_ebank"
              queryAction="/FAERP/SalarybatchAction.do?cmd=simpleQuery"
              submitAction="/FAERP/SalarybatchAction.do?cmd=update"
              width="100%"
              height="400px"
              pageSize="100"
              xpath="SalarybatchVo"
              submitXpath="SalarybatchVo"
              paramFormId="ebankForm"
              >
              <r:toolbar  tools="nav,pagesize,info"/>
      			<r:field fieldName="id" 
              label="<input type='checkbox' onclick='chk_all(this)' />" 
               width ="30px" onRefreshFunc="showchkbox"/>
              <r:field  fieldName="sa_batch_code" messagekey="sa_batch_code" >
              </r:field>
              <r:field  fieldName="pay_state" messagekey="sa_batch_code"  width="0"><!-- add by sqp 2014年3月27 日-->
              </r:field>
               <r:field  fieldName="customer_code" messagekey="customer_code" >
              </r:field>
              <r:field  fieldName="customer_name" messagekey="customer_name">
              </r:field>
              <r:field  fieldName="pay_year_month" messagekey="pay_year_month">
              </r:field>
               <r:field  fieldName="tax_month" messagekey="tax_month" >
              </r:field>
              <r:field  fieldName="ebank_time" messagekey="ebank_time" >
              </r:field>
              <r:field  fieldName="is_verify" messagekey="is_verify" allowModify="false">
                <h:select name="list_apply_state" property="is_verify">
                   <h:option value="1" label="是"></h:option>
                   <h:option value="0" label="否"></h:option>
                </h:select>
              </r:field>
              <r:field  fieldName="verify_time" messagekey="verify_time" >
              </r:field>
              <r:field  fieldName="apply_pay_date" messagekey="apply_pay_date" >
              </r:field>
              <r:field  fieldName="audit_user_name" messagekey="audit_user" >
              </r:field>
              <r:field  fieldName="submit_user" messagekey="submit_user" >
              </r:field>
              <r:field  fieldName="icbc_number" messagekey="icbc_number"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="cmb_number" messagekey="cmb_number" onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="cmb_other_number" messagekey="cmb_other_number"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="fail_number" messagekey="fail_number_"  onRefreshFunc="toformatnumber">
              </r:field>
              <r:field  fieldName="total_number" messagekey="total_number"  >
              </r:field> 
              <r:field  fieldName="total_amount" messagekey="total_amount_"  onRefreshFunc="toformatnumber">
              </r:field>
            </r:datacell>
	      	<div class="xz_title"><fmt:message key='button_download_ebank'/></div>
	      	<div class="foot_button"><span class="td_2">
	        <input onclick="downEbankfile(1)" type="button" class="icon_3" <au:authorityBtn code="gzff_wy_xzghbh" type="1"/> value="<fmt:message key='button_download_ebank_1'/>" />
	        &nbsp;&nbsp;&nbsp;&nbsp;
	        <input onclick="downEbankfile(2)" type="button" class="icon_3" <au:authorityBtn code="gzff_wy_xzzhbh" type="1"/> value="<fmt:message key='button_download_ebank_2'/>" />
	        &nbsp;&nbsp;&nbsp;&nbsp;
	        <input id="btn_down_abc" onclick="downEbankfile(3)" type="button" class="icon_3" value="下载农行" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input id="btn_down_ccb" onclick="downEbankfile(4)" type="button" class="icon_3" value="下载建行" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input id="btn_down_pufa" onclick="downEbankfile(5)" type="button" class="icon_3" value="下载浦发" />
            </span> <span class="td_2">
	        <!--<input onclick="downEbankfile(0)" type="button" class="icon_3" <au:authorityBtn code="gzff_wy_xzzhth" type="1"/> value="下载招行它行" />-->
	        </span> <span class="td_2">
			&nbsp;&nbsp;&nbsp;&nbsp;
	        <input type="button" class="icon_3" onClick="viewFail()" <au:authorityBtn code="gzff_wy_cksbyg" type="1"/> value="<fmt:message key='button_download_viewFail'/>" />
	        </span>
	        </div>
          </form>	        
        </div>
        
</div>
</div>
</div>
</body>
</fmt:bundle>
</html>
