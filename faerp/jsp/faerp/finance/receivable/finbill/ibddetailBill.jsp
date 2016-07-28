<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
<%@ page import="gap.authority.helper.LoginHelper" %>
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.LoginHelper"%>
<html>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='title_querybill_detail'/></title>
 
	<!-- - <script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodify4approval.js"></script>-->
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="FinbillAction.do?cmd=list2item4approval2">
<div id="right">
<script language="javascript">
		function exportEXCEL_onClick(){
	        var bill_id = document.form.bill_id.value;
	        var cost_center_name = document.form.cost_center_name.value;
	        var bill_year_month = document.form.bill_year_month.value;
	        var bill_code = document.form.bill_code.value;
	        var login_name = document.form.login_name.value;
	        if(bill_id != null && bill_id !=""){
	            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillModifyReport.jsp?raq=bill_modify.raq&arg1="+bill_id+"&arg2="+cost_center_name+"&arg3="+bill_year_month+"&arg4="+bill_code+"&arg5="+login_name;
	            $id("datacell_formid").submit();
	        }else{
	           alert("<fmt:message key='data_error_1'/>");
	           return;
	        }
	    }
	  
	  function select_onClick(){
	  
	  $id("datacell_formid").submit();
	  }
	  
	  
   //writeTableTopFesco('账单明细查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
	<div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细</div>
    <table width="100%">
            <tr>
                <td align="center"><fmt:message key='empnameorcode'/>:&nbsp;&nbsp;<input type="text" name="empnameorcode" id="empnameorcode" /></td>
                <td align="left"><input name="button1" type="button" class="icon_1" onclick="javascript:select_onClick();"  value="<fmt:message key='button_query'/>" /></td>
                <td align="left"><input name="button2" type="button" class="icon_1" onclick="javascript:exportEXCEL_onClick();"  value="<fmt:message key='button_exportexl'/>" /></td>
                <td ><li style="font-size:12px; font-weight:inherit; width:200px; margin-left:50%;"><fmt:message key='bill_code'/>：${billVo.bill_code }</li></td>
                <td align="right" ><li><fmt:message key='bill_amount'/>：${billVo.bill_amount }</li></td>
                <td align="left"><li>&nbsp;</li></td>
            </tr>
     
     </table>
    <input type="hidden" value="${billVo.id }" name="bill_id" id="bid">
    
    <input type="hidden" value="${billVo.cost_center_name }" name="cost_center_name">
    <input type="hidden" value="${billVo.bill_year_month }" name="bill_year_month">
    <input type="hidden" value="${billVo.bill_code }" name="bill_code">
    <input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
    <!-- /FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell -->
	  <div class="box" id="values_div"   style="overflow-y:scroll;" >
      <table  width="100%"  class="datagrid1"    >
     ${detailBillHTML}
     </table>
	</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

 
