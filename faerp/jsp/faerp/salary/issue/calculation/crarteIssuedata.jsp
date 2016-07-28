<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
	var _jQuery = window.jQuery, _$ = window.$;
	jQuery.noConflict();
	var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="rayoo.finance.receivable.MyUtils"%>
<html>
<fmt:bundle basename="rayoo.salary.issue.calculation.calculation_resource" prefix="rayoo.salary.issue.calculation.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='button_scffsj'/></title>
	<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/sararyCal.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <style type="text/css">
        body {
		    color: #333333;
		    font-family: "宋体";
		    font-size: 12px;
		    line-height: 150%;
		}
        .box_xinzeng_me td{ height:30px; padding:0 10px;}
        .box_xinzeng_me .td_1{ background:#f1f7f9; text-align:right;}
        .box_xinzeng_me .xz_button {
		    margin-top: 10px;
		    text-align: center;
		}
    </style>
</head>
<body>
<%
   Date currDate = new Date();
   String sdate = MyUtils.date2String(currDate, "yyyyMMdd");
%>
<form name="form" method="post" id="createissuedataform" action="">
<div class="box_xinzeng_me" style="margin: 10px;">
    <input type="hidden" name="salary_class_id" id="salary_class_id">
  <table width="80%" cellspacing="1" cellpadding="0" border="0" bgcolor="#c5dbe2" align="center">
      <tr>
        <td width="45%" class="td_1"><fmt:message key='pay_name'/></td>
        <td width="55%" class="td_2"><input type="text" id="pay_name" name="pay_name" class="xText"></td>
       </tr>
      <tr>
        <td class="td_1"><fmt:message key='pay_year_month'/></td>
        <td class="td_2">
            <w:date format="yyyyMMdd" name="pay_year_month" id="pay_year_month" value="<%=sdate %>"/>
        </td>
      </tr>
      <tr>
        <td class="td_1"><fmt:message key='tax_month'/></td>
        <td class="td_2">
            <w:date format="yyyyMMdd" name="tax_month" id="tax_month" value="<%=sdate %>"/>
        </td>
      </tr>
      <tr>
        <td class="td_1"><fmt:message key='bill_year_month'/></td>
        <td class="td_2">
           <w:date format="yyyyMMdd" name="bill_year_month" id="bill_year_month" value="<%=sdate %>"/>
         </td>
      </tr>
      <tr>
        <td class="td_1"><fmt:message key='is_unite_tax'/></td>
        <td class="td_2">
            <input type="checkbox" checked="checked" value="1" name="is_unite_tax">
        </td>
      </tr>
  </table>
  <div class="xz_button">
     <input type="button" onclick="closeIssuePage(1);" value="<fmt:message key='button_confirm'/>" class="icon_2"> 
     <input type="button" onclick="closeIssuePage(2);" value="<fmt:message key='button_cancel'/>" class="icon_2" >
  </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script type="text/javascript" language="javascript">
if (${msg != null } && ${msg != "" }) {
    alert('${msg}');
}
_$(document).ready(function(){
    _$("#salary_class_id").val(window.dialogArguments);
});

</script>
