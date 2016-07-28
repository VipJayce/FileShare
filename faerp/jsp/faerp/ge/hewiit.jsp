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
        var create_type=document.getElementById("create_type").value;
        var cust_group=document.getElementById("cust_group").value;
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
        if(create_type=="1"){
        var cust_id = document.form.cust_id.value;
        var cost_center_id = document.form.cost_center_id.value;
        
        if(cust_id ==null || cust_id == ""){
            alert("<fmt:message key='alert_select_customer'/>");
            return;
        }
        if(cost_center_id == null || cost_center_id == ""){
            alert("<fmt:message key='alert_select_cost_center'/>");
            return;
        }
        
        $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeHewitt.jsp?raq=ge_hewitt.raq&arg1="+cust_id+"&arg2="+cost_center_id+"&arg3="+yearmonth+"&arg4="+b_yearmonth+"&arg5=1099110200000000005&arg6=1099110200000000006&arg7=1099110200000000007&arg8=1099110200000000008&arg9=1099110200000000009&arg10=1099110200000000010&arg11=1099110200000000014&arg12=1099110200000000015");
        $id("datacell_formid").submit();
        }else if(create_type=="2"){
            var cust_service_man=document.getElementById("customer_service_hidden").value;
            if(cust_service_man==""){
                alert("<fmt:message key='alert_select_customer_service_first'/>");
                return;
            }
        $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeHewitt4CustomerService.jsp?raq=ge_hewitt4customer_service.raq");
        $id("datacell_formid").submit();
        }else{
            alert("暂时没有开发第三种情况！");
        }
    }
    
    function create_reportinfo(){
     var yearmonth = document.form.month.value;
     var cust_group=document.getElementById("cust_group").value;
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
        var cust_service_man=document.getElementById("customer_service_hidden").value;
         if(cust_service_man==""){
                alert("<fmt:message key='alert_select_customer_service_first'/>");
                return;
            }
         jQuery("#but22").css("display","none");
         jQuery.ajax({
            url: "<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=toCreateHewiitReportInfo&yearmonth="+yearmonth+"&b_yearmonth="+b_yearmonth+"&serviceuserid="+cust_service_man,
            type: "POST",
            dataType: "html",
            timeout: 10000000,
            error: function(){
                alert("系统错误，请刷新后重新计算");
                return ;
            },
            success: function(data){
            //后台取到数据
            alert("已经提交后台计算，稍后可导出报表!");
            return;
            }
             });  
        /**
        $id("datacell_formid").action="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=toCreateHewiitReportInfo&yearmonth="+yearmonth+"&b_yearmonth="+b_yearmonth+"&serviceuserid="+cust_service_man;
        $id("datacell_formid").submit();
        alert("已经开始计算报表，请稍后在导出报表");*/
        
    }
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <div id="right">
      <script language="javascript">
       writeTableTopFesco("<fmt:message key='title_hewiit'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
                      <td   class="td_1"><fmt:message key='create_type'/></td>
                      <td  class="td_2">
                      <select id="create_type" name="create_type" onchange="do_ex()">
                                      <option value="1" selected="selected"><fmt:message key='customer_name_4option'/></option>
                                      <option value="2"><fmt:message key='customer_service'/></option>
                      </select>
                      </td>
                    </tr>
                    <tr style="display: inline" id="tr4kehu">
                        <td class="td_1"><fmt:message key='customer_name'/></td>
                      <td class="td_2"><w:lookup readonly="true"  id="lk_cust"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                        messagekey="choose_cust"  height="450" width="610" style="width:183px" />
                        <input id="cust_id" name="cust_id" type="hidden">
                        <input id="cust_name" name="cust_name" type="hidden"/>
                      </td>
                      <td class="td_1"><fmt:message key='cost_center'/></td>
                      <td class="td_2"><r:comboSelect id="cost_center_id" name="cost_center_id"
                                    queryAction="../../../BillmodifyAction.do?cmd=getCostCenterByCustomerID"
                                    textField="cost_center_name"
                                    valueField="id"
                                    xpath="CostcenterVo"
                                    width="200px" messagekey="please_select"> </r:comboSelect>
                      </td>
                    </tr>
                    <tr style="display:none" id="tr4kefu">
                        <td class="td_1"><fmt:message key='customer_service'/></td>
                         <td class="td_2">  
                                    <r:comboSelect id="customer_service" name="customer_service1" queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                textField="name" valueField="partyid" xpath="Partyrelation" width="200px" messagekey="please_select" />
                     </td>
                     <td class="td_1">
                     <div id="but22">
                     <input type="button" id="but" class="icon_3"    onclick="create_reportinfo();" value="计算报表" />
                     </div>
                 </td>
                     <td class="td_2"></td>
                    </tr>
                    <tr>
                    <td class="td_1">所属客户</td>
                    <td class="td_2">
              <r:comboSelect id="cust_group" name="cust_group" queryAction="/FAERP/Cust_groupAction.do?cmd=queryListCustname"
              textField="cust_group_name" valueField="cust_group_code" xpath="Cust_groupVo" width="200px" messagekey="please_select"/> 
                    </td>
                    <td class="td_1"></td>
                    <td class="td_2"></td>
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
    
    /********************************选择生成方式***************************************/
    function do_ex(){
    var type=document.getElementById("create_type").value;
       if(type==1){
             document.getElementById("tr4kehu").style.display="inline";//显示客户行
             document.getElementById("tr4kefu").style.display="none";//隐藏客服
        }
        else if(type==2){
            document.getElementById("tr4kehu").style.display="none";//隐藏客户行
             document.getElementById("tr4kefu").style.display="inline";//显示客服
        }
    }
    
</script>