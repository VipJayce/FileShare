<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>

<html>
    <fmt:bundle basename="rayoo.finance.bill.billprint.billprint_resource" prefix="rayoo.finance.bill.billprint.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
  	//魏佳新增--默认账单年月为当前日期的年月
  	jQuery(function(){
  	    var myDate = new Date();
		var year = myDate.getFullYear();    //获取完整的年份(4位,1970-????)
		var month = myDate.getMonth()+1;       //获取当前月份(0-11,0代表1月)
		//var day = myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
		if(month<10){
		  month = "0"+month;
		}
		var ym = year.toString()+month.toString();
        document.getElementById("bill_year_month").value=ym;
    });
  	
    function exportEXCEL_onClick(){
        var bill_year_month = document.form.bill_year_month.value;
        var user_id = "";
        var cust_name = document.form.cust_name.value;
        var cost_center_id = document.form.cost_center_id.value;
        var bill_type_bd = document.form.bill_type_bd.value;
        var bill_type = document.form.bill_type.value;
        var sort_type = document.form.sort_type.value;
        var login_name = document.form.login_name.value;
        var company_id = document.form.company_id.value;
        
        if(bill_year_month ==null || bill_year_month == ""){
           alert("<fmt:message key='alert_bill_year_month_null'/>");
           return;
        }else{
           if(bill_year_month.length != 6){
               alert("<fmt:message key='alert_bill_year_month_length'/>");
               return;
           }
           var year = bill_year_month.substring(0,4);
           var month = bill_year_month.substring(4,6);
           if(year<2000 || year>2030 || month<1 || month>12){
               alert("<fmt:message key='alert_bill_year_month'/>");
               return;
           }
        }
        if(cust_name ==null || cust_name == ""){
            alert("<fmt:message key='alert_select_customer'/>");
            return;
        }
        if(cost_center_id == null || cost_center_id == ""){
            alert("<fmt:message key='alert_select_cost_center'/>");
            return;
        }
        
        if(bill_type==1){
            //选择查看付款核查单时必须选择账单类型
            if(bill_type_bd == null ||bill_type_bd==''||typeof(bill_type_bd) == "undefined"){
                alert("<fmt:message key='alert_select_bill_type_bd'/>") ;
                return false ;
            }
            var is_merge_addTax = document.form.is_merge_addTax.value;
            if(is_merge_addTax == 0){
	            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillPrintReport.jsp?raq=bill_print1.raq&arg1="+bill_year_month+"&arg2="+user_id+"&arg3="+cust_name+"&arg4="+cost_center_id+"&arg5="+bill_type_bd+"&arg7="+login_name+"&arg8="+company_id);
            }
            if(is_merge_addTax == 1){
	            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillPrintReport.jsp?raq=bill_print1new.raq&arg1="+bill_year_month+"&arg2="+user_id+"&arg3="+cust_name+"&arg4="+cost_center_id+"&arg5="+bill_type_bd+"&arg7="+login_name+"&arg8="+company_id);
            }
            $id("datacell_formid").submit();
        }else if(bill_type==2){
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillPrintReport.jsp?raq=bill_print2.raq&arg1="+bill_year_month+"&arg2="+user_id+"&arg3="+cust_name+"&arg4="+cost_center_id+"&arg5="+bill_type_bd+"&arg7="+login_name+"&arg8="+company_id);
            $id("datacell_formid").submit();
        }else if(bill_type==3){
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillPrintReport.jsp?raq=bill_print3.raq&arg1="+bill_year_month+"&arg2="+user_id+"&arg3="+cust_name+"&arg4="+cost_center_id+"&arg5="+bill_type_bd+"&arg7="+login_name+"&arg8="+company_id);
            $id("datacell_formid").submit();
        }else if(bill_type==4){
            //选择查看付款核查单时必须选择账单类型
            if(bill_type_bd == null ||bill_type_bd==''||typeof(bill_type_bd) == "undefined"){
                alert("<fmt:message key='alert_select_bill_type_bd'/>") ;
                return false ;
            }
            $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillPrintReport.jsp?raq=bill_print1_double_base.raq&arg1="+bill_year_month+"&arg2="+user_id+"&arg3="+cust_name+"&arg4="+cost_center_id+"&arg5="+bill_type_bd+"&arg7="+login_name+"&arg8="+company_id);
            $id("datacell_formid").submit();
        }
    }
	
