<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.search.salarysearch.vo.SalarySearchVo" %>
<%@ page import="rayoo.salary.search.salarysearch.util.ISalarySearchConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISalarySearchConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISalarySearchConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SalarySearchVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SalarySearchAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/SalarySearchAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/salary/search/salarysearch/insertSalarySearch.jsp";
		form.submit();
	}
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/SalarySearchAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/SalarySearchAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_batch_code</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_batch_code" inputName="sa_batch_code" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">customer_name</td>
			<td align="left">
				<input type="text" class="text_field" name="customer_name" inputName="customer_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">customer_code</td>
			<td align="left">
				<input type="text" class="text_field" name="customer_code" inputName="customer_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">customer_id</td>
			<td align="left">
				<input type="text" class="text_field" name="customer_id" inputName="customer_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">sa_class_id</td>
			<td align="left">
				<input type="text" class="text_field" name="sa_class_id" inputName="sa_class_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="pay_year_month" inputName="pay_year_month" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_verify</td>
			<td align="left">
				<input type="text" class="text_field" name="is_verify" inputName="is_verify" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">verify_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="verify_time_from" id="verify_time_from" inputName="verify_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('verify_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="verify_time_to" id="verify_time_to" inputName="verify_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('verify_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_pay</td>
			<td align="left">
				<input type="text" class="text_field" name="is_pay" inputName="is_pay" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="pay_time_from" id="pay_time_from" inputName="pay_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('pay_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="pay_time_to" id="pay_time_to" inputName="pay_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('pay_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_audit_id</td>
			<td align="left">
				<input type="text" class="text_field" name="pay_audit_id" inputName="pay_audit_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">audit_user</td>
			<td align="left">
				<input type="text" class="text_field" name="audit_user" inputName="audit_user" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_name</td>
			<td align="left">
				<input type="text" class="text_field" name="pay_name" inputName="pay_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">tax_month</td>
			<td align="left">
				<input type="text" class="text_field" name="tax_month" inputName="tax_month" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_unite_tax</td>
			<td align="left">
				<input type="text" class="text_field" name="is_unite_tax" inputName="is_unite_tax" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">remarks</td>
			<td align="left">
				<input type="text" class="text_field" name="remarks" inputName="remarks" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">submit_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="submit_user_id" inputName="submit_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">submit_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="submit_time_from" id="submit_time_from" inputName="submit_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('submit_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="submit_time_to" id="submit_time_to" inputName="submit_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('submit_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_state</td>
			<td align="left">
				<input type="text" class="text_field" name="apply_state" inputName="apply_state" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">audit_state</td>
			<td align="left">
				<input type="text" class="text_field" name="audit_state" inputName="audit_state" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">must_day</td>
			<td align="left">
				<input type="text" class="text_field_half" name="must_day_from" inputName="must_day" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="must_day_to" inputName="must_day" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">reject_cause</td>
			<td align="left">
				<input type="text" class="text_field" name="reject_cause" inputName="reject_cause" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">ebank_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="ebank_time_from" id="ebank_time_from" inputName="ebank_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('ebank_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="ebank_time_to" id="ebank_time_to" inputName="ebank_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('ebank_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">total_number</td>
			<td align="left">
				<input type="text" class="text_field_half" name="total_number_from" inputName="total_number" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="total_number_to" inputName="total_number" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">total_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="total_amount_from" inputName="total_amount" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="total_amount_to" inputName="total_amount" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">fail_number</td>
			<td align="left">
				<input type="text" class="text_field_half" name="fail_number_from" inputName="fail_number" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="fail_number_to" inputName="fail_number" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payroll_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="payroll_type_bd" inputName="payroll_type_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">payroll_state_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="payroll_state_bd" inputName="payroll_state_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_pay_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="apply_pay_date_from" id="apply_pay_date_from" inputName="apply_pay_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_pay_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="apply_pay_date_to" id="apply_pay_date_to" inputName="apply_pay_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_pay_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">audit_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="audit_time_from" id="audit_time_from" inputName="audit_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('audit_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="audit_time_to" id="audit_time_to" inputName="audit_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('audit_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">gen_money_code</td>
			<td align="left">
				<input type="text" class="text_field" name="gen_money_code" inputName="gen_money_code" maxLength="25"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_salary_type</td>
			<td align="left">
				<input type="text" class="text_field" name="pay_salary_type" inputName="pay_salary_type" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">not_code_reason</td>
			<td align="left">
				<input type="text" class="text_field" name="not_code_reason" inputName="not_code_reason" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">claim_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="claim_user_id" inputName="claim_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">claim_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="claim_date_from" id="claim_date_from" inputName="claim_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('claim_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="claim_date_to" id="claim_date_to" inputName="claim_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('claim_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">real_pay_day</td>
			<td align="left">
				<input type="text" class="text_field_half" name="real_pay_day_from" inputName="real_pay_day" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="real_pay_day_to" inputName="real_pay_day" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">pay_state</td>
			<td align="left">
				<input type="text" class="text_field" name="pay_state" inputName="pay_state" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_pay_time</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="apply_pay_time_from" id="apply_pay_time_from" inputName="apply_pay_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_pay_time_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="apply_pay_time_to" id="apply_pay_time_to" inputName="apply_pay_time"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_pay_time_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">apply_pay_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="apply_pay_user_id" inputName="apply_pay_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_cs_verify</td>
			<td align="left">
				<input type="text" class="text_field" name="is_cs_verify" inputName="is_cs_verify" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td/>
          
			<td/>
			<td/>
			  <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
            	<td/>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div id="values_div" class="box" > 
      <table  width="100%" cellspacing="0"  class="datagrid1">
<tr>
<th  class="fex_row"><input type='checkbox' onclick="checkAllList_onClick(this);"  pdType='control' control='checkbox_template'/></th>
<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_batch_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_batch_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_batch_code")%>">
           	</a>	
       
			 sa_batch_code</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_name")%>">
           	</a>	
       
			 customer_name</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_code")%>">
           	</a>	
       
			 customer_code</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"customer_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"customer_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"customer_id")%>">
           	</a>	
       
			 customer_id</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"sa_class_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"sa_class_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"sa_class_id")%>">
           	</a>	
       
			 sa_class_id</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_year_month")%>">
           	</a>	
       
			 pay_year_month</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_verify")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_verify")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_verify")%>">
           	</a>	
       
			 is_verify</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"verify_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"verify_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"verify_time")%>">
           	</a>	
       
			verify_time</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_pay")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_pay")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_pay")%>">
           	</a>	
       
			 is_pay</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_time")%>">
           	</a>	
       
			pay_time</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_audit_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_audit_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_audit_id")%>">
           	</a>	
       
			 pay_audit_id</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"audit_user")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"audit_user")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"audit_user")%>">
           	</a>	
       
			 audit_user</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_name")%>">
           	</a>	
       
			 pay_name</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_year_month")%>">
           	</a>	
       
			 bill_year_month</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"tax_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"tax_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"tax_month")%>">
           	</a>	
       
			 tax_month</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_unite_tax")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_unite_tax")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_unite_tax")%>">
           	</a>	
       
			 is_unite_tax</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"remarks")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"remarks")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"remarks")%>">
           	</a>	
       
			 remarks</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"submit_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"submit_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"submit_user_id")%>">
           	</a>	
       
			 submit_user_id</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"submit_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"submit_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"submit_time")%>">
           	</a>	
       
			submit_time</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_state")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_state")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_state")%>">
           	</a>	
       
			 apply_state</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"audit_state")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"audit_state")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"audit_state")%>">
           	</a>	
       
			 audit_state</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"must_day")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"must_day")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"must_day")%>">
           	</a>	
       
			 must_day</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"reject_cause")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"reject_cause")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"reject_cause")%>">
           	</a>	
       
			 reject_cause</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"ebank_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"ebank_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"ebank_time")%>">
           	</a>	
       
			ebank_time</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"total_number")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"total_number")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"total_number")%>">
           	</a>	
       
			 total_number</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"total_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"total_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"total_amount")%>">
           	</a>	
       
			 total_amount</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"fail_number")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"fail_number")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"fail_number")%>">
           	</a>	
       
			 fail_number</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payroll_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payroll_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payroll_type_bd")%>">
           	</a>	
       
			 payroll_type_bd</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"payroll_state_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"payroll_state_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"payroll_state_bd")%>">
           	</a>	
       
			 payroll_state_bd</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_pay_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_pay_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_pay_date")%>">
           	</a>	
       
			apply_pay_date</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"audit_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"audit_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"audit_time")%>">
           	</a>	
       
			audit_time</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"gen_money_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"gen_money_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"gen_money_code")%>">
           	</a>	
       
			 gen_money_code</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_salary_type")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_salary_type")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_salary_type")%>">
           	</a>	
       
			 pay_salary_type</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"not_code_reason")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"not_code_reason")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"not_code_reason")%>">
           	</a>	
       
			 not_code_reason</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"claim_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"claim_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"claim_user_id")%>">
           	</a>	
       
			 claim_user_id</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"claim_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"claim_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"claim_date")%>">
           	</a>	
       
			claim_date</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"real_pay_day")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"real_pay_day")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"real_pay_day")%>">
           	</a>	
       
			 real_pay_day</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"pay_state")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"pay_state")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"pay_state")%>">
           	</a>	
       
			 pay_state</th>
			<th>
							
				 	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_pay_time")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_pay_time")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_pay_time")%>">
           	</a>	
       
			apply_pay_time</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"apply_pay_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"apply_pay_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"apply_pay_user_id")%>">
           	</a>	
       
			 apply_pay_user_id</th>
			<th>
				
			  	<a href="/FAERP/SalarySearchAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_cs_verify")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_cs_verify")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_cs_verify")%>">
           	</a>	
       
			 is_cs_verify</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="sa_batch_code"/>   </td>
			
			<td><bean:write name="data" property="customer_name"/>   </td>
			
			<td><bean:write name="data" property="customer_code"/>   </td>
			
			<td><bean:write name="data" property="customer_id"/>   </td>
			
			<td><bean:write name="data" property="sa_class_id"/>   </td>
			
			<td><bean:write name="data" property="pay_year_month"/>   </td>
			
			<td><bean:write name="data" property="is_verify"/>   </td>
			
			<td><bean:write name="data" property="verify_time"/>   </td>
			<td><bean:write name="data" property="is_pay"/>   </td>
			
			<td><bean:write name="data" property="pay_time"/>   </td>
			<td><bean:write name="data" property="pay_audit_id"/>   </td>
			
			<td><bean:write name="data" property="audit_user"/>   </td>
			
			<td><bean:write name="data" property="pay_name"/>   </td>
			
			<td><bean:write name="data" property="bill_year_month"/>   </td>
			
			<td><bean:write name="data" property="tax_month"/>   </td>
			
			<td><bean:write name="data" property="is_unite_tax"/>   </td>
			
			<td><bean:write name="data" property="remarks"/>   </td>
			
			<td><bean:write name="data" property="submit_user_id"/>   </td>
			
			<td><bean:write name="data" property="submit_time"/>   </td>
			<td><bean:write name="data" property="apply_state"/>   </td>
			
			<td><bean:write name="data" property="audit_state"/>   </td>
			
			<td><bean:write name="data" property="must_day"/>   </td>
			
			<td><bean:write name="data" property="reject_cause"/>   </td>
			
			<td><bean:write name="data" property="ebank_time"/>   </td>
			<td><bean:write name="data" property="total_number"/>   </td>
			
			<td><bean:write name="data" property="total_amount"/>   </td>
			
			<td><bean:write name="data" property="fail_number"/>   </td>
			
			<td><bean:write name="data" property="payroll_type_bd"/>   </td>
			
			<td><bean:write name="data" property="payroll_state_bd"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="apply_pay_date"/>   </td>
			<td><bean:write name="data" property="audit_time"/>   </td>
			<td><bean:write name="data" property="gen_money_code"/>   </td>
			
			<td><bean:write name="data" property="pay_salary_type"/>   </td>
			
			<td><bean:write name="data" property="not_code_reason"/>   </td>
			
			<td><bean:write name="data" property="claim_user_id"/>   </td>
			
			<td><bean:write name="data" property="claim_date"/>   </td>
			<td><bean:write name="data" property="real_pay_day"/>   </td>
			
			<td><bean:write name="data" property="pay_state"/>   </td>
			
			<td><bean:write name="data" property="apply_pay_time"/>   </td>
			<td><bean:write name="data" property="apply_pay_user_id"/>   </td>
			
			<td><bean:write name="data" property="is_cs_verify"/>   </td>
			
			</tr>
</logic:iterate>
</table>
</div>
<jsp:include page="/jsp/include/page.jsp" />
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(ISalarySearchConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(ISalarySearchConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
