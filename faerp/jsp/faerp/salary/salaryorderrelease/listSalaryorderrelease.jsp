<%@ page contentType="text/html; charset=UTF-8" %>
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
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.salaryorderrelease.salaryorderrelease_resource" prefix="rayoo.salary.salaryorderrelease.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_salaryorderrelease'/></title>
<script language="javascript">
	jQuery(function(){
	    if("${loadData}" != "true"){
	       $id("dc_saorderreleaseid").isQueryFirst = false;
	    }
	    $id("dc_releasecompanyid").isQueryFirst = false;
	    $id("dc_saorderreleaseempid").isQueryFirst = false;
	    //工资单类型列标红
	    $id("dc_saorderreleaseid").afterRefresh = function(){
        var Me = $id("dc_saorderreleaseid");
        var rows = Me.allTR;
        for (var i=0;i<rows.length;i++ ){
          var cells = rows[i].cells;
          for (var j=0;j<cells.length;j++ ){
            var cell = cells[j];
            var field = Me.getField(cell);
            if(field.fieldName=="payroll_type_bd"){
                cell.style.backgroundColor = "red";
            }
          }
        }        
    }
	});
	//tab切换
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabConInner1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("TabCon3").style.display="none";
            document.getElementById("TabConInner3").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            document.getElementById("font3").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("TabCon3").style.display="none";
            document.getElementById("TabConInner3").style.display="none";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font3").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
            case 3:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("TabCon3").style.display="block";
            document.getElementById("TabConInner3").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#000000";
            document.getElementById("font3").style.color="#ffffff";
            break;
        }
    }


function toselect_onclick() { 
        $id("dc_saorderreleaseid").reload() ;
}
function toselect_onclick_company() { 
        $id("dc_releasecompanyid").reload() ;
}
function toselect_onclick_emp() { 
        $id("dc_saorderreleaseempid").reload() ;
}
    
function viewItemCP(){
   var obj = choose_row("dc_releasecompanyid");
    var batchId = obj.getValue("id");
    var clzId = obj.getValue("sa_class_id");
    $id("salaryorderformcompany").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do";
    $id("h_cmd").value = "toDetail";
    $id("h_batchId").value = batchId;
    $id("h_clzId").value = clzId;
    $id("salaryorderformcompany").submit();
}
function viewItemEmp(){
   var obj = choose_row("dc_saorderreleaseempid");
    var batchId = obj.getValue("id");
    var emp_id = obj.getValue("emp_id") ;
    var clzId = obj.getValue("sa_class_id");
    $id("salaryorderformemp").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do";
    $id("h_cmd_emp").value = "toDetail";
    $id("h_batchId_emp").value = batchId;
    $id("h_clzId_emp").value = clzId;
    $id("h_empId_emp").value = emp_id;
    $id("salaryorderformemp").submit();
}

function toemail_onclick(){
   var obj = choose_row("dc_saorderreleaseid");
    var batchId = obj.getValue("id");
    var clzId = obj.getValue("sa_class_id");
    $id("salaryorderform").action = 
    	"<%=request.getContextPath()%>/jsp/faerp/salary/salaryorderrelease/payemaillist.jsp?batchId="+batchId+"&clzId="+clzId;
    $id("salaryorderform").submit();
}

function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
    if(!obj){
        alert("<fmt:message key='alert_select_one'/>");
        return ;
    }
    return obj;
}


function rtnFuncCustomer_s(arg){
    var lookup = $id("customer_name_s");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
 }
function rtnFuncCustomer_c(arg){
    var lookup = $id("customer_name_c");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
 }
