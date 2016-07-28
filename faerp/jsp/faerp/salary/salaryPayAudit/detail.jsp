<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.salaryPayAudit.salaryPayAudit_resource" prefix="rayoo.salary.salaryPayAudit.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title><fmt:message key='title_viewDetail'/></title>
</head>

<body>
<form id="formItem" action="" method="post"> 
<input type="hidden" id="h_batchId" name="batchId" value="${param.batchId}"/>
<input type="hidden" id="h_clzId" name="clzId" value="${param.clzId}"/>
<input type="hidden" id="h_emp_ids" name="emp_ids" value="${param.emp_id}"/>
<input type="hidden" id="h_cmd" name="cmd" />
<div id="right">
	<div class="right_title_bg">
	  <div class=" right_title"><fmt:message key='title_viewDetail'/></div>
	</div>
  <div class="ringht_s">
    <!--表格 -->
    <div style="padding: 8 0 8 8;">
    <r:datacell id="dc_salary_data" 
        width="99%"
        freezeNumber="3"
        pageSize="10000"
        paramFormId="formItem"
        queryAction="/FAERP/SalaryPayAuditAction.do?cmd=detail"
        submitAction="/FAERP/SalaryPayAuditAction.do?cmd=detail"
	    submitXpath="SalarydataVo" 
	    xpath="SalarydataVo">
	  <r:toolbar  tools="nav,pagesize,info"/>
	  <!--<r:field fieldName="emp_id" 
              label="<input type='checkbox' onclick='chk_all(this)' />" 
              sortAt="none" width ="30px" onRefreshFunc="showchkbox">
      </r:field>
	  --><r:field sortAt="none" fieldName="emp_code" messagekey="emp_code">
	    
	  </r:field>
	  <r:field sortAt="none" fieldName="emp_name" messagekey="emp_name">
	    
	  </r:field>
	  <r:field sortAt="none" fieldName="pay_year_month" messagekey="pay_year_month">
	    
	  </r:field>
	  <logic:iterate name="salarydataTitleList" id="salarydataTitle" indexId="indexs">
             <r:field sortAt="none" fieldName="def${salarydataTitle.item_serial_new_id }" label="${salarydataTitle.newsalarylabel }"
             onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
             </r:field>
      </logic:iterate>
	</r:datacell>
	</div>
    <!--表格 end-->
	<div class="foot_button">
	  <input onclick="location.href='javascript:history.go(-1);'" type="button" class="foot_icon_1" value="<fmt:message key='button_back'/>"/>
	  <!--<input onclick="exportPayroll()" type="button" class="foot_icon_3" value="导出excel工资条"/>-->
	  <input onclick="exportDetail()" type="button" class="foot_icon_2" value="<fmt:message key='button_exportDetail'/>"/>
	</div>
  </div>
</div>
</form>
</body>
<script type="text/javascript">
/*
//全选
function chk_all(){
    jQuery("input[name='chk_id']").each(function(){
        jQuery(this).attr("checked",!jQuery(this).attr("checked"))
    });
}*/
//全选
function chk_all(item){
    if (jQuery(item).attr("checked")) {
        jQuery(":checkbox").attr("checked", true);
    } else {
        jQuery(":checkbox").attr("checked", false);
    }
}
//显示一列chkbox
function showchkbox(value,entity,rowNo,cellNo){
    return "<input type='checkbox' name='chk_id' value='" + entity.getProperty("emp_id") + "' />";
}
//导出薪资明细
function exportDetail(){
    $id("h_cmd").value = "expSalaryDetail";
    $id("formItem").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do?cmd=expSalaryDetail&batchId=${param.batchId}&emp_ids=${param.emp_id}&clzId=${param.clzId}&flag_in_finance=1" ;
    $id("formItem").submit();
}
//导出工资条
function exportPayroll(){
	var ids = getChkedRecord();
	if(ids){
		$id("h_emp_ids").value = ids;
		$id("h_cmd").value = "expPayroll";
    	$id("formItem").action = "<%=request.getContextPath()%>/SalaryPayAuditAction.do" ;
    	$id("formItem").submit();
	}
}
//获得选中的记录
function getChkedRecord(){
	var ids = new Array();
    jQuery("input[name='chk_id']").each(function(){
        if(jQuery(this).attr("checked")){
            ids.push(this.value)
        }
    });
    
    var len = ids.join();
    if(len == 0){
    	alert("<fmt:message key='alert_select_record'/>");
    	return "";
    }
    return len;
}
</script>
</fmt:bundle>
</html>
