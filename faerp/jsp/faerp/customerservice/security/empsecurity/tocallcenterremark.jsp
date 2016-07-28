<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/CommonCheck.js"/>
<h:script src="/js/caculateMoney.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>

<script language="javascript">    
   function save_onclick(){
          var remark = $id("remark").value ;
          window.opener.callBackByOther(remark);  //回调进行刷新
          window.close() ;
   }
</script>
</head>
<body>
<form name="form"  method="post" id="datacell_formid" action="<%=request.getContextPath()%>/PbcustlevelsetAction.do?cmd=update">
<div id="center_div" align="center">
  <label for="bill_other_reason"><span style="color:red;">*&nbsp;</span>请输入原因：</label><br/>
  <textarea class="form-control" id="remark" name="remark" maxlength="3000" style="width: 300px" rows="10"></textarea>
   <div class="foot_button">
    <input name="save_submit" class="button_ellipse" type="button" value="提交"   onclick="javascript:save_onclick();">
    <br/><br/>
</div>
</form>
</fmt:bundle>
</body>
</html>