function rtnFuncCustomer_e(arg){
    var lookup = $id("customer_name_e");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
 }
 //保密工资单打印
 function payrollPrt(flag){
 	var obj = choose_row("dc_saorderreleaseid");
    var batch_id = obj.getValue("id");
    if(!batch_id){
    	alert("<fmt:message key='alert_select_record'/>");
    	return;
    }
    var raq_file = "report_security_payroll.raq";
    if(flag==2){
    	raq_file = "report_spec_payroll.raq";
    }
    var class_id = obj.getValue("sa_class_id");
    var param = "raq="+raq_file+"&batch_id="+batch_id+"&class_id="+class_id;
 	$id("salaryorderform").action = 
 		"<%=request.getContextPath()%>/jsp/faerp/reportJsp/showSecurityPayrollReport.jsp?"+param;
 	//更新工资单打印状态	
 	jQuery.post("<%=request.getContextPath()%>/SalaryorderreleaseAction.do?cmd=updateState&batchId="+batch_id+"&flag="+flag);
 		
 	$id("salaryorderform").submit();
 }
 //短信工资单
 function msg_onclick(){
    var obj = choose_row("dc_saorderreleaseid");
    var batch_id = obj.getValue("id");
    if(!batch_id){
        alert("请选择要操作记录！");
        return;
    }
    $id("salaryorderform").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=expMsgPayroll&batch_id="+batch_id; 
    $id("salaryorderform").submit();
 }
 
