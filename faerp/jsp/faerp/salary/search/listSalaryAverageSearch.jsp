<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.search.search_resource" prefix="rayoo.salary.search.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
jQuery(function(){
    var _now = new Date();
    var y =  _now.getFullYear();
    jQuery("#"+y).attr("selected",true);
    $id("dc_searchid_averageid").isQueryFirst = false;
});

 function toselect_onclick() { 
        var cust_name_s = $id("cust_name_s") ;
        if(!cust_name_s.value){
            alert("<fmt:message key='alert_select_customer'/>") ;
            return false ;
        }
        var pay_year_month = $id("pay_year_month") ;
        if(!pay_year_month.value){
            alert("请输入年月份") ;
            return false ;
        }
        var p = /^[12]\d{3}(0\d|1[0-2])$/;
        if (!p.test($id("pay_year_month").value) && $id("pay_year_month").value != "" && $id("pay_year_month").value != null) {
            alert("请输入正确格式的年月份") ;
            $id("pay_year_month").value = "";
            return false;
        }
        
        $id("dc_searchid_averageid").reload() ;
        return true ;
}

function rtnFuncCustomer(arg){
        var lookup = $id("cust_name_s");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];  
        return false;
    }
 function exportExcel(){
        var cust_name_s = $id("cust_name_s") ;
        if(!cust_name_s.value){
            alert("<fmt:message key='alert_select_customer'/>") ;
            return false ;
        }
        
        var pay_year_month = $id("pay_year_month") ;
        if(!pay_year_month.value){
            alert("请输入年月份") ;
            return false ;
        }
        var p = /^[12]\d{3}(0\d|1[0-2])$/;
        if (!p.test($id("pay_year_month").value) && $id("pay_year_month").value != "" && $id("pay_year_month").value != null) {
            alert("请输入正确格式的年月份") ;
            $id("pay_year_month").value = "";
            return false;
        }
        
        var formid = $id("datacell_form_avg") ;
        formid.submit() ;
        return true ;
    }
</script>
</script>
</head>
<body>
<form name="datacell_form_avg" id="datacell_form_avg" action="<%=request.getContextPath()%>/SalarySearchAction.do?cmd=exportSalarySearchAverage" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_avg_search'/></div></div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="135" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div></td>
        <td width="60"><span style="color: red">*</span><fmt:message key='span_select_customer'/></td>
        <td width="220"><span class="td_2">
        <w:lookup onReturnFunc="rtnFuncCustomer" readonly="false" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="span_select_customer" height="440" width="600"  style="width:170px"/>
        </span></td>
        <td width="60"><span style="color: red">*</span><fmt:message key='year_'/></td>
        <td width="220"><span class="td_2">
          <input type="text" class="text_field"
                    name="pay_year_month" id="pay_year_month"
                    value="" inputName="年月" maxLength="6"
                    onkeyup="this.value=this.value.replace(/\D/g,'')"
                    onafterpaste="this.value=this.value.replace(/\D/g,'')" />(201301)
        </span></td>
        <td width="60">&nbsp;</td>
        <td  width="220"><input type="button" class="icon_1" value="<fmt:message key='button_search'/>" onclick="return toselect_onclick() ;"/> &nbsp;&nbsp;&nbsp;<input type="button" class="icon_2" onclick="return exportExcel();" <au:authorityBtn code="pjgz_exp" type="1"/>  value="<fmt:message key='button_export_exl'/>" /></td>
      </tr>
      </table>
  </div>
     <r:datacell id="dc_searchid_averageid"
                        queryAction="/FAERP/SalarySearchAction.do?cmd=SearchSalaryByAverage"
                        submitAction="/FAERP/SalarySearchAction.do?cmd=update"
                        width="100%" xpath="SalarySearchAverageVo" submitXpath="SalarySearchAverageVo"
                        pageSize="100"
                        paramFormId="datacell_form_avg" height="340px">
                        <r:toolbar location="bottom" tools="nav,pagesize,info" />
                        <r:field fieldName="emp_name" messagekey="emp_name" width="130px">
                        </r:field>
                        <r:field fieldName="id_card_type_bd" messagekey="id_card_type_bd" width="120px">
                            <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                        </r:field>
                        <r:field fieldName="id_card" messagekey="id_card" width="150px">
                        </r:field>                        
                        <r:field fieldName="apply_on_post_date" messagekey="apply_on_post_date" width="150px">
                        </r:field>
                        <r:field fieldName="welfare_address" messagekey="welfare_address" width="150px">
                        </r:field>
                        <r:field fieldName="cust_name" messagekey="customer_name" width="200px">
                        </r:field>          
                        <r:field fieldName="pay_month1_pay" messagekey="pay_Jan" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month2_pay" messagekey="pay_Feb" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month3_pay" messagekey="pay_Mar" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month4_pay" messagekey="pay_Apr" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month5_pay" messagekey="pay_May" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month6_pay" messagekey="pay_Jun" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month7_pay" messagekey="pay_Jul" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month8_pay" messagekey="pay_Aug" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month9_pay" messagekey="pay_Sept" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month10_pay" messagekey="pay_Oct" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month11_pay" messagekey="pay_Nov" width="100px">
                        </r:field>          
                        <r:field fieldName="pay_month12_pay" messagekey="pay_Dec" width="100px">
                        </r:field>   
                         <r:field fieldName="social_security" messagekey="social_security" width="100px">
                        </r:field>           
                    </r:datacell>
    <!--翻页 end-->
    </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
