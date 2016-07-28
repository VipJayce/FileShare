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
<fmt:bundle basename="rayoo.salary.issue.calculation.calculation_resource" prefix="rayoo.salary.issue.calculation.">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='calculation_detail'/></title>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="h_emp_ids" name="emp_ids" />
<input type="hidden" id="h_cmd" name="cmd" />
<input type="hidden" id="h_batchId" name="batchId" value="${batchVo.id }"/>
<div id="right">
    <script language="javascript">
        writeTableTopFesco("薪资数据明细",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
  <div class="ringht_s">
	<div id="ccChild0" class="search">
	</div>
    <div class="clear"></div>
	<div style="padding: 0 0 8 8;">
	
        <r:datacell 
            id="itemdatacell"
            paramFormId="datacell_formid"
            queryAction="/FAERP/PpssasalarydataAction.do?cmd=getdataByBatchId&batch_id=${batchVo.id }"
            width="98%"
            height="304px"
            pageSize="10000"
            xpath="PpssasalarydataVo"
            freezeNumber="3"
            >
          <r:toolbar  tools="nav,pagesize,info"/>
          <r:field sortAt="none" fieldName="emp_code" messagekey="emp_code" width="80px;"></r:field>
          <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name" width="100px;" ></r:field>
          <r:field sortAt="none" fieldName="pay_year_month" messagekey="pay_year_month" width="100px;"></r:field>
          <logic:iterate name="salarydataTitleList" id="salarydataTitle" scope="session" indexId="indexs">
        <r:field sortAt="none" fieldName="def${salarydataTitle.item_serial_new_id }"
            label="${salarydataTitle.newsalarylabel }"
            onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        </r:field>
    </logic:iterate>
        </r:datacell>
	
    </div>
	<div class="foot_button">
	  <input type="button" value="<fmt:message key='button_back'/>" class="foot_icon_1" onclick="window.history.back();">
	  <input type="button" onclick="exportDetail();" value="<fmt:message key='button_output_exl_2'/>" class="foot_icon_2">
	</div>
  </div>
</div>
</form>
</body>
</html>
<script language="javascript">
//导出薪资明细
function exportDetail(){
    //$id("h_cmd").value = "expSalaryDetail";
    var batchid=document.getElementById("h_batchId").value;
    $id("datacell_formid").action = "<%=request.getContextPath()%>/PpssasalarydataAction.do?cmd=expSalaryDetail&batchId="+batchid ;
    $id("datacell_formid").submit();
}
</script>
</fmt:bundle>
