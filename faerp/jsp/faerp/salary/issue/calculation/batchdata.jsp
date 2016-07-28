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
	<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/editbatch.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" id="h_emp_ids" name="emp_ids" />
<input type="hidden" id="h_cmd" name="cmd" />
<input type="hidden" id="h_batchId" name="batchId" value="${batchVo.id }"/>
<input type="hidden" id="h_clzId" name="clzId" value="${batchVo.sa_class_id }"/>
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='calculation_detail'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
  <div class="ringht_s">
	<div id="ccChild0" class="search">
	</div>
    <div class="clear"></div>
	<div style="padding: 0 0 8 8;">
        <r:datacell 
            id="itemdatacell"
            paramFormId="datacell_formid"
            queryAction="/FAERP/SalarydataAction.do?cmd=getdataByBatchId&batch_id=${batchVo.id }"
            width="98%"
            height="304px"
            pageSize="10000"
            xpath="SalarydataVo"
            submitXpath="SalarydataVo"
            submitAction="/FAERP/SalarydataAction.do?cmd=saveSalaryData"
            freezeNumber="6"
            >
          <r:toolbar  tools="nav,pagesize,info"/>
	      <r:field fieldName="emp_id" 
	              label="<input type='checkbox' name='checkall' id='checkall' onclick='chk_all(this);' />" 
	              sortAt="none" width ="30px" onRefreshFunc="showchkbox">
	      </r:field>
          <r:field sortAt="none" fieldName="emp_code" messagekey="emp_code" width="150px;"></r:field>
          <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name" width="60px;"></r:field>
          <r:field sortAt="none" fieldName="pay_year_month" messagekey="pay_year_month" width="60px;"></r:field>
          <r:field sortAt="none" fieldName="stop_flag" messagekey="stop_flag" width="60px;">
            <d:select dictTypeId="TrueOrFalse" disabled="true"/>
          </r:field>
          <r:field sortAt="none" fieldName="tax_flag" messagekey="tax_flag" width="90px;">
            <d:select dictTypeId="TAX_FLAG" disabled="true"/>
          </r:field>
           <r:field fieldName="is_postpone" messagekey="is_delay" width="80px;">
            <d:select dictTypeId="TrueOrFalse" disabled="true"/>
          </r:field>
          <r:field sortAt="none" fieldName="account_num" label="银行卡" width="150px;"></r:field>
          <logic:iterate name="salarydataTitleList" id="salarydataTitle" scope="session" indexId="indexs">
		<r:field sortAt="none" fieldName="def${salarydataTitle.item_serial_new_id }"
			label="${salarydataTitle.newsalarylabel }"
			onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
		</r:field>
	</logic:iterate>
        </r:datacell>
    </div>
	<div class="foot_button">
	  <input type="button" value="<fmt:message key='button_back'/>" class="foot_icon_1" onclick="window.close();">
	  <input type="button" onclick="exportPayroll();" value="<fmt:message key='button_output_exl_1'/>" class="foot_icon_3">
	  <input type="button" onclick="exportDetail();" value="<fmt:message key='button_output_exl_2'/>" class="foot_icon_2">
	</div>
  </div>
</div>
</form>
</body>
</html>
<script language="javascript">
if (${msg != null } && ${msg != "" }) {
    alert('${msg}');
}

function changeEntityChk(flag) {
    var dc1 = $id("itemdatacell").dataset;
    var values = dc1.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}
//全选
function chk_all(item){
    if (_$(item).attr("checked")) {
        //changeEntityChk(true);
        _$(":checkbox").attr("checked", true);
    } else {
        //changeEntityChk(false);
        _$(":checkbox").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
	var emp_id = entity.getProperty("emp_id");
    return emp_id?"<input type='checkbox' name='chk_id' value='" + emp_id + "' />":"";
}
//导出薪资明细
function exportDetail(){
    $id("h_cmd").value = "expSalaryDetail";
    $id("datacell_formid").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
    $id("datacell_formid").submit();
}

//导出工资条
function exportPayroll(){
    var ids = getChkedRecord();
    if(ids){
        $id("h_emp_ids").value = ids;
        $id("h_cmd").value = "expPayroll";
        $id("datacell_formid").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
        $id("datacell_formid").submit();
    }
}
//获得选中的记录
function getChkedRecord(){
    var ids = new Array();
    _$("input[name='chk_id']").each(function(){
        if(_$(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    var len = ids.join();
    if(len == 0){
        alert("<fmt:message key='alert_select_one_record'/>");
        return "";
    }
    return len;
}
</script>
</fmt:bundle>
