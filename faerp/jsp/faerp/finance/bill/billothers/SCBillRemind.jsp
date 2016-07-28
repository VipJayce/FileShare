<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base target="_self"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>未出账单列表</title>
</head>
<body>
   <form name="form" method="post"  id="datacell_formid">
	   <div id="right">
	    <script language="javascript">
	        writeTableTopFesco('未出账单列表','<%=request.getContextPath()%>/');  //显示本页的页眉
	    </script>
	    <div  id="div1" style="margin:5 0 0 10px;">
	              <r:datacell 
	              queryAction="/FAERP/FinbillAction.do?cmd=searchSCBillRemind"
	              id="celllist1"
	              paramFormId="datacell_formid" 
	              width="97%" height="430px" 
	              xpath="SCBillRemindVo"
	              readonly="true"
	              pageSize="500"
	              >
	                <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	                <r:field fieldName="customer_name" label="客户名称" width="200px">
	                </r:field>
	                <r:field fieldName="customer_code" label="客户编码" width="100px">
	                </r:field>
	                <r:field fieldName="cost_center_name" label="成本中心名称" width="200px">
	                </r:field>
	                <r:field fieldName="user_name" label="客服" width="100px">
	                </r:field>
	                <r:field fieldName="dept_name" label="所属部门" width="180px">
	                </r:field>
	                <r:field fieldName="payment_day" label="出账单日" width="100px">
	                </r:field>
	            </r:datacell>
	    </div>
	  </div>
    </form>
</body>
</html>
