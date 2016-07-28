<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预收款</title>
<script language="javascript">
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
	<div class="ringht_s">
	   <div class="social_tab">
	       <div class="box_3">
           <table  width="100%" height="40" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1">选择客户</td>
               <td class="td_2">
                <w:lookup onReturnFunc="rtnFuncCustomer" readonly="false"
		            id="customer_id" name="customer_id" property="customer_id"
		            displayProperty="customer_name"
		            lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
		            dialogTitle="选择客户" height="440" width="600" style="width:170px"/>
               </td>
               <td class="td_1">客户编号</td>
               <td class="td_2">
                <input type="text" id="cust_code" name="cust_code" />
               </td>
             </tr>
          </table>
          </div>
	    <div class="foot_button">
	      <input onclick="javascript:window.close();" type="button" class="foot_icon_1" value="关闭"/>
	    </div>
	  </div>
   </div>
</div>
</form>
</body>
</html>

