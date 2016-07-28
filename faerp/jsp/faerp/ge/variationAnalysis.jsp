<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.ge.dedicatedservice_resource" prefix="rayoo.ge.dedicatedservice.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>codegen</title>
  <script language="javascript">
    
    function exportEXCEL_onClick(){
        var yearmonth = document.form.month.value;
        var cust_id = document.form.cust_id.value;
        var cost_center_id = document.form.cost_center_id.value;
        
        if(yearmonth ==null || yearmonth == ""){
           alert("<fmt:message key='alert_month_null'/>");
           return;
        }else{
           if(yearmonth.length != 6){
               alert("<fmt:message key='alert_month_length'/>");
               return;
           }
           var year = yearmonth.substring(0,4);
           var month = yearmonth.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_month'/>");
               return;
           }
        }
        
        var year = yearmonth.substring(0,4);
        var month = yearmonth.substring(4,6);
        var b_yearmonth = year + month;
        if (month == '01'){
            b_yearmonth = parseInt(year)-1 + "12";
        }else{
            b_yearmonth = parseInt(b_yearmonth)-1 + "";
        }
        
        if(cust_id ==null || cust_id == ""){
            alert("<fmt:message key='alert_select_customer'/>");
            return;
        }
        if(cost_center_id == null || cost_center_id == ""){
            alert("<fmt:message key='alert_select_cost_center'/>");
            return;
        }
        
        $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showVariationAnalysis.jsp?raq=VARIATION_ANALYSIS.raq&arg1="+cust_id+"&arg2="+cost_center_id+"&arg3="+yearmonth+"&arg4="+b_yearmonth);
        $id("datacell_formid").submit();
    }
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <div id="right">
      <script language="javascript">
       writeTableTopFesco("<fmt:message key='title_variationAnalysis'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
      <div class="ringht_s">
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><div class="zbox">
                <div class="xz_title">
                  <fmt:message key='report'/>
                </div>
                <!--表格1-->
                <div class="box_3">
                  <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                    <tr>
                      <td class="td_1"><fmt:message key='month'/></td>
                      <td class="td_2"><input type="text" class="text_field" name="month" inputName="年月" maxLength="50" value=""/></td>
                      <td class="td_1"><fmt:message key='customer_name'/></td>
                      <td class="td_2"><w:lookup readonly="true"  id="lk_cust"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                        messagekey="choose_cust"  height="450" width="610" style="width:187px" />
                        <input id="cust_id" name="cust_id" type="hidden">
                        <input id="cust_name" name="cust_name" type="hidden"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="td_1"><fmt:message key='cost_center'/></td>
                      <td class="td_2" colspan="3"><r:comboSelect id="cost_center_id" name="cost_center_id"
                                    queryAction="../../../BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                                    textField="cost_center_name"
                                    valueField="id"
                                    xpath="CostcenterVo"
                                    width="200" messagekey="please_select"> </r:comboSelect>
                      </td>
                    </tr>
                  </table>
                </div>
                <div class="foot_button"> <input class="foot_icon_3" type="button" value="<fmt:message key='button_export'/>" 
                  <au:authorityBtn code="zddy_exp" type="1"/>
                  onClick="exportEXCEL_onClick();"> </div>
              </div></td>
          </tr>
        </table>
      </div>
    </div>
  </form>
</body>
</fmt:bundle>
</html>
<script language="javascript">
   $id("lk_cust").onReturnFunc = function (returnValue){
        var lookup = $id("lk_cust");
        lookup.value = returnValue[0];
        jQuery("#cust_name").val(returnValue[2]);
        jQuery("#cust_id").val(returnValue[0]);
        lookup.displayValue = returnValue[2];
        $id("cost_center_id").addParam("cust_id", returnValue[0]);
        $id("cost_center_id").loadData();
        $id("cost_center_id").refresh();
        return false;
    }
    
</script>