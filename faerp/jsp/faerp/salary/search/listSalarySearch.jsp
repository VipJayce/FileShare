<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.salary.search.search_resource" prefix="rayoo.salary.search.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

<!-- yangyuting add 2015-10-8  -->
<style type="text/css">
@media screen and (-webkit-min-device-pixel-ratio:0) { 
	#right{
	    width: 100%;
	    margin: 0 auto;
	    height: 20%;
	}
} 
</style>

<script language="javascript">

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
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }

    function toselect_onclick() {
    	var total_amount = $id("total_amount").value
    	if(total_amount & !isInteger(total_amount)){
	   		alert("<fmt:message key='alert_total_amount_num'/>");
	   		return;
		}
        $id("dc_searchid").reload() ;
    }
    function toselect_onclick_emp() { 
        $id("dc_searchid_emp").reload() ;
    }
    

    
    function rtnFuncCustomer(arg){
	    var lookup = $id("cust_name");
	    lookup.value = arg[2];
	    lookup.displayValue = arg[2];  
	    return false;
    }
    function rtnFuncCustomer_emp(arg){
	    var lookup = $id("customer_name_emp");
	    lookup.value = arg[2];
	    lookup.displayValue = arg[2];  
	    return false;
    }
    //查看明细
function viewItem(){
   var  obj = choose_row("dc_searchid");
   if(obj == null){return false ;}else{
    batchId = obj.getValue("id");
    //alert(batchId);
    $id("datacell_formid").action = "<%=request.getContextPath()%>/SalarybatchAction.do?cmd=list2item&forward_type=2&batch_id="+batchId;
   // $id("h_batchId").value = batchId;
    $id("datacell_formid").submit();
    return true ;
   }
}
    //查看明细
