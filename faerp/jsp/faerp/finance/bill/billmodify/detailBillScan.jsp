<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<h:script src="/js/faerp/searchselectvalidate.js"/>
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
	<title>账单修改明细预览</title>
 
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="BillmodifyAction.do?cmd=list2item4approval2">
<div id="right">
<script language="javascript">
  function select_onClick(){
  	$id("datacell_formid").submit();
  }
  //writeTableTopFesco('账单修改明细预览','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
	<div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }年${fn:substring(billVo.bill_year_month, 4, 6) }月应付明细</div>
    <table width="100%">
            <tr>
                <td align="center"><fmt:message key='empnameorcode'/>:&nbsp;&nbsp;<input type="text" name="empnameorcode" id="empnameorcode" /></td>
                <td align="left"><input name="button1" type="button" class="icon_1" onclick="javascript:select_onClick();"  value="<fmt:message key='button_query'/>" /></td>
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
	<div class="box" id="values_div"   style="overflow-y:scroll;" >
      	<table  width="100%"  class="datagrid1">
     		${detailBillHTML}
		</table>
	</div>
	<jsp:include page="/jsp/include/page.jsp" />
 
	<div class="xz_title" style="margin-top:10px;"><fmt:message key='title_once_pay_item'/></div>
  	 <r:datacell id="celllist1"
			queryAction="/FAERP/FinbillAction.do?cmd=queryBillTempOther&bill_id=${billVo.id}"
			paramFormId="datacell_formid" width="100%" height="150px"
			xpath="BillOthersVo" readonly="true">
			<r:field fieldName="charge_item_bd" messagekey="charge_item_bd" width="435px">
			</r:field>
			<r:field fieldName="amount" messagekey="amount" width="150px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
			</r:field>
			<r:field fieldName="vat_amount" label="增值税" width="150px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
			</r:field>
			<r:field fieldName="add_vat_amount" label="附加税" width="150px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(formatNumber(cellText,'#,###.###'),'#,###.##');})">
			</r:field>
			<r:field fieldName="charge_desc" messagekey="charge_desc" width="200px">
				<h:text />
			</r:field>
			<r:field fieldName="last_update_date" messagekey="last_update_date" width="200px">
				<w:date format="yyyy-MM-dd"/>
			</r:field>
		</r:datacell>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

 