</script>
	</head>
	<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
<input type="hidden" name="company_id" id="company_id" value="<%=LoginHelper.getLoginVo(request).getCompany_id()%>"/>
	<div id="right">
	<script language="javascript">
	   writeTableTopFesco("<fmt:message key='title_billprint'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<div class="ringht_s">


	<table width="98%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<div class="zbox">
			<div class="xz_title"><fmt:message key='report'/></div>
			<!--表格1-->
			<div class="box_3">
			<table width="100%" height="40" border="0" cellpadding="0"
				cellspacing="1" bgcolor="#c5dbe2">
				<tr>
					<td class="td_1"><fmt:message key='billyearmonth'/></td>
					<td class="td_2">
					   <input id="bill_year_month" type="text" class="text_field" name="bill_year_month" inputName="账单年月" maxLength="50" value=""/>
					</td>
				
					<td class="td_1"><fmt:message key='customer_name'/></td>
		            <td class="td_2">
		                    <w:lookup readonly="true"  id="lk_cust"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                                messagekey="choose_cust"  height="450" width="610" style="width:187px" />
		                <input id="cust_name" name="cust_name" type="hidden"/>
		            </td>
		            </tr>
				<tr>
		            <td class="td_1"><fmt:message key='cost_center'/></td>
		            <td class="td_2">
			            <r:comboSelect id="cost_center_id" name="cost_center_id"
			                queryAction="BillmodifyAction.do?cmd=getCostCenterByCustomerID"
			                textField="cost_center_name"
			                valueField="id"
			                xpath="CostcenterVo"
			                width="200" messagekey="please_select">
			            </r:comboSelect>
		            </td>
				
					<td class="td_1"><fmt:message key='bill_type_bd'/></td>
                    <td class="td_2">
                        <%=gap.rm.tools.helper.RmJspHelper.getSelectField("bill_type_bd", -1,"BILL_TYPE_BD", "","", false)%>
                    </td>
                    </tr>
				<tr>
					<td class="td_1"><fmt:message key='bill_type'/></td>
					<td class="td_2">
					   <select id="bill_type" name="bill_type" style='width:200px'>
                          <option value="1"><fmt:message key='bill_type_1'/></option>
                          <option value="4">付款核查单----双基数</option>
                          <option value="2"><fmt:message key='bill_type_2'/></option>
                          <option value="3"><fmt:message key='bill_type_3'/></option>
                       </select>
					</td>
				
					<td class="td_1"><fmt:message key='sort_type'/></td>
					<td class="td_2">
					   <select id="sort_type" name="sort_type">
                          <option value="emp_code"><fmt:message key='sort_type_emp_code'/></option>
                          <option value="emp_name"><fmt:message key='sort_type_emp_name'/></option>
                          <option value="internal_code"><fmt:message key='sort_type_internal_code'/></option>
                       </select>
					</td>
				</tr>
				<tr>
					<td class="td_1">是否合并附加税</td>
					<td class="td_2">
					   <select id="is_merge_addTax" name="is_merge_addTax" style='width:200px'>
                          <option value="0">否</option>
                          <option value="1">是</option>
                       </select>
					</td>
					<td class="td_1"></td>
					<td class="td_2">
					</td>
				</tr>
			</table>
			</div>
			<div class="foot_button">
			     <!--<a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
			     -->
			     <input class="foot_icon_3" type="button"   value="<fmt:message key='button_export'/>"  <au:authorityBtn code="zddy_exp" type="1"/>  onClick="exportEXCEL_onClick();">
			</div>
			</div>
			</td>
		</tr>
	</table>
	
	</form>
</fmt:bundle>
</body>
</html>
<script>
$id("lk_cust").onReturnFunc = function (returnValue){
    var lookup = $id("lk_cust");
    lookup.value = returnValue[0];
    jQuery("#cust_name").val(returnValue[2]);
    lookup.displayValue = returnValue[2];
    $id("cost_center_id").addParam("cust_id", returnValue[0]);
    $id("cost_center_id").loadData();
    $id("cost_center_id").refresh();
    return false;
}
</script>