function viewItemEmp(){
   var  obj = choose_row("dc_searchid_emp");
   if(obj == null){return false ;}else{
    batchId = obj.getValue("id");
    var emp_id = obj.getValue("emp_id");
    var clzId=obj.getValue("clzId");
    //alert("batchId="+batchId+"emp_id="+emp_id);
   // $id("datacell_form_emp").action = "<%=request.getContextPath()%>/jsp/faerp/salary/salaryPayAudit/detail.jsp?batchId="+batchId+"&emp_id="+emp_id+"&clzId="+clzId+"&date=" + new Date();
   $id("datacell_form_emp").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=toDetail&batchId="+batchId+"&emp_id="+emp_id+"&clzId="+clzId+"&date=" + new Date();
   
 
    $id("h_batchId").value = batchId;
    $id("datacell_form_emp").submit();
    return true ;
   }
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


 jQuery(function(){
     $id("dc_searchid").isQueryFirst = false;
     $id("dc_searchid_emp").isQueryFirst = false;
 });
</script>
</head>
<body>

        <div id="bg" class="xixi1" >
            <div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key='title_company_search'/></div>
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'"><fmt:message key='title_emp_search'/></div>
        </div>


    <div id="TabCon1">
    
    <div id="right" class="search" >

        <form  id="datacell_formid" method="post" action="<%=request.getContextPath()%>/SaleryitemAction.do">
        <input name="h_batchId" id="h_batchId" type="hidden"/>
                <table width="100%" border="0" cellspacing="1" cellpadding="0" >
                  <tr>
                     <td class="td_1"  align="right"><fmt:message key='year'/></td>
                     <td class="td_2">
                     <select name="year" class="sSelect" id="year" style="width:80px;">
                        <option value=""><fmt:message key='please_select'/></option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013">2013</option>
                        <option value="2014">2014</option>
                        <option value="2015">2015</option>
                        <option value="2016">2016</option>
                      </select>
                      <select name="month" class="sSelect" id="month" style="width:80px;">
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
                      </select>
                      &nbsp;&nbsp;<span style="color:red;text-align:center;"><fmt:message key='year_month'/></span>
                      </td>
                    <td class="td_1"  align="right"><fmt:message key='customer_name'/></td>
                    <td class="td_2">
                    	<w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name" name="cust_name" 
                    	lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="span_select_customer" 
                    	height="440" width="600"  style="width:170px"/>
                     </td>
 
                    <td class="td_1"><fmt:message key='total_amount'/></td>
                    <td class="td_2"><input name="total_amount" type="text" class="sText" id="total_amount" value=""/></td>

                  </tr>
                  <tr>
                    <td class="td_1"></td>
                    <td class="td_2"></td>
                    <td class="td_2">&nbsp;</td>
                    <td class="td_2"><input type="button" class="icon_1" onclick="toselect_onclick() ;" value="<fmt:message key='button_search'/>" /></td>
                    <td class="td_2">&nbsp;</td>
                    <td class="td_2">&nbsp;</td>
                  </tr>
                </table>
                
        </form>

                  <!--按钮--><!--按钮 end-->
                     <!--表格 -->
                  <div class="button">
                       <div class="button_right">
                         <ul>
                           <li class="a_1"><a  onclick="viewItem()"><fmt:message key='button_viewItem'/></a></li>
                         </ul>
                       </div>
         
                  </div>
       </div>
              
       </div>    
                  
                  
                  
                  
                  <div id="TabConInner1" style="padding: 8 0 8 8;">
        <r:datacell id="dc_searchid"
            queryAction="/FAERP/SalarySearchAction.do?cmd=SearchSalary"
            submitAction="/FAERP/SalarySearchAction.do?cmd=insertSeachSalary"
            width="99%" xpath="SalarySearchVo" submitXpath="SalarySearchVo"
            pageSize="100"
            paramFormId="datacell_formid" height="320px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="customer_name" messagekey="customer_name" width="200px">
            </r:field>
            <r:field fieldName="customer_code" messagekey="customer_code" width="100px">
            </r:field>          
            <r:field fieldName="sa_class_name" messagekey="sa_class_name" width="200px">
            </r:field>          
            <r:field fieldName="pay_year_month" messagekey="pay_year_month" width="100px">
            </r:field>          
            <r:field fieldName="pay_name" messagekey="pay_name" width="120px">
            </r:field>          
            <r:field fieldName="total_amount" messagekey="total_amount" width="100px">
            </r:field>          
            <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100px">
            </r:field>          
            <r:field fieldName="tax_month" messagekey="tax_month" width="100px">
            </r:field>          
            <r:field fieldName="is_verify" messagekey="is_verify" width="100px">
            <h:select property="is_verify" disabled="true">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                  </h:select>
            </r:field>          
            <r:field fieldName="verify_time" messagekey="verify_time" width="100px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="real_pay_day" messagekey="real_pay_day" width="100px">
            </r:field>          
            <r:field fieldName="submit_user_id" messagekey="submit_user" width="100px">
            </r:field>          
            <r:field fieldName="audit_user" messagekey="audit_user" width="100px">
            </r:field>          
            <r:field fieldName="apply_pay_date" messagekey="apply_pay_date" width="100px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="is_pay" messagekey="is_pay" width="100px">
            <h:select property="is_pay" disabled="true">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                  </h:select>
            </r:field>          
            <r:field fieldName="pay_time" messagekey="pay_time" width="100px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="create_date" messagekey="create_date" width="100px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
        </r:datacell>
</div>    


    <div id="TabCon2" style="display:none">
        <div id="right" class="search"> 
        <form action="" method="post" id="datacell_form_emp">
        <input name="h_batchId" id="h_batchId" type="hidden"/>
                  <table width="100%" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                     <td class="td_1"  align="right"><fmt:message key='year'/></td>
                     <td class="td_2">
                     <select name="year_emp" class="sSelect" id="year_emp" style="width:80px;">
                        <option value=""><fmt:message key='please_select'/></option>
                        <option value="2009">2009</option>
                        <option value="2010">2010</option>
                        <option value="2011">2011</option>
                        <option value="2012">2012</option>
                        <option value="2013">2013</option>
                        <option value="2014">2014</option>
                        <option value="2015">2015</option>
                        <option value="2016">2016</option>
                      </select>
                      <select name="month_emp" class="sSelect" id="month_emp" style="width:80px;">
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
                      </select>
                      &nbsp;&nbsp;<span style="color:red;text-align:center;"><fmt:message key='year_month'/></span>
                      </td>
                    <td class="td_1" align="right"><fmt:message key='emp_code'/></td>
                      <td class="td_2"><input name="emp_code" type="text" class="xText" id="emp_code"/></td>
                      <td class="td_1" align="right"><fmt:message key='bank_type_bd'/></td>
                      <td class="td_2">
                      <d:select dictTypeId="BANK_TYPE_BD" name="bank_type_bd" id="bank_type_bd"  style="width:190px"/>
                      </td>
                  </tr>
                    <tr>
                     <td class="td_1" align="right"><fmt:message key='customer_name'/></td>
                      <td class="td_2">
                      <w:lookup onReturnFunc="rtnFuncCustomer_emp" readonly="false" id="customer_name_emp" name="customer_name_emp" 
                      lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="span_select_customer" height="440" width="600"  
                      style="width:170px"/>
                    </td>
                    <td class="td_1" align="right"><fmt:message key='emp_name'/></td>
                      <td class="td_2"><input name="emp_name" type="text" class="xText" id="emp_name"/></td>

                      <td class="td_1" align="right"><fmt:message key='bank_num'/></td>
                      <td class="td_2"><input name="bank_num" type="text" class="xText" id="bank_num"/></td>
                  </tr>
                    <tr>
                     <td class="td_1" align="right"></td>
                     <td class="td_2"></td>
	                 <td class="td_2">&nbsp;</td>
		             <td class="td_2"><input type="button" class="icon_1" onclick="toselect_onclick_emp()" value="<fmt:message key='button_search'/>" /></td>
		             <td class="td_2">&nbsp;</td> 
	                 <td class="td_2">&nbsp;</td>
                  </tr>

                </table>
              </form>

                <div class="button">
                  <div class="button_right">
                    <ul>
                      <li class="a_1"><a onclick="viewItemEmp()"><fmt:message key='button_viewItem'/></a></li>
                  </ul>
                </div>
                  <div class="clear"></div>
              </div>
              </div></div>
                <div id="TabConInner2" style="display:none;padding: 8 0 8 8;">
                    <r:datacell id="dc_searchid_emp"
                        queryAction="/FAERP/SalarySearchAction.do?cmd=SearchSalaryByEmp"
                        submitAction="/FAERP/SalarySearchAction.do?cmd=insertSeachSalaryByEmp"
                        width="99%" xpath="SalarySearchEmpVo" submitXpath="SalarySearchEmpVo"
                        pageSize="100"
                        paramFormId="datacell_form_emp" height="305px">
                        <r:toolbar location="bottom" tools="nav,pagesize,info" />
                        <r:field fieldName="emp_code" messagekey="emp_code" width="100px">
                        </r:field>
                        <r:field fieldName="emp_name" messagekey="emp_name" width="100px">
                        </r:field>
                        <r:field fieldName="id_card" messagekey="id_card" width="200px">
                        </r:field>
                        <r:field fieldName="customer_name" messagekey="customer_name" width="200px">
                        </r:field>
                        <r:field fieldName="sa_class_name" messagekey="sa_class_name" width="150px">
                        </r:field>          
                        <r:field fieldName="pay_year_month" messagekey="pay_year_month" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_name" messagekey="pay_name" width="100px">
                        </r:field>          
                        <r:field fieldName="bank_type_bd" messagekey="bank_type_bd" width="100px">
                         <h:select name="bank_type_bd_list" property="bank_type_bd" disabled="true">
                             <h:option value="" label="请选择"/>
                             <h:option value="1" label="工行"/>
                             <h:option value="0" label="它行"/>
                             <h:option value="2" label="招行"/>
                        </h:select>
                        </r:field>          
                        <r:field fieldName="account_num" messagekey="bank_num" width="150px">
                        </r:field>          
                        <r:field fieldName="bill_year_month" messagekey="bill_year_month" width="100px">
                        </r:field>          
                        <r:field fieldName="tax_month" messagekey="tax_month" width="100px">
                        </r:field>          
                        <r:field fieldName="is_verify" messagekey="is_verify" width="100px">
                        <h:select property="is_verify" disabled="true">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
                  </h:select>
                        </r:field>          
                        <r:field fieldName="verify_time" messagekey="verify_time" width="100px">
                        <w:date format="yyyy-MM-dd"/>
                        </r:field>          
                        <r:field fieldName="real_pay_day" messagekey="real_pay_day" width="100px">
                        </r:field>          
                        <r:field fieldName="is_pay" label="is_pay" width="100px">
	                         <h:select property="is_pay" disabled="true">
	                         <h:option value="1" label="是"/>
	                         <h:option value="0" label="否"/>
                        </h:select>
                        </r:field>          
                        <r:field fieldName="pay_time" label="pay_time" width="100px">
                        <w:date format="yyyy-MM-dd"/>
                        </r:field>          
                    </r:datacell>   
          </div>
</body>
</fmt:bundle>
</html>
