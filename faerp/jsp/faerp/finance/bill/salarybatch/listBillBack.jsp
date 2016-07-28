<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.bill.salarybatch.salarybatch_resource" prefix="rayoo.finance.bill.salarybatch.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key='title_billback'/></title>
    <script language="javascript">

   
   
   function apply_onClick(){
   if(confirm("<fmt:message key='alert_confirm_apply_data'/>")) {
        var cust_id =  $id("cust_id").value ;
        if(cust_id == ''||cust_id==null){
            alert("<fmt:message key='alert_select_apply_customer'/>") ;
            return false ;
        }
        var cost_center_id =  $id("cost_center_id").getValue();
        if(cost_center_id == ''||cost_center_id==null){
            alert("<fmt:message key='alert_select_costCenter'/>") ;
            return false ;
        }
        var bill_year_month =  $id("bill_year_month").value ;
        if(bill_year_month == ''||bill_year_month == null){
            alert("<fmt:message key='alert_select_bill_year_month'/>") ;
            return false ;
        }
        var product_id =  $id("product_id").value ;
        var emp_code =  $id("emp_code").value ;
        var service_month =  $id("service_month").value ;
        
            var url ="<%=request.getContextPath()%>/FinbillAction.do?cmd=ApplyBackBill" ;
            url = url+"&cust_id="+cust_id+"&cost_center_id="+cost_center_id+"&bill_year_month="+bill_year_month+"&product_id="+product_id+"&emp_code="+emp_code+"&service_month="+service_month;
            jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  error: function(){
                      alert("<fmt:message key='alert_sys_err'/>");
                      return  null;
                  },
                  success: function(text){
                      if(text!=null){       
                        alert(text);
                      }
                  }
                  });
     }
   }
    </script>
    </head>
    <body>
    <form name="myform" method="post" id="myform" action="">
    <!--查询 -->
    <div id="right">
     <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='title_billback'/></div>
    </div>
  <div class="search">  
    <br/>
    <div id="TabCon1"><!--表格1-->
    <div class="xz_title" style="margin-top: 10px;"></div>
    <div class="box_3">
    <table width="80%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2" align="center"> 
        <tr>
            <td class="td_1"><span style="color: red">*</span><fmt:message key='customer_name'/></td>
            <td class="td_2">
                <w:lookup
                id="lk_cust"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                messagekey="select_customer" height="450" width="610" style="width:180px" readonly="true"/>
           <input type="hidden" name="cust_id" id="cust_id">
                       </td>
            <td class="td_1">
            <span style="color: red">*</span><fmt:message key='cost_center_'/></td>
            <td class="td_2">
            <r:comboSelect id="cost_center_id" name="cost_center_id"
            queryAction="/FAERP/BillmodifyAction.do?cmd=getCostCenterByCustomerID"
            textField="cost_center_name"
            valueField="id"
            xpath="CostcenterVo"
            width="203" messagekey="please_select">
        </r:comboSelect>
                </td>
            
        <tr>
              
            <!--仅指大类为商业保险的三级类别-->
            <td class="td_1"><span style="color: red">*</span><fmt:message key='bill_year_month_'/></td>
            <td class="td_2">
            <h:text id="bill_year_month"  name="bill_year_month"  style="width=180px" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/> (格式YYYYMM)
            </td>
            <td class="td_1"><fmt:message key='backbill_emp_code'/></td>
            <td class="td_2">
                <h:text id="emp_code"  name="emp_code"  style="width=180px"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key='backbill_servicemonth'/></td>
            <td class="td_2">
                <h:text id="service_month"  name="service_month"  style="width=180px" validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/> (格式YYYYMM)
            </td>
            <td class="td_1"><fmt:message key='backbill_product'/></td>
            <td class="td_2">
            
                <input type="hidden" id="product_id" name="product_id">
                <w:lookup
                id="lk_product"
                lookupUrl="/FAERP/ProductAction.do?cmd=queryAllProductGetOnlyOne"
                messagekey="select_product" height="450" width="610" style="width:180px" readonly="true"/>
            </td>
        </tr>
        <tr>
            <td class="td_2" colspan="4" align="center"><span class="td_2"><input name="submit2" type="button" class="icon_1" value="<fmt:message key='button_scmd'/>" <au:authorityBtn code="jtbsc_scmd" type="1"/> onClick="apply_onClick()" /> </span></td>
        </tr>
    </table>
    <p></p>
    <p></p>
    </div></div>
    </form>
</fmt:bundle>
</body>

</html>
<script type="text/javascript">
<!--

$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[2];
    $id("cust_id").value=returnValue[0];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}

$id("lk_product").onReturnFunc = function (returnValue){
    var lookup = $id("lk_product");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[1];
    $id("product_id").value=returnValue[0];
    return false;
}

//-->
</script>

