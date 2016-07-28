<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle
	basename="rayoo.finance.finpaymentmanage.finpayment.finpayment_resource"
	prefix="rayoo.finance.finpaymentmanage.finpayment.">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	</head>
	<%
	    String service_year_month = request.getParameter("service_year_month");
	    String product_id = request.getParameter("product_id");
	    String emp_post_id = request.getParameter("emp_post_id");
	    request.setAttribute("service_year_month", service_year_month);
	    request.setAttribute("product_id", product_id);
	    request.setAttribute("emp_post_id", emp_post_id);
	%>
	<body>
	<form name="form" id="datacell_formid" method="post">
		<div class="ringht_s">
			<div id="TabCon1">
				<div id="values_div3"
					style="width: 100%; height: 200px; margin: 5 0 0 8;">
						<r:datacell id="datacell1"
						      queryAction="/FAERP/FinbillitemAction.do?cmd=getFinBillItem&service_year_month=${service_year_month}&product_id=${product_id}&emp_post_id=${emp_post_id}"
						      paramFormId="datacell_formid" width="99%" height="318px" xpath="FinbillitemVo" readonly="true">
							<r:toolbar location="bottom" tools="nav,pagesize,info" />
							<r:field fieldName="bill_year_month" label="账单年月" width="90px"></r:field>
							<r:field fieldName="service_year_month" label="服务年月" width="90px"></r:field>
							<r:field fieldName="amount" label="对应产品项目的金额" width="90px"></r:field>
							<r:field fieldName="p_money" label="个人金额" width="90px"></r:field>
							<r:field fieldName="e_money" label="企业金额" width="90px"></r:field>
							<r:field fieldName="previou_oldid" label="是否变更" width="90px"></r:field>
					     </r:datacell>
				</div>
			</div>
		</div>
	</form>
	<script language="javascript">
    </script>
</fmt:bundle>