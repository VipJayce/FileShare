<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salaryPayAudit.salaryPayAudit_resource" prefix="rayoo.salary.salaryPayAudit.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_salaryPayAudit'/></title>
</head>

<body>
<div id="right">
  <div class="ringht_s">
    <div class="social_tab">
	    <div id="bg" class="social_xixi1">
	      <div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'"><fmt:message key='title_salaryPayAudit'/></div>
	      <div id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'"><fmt:message key='title_bankInterface'/></div>
        </div>
      <div id="TabCon1">
	      <div class="xz_title" style="margin-top:10px;"><fmt:message key='title_search'/></div>
	      <div class="ringht_x">
	        <div class="box_tab">
	          <form id="formPayAudit" action="" method="post">
	          <input type="hidden" name="batchId" id="h_batchId"/>
	          <input type="hidden" name="clzId" id="h_clzId"/>
	          <input type="hidden" name="cmd" id="h_cmd"/>
	          <input type="hidden" name="filename" id="h_filename"/>
	          <input type="hidden" name="filepath" id="h_filepath"/>
	          <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
	            <tr>
	              <td class="td_1"><fmt:message key='submit_time'/></td>
	              <td class="td_2">
	              <w:date allowInput="false" id="w_from" name="submit_time_from" format="yyyy-MM-dd" style="width:75px;"/>
	              <w:date allowInput="false" id="w_to" name="submit_time_to" format="yyyy-MM-dd" style="width:75px;"/>
                  </td>
	              <td class="td_1"><fmt:message key='customer_code'/></td>
	              <td class="td_2"><input name="customer_code" class="sText" /></td>
	              <td class="td_1"><fmt:message key='customer_name'/></td>
	              <td class="td_2">
	               <w:lookup name="customer_name" onReturnFunc="rtnFunc" id="lk_clz" 
	               lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="select_cust" height="500" width="600"/>
                    <input type="hidden" name="customer_id" id="h_customer_id"/>
	              </td>
                </tr>
	            <tr>
	              <td class="td_1"><fmt:message key='sa_batch_code'/></td>
	              <td class="td_2"><input name="sa_batch_code" class="sText" /></td>
	              <td class="td_1">上传人</td>
	              <td class="td_2">
	              	<r:comboSelect id="combo_cs" name="create_user_id"
                       queryAction="CustServiceAction.do?cmd=getListDataTwo"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select" />
	              </td>
	              <td class="td_1"><fmt:message key='must_day'/></td>
	              <td class="td_2"><input name="must_day" class="sText" id="txt_must_day"/></td>
	            </tr>
	            <tr>
	              <td class="td_1"><fmt:message key='audit_state'/></td>
	              <td class="td_2">
	               <d:select nullLabel="请选择" name="audit_state" dictTypeId="AUDIT_STATE" value="0"/>
	              </td>
	              <td class="td_1">&nbsp;</td>
	              <td class="td_2">&nbsp;</td>
	              <td class="td_2">&nbsp;</td>
	              <td class="td_2"><input onclick="qryPayAudit()" class="icon_1" value="<fmt:message key='button_search'/>" /></td>
                </tr>
              </table>
	          <div class="button">
	            <div class="button_right">
	              <!--<ul>
	                <li class="xz_2"><a onclick="downBill()" href="javascript:void(0);">下载收费单</a></li>
	                <li class="a_1"><a onclick="viewItem()" href="javascript:void(0);">明细数据</a></li>
	                <li class="g_1"><a onclick="dataVerify()" href="javascript:void(0);">数据确认</a></li> 
                    <li class="xz_1"><a onclick="downFinancialSheet()" href="javascript:void(0);">下载财务报表</a></li> 					<li class="xz_1"><a onclick="goEbankPage()" href="javascript:void(0);">下载网银</a></li>
                    <li class="g_1"><a onclick="submitAudit()" href="javascript:void(0);">提交</a></li> 
                    <li class="tb" style="margin-left:220px; "><a href="javascript:void(0);" onclick="rejectAudit()">驳回</a></li>
                  </ul>
                  -->
                  <input class="xz_2" type="button"   value="<fmt:message key='button_xzsfd'/>" <au:authorityBtn code="gzsh_xzsfd" type="1"/>  onClick="downBill();">
			      <input class="a_1" type="button"   value="<fmt:message key='button_viewItem'/>"  <au:authorityBtn code="gzsh_viewItem" type="1"/>  onClick="viewItem();">
			      <input class="xz_2" type="button"   value="<fmt:message key='button_downItem'/>" <au:authorityBtn code="gzsh_viewItem" type="1"/>  onClick="downItem();">
			      <input class="g_1" type="button"   value="<fmt:message key='button_sjqr'/>"  <au:authorityBtn code="gzsh_sjqr" type="1"/>  onClick="dataVerify();">
			      <input class="xz_1" type="button"   value="<fmt:message key='button_xzcwbb'/>"  <au:authorityBtn code="gzsh_xzcwbb" type="1"/>  onClick="downFinancialSheet();">   
			      <input class="xz_1" type="button"   value="<fmt:message key='button_xzwy'/>"  <au:authorityBtn code="gzsh_xzwy" type="1"/>  onClick="goEbankPage();">
			      <input class="g_1" type="button"   value="<fmt:message key='button_submit'/>"  <au:authorityBtn code="gzsh_tj" type="1"/>  onClick="submitAudit();">
			      <input class="tb" style="margin-left: 65px;" type="button"   value="<fmt:message key='button_bh'/>"  <au:authorityBtn code="gzsh_bh" type="1"/>  onClick="rejectAudit();">
                </div>
	            <div class="clear"></div>
              </div>
            </div>
            <r:datacell id="dc_sa_pay_audit" 
                queryAction="/FAERP/SalaryPayAuditAction.do?cmd=simpleQuery"
                submitAction=""
                width="100%"
                pageSize="100"
                paramFormId="formPayAudit"
                submitXpath="SalaryPayAuditVo" 
                xpath="SalaryPayAuditVo">
              <r:toolbar  tools="nav,pagesize,info"/>
              <r:field  fieldName="rid" label="NO." width="30px">
              </r:field>
              <r:field  fieldName="sa_batch_code" messagekey="sa_batch_code">
                
              </r:field>
              <r:field  fieldName="customer_code" messagekey="customer_code">
                
              </r:field>
              <r:field  fieldName="customer_name" messagekey="customer_name" width="440px">
              
              </r:field>
            <r:field  fieldName="submit_time" messagekey="submit_time">
            </r:field>
            <r:field  fieldName="audit_user" label="审核人">
            </r:field>
            <r:field  fieldName="submit_user" label="上传人">
              
            </r:field>
            <r:field  fieldName="cs_dept" messagekey="cs_dept" width="100px">
            </r:field>                    
            <r:field  fieldName="pay_year_month" messagekey="pay_year_month">
              
            </r:field>
            <r:field  fieldName="must_day" messagekey="must_day">
              
            </r:field>
            <r:field  fieldName="audit_state" messagekey="audit_state" allowModify="false">
              <d:select name="audit_state_list" dictTypeId="AUDIT_STATE"/>
            </r:field>
            <r:field  fieldName="reject_reason" label="驳回原因" allowModify="false">
               <d:select name= "reject_reason" id="reject_reason" dictTypeId= "REJECT_REASON" ></d:select >
            </r:field>
            <r:field  fieldName="reject_number" label="驳回人数">
            
            </r:field>
            <r:field  fieldName="reject_cause" label="驳回备注">
            
            </r:field>
            <r:field  fieldName="file_pwd" messagekey="file_pwd">
              
            </r:field>
            <r:field  fieldName="emp_differ_list" messagekey="emp_differ_list">
              
            </r:field>
            <r:field  fieldName="emp_differ_cause" messagekey="emp_differ_cause">
              
            </r:field>
            <r:field  fieldName="sum_differ_list" messagekey="sum_differ_list">
              
            </r:field>
            <r:field  fieldName="sum_differ_cause" messagekey="sum_differ_cause">
              
            </r:field>
            <r:field  fieldName="e_tax_list" messagekey="e_tax_list">
              
            </r:field>
            <r:field  fieldName="e_fund_list" messagekey="e_fund_list">
              
            </r:field>
            <r:field  fieldName="only_tax_list" messagekey="only_tax_list">
              
            </r:field>
            <r:field  fieldName="alien_list" messagekey="alien_list">
              
            </r:field>
            <r:field  fieldName="other_cause" messagekey="other_cause" width="440px">
            </r:field>
              <r:field  fieldName="remarks" messagekey="remarks">
                
              </r:field>
            </r:datacell> 
          </div>
          </form>
      </div>
      <div id="TabCon2" style="display:none;">
        <form id="ebankForm">
          <input type="hidden" name="batchId" id="h_batchId_ebank"/>
          <input type="hidden" name="bankType" id="h_bankType_ebank"/>
          <input type="hidden" name="cmd" id="h_cmd_ebank"/>
	      <div class="box_tab">
	        <div class="xz_title"><fmt:message key='title_search'/></div>
	        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	          <tr>
                <td class="td_1"><fmt:message key='w_apply_pay_date'/></td>
	            <td class="td_2"><w:date allowInput="false" id="w_apply_pay_date" name="apply_pay_date" format="yyyy-MM-dd"/></td>
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
	            <td class="td_1"><fmt:message key='total_amount'/></td>
	            <td class="td_2"><input id="n_total_amount_f" name="total_amount_f" class="sText_1" />
                  <input id="n_total_amount_t" name="total_amount_t" class="sText_1" /></td>
	            <td class="td_2">&nbsp;</td>
	            <td class="td_2">&nbsp;</td>
              </tr>
	          <tr>
	            <td colspan="6" align="center" class="td_2">
	            <input onclick="qrySalarybatch()" type="button" class="icon_1" value="<fmt:message key='button_search'/>" />
	              &nbsp;&nbsp;&nbsp;&nbsp;
	            </td>
	          </tr>
            </table>
          </div>
          <r:datacell 
              id="dc_ebank"
              queryAction="/FAERP/SalarybatchAction.do?cmd=simpleQuery"
              submitAction="/FAERP/SalarybatchAction.do?cmd=update"
              width="100%"
              height="350px"
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
              <r:field  fieldName="apply_pay_date" messagekey="w_apply_pay_date" >
              </r:field>
              <r:field  fieldName="icbc_number" messagekey="icbc_number" >
              </r:field>
              <r:field  fieldName="cmb_number" messagekey="cmb_number" >
              </r:field>
              
              <r:field  fieldName="fail_number" messagekey="fail_number" >
              </r:field>
              <r:field  fieldName="total_number" messagekey="total_number" >
              </r:field> 
              <r:field  fieldName="total_amount" messagekey="total_amount" >
              </r:field>
            </r:datacell>
	      <div class="xz_title"><fmt:message key='downEbankfile'/></div>
	      <div class="foot_button"><span class="td_2">
	        <input id="btn_down_icbc" onclick="downEbankfile(1)" type="button" class="icon_3" value="<fmt:message key='button_downEbankfile_1'/>" />
	        &nbsp;&nbsp;&nbsp;&nbsp;
	        <input id="btn_down_cmb" onclick="downEbankfile(2)" type="button" class="icon_3" value="<fmt:message key='button_downEbankfile_2'/>" />
	        &nbsp;&nbsp;&nbsp;&nbsp;
	        <input id="btn_down_abc" onclick="downEbankfile(3)" type="button" class="icon_3" value="下载农行" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input id="btn_down_ccb" onclick="downEbankfile(4)" type="button" class="icon_3" value="下载建行" />
            &nbsp;&nbsp;&nbsp;&nbsp;
            <input id="btn_down_pufa" onclick="downEbankfile(5)" type="button" class="icon_3" value="下载浦发" />
	        </span> <span class="td_2">
			&nbsp;&nbsp;&nbsp;&nbsp;
	        <input type="button" class="icon_3" onClick="viewFail()" value="<fmt:message key='button_viewFail'/>" />
	        </span>
	        </div>
          </form>	        
        </div>
	  </div>
  </div>
 </div>