</script>
</head>
<body>
<div id="bg" class="reserve_xixi1">
          <div id="font1" class="reserve_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='reserve_xixi1'"><fmt:message key='title_salaryorderrelease'/></div>
          <div id="font2" class="reserve_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='reserve_xixi2'"><fmt:message key='title_company_search'/></div>
          <div id="font3" class="reserve_tab3" onMouseDown="setTab03Syn(3);document.getElementById('bg').className='reserve_xixi3'"><fmt:message key='title_emp_search'/></div>
        </div>
        <div id="TabCon1">
        <div id="right" class="search" >
        <form name="salaryorderform" method="post" id="salaryorderform" action="<%=request.getContextPath()%>/SalaryorderreleaseAction.do">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" align="center">
              <tr>
                <td class="td_1" align="center"><fmt:message key='customer_code'/></td>
                <td class="td_2"><input name="customer_code_s" type="text" class="sText" id="customer_code_s" value=""/></td>
                <td class="td_1" align="center"><fmt:message key='customer_name'/></td>
                <td class="td_2">
                <w:lookup onReturnFunc="rtnFuncCustomer_s" readonly="false" id="customer_name_s" name="customer_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
				messagekey="select_cust" height="440" width="600"  style="width:170px"/> 
                </td>
                <td class="td_1" align="center"><fmt:message key='payroll_type_bd'/></td>
                <td class="td_2">
                  <select name="payroll_type_bd_s" class="sSelect" >
                       <option value=""><fmt:message key='please_select'/></option><!-- modify by sqp  直接在该基础上添加了一个新的选项 --请选择-- -->
	                  <option value="1"><fmt:message key='payroll_type_1'/></option>
	                  <option value="2" selected><fmt:message key='payroll_type_2'/></option>
	                  <option value="3"><fmt:message key='payroll_type_3'/></option>
                  </select>
                <!--<d:select name="payroll_type_bd_s" dictTypeId="PAYROLL_TYPE_BD" nullLabel="请选择" value="1"/>
                --></td>
              </tr>
              <tr>
                <td class="td_1" align="center"><fmt:message key='pay_year_month'/></td>
                <td class="td_2"><input name="pay_year_month_s" type="text" class="sText" value=""/></td>
                <td class="td_1" align="center"><fmt:message key='real_pay_day'/></td>
                <td class="td_2"><w:date allowInput="false" id="real_pay_day_s" name="real_pay_day_s" format="yyyy-MM-dd" style="width:170px;"/></td>
                <td class="td_1" align="center"><fmt:message key='payroll_state_bd'/></td>
                <td class="td_2"><select name="payroll_state_bd_s" class="sSelect" >
                  <option value=""><fmt:message key='please_select'/></option>
                  <option value="1"><fmt:message key='payroll_state_1'/></option>
                  <option value="0" selected><fmt:message key='payroll_state_0'/></option>
                  </select></td>
              </tr>
              <tr>
                <td class="td_1" align="center"><fmt:message key='sa_batch_code'/></td>
                <td class="td_2"><input name="sa_batch_code_s" type="text" class="sText" value=""/></td>
                <td class="td_1" align="center"><fmt:message key='payroll_state_bd_special'/></td>
                <td class="td_2"><select name="payroll_state_bd_special" class="sSelect" >
                  <option value=""><fmt:message key='please_select'/></option>
                  <option value="1"><fmt:message key='payroll_state_1'/></option>
                  <option value="0" selected><fmt:message key='payroll_state_0'/></option>
                  </select></td>
                <td class="td_1">&nbsp;</td>
                <td class="td_2">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="6" align="center" class="td_2"><span class="td_2">
                  <input name="button2" type="button" class="icon_1" onclick="toselect_onclick()"  value="<fmt:message key='button_search'/>" />
                </span></td>
              </tr>
            </table>
          </form>
          <div class="button">
            <div class="button_right">
              <!--<ul>
                <li class="zf"><a href="#">支付</a></li>
                <li class="j_1"><a href="#">打印特殊工资单</a></li>
                <li class="j_1"><a onclick="securityPayrollPrt()" href="javascript:void(0);">打印保密工资单</a></li>
                <li class="yj_1"><a onclick="toemail_onclick()">Email工资单</a></li>
              </ul>
              -->
              <input class="j_1" type="button" onclick="payrollPrt(2)" value="<fmt:message key='button_payroll_1'/>"  <au:authorityBtn code="gzdff_dytsgzd" type="1"/>>
              <input class="j_1" type="button"  onclick="payrollPrt(1)" value="<fmt:message key='button_payroll_2'/>" <au:authorityBtn code="gzdff_dybmgzd" type="1"/>>
              <input class="yj_1" type="button"  value="<fmt:message key='button_payroll_3'/>" <au:authorityBtn code="gzdff_mailgzd" type="1"/>  onClick="toemail_onclick();">
              <input class="yj_1" type="button"  value="短信工资单" <au:authorityBtn code="gzdff_mailgzd" type="1"/>  onClick="msg_onclick();">
            </div>
            <div class="clear"></div>
          </div>
          </div></div>
           <div id="TabConInner1" >
        <r:datacell id="dc_saorderreleaseid"
            queryAction="/FAERP/SalaryorderreleaseAction.do?cmd=seachSalaryOrderRelease"
            submitAction=""
            pageSize="100"
            width="100%" xpath="SalaryorderreleaseVo" submitXpath="SalaryorderreleaseVo"
            paramFormId="salaryorderform" height="310px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field  fieldName="payroll_type_bd" messagekey="payroll_type_bd" width="100px" allowModify="false">
            	<d:select dictTypeId="PAYROLL_TYPE_BD" />
            </r:field>          
            <r:field  fieldName="payroll_state_bd" messagekey="payroll_state_bd" width="100px" allowModify="false">
            	<d:select dictTypeId="PAYROLL_STATE_BD"/>
            </r:field>
               <r:field  fieldName="payroll_state_bd_special" messagekey="payroll_state_bd_special" width="100px" allowModify="false">
                <d:select dictTypeId="PAYROLL_STATE_BD"/>
            </r:field>
            <r:field  fieldName="real_pay_day" messagekey="real_pay_day" width="100px">
            </r:field> 
            <r:field  fieldName="print_date" messagekey="print_date" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
            </r:field> 
            <r:field  fieldName="sa_batch_code" messagekey="sa_batch_code" width="100px">
            </r:field>
            <r:field  fieldName="pay_name" messagekey="pay_name" width="150px">
            </r:field>          
            <r:field  fieldName="pay_year" messagekey="pay_year" width="100px">
            </r:field>          
            <r:field  fieldName="pay_month" messagekey="pay_month" width="100px">
            </r:field>
            <r:field  fieldName="cs_dept" messagekey="cs_dept" width="100px">
            </r:field>                    
            <r:field  fieldName="customer_code" messagekey="customer_code" width="100px">
            </r:field>          
            <r:field  fieldName="customer_name" messagekey="customer_name" width="200px">
            </r:field>          
            <r:field  fieldName="total_number" messagekey="total_number" width="100px">
            </r:field>      
              <r:field  fieldName="baomi" messagekey="baomi_number" width="100px">
            </r:field>   
              <r:field  fieldName="teshu" messagekey="teshu_number" width="100px">
            </r:field>       
            <r:field  fieldName="total_amount" messagekey="total_amount" width="100px">
            </r:field>          
        </r:datacell>
        </div>
        
        <div id="TabCon2" style="display:none; ">
	        <div id="right" class="search"> 
	        <form name=salaryorderformcompany method="post" id="salaryorderformcompany" action="<%=request.getContextPath()%>/SalaryorderreleaseAction.do">
	        <input type="hidden" name="batchId" id="h_batchId"/>
	        <input type="hidden" name="clzId" id="h_clzId"/>
	        <input type="hidden" name="cmd" id="h_cmd"/>
                <table width="100%" border="0" cellspacing="1" cellpadding="0" >
                  <tr>
                    <td class="td_1" align="center"><fmt:message key='customer_code'/></td>
                    <td class="td_2"><input name="customer_code_c" type="text" class="sText" id="customer_code_c" value=""/></td>
                    <td class="td_1" align="center"><fmt:message key='customer_name'/></td>
                    <td class="td_2">
                    <w:lookup onReturnFunc="rtnFuncCustomer_c" readonly="false" id="customer_name_c" name="customer_name_c" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
