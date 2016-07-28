<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agentfinbill.vo.AgentfinbillVo" %>
<%@ page import="rayoo.agent.agentfinbill.util.IAgentfinbillConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IAgentfinbillConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IAgentfinbillConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	AgentfinbillVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/AgentfinbillAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/AgentfinbillAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/agent/agentfinbill/insertAgentfinbill.jsp";
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
		form.action="<%=request.getContextPath()%>/AgentfinbillAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post" action="<%=request.getContextPath()%>/AgentfinbillAction.do">
<input type="hidden" name="cmd" value="">
<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;<fmt:message key="query_by_condition"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
<table class="table_div_content">
<tr><td>
	<table class="table_noFrame" width="100%">
		<tr>
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cost_center_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_name" inputName="cost_center_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cost_center_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_id" inputName="cost_center_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_code</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_code" inputName="bill_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">version</td>
			<td align="left">
				<input type="text" class="text_field_half" name="version_from" inputName="version" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="version_to" inputName="version" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_type_bd" inputName="bill_type_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_security</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_security" inputName="is_exclusive_security" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_accumulation</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_accumulation" inputName="is_exclusive_accumulation" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_salary</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_salary" inputName="is_exclusive_salary" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_tax</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_tax" inputName="is_exclusive_tax" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_deformity</td>
			<td align="left">
				<input type="text" class="text_field" name="is_deformity" inputName="is_deformity" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">salary_scope_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_scope_bd" inputName="salary_scope_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="bill_amount_from" inputName="bill_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="bill_amount_to" inputName="bill_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_create_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_create_status_bd" inputName="bill_create_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_lock_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_lock_status_bd" inputName="bill_lock_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_gather_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_gather_status_bd" inputName="bill_gather_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">verification_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="verification_amount_from" inputName="verification_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="verification_amount_to" inputName="verification_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_invoice_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_invoice_status_bd" inputName="bill_invoice_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">invoice_id</td>
			<td align="left">
				<input type="text" class="text_field" name="invoice_id" inputName="invoice_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_closed</td>
			<td align="left">
				<input type="text" class="text_field" name="is_closed" inputName="is_closed" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">closed_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="closed_date_from" id="closed_date_from" inputName="closed_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('closed_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="closed_date_to" id="closed_date_to" inputName="closed_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('closed_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">gathering_agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="gathering_agent_id" inputName="gathering_agent_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_agent_id" inputName="bill_agent_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="last_update_date_from" id="last_update_date_from" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="last_update_date_to" id="last_update_date_to" inputName="last_update_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">rate_odds</td>
			<td align="left">
				<input type="text" class="text_field_half" name="rate_odds_from" inputName="rate_odds" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="rate_odds_to" inputName="rate_odds" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">outstanding_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="outstanding_amount_from" inputName="outstanding_amount" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="outstanding_amount_to" inputName="outstanding_amount" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approve_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="approve_bd" inputName="approve_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyfortime</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="applyfortime_from" id="applyfortime_from" inputName="applyfortime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('applyfortime_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="applyfortime_to" id="applyfortime_to" inputName="applyfortime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('applyfortime_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyforuserpartyid</td>
			<td align="left">
				<input type="text" class="text_field" name="applyforuserpartyid" inputName="applyforuserpartyid" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyforusername</td>
			<td align="left">
				<input type="text" class="text_field" name="applyforusername" inputName="applyforusername" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approvetime</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="approvetime_from" id="approvetime_from" inputName="approvetime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('approvetime_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="approvetime_to" id="approvetime_to" inputName="approvetime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('approvetime_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approvepartyid</td>
			<td align="left">
				<input type="text" class="text_field" name="approvepartyid" inputName="approvepartyid" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approveusername</td>
			<td align="left">
				<input type="text" class="text_field" name="approveusername" inputName="approveusername" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approve</td>
			<td align="left">
				<input type="text" class="text_field" name="approve" inputName="approve" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyfor</td>
			<td align="left">
				<input type="text" class="text_field" name="applyfor" inputName="applyfor" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_amout</td>
			<td align="left">
				<input type="text" class="text_field_half" name="adjust_amout_from" inputName="adjust_amout" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="adjust_amout_to" inputName="adjust_amout" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_desc</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_desc" inputName="adjust_desc" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_man_id</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_man_id" inputName="adjust_man_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="adjust_date_from" id="adjust_date_from" inputName="adjust_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="adjust_date_to" id="adjust_date_to" inputName="adjust_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_status_bd" inputName="adjust_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_audit_man_id</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_audit_man_id" inputName="adjust_audit_man_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_audit_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="adjust_audit_date_from" id="adjust_audit_date_from" inputName="adjust_audit_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_audit_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="adjust_audit_date_to" id="adjust_audit_date_to" inputName="adjust_audit_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_audit_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">invoice_status</td>
			<td align="left">
				<input type="text" class="text_field" name="invoice_status" inputName="invoice_status" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">rate_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="rate_amount_from" inputName="rate_amount" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="rate_amount_to" inputName="rate_amount" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field" name="old_id" inputName="old_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">voucher_status</td>
			<td align="left">
				<input type="text" class="text_field" name="voucher_status" inputName="voucher_status" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">voucher_ym</td>
			<td align="left">
				<input type="text" class="text_field" name="voucher_ym" inputName="voucher_ym" maxLength="3"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="agent_id" inputName="agent_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td/>
            <td>
                <input name="button_ok" class="button_ellipse" type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="button_ellipse" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
			<td/>
			<td/>
		</tr>
	</table>

</td></tr>
</table>
</div>
					
<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">&nbsp;<fmt:message key="detail_table"/>
		</td>
		<td> 
			<table align="right">
				<tr>
					<td class="button_ellipse" onClick="javascript:detail_onClick();"><img src="<%=request.getContextPath()%>/images/icon/search.gif" class="div_control_image"><fmt:message key="view"/></td>
					<td class="button_ellipse" onClick="javascript:toAdd_onClick();"><img src="<%=request.getContextPath()%>/images/icon/add.gif" class="div_control_image"><fmt:message key="insert"/></td>
					<td class="button_ellipse" onClick="javascript:deleteMulti_onClick();"><img src="<%=request.getContextPath()%>/images/icon/delete.gif" class="div_control_image"><fmt:message key="delete"/></td>
					<td class="button_ellipse" onClick="javascript:findCheckbox_onClick();"><img src="<%=request.getContextPath()%>/images/icon/modify.gif" class="div_control_image"><fmt:message key="modify"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content2">
	<tr>
		<td>
		<layout:collection name="beans" id="rmBean" styleClass="listCss" width="100%" indexId="orderNumber" align="center" sortAction="0">
			
			<layout:collectionItem width="1%" title="<input type='checkbox' pdType='control' control='checkbox_template'/>" style="text-align:center;">
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<bean:define id="rmDisplayName" name="rmBean" property="id"/>
				<input type="checkbox" name="checkbox_template" value="<%=rmValue%>" displayName="<%=rmDisplayName%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="3%"  title="序" style="text-align:center;">
				<venus:sequence/>
				<bean:define id="rmValue" name="rmBean" property="id"/>
				<input type="hidden" signName="hiddenId" value="<%=rmValue%>"/>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="company_id" property="company_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cust_id" property="cust_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cust_code" property="cust_code" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cust_name" property="cust_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cost_center_name" property="cost_center_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cost_center_id" property="cost_center_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_code" property="bill_code" sortable="true"/>
			
			<layout:collectionItem width="8%" title="version" property="version" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_year_month" property="bill_year_month" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_type_bd" property="bill_type_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_exclusive_security" property="is_exclusive_security" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_exclusive_accumulation" property="is_exclusive_accumulation" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_exclusive_salary" property="is_exclusive_salary" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_exclusive_tax" property="is_exclusive_tax" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_deformity" property="is_deformity" sortable="true"/>
			
			<layout:collectionItem width="8%" title="salary_scope_bd" property="salary_scope_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_amount" property="bill_amount" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_create_status_bd" property="bill_create_status_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_lock_status_bd" property="bill_lock_status_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_gather_status_bd" property="bill_gather_status_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="verification_amount" property="verification_amount" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_invoice_status_bd" property="bill_invoice_status_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="invoice_id" property="invoice_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_closed" property="is_closed" sortable="true"/>
			
			<layout:collectionItem width="8%" title="closed_date" property="closed_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="closed_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="gathering_agent_id" property="gathering_agent_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="bill_agent_id" property="bill_agent_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_valid" property="is_valid" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_del" property="is_del" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_update_user_id" property="last_update_user_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_update_date" property="last_update_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="last_update_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="rate_odds" property="rate_odds" sortable="true"/>
			
			<layout:collectionItem width="8%" title="outstanding_amount" property="outstanding_amount" sortable="true"/>
			
			<layout:collectionItem width="8%" title="approve_bd" property="approve_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="applyfortime" property="applyfortime" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="applyfortime"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="applyforuserpartyid" property="applyforuserpartyid" sortable="true"/>
			
			<layout:collectionItem width="8%" title="applyforusername" property="applyforusername" sortable="true"/>
			
			<layout:collectionItem width="8%" title="approvetime" property="approvetime" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="approvetime"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="approvepartyid" property="approvepartyid" sortable="true"/>
			
			<layout:collectionItem width="8%" title="approveusername" property="approveusername" sortable="true"/>
			
			<layout:collectionItem width="8%" title="approve" property="approve" sortable="true"/>
			
			<layout:collectionItem width="8%" title="applyfor" property="applyfor" sortable="true"/>
			
			<layout:collectionItem width="8%" title="adjust_amout" property="adjust_amout" sortable="true"/>
			
			<layout:collectionItem width="8%" title="adjust_desc" property="adjust_desc" sortable="true"/>
			
			<layout:collectionItem width="8%" title="adjust_man_id" property="adjust_man_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="adjust_date" property="adjust_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="adjust_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="adjust_status_bd" property="adjust_status_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="adjust_audit_man_id" property="adjust_audit_man_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="adjust_audit_date" property="adjust_audit_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="adjust_audit_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="invoice_status" property="invoice_status" sortable="true"/>
			
			<layout:collectionItem width="8%" title="rate_amount" property="rate_amount" sortable="true"/>
			
			<layout:collectionItem width="8%" title="old_id" property="old_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="voucher_status" property="voucher_status" sortable="true"/>
			
			<layout:collectionItem width="8%" title="voucher_ym" property="voucher_ym" sortable="true"/>
			
			<layout:collectionItem width="8%" title="agent_id" property="agent_id" sortable="true"/>
			
			</layout:collection>
		
		<!-- 下边这句是翻页, 如果去掉就不带翻页了,同时注意Action中也要调整方法 -->
		<jsp:include page="/jsp/include/page.jsp" />
		</td>
	</tr>
</table>
</div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IAgentfinbillConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IAgentfinbillConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
