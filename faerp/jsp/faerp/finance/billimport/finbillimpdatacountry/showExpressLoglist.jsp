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
	<title>同步Express异常信息</title>
 
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="datacell_formid" method="post" id="datacell_formid" action="">
<div id="right">
<div class="ringht_s">
    <!-- /FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell -->
	  <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="celllist1"
        queryAction="/FAERP/FinbillimpdatacountryAction.do?cmd=queryEmpPostDataByXpressLog&batch_id=${requestScope.get_batch_id}"
        submitAction="#"
        width="99%"
        height="305px" 
        xpath="CallXpressLogVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="emp_name" label="员工姓名" width="100">
      </r:field>
      <r:field fieldName="emp_code" label="唯一号" width="100">
      </r:field>
      <r:field fieldName="cust_code" label="客户编号" width="130">
      </r:field>
      <r:field fieldName="cust_name" label="客户名称" width="150">
      </r:field>
      <r:field fieldName="datastate" label="执行状态" width="100">
      </r:field>
      <r:field fieldName="description" label="描述" width="170">
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</form>
</body>
</html>

 