messagekey="select_cust" height="440" width="600"  style="width:170px"/> 
                    </td>
                    <td class="td_1" align="center"><fmt:message key='total_amount_c'/></td>
                    <td class="td_2"><input name="total_amount_c" type="text" class="sText" id="total_amount_c" value=""/></td>
                  </tr>
                  <tr>
                    <td class="td_1" align="center"><fmt:message key='pay_year_c'/></td>
                    <td class="td_2"><input name="pay_year_c" type="text" class="sText" id="pay_year_c" value=""/></td>
                    <td class="td_1" align="center"><fmt:message key='pay_month'/></td>
                    <td class="td_2"><input name="pay_month_c" type="text" class="sText" id="pay_month_c" value=""/></td>
                    <td class="td_2">&nbsp;</td>
                    <td class="td_2"><input type="button" class="icon_1" onclick="toselect_onclick_company()" value="<fmt:message key='button_search'/>" /></td>
                  </tr>
                </table>
              </form>
              <div class="button">
                <div class="button_right">
                  <!--<ul>
                    <li class="a_1"><a  onclick="viewItemCP()">查看明细</a></li>
                  </ul>
                  -->
                  <input class="a_1" type="button"   value="<fmt:message key='button_viewItem'/>"  <au:authorityBtn code="gzdff_gsffcxCkmx" type="1"/>  onClick="viewItemCP();">
                </div>
                <div class="clear"></div>
              </div>
              
              </div></div>
              <div id="TabConInner2" style="display:none">
        <r:datacell id="dc_releasecompanyid"
            queryAction="/FAERP/SalaryorderreleaseAction.do?cmd=seachSalaryOrderReleaseCompany"
            submitAction=""
            pageSize="100"
            width="100%" xpath="SalaryorderreleaseVo" submitXpath="SalaryorderreleaseVo"
            paramFormId="salaryorderformcompany" height="320px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="customer_name" messagekey="customer_name" width="200px">
            </r:field>          
            <r:field fieldName="customer_code" messagekey="customer_code" width="100px">
            </r:field>          
            <r:field fieldName="sa_class_name" messagekey="sa_class_name" width="200px">
            </r:field>          
            <r:field fieldName="pay_year" messagekey="pay_year" width="100px">
            </r:field>          
            <r:field fieldName="pay_month" messagekey="pay_month" width="100px">
            </r:field>          
            <r:field fieldName="pay_name" messagekey="pay_name" width="100px">
            </r:field>          
            <r:field fieldName="total_amount" messagekey="total_amount_c" width="100px">
            </r:field>          
            <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100px">
            </r:field>          
            <r:field fieldName="tax_month" messagekey="tax_month" width="100px">
            </r:field>          
            <r:field fieldName="is_verify" messagekey="is_verify" width="100px">
            	<h:select property="is_verify">
                   <h:option value="1" label="是"></h:option>
                   <h:option value="0" label="否"></h:option>
                </h:select>
            </r:field>          
            <r:field fieldName="verify_time" messagekey="verify_time" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="real_pay_day" messagekey="real_pay_day" width="100px">
            </r:field>          
            <r:field fieldName="user_name" messagekey="user_name" width="100px">
            </r:field>          
            <r:field fieldName="audit_user" messagekey="audit_user" width="100px">
            </r:field>          
            <r:field fieldName="real_pay_day" messagekey="real_pay_day" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="is_pay" messagekey="is_pay" width="100px">
            	<h:select property="is_pay">
                   <h:option value="1" label="是"></h:option>
                   <h:option value="0" label="否"></h:option>
                </h:select>
            </r:field>          
            <r:field fieldName="pay_time" messagekey="pay_time" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="create_date" messagekey="create_date" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
        </r:datacell>
   </div>
        <div id="TabCon3" style="display:none;">
           <div id="right" class="search"> 
          <form name="salaryorderformemp" id="salaryorderformemp" method="post" action="<%=request.getContextPath()%>/SalaryorderreleaseAction.do">
              <input type="hidden" name="emp_id" id="h_empId_emp"/>
              <input type="hidden" name="batchId" id="h_batchId_emp"/>
	          <input type="hidden" name="clzId" id="h_clzId_emp"/>
	          <input type="hidden" name="cmd" id="h_cmd_emp"/>
              <table width="100%" border="0" cellspacing="1" cellpadding="0" >
                <tr>
                  <td class="td_1" align="center"><fmt:message key='customer_code'/></td>
                  <td class="td_2"><input name="customer_code_e" type="text" class="xText" id="customer_code_e"/></td>
                  <td class="td_1" align="center"><fmt:message key='customer_name'/></td>
                  <td class="td_2">
                   <w:lookup onReturnFunc="rtnFuncCustomer_e" readonly="false" id="customer_name_e" name="customer_name_e" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
