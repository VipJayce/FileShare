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
<html><body>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>账单明细查询</title>
 
	<!-- - <script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodify4approval.js"></script>-->
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="Agent_billAction.do?cmd=list2item4approval2">
<div id="right">
<script language="javascript">
		function exportEXCEL_onClick(){
	        var bill_id = document.form.bill_id.value;
	        var cost_center_name = document.form.cost_center_name.value;
	        var bill_year_month = document.form.bill_year_month.value;
	        var bill_code = document.form.bill_code.value;
	        var login_name = document.form.login_name.value;
	        if(bill_id != null && bill_id !=""){
	            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showAgentBillModifyReport.jsp?raq=agent_bill_modify.raq&arg1="+bill_id+"&arg2="+cost_center_name+"&arg3="+bill_year_month+"&arg4="+bill_code+"&arg5="+login_name;
	            $id("datacell_formid").submit();
	        }else{
	           alert("数据异常，请联系管理员！");
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
                <td align="center">员工姓名/唯一号:&nbsp;&nbsp;<input type="text" name="empnameorcode" id="empnameorcode" /></td>
                <td align="left"><input name="button1" type="button" class="icon_1" onclick="javascript:select_onClick();"  value="查 询" /></td>
                <td align="left"><input name="button2" type="button" class="icon_1" onclick="javascript:exportEXCEL_onClick();"  value="导出excel" /></td>
                <td ><li style="font-size:12px; font-weight:inherit; width:200px; margin-left:50%;">账单号：${billVo.bill_code }</li></td>
                <td align="right" ><li>账单金额：${billVo.bill_amount }</li></td>
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
	<jsp:include page="/jsp/include/page.jsp" />
 
	<div class="xz_title" style="margin-top:10px;">一次收费项目表</div>
  	 <r:datacell id="celllist1"
			queryAction="/FAERP/Agent_billAction.do?cmd=queryBillOther&bill_id=${billVo.id}"
			paramFormId="datacell_formid" width="100%" height="150px"
			xpath="BillOthersVo" readonly="true">
			
			<r:field fieldName="charge_item_bd" label="项目名称" width="435px">
				<d:select dictTypeId="CHARGE_ITEM_BD"/>
			</r:field>
			<r:field fieldName="amount" label="金额" width="235px">
			</r:field>
			<r:field fieldName="charge_desc" label="备注" width="300px">
				<h:text />
			</r:field>
			<r:field fieldName="last_update_date" label="时间" width="230px">
				<w:date format="yyyy-MM-dd"/>
			</r:field>
		</r:datacell>
	
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

 
