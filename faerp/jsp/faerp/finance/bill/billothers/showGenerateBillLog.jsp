<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%String generateBillIBatchd=request.getParameter("generateBillIBatchd");
%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle
    basename="rayoo.finance.bill.billcenter.billcenter_resource_zh"
    prefix="rayoo.finance.bill.billcenter.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账单批量生成参数配置</title>
<script language="javascript">

</script>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid">
<input  type="hidden"  value="<%=generateBillIBatchd %>" id="generateBillIBatchd" name = "generateBillIBatchd"/>
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height:350px "> 
    <div style="padding: 8 0 8 8;">
        <r:datacell id="datacell1" paramFormId="datacell_formid" 
            queryAction="/FAERP/FinbillAction.do?cmd=queryGenerateLogByBatchId" width="99%" height="510px" xpath="FinbillGenerateBatchDetailVo">
	        <r:toolbar location="bottom" tools="nav,pagesize,info" />
	        <r:field fieldName="customer_code" messagekey="cust_code"
	            width="100" allowModify="false">
	            <h:text />
	        </r:field>
	        <r:field fieldName="customer_name" messagekey="customer_name"
	            width="200" allowModify="false">
	            <h:text />
	        </r:field>
	        <r:field fieldName="cost_center_name" messagekey="cost_center_name"
	            width="200" allowModify="false">
	            <h:text />
	        </r:field>
	        <r:field fieldName="bill_status" messagekey="bill_status_bd" width="120"  allowModify="false">
	            <h:select name="list_status" property="bill_status">
	                <h:option value="0" label="计算中"></h:option>
	                <h:option value="1" label="计算成功"></h:option>
	                <h:option value="2" label="计算失败"></h:option>
	            </h:select>
	        </r:field>
	        <r:field fieldName="remark" messagekey="bill_remark" width="270" allowModify="false">
	            <h:text />
	        </r:field>
	    </r:datacell>
    </div>
 </div>
 </div>
 </form>

<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	window.onload = function(){
	    //$id("datacell1").isQueryFirst = false;
	}

</script>
</body>
</fmt:bundle>
</html>