messagekey="select_cust" height="440" width="600"  style="width:170px"/> 
                  </td>
                  <td class="td_1" align="center"><fmt:message key='bank_type_bd'/></td>
                  <td class="td_2"><select name="bank_type_bd_e" class="sSelect" id="bank_type_bd_e">
                    <option value=""><fmt:message key='please_select'/></option>
                    <option value="1"><fmt:message key='bank_type_1'/></option>
                    <option value="2"><fmt:message key='bank_type_2'/></option>
                    <option value="0"><fmt:message key='bank_type_0'/></option>
                    </select></td>
                </tr>
                <tr>
                  <td class="td_1" align="center"><fmt:message key='emp_code'/></td>
                  <td class="td_2"><input name="emp_code_e" type="text" class="xText" id="emp_code_e"/></td>
                  <td class="td_1" align="center"><fmt:message key='emp_name'/></td>
                  <td class="td_2"><input name="emp_name_e" type="text" class="xText" id="emp_name_e"/></td>
                  <td class="td_1" align="center"><fmt:message key='account_num'/></td>
                  <td class="td_2"><input name="account_num_e" type="text" class="xText" id="account_num_e"/></td>
                </tr>
                <tr>
                  <td class="td_1" align="center"><fmt:message key='pay_year_month'/></td>
                  <td class="td_2"><select name="pay_year_e" class="sSelect" id="pay_year_e">
                    <option value=""><fmt:message key='please_select'/></option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013">2013</option>
                        <option value="2014">2014</option>
                        <option value="2015">2015</option>
                        <option value="2016">2016</option>
                    </select></td>
                  <td class="td_1" align="center"><fmt:message key='pay_month'/></td>
                  <td class="td_2"><select name="pay_month_e" class="sSelect" id="pay_month_e">
                    <option value="" selected><fmt:message key='please_select'/></option>
                    <option value="01">1</option>
                        <option value="02">2</option>
                        <option value="03">3</option>
                        <option value="04">4</option>
                        <option value="05">5</option>
                        <option value="06">6</option>
                        <option value="07">7</option>
                        <option value="08">8</option>
                        <option value="09">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                    </select></td>
                  <td class="td_2">&nbsp;</td>
                  <td class="td_2"><input type="button" class="icon_1" onclick="toselect_onclick_emp()" value="<fmt:message key='button_search'/>" /></td>
                </tr>
              </table>
            </form>
            <div class="button">
              <div class="button_right">
                <!--<ul>
                  <li class="a_1"><a onclick="viewItemEmp()">查看明细</a></li>
                </ul>
                -->
                <input class="a_1" type="button"   value="<fmt:message key='button_viewItem'/>"  <au:authorityBtn code="gzdff_ygffcxCkmx" type="1"/>  onClick="viewItemEmp();">
              </div>
              <div class="clear"></div>
            </div>
            </div>
            </div>
            <div id="TabConInner3" style="display:none">
        <r:datacell id="dc_saorderreleaseempid"
            queryAction="/FAERP/SalaryorderreleaseAction.do?cmd=seachSalaryOrderReleaseEmp"
            submitAction=""
            pageSize="100"
            width="100%" xpath="SalaryorderreleaseVo" submitXpath="SalaryorderreleaseVo"
            paramFormId="salaryorderformemp" height="320px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="emp_code" messagekey="emp_code" width="150px">
            </r:field>          
            <r:field fieldName="emp_name" messagekey="emp_name" width="100px">
            </r:field>          
            <r:field fieldName="id_card" messagekey="id_card" width="200px">
            </r:field>          
            <r:field fieldName="customer_name" messagekey="customer_name" width="200px">
            </r:field>          
            <r:field fieldName="sa_class_name" messagekey="sa_class_name" width="200px">
            </r:field>          
            <r:field fieldName="pay_year" messagekey="pay_year" width="100px">
            </r:field>          
            <r:field fieldName="pay_month" messagekey="pay_month" width="100px">
            </r:field>          
            <r:field fieldName="pay_name" messagekey="pay_name" width="100px">
            </r:field>          
            <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100px">
            </r:field>          
            <r:field fieldName="tax_month" messagekey="tax_month" width="100px">
            </r:field>          
            <r:field fieldName="is_verify" messagekey="is_verify" width="100px" allowModify="false">
            	<h:select property="is_verify">
                   <h:option value="1" label="是"></h:option>
                   <h:option value="0" label="否"></h:option>
                </h:select>
            </r:field>          
            <r:field fieldName="real_pay_day" messagekey="real_pay_day" width="100px">
            </r:field>          
            <r:field fieldName="is_pay" messagekey="is_pay" width="100px" allowModify="false">
            	<h:select property="is_pay">
                   <h:option value="1" label="是"></h:option>
                   <h:option value="0" label="否"></h:option>
                </h:select>
            </r:field>          
            <r:field fieldName="pay_time" messagekey="pay_time" width="100px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="bank_type_bd" messagekey="bank_type_bd" width="100px" allowModify="false">
            	<d:select dictTypeId="BANK_TYPE_BD" property="bank_type_bd"/>
            </r:field>          
            <r:field fieldName="account_num" messagekey="account_num" width="130px">
            </r:field>          
        </r:datacell>
          </div>
</body>
</fmt:bundle>
</html>

