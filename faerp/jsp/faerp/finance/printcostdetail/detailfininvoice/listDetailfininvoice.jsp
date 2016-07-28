<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>

<html>
<fmt:bundle basename="rayoo.finance.printcostdetail.detailfininvoice.detailfininvoice_resource" prefix="rayoo.finance.printcostdetail.detailfininvoice.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("billid") + "\",\"" + entity.getProperty("cost_center_name") + "\",\"" + entity.getProperty("cust_name") + "\",\""+entity.getProperty("invoice_code")+"\",\""+entity.getProperty("invoice_amount")+"\");>";
    }
    
    function ClickRow(tid,billid,cost_center_name,cust_name,invoice_code,invoice_amount){
          $id("billid").value = billid;
          $id("tid").value = tid;
          $id("cost_center_name").value = cost_center_name;
          $id("cust_name").value = cust_name;
          $id("invoice_code").value = invoice_code;
          $id("invoice_amount").value = invoice_amount;
    }
    
    function showListData(){
        var bill_year_month = document.form.bill_year_month.value;
        if(bill_year_month!=null && bill_year_month!=""){
	        if(bill_year_month.length != 6){
	           alert("<fmt:message key='alert_billyear_error'/>");
	           return;
	       }
	       var year = bill_year_month.substring(0,4);
	       var month = bill_year_month.substring(4,6);
	       if(year<2000 || year>2030 || month<1 || month>12){
	           alert("<fmt:message key='alert_billyear_error_1'/>");
	           return;
	       }
	   }
        
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function resetQuery(){
        $id("cust_id").value = "";
    }
    
    function exportToExcel(){
        var tid = document.form.tid.value;
        var billid = document.form.billid.value;
        var cust_name = document.form.cust_name.value;
        var cost_center_name = document.form.cost_center_name.value;
        var invoice_code = document.form.invoice_code.value;
        var invoice_amount = document.form.invoice_amount.value;
        var login_name = document.form.login_name.value;
        if(tid == null || tid == ""){
            alert("<fmt:message key='select_one_export'/>");
            return;
        }else{
            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showPrintCostDetailReport.jsp?raq=printCostDetails.raq&arg1="+tid+"&arg2="+cust_name+"&arg3="+cost_center_name+"&arg4="+invoice_code+"&arg5="+invoice_amount+"&arg6="+login_name;
            $id("datacell_formid").submit();
        }
    }
    
    _$(document).ready(function() {
        $id("datacell1").isQueryFirst = false;
    });

</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input id="cust_id" name="cust_id" type="hidden"  value="" />
<input id="billid" name="billid" type="hidden"  value="" />
<input id="tid" name="tid" type="hidden"  value="" />
<input id="cost_center_name" name="cost_center_name" type="hidden"  value="" />
<input id="cust_name" name="cust_name" type="hidden"  value="" />
<input id="invoice_code" name="invoice_code" type="hidden"  value="" />
<input id="invoice_amount" name="invoice_amount" type="hidden"  value="" />
<input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key='title_queryfinbill'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	   <tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
		</tr>
		
		<tr>
		    <td align="right"><fmt:message key='cust_name'/></td>
            <td align="left">
                <w:lookup readonly="true"
                    id="lk_cust"
                    lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                    messagekey="select_cust" height="500" width="810" style="width:170"/>
            </td>
            <td align="right"><fmt:message key='cost_center'/></td>
            <td align="left">
	            <r:comboSelect id="cost_center_id" name="cost_center_id"
	                queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
	                textField="cost_center_name"
	                valueField="id"
	                xpath="CostcenterVo"
	                width="180" messagekey="please_select">
	            </r:comboSelect>
            </td>
            <td align="right"><fmt:message key='invoice_code'/>>=</td>
            <td align="left">
                <input  type="text" name="invoice_code1" id="invoice_code1" style="width:186"/>
            </td>
		</tr>
		<tr>
		    <td align="right"><fmt:message key='invoice_code'/><=</td>
            <td align="left">
                <input  type="text" name="invoice_code2" id="invoice_code2" style="width:186"/>
            </td>
            <td align="right"><fmt:message key='create_date_from'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="create_date_from" width="70px"/>到<w:date format="yyyy-MM-dd" name="create_date_to" width="70px"/></td>
            </td>
            <td align="right"><fmt:message key='bill_year_month'/></td>
            <td align="left">
                <input  type="text" name="bill_year_month" id="bill_year_month" style="width:186"/>
            </td>
		</tr>
		<tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
	            <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
	            <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();resetQuery()">
            </td>
        </tr>
</table>
</div>

<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="e">      <a  onClick="javascript:exportToExcel();">导出</a> </li>
                </ul>
                --><input class="e" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="dyfy_exp" type="1"/>  onClick="exportToExcel();">
         </div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FininvoiceAction.do?cmd=searchInvoiceQueryDataForExport"
        width="98%"
        height="304px"
        xpath="FininvoiceVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center" >
       </r:field> 
      <r:field fieldName="cust_code" messagekey="cust_code"  width="90px">
        <h:text/>
      </r:field>
      <r:field fieldName="cust_name" messagekey="cust_name" width="250px" >
        <h:text/>
      </r:field>
      <r:field fieldName="cost_center_name" messagekey="cost_center" width="250px" >
        <h:text/>
      </r:field>
      <r:field fieldName="invoice_code" messagekey="invoice_code_" width="200px">
        <h:text/>
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" >
        <w:date format="yyyy-MM-dd"/>
      </r:field>     
      <r:field fieldName="invoice_amount" messagekey="invoice_amount" >
        <h:text/>
      </r:field>
      <r:field fieldName="type_bd" messagekey="type_bd" >
        <d:select dictTypeId="INVOICE_TYPE_BD" />
      </r:field>
    </r:datacell>
    </div>
					
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script>
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    _$("#cust_id").val(returnValue[0]);
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}
</script>