</body>
<script type="text/javascript">
jQuery(function(){
    //$id("dc_sa_pay_audit").isQueryFirst = false;
    $id("dc_ebank").isQueryFirst = false;
});
//查看失败员工
function viewFail(){
    obj = choose_row("dc_ebank");
    if(!obj)return;
    batchId = obj.getValue("id");
    showModalCenter("<%=request.getContextPath()%>/jsp/faerp/salary/salaryPayAudit/viewFail.jsp?batchId=" + batchId,null,null,
                                                                                        800,500,"<fmt:message key='button_viewFail'/>");
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

//选择客户
function rtnFunc(arg){
    var lookup = $id("lk_clz");
    lookup.value = arg[2];
    lookup.displayValue = arg[2];
    jQuery("#h_customer_id").val(arg[0]);        
    return false;
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
function qrySalarybatch(){
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
        alert("<fmt:message key='alert_is_number'/>");
        return false;
    }
    if(f && t && (t < f)){
        alert("<fmt:message key='alert_fail_number'/>");
        return false;
    }
    return true;
}
//查询
function qryPayAudit(){
	md = $id("txt_must_day").value;
	if(md && !isInteger(md)){
        alert("<fmt:message key='alert_txt_must_day'/>");
        return false;
    }
    $id("dc_sa_pay_audit").reload();
}
//查看明细
function viewItem(){
    obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    batchId = obj.getValue("id");
    clzId = obj.getValue("sa_class_id");
    //alert(batchId);
    $id("formPayAudit").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do";
    $id("h_cmd").value = "toDetail";
    $id("h_batchId").value = batchId;
    $id("h_clzId").value = clzId;
    $id("formPayAudit").submit();
}
//数据确认
function dataVerify(){
    obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    batchId = obj.getValue("id");
    audit_state = obj.getValue("audit_state");
    if(audit_state == 1 || audit_state == 3){
    	alert("<fmt:message key='alert_audit_state_3'/>");
    	return;
    }
    
    if(window.confirm("<fmt:message key='alert_is_confirm'/>")){
       showProgressBar();
       jQuery.post("<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=dataVerify&batchId="+batchId,function(data){
           if(data){
           	hideProgressBar();
            alert("<fmt:message key='alert_data_confirm'/>");
            obj.setProperty("audit_state","1");
            //$id("dc_sa_pay_audit").reload();
           }else{
           	hideProgressBar();
           	alert("<fmt:message key='alert_audit_state_3'/>");
           	$id("dc_sa_pay_audit").reload();
           }
       });
    }
}
//提交审核
function submitAudit(){
    obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    batchId = obj.getValue("id");
    audit_state = obj.getValue("audit_state");
    if(audit_state == 3){
    	alert("<fmt:message key='alert_audit_confirm'/>");
    	return;
    }else if(audit_state == 0 || audit_state == 2 ){
    	alert("<fmt:message key='alert_no_audit'/>");
    	return;
    }
    
    if(window.confirm("<fmt:message key='alert_is_submit'/>")){
       condition = jQuery("#formPayAudit").serialize();
       jQuery.post("<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=submitAudit&batchId="+batchId,function(data){
           if(data){
            alert("<fmt:message key='alert_submit_complete'/>");
            $id("dc_sa_pay_audit").reload();
           }
       });
    }
}
//驳回
function rejectAudit(){
    obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    batchId = obj.getValue("id");
    audit_state = obj.getValue("audit_state");
    if(audit_state == 2){
    	alert("<fmt:message key='alert_is_bh'/>");
    	return;
    }else if(audit_state == 1 || audit_state == 3 ){
    	alert("<fmt:message key='alert_no_bh'/>");
    	return;
    }
    batchCode = obj.getValue("sa_batch_code");
    cs_id = obj.getValue("submit_user_id");
    cs = obj.getValue("submit_user");
    cust_id = obj.getValue("customer_id");
    cust_nm = obj.getValue("customer_name");
    cust_cd = obj.getValue("customer_code");
    params = "&batchId=" + batchId + "&batchCode=" + batchCode + "&cs_id=" + cs_id + "&cs=" + cs 
            + "&cust_nm=" + cust_nm + "&cust_cd=" + cust_cd + "&cust_id=" + cust_id ;
    showModalCenter("<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=toRejectAudit" + params,null,freshdc,
                                                                                        600,300,"<fmt:message key='button_bh'/>");
}
//驳回后刷新datacell
function freshdc(){
	$id("dc_sa_pay_audit").reload();
}
//下载收费单
function downBill(){
    obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    batchId = obj.getValue("id");
    filename = obj.getValue("file_name");
    filepath = obj.getValue("file_path");
    $id("h_batchId").value = batchId;
    $id("h_cmd").value = "downBill";
    $id("h_filename").value = filename;
    $id("h_filepath").value = filepath;
    $id("formPayAudit").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
    $id("formPayAudit").submit();
}
//导出薪资明细
function downItem(){
    $id("h_cmd").value = "expSalaryDetail";
    var obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    var batchId = obj.getValue("id");
    var clzId = obj.getValue("sa_class_id");
    $id("formPayAudit").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do?batchId="+batchId+"&emp_ids=&clzId="+clzId+"&flag_in_finance=1" ;
    $id("formPayAudit").submit();
}
//下载财务报表
function downFinancialSheet(){
    obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    audit_state = obj.getValue("audit_state");
    if(audit_state ==0  || audit_state == 2){
    	alert("<fmt:message key='alert_earlier_confirm'/>");
    	return;
    }
    batchId = obj.getValue("id");
    $id("h_batchId").value = batchId;
    $id("h_cmd").value = "downFinancialSheet";
    $id("formPayAudit").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
    $id("formPayAudit").submit();
}
//下载网银
function downEbankfile(bankType){
    //obj = choose_row("dc_ebank");
    //if(!obj)return;
    //batchId = obj.getValue("id");
    var ids = getChkedRecord();
    if(ids.length<=0){
    	return;
    }
    $id("h_batchId_ebank").value = ids;
    $id("h_bankType_ebank").value = bankType;
    $id("h_cmd_ebank").value = "downEbankfile";
    $id("ebankForm").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
    $id("ebankForm").submit();
    /*//验证是否有对应的网银数据
    jQuery.post("<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=checkEbank&batchId="+ids+"&bankType="+bankType,function(data){
           if(data == "0"){
            //alert("没有对应的网银数据！");
            return;
           }else{
           	$id("h_batchId_ebank").value = ids;
		    $id("h_bankType_ebank").value = bankType;
		    $id("h_cmd_ebank").value = "downEbankfile";
		    $id("ebankForm").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
		    $id("ebankForm").submit();
           }
    });*/
    
}
//选择客服
function rtnFuncCS(arg){
    var lookup = $id("lk_cs");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#h_submit_user").val(arg[0]);        
    return false;
}
//跳转到网银接口页面
function goEbankPage(){
	obj = choose_row("dc_sa_pay_audit");
    if(!obj)return;
    audit_state = obj.getValue("audit_state");
    if(audit_state ==0  || audit_state == 2){
    	alert("<fmt:message key='alert_earlier_confirm'/>");
    	return;
    }
	setTab03Syn(2);
	document.getElementById('bg').className='social_xixi2';
	
	$id("w_apply_pay_date").setValue(obj.getValue("apply_pay_date"));
	$id("t_cust_cd").value = obj.getValue("customer_code");
	//$id("lk_clz2").setValue(obj.getValue("customer_name")) ;
	//$id("lk_clz2").setDisplayValue(obj.getValue("customer_name"));
	$id("h_customer_id2").value = obj.getValue("customer_id");
	$id("t_batch_cd").value = obj.getValue("sa_batch_code");
	//$id("n_total_amount_f").value = obj.getValue("total_amount");
	//$id("n_total_amount_t").value = obj.getValue("total_amount");
	qrySalarybatch();
}
//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
        procEbankdownBtn();
    } else {
        jQuery(":checkbox").attr("checked", false);
        procEbankdownBtn();
    }
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input type='checkbox' onclick='procEbankdownBtn();' name='chk_id' value='" + entity.getProperty("id") + "' />";
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
    if(len.length <= 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return "";
    }
    return len;
}
//获得选中的记录
function getChkedRecord2(){
	var total_icbc = 0;
	var total_cmb = 0;
	var ds = $id("dc_ebank").dataset;
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            var entity = ds.findEntity("id",this.value);
            var icbc = entity.getValue("icbc_number");
            var cmb = entity.getValue("cmb_number");
            total_icbc = total_icbc+icbc;
            total_cmb = total_cmb+cmb;
        }
    });
    if(total_icbc <= 0){
		 jQuery("#btn_down_icbc").attr("disabled","disabled");
	}else{
		 jQuery("#btn_down_icbc").removeAttr("disabled");
	}
    if(total_cmb <= 0){
		 jQuery("#btn_down_cmb").attr("disabled","disabled");
	}else{
		 jQuery("#btn_down_cmb").removeAttr("disabled");
	}
}
/**
*根据批次中的银行类别灰掉网银下载按钮
*/
function procEbankdownBtn(){
	getChkedRecord2();
}
</script>
</fmt:bundle>
</html>
