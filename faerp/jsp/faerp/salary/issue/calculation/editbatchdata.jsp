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
<html>
<fmt:bundle basename="rayoo.salary.issue.calculation.calculation_resource" prefix="rayoo.salary.issue.calculation.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='edit_salary_data'/></title>
	<script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/editbatch.js"></script>
    <script language="javascript" src="<venus:base/>/jsp/faerp/salary/issue/calculation/calcommon.js"></script>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='edit_salary_data'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
  <div class="ringht_s">
	<div id="ccChild0" class="search">
	</div>
	<div class="button">
	  <div class="button_right">
	    <ul>
	      <li class="bc" onclick="saveSelect(2);"><a href="###"><fmt:message key='button_save'/></a></li>
	      <li class="dj_3" onclick="getbillitem();"><a href="###"><fmt:message key='button_getbillitem'/></a></li>
	      <li class="js" onclick="calSalary(1);"><a><fmt:message key='button_calSalary'/></a></li>
	      <li class="d" onclick="stopitem();"><a href="###"><fmt:message key='button_del'/></a></li>
	      <li class="js_1" onclick="AT2Salary(1);"><a href="###"><fmt:message key='button_AT2Salary'/></a></li>
	      <li class="m"><a href="javascript:window.close();"><fmt:message key='button_back'/></a></li>
	    </ul>
	  </div>
	  <div class="clear"></div>
	</div>
    <div class="clear"></div>
    <!-- 为了防止和DATACELL中的FIELDNAME 冲突，加上h -->
    <input type="hidden" id="h_sa_class_id" name="h_sa_class_id" value="${batchVo.sa_class_id }"/>
    <input type="hidden" id="h_sa_batch_id" name="h_sa_batch_id" value="${batchVo.id }" />
    <input type="hidden" id="old_year_month" name="old_year_month" value="${batchVo.bill_year_month }">
    <input type="hidden" id="batch_id" name="batch_id" value="${batchVo.id }" />
    <input type="hidden" id="h_apply_state" name="h_apply_state" value="${batchVo.apply_state }" />
    <input type="hidden" id="h_audit_state" name="h_audit_state" value="${batchVo.audit_state }" />
	<input type="hidden" id="h_is_verify" name="h_is_verify" value="${batchVo.is_verify }">
	<input type="hidden" id="h_bill_year_month" name="h_bill_year_month" value="${batchVo.bill_year_month }"/>
	<input type="hidden" id="h_cust_id" name="h_cust_id" value="${batchVo.customer_id }"/>
	<input type="hidden" id="h_is_si" name="h_is_si" value="${clz.is_si }"/>
	<input type="hidden" id="new_add_emp" name="new_add_emp"/>
	<input type="hidden" id="total_amount" name="total_amount" value="${total_amount }"/>
	
	<div style="padding: 0 0 8 8;">
	    <r:datacell 
	        id="itemdatacell"
	        paramFormId="datacell_formid"
	        queryAction="/FAERP/SalarydataAction.do?cmd=getdataByBatchId&batch_id=${batchVo.id }&flag=edit"
	        width="98%"
	        height="304px"
	        pageSize="10000"
	        xpath="SalarydataVo"
	        submitXpath="SalarydataVo"
	        submitAction="/FAERP/SalarydataAction.do?cmd=saveSalaryData"
	        >
	        <r:toolbar  tools="info"/>
	      <r:field allowModify="false"  fieldName="id_index" sortAt="none" 
	        label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" 
	        width="30px" onRefreshFunc="setCheckboxStatus">
	      </r:field>
	      <r:field fieldName="emp_code" messagekey="emp_code" width="80px;"></r:field>
	      <r:field fieldName="emp_name" messagekey="emp_name" width="80px;"></r:field>
	      <r:field fieldName="pay_year_month" messagekey="pay_year_month_" width="80px;"></r:field>
	      <r:field sortAt="none" fieldName="tax_flag" messagekey="tax_flag" allowModify="false" width="90px;">
            <d:select dictTypeId="TAX_FLAG" disabled="true"/>
          </r:field>
          <r:field sortAt="none" fieldName="account_num" label="银行卡" width="150px;"></r:field>
	      <logic:iterate name="salarydataTitleList" id="salarydataTitle" scope="session" indexId="indexs">
		<r:field fieldName="def${salarydataTitle.item_serial_new_id }"
			label="${salarydataTitle.newsalarylabel }"
			onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
			<h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！" />
		</r:field>
	</logic:iterate>
	    </r:datacell>
	</div>
	<div class="button">
	 <div class="button_right">
	   <ul>
	     <!-- 客户要求：从薪资档案中获取雇员数据 -->
	     <li class="c_4" onclick="showAddempPage();"><a href="###"><fmt:message key='button_add_emp_data'/></a></li>
	     <li class="bc_1" onclick="saveSelect(2);"><a href="###"><fmt:message key='button_save_all'/></a></li>
	     <li class="dj_4" onclick="getbillitem_all();"><a><fmt:message key='button_getbillitem_all'/></a></li>
	     <li class="js_2" onclick="calSalary(2)"><a href="###"><fmt:message key='button_calSalary_all'/></a></li>
	     <li class="Js_3" onclick="AT2Salary(2);"><a href="###"><fmt:message key='button_AT2Salary_all'/></a></li>
	     <li class="g_1" onclick="affirm(2);"><a href="###"><fmt:message key='button_sjqr'/></a></li>
	     <li class="h_2" onclick="approval2fin(2);"><a href="###"><fmt:message key='button_tjsh'/></a></li>
	   </ul>
	 </div>
	 <div class="clear"></div>
	</div>
  </div>
</div>
</form>
</body>
</fmt:bundle>
</html>
<script language="javascript">
if (${msg != null } && ${msg != "" }) {
    alert('${msg}');
}
</script>
