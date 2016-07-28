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
	<title><fmt:message key='delay_salary_data'/></title>
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
        writeTableTopFesco("<fmt:message key='delay_salary_data'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
  <div class="ringht_s">
	<div id="ccChild0" class="search">
	   <table width="60%" border="0" cellspacing="0" cellpadding="0">
		    <tr>
		        <td align="right"><fmt:message key='emp_name'/></td>
		        <td align="left">
		            <input type="text" id="emp_name" name="emp_name" class="text_field" style="width: 150px;">
		        </td>
		        <td align="right"><fmt:message key='emp_idcard'/></td>
		        <td align="left">
		             <input type="text" id="emp_idcard" name="id_card" class="text_field" style="width: 150px;">
		        </td>
		        <td>
		             <input onclick="listquery();" id="batchListquery" class="icon_1" type="button" value="<fmt:message key='button_search'/>"/>
		        </td>
		    </tr>
        </table>
	</div>
	
	<div class="button">
	  <div class="button_right">
	    <ul>
	      <li class="g_1" onclick="updateDelayFlag(1);"><a href="###"><fmt:message key='button_set_delay_flag'/></a></li>
	      <li class="d_1" onclick="updateDelayFlag(0);"><a href="###"><fmt:message key='button_remove_delay_flag'/></a></li>
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
	        queryAction="/FAERP/SalarydataAction.do?cmd=getdataByBatchId&batch_id=${batchVo.id }&flag=delay"
	        width="98%"
	        height="390px"
	        pageSize="10000"
	        xpath="SalarydataVo"
	        submitXpath="SalarydataVo"
	        submitAction="/FAERP/SalarydataAction.do?cmd=saveSalaryData"
	        readonly="true"
	        >
	        <r:toolbar  tools="info"/>
	      <r:field allowModify="false"  fieldName="id_index" sortAt="none" 
	        label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" 
	        width="30px" onRefreshFunc="setDelayCheckboxStatus">
	      </r:field>
	      <r:field fieldName="emp_code" messagekey="emp_code" width="80px;"></r:field>
	      <r:field fieldName="emp_name" messagekey="emp_name" width="80px;"></r:field>
	      <r:field fieldName="id_card" messagekey="emp_idcard" width="80px;"></r:field>
	      <r:field fieldName="is_postpone" messagekey="is_delay" width="80px;">
	        <d:select dictTypeId="TrueOrFalse" disabled="true"/>
	      </r:field>
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
  </div>
</div>
</form>
</body>
</html>
<script language="javascript">

jQuery(function(){
    $id("itemdatacell").isQueryFirst = false;
});

function listquery() {
    var emp_name = jQuery("#emp_name").val();
    var emp_idcard = jQuery("#emp_idcard").val();
    if (emp_name || emp_idcard){
	    $id("itemdatacell").reload();
    }else{
        alert('<fmt:message key="alert_delay_tip"/>');
        return false;
    }
}

function updateDelayFlag(flag) {
    var arr = [];
    jQuery("input:checkbox[name=checkbox_template]:checked'").each(function(i){
       arr.push(jQuery(this).val());
    });

    jQuery.ajax({
       type: "POST",
       url: venusbase + "/SalarydataAction.do?cmd=updatePostpone",
       data: "flag=" + flag + "&ids=" + arr.join(","),
       dataType: "html",
       success: function(msg){
            if (msg) {
                alert(msg);
                listquery();
            }
        }
    });
}

function setDelayCheckboxStatus(value, entity, rowNo, cellNo){
    var dc = $id("itemdatacell");
    var str = "<input type='checkbox' name='checkbox_template' value=" + entity.getProperty("id") + ">";
  //  if(dc.dataset.getLength()-1 == rowNo){
   //     str = "";
   // }
   return str;
}

if (${msg != null } && ${msg != "" }) {
    alert('${msg}');
}
</script>
</fmt:bundle>
