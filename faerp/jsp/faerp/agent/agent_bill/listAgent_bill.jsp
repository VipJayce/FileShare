<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agent_bill.vo.Agent_billVo" %>
<%@ page import="rayoo.agent.agent_bill.util.IAgent_billConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IAgent_billConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IAgent_billConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	Agent_billVo resultVo = null;  //定义一个临时的vo变量
%>
<html><body>
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
		form.action="<%=request.getContextPath()%>/Agent_billAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/Agent_billAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/agent/agent_bill/insertAgent_bill.jsp";
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
		form.action="<%=request.getContextPath()%>/Agent_billAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/Agent_billAction.do">
<input type="hidden" name="cmd" value="">
 
 
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
			<td align="right">cust_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cost_center_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_name" inputName="cost_center_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">cost_center_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_id" inputName="cost_center_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_code</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_code" inputName="bill_code" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">version</td>
			<td align="left">
				<input type="text" class="text_field_half" name="version_from" inputName="version" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="version_to" inputName="version" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_type_bd" inputName="bill_type_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_security</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_security" inputName="is_exclusive_security" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_accumulation</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_accumulation" inputName="is_exclusive_accumulation" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_salary</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_salary" inputName="is_exclusive_salary" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_tax</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_tax" inputName="is_exclusive_tax" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_deformity</td>
			<td align="left">
				<input type="text" class="text_field" name="is_deformity" inputName="is_deformity" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">salary_scope_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_scope_bd" inputName="salary_scope_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="bill_amount_from" inputName="bill_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="bill_amount_to" inputName="bill_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_create_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_create_status_bd" inputName="bill_create_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_lock_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_lock_status_bd" inputName="bill_lock_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_gather_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_gather_status_bd" inputName="bill_gather_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">verification_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="verification_amount_from" inputName="verification_amount" value="" columnSize="" decimalDigits="2" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="verification_amount_to" inputName="verification_amount" value="" columnSize="" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_invoice_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_invoice_status_bd" inputName="bill_invoice_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">invoice_id</td>
			<td align="left">
				<input type="text" class="text_field" name="invoice_id" inputName="invoice_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_closed</td>
			<td align="left">
				<input type="text" class="text_field" name="is_closed" inputName="is_closed" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">closed_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="closed_date_from" id="closed_date_from" inputName="closed_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('closed_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="closed_date_to" id="closed_date_to" inputName="closed_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('closed_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">gathering_agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="gathering_agent_id" inputName="gathering_agent_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">bill_agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_agent_id" inputName="bill_agent_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" maxLength="64"/>
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
			<td align="right">rate_odds</td>
			<td align="left">
				<input type="text" class="text_field_half" name="rate_odds_from" inputName="rate_odds" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="rate_odds_to" inputName="rate_odds" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">outstanding_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="outstanding_amount_from" inputName="outstanding_amount" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="outstanding_amount_to" inputName="outstanding_amount" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">approve_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="approve_bd" inputName="approve_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">applyfortime</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="applyfortime_from" id="applyfortime_from" inputName="applyfortime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('applyfortime_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="applyfortime_to" id="applyfortime_to" inputName="applyfortime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('applyfortime_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">applyforuserpartyid</td>
			<td align="left">
				<input type="text" class="text_field" name="applyforuserpartyid" inputName="applyforuserpartyid" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">applyforusername</td>
			<td align="left">
				<input type="text" class="text_field" name="applyforusername" inputName="applyforusername" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">approvetime</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="approvetime_from" id="approvetime_from" inputName="approvetime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('approvetime_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="approvetime_to" id="approvetime_to" inputName="approvetime"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('approvetime_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">approvepartyid</td>
			<td align="left">
				<input type="text" class="text_field" name="approvepartyid" inputName="approvepartyid" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">approveusername</td>
			<td align="left">
				<input type="text" class="text_field" name="approveusername" inputName="approveusername" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">approve</td>
			<td align="left">
				<input type="text" class="text_field" name="approve" inputName="approve" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">applyfor</td>
			<td align="left">
				<input type="text" class="text_field" name="applyfor" inputName="applyfor" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_amout</td>
			<td align="left">
				<input type="text" class="text_field_half" name="adjust_amout_from" inputName="adjust_amout" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="adjust_amout_to" inputName="adjust_amout" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_desc</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_desc" inputName="adjust_desc" maxLength="2000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_man_id</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_man_id" inputName="adjust_man_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="adjust_date_from" id="adjust_date_from" inputName="adjust_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="adjust_date_to" id="adjust_date_to" inputName="adjust_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_status_bd" inputName="adjust_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_audit_man_id</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_audit_man_id" inputName="adjust_audit_man_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">adjust_audit_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="adjust_audit_date_from" id="adjust_audit_date_from" inputName="adjust_audit_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_audit_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="adjust_audit_date_to" id="adjust_audit_date_to" inputName="adjust_audit_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_audit_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">invoice_status</td>
			<td align="left">
				<input type="text" class="text_field" name="invoice_status" inputName="invoice_status" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">rate_amount</td>
			<td align="left">
				<input type="text" class="text_field_half" name="rate_amount_from" inputName="rate_amount" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="rate_amount_to" inputName="rate_amount" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field" name="old_id" inputName="old_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">voucher_status</td>
			<td align="left">
				<input type="text" class="text_field" name="voucher_status" inputName="voucher_status" maxLength="1"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">voucher_ym</td>
			<td align="left">
				<input type="text" class="text_field" name="voucher_ym" inputName="voucher_ym" maxLength="3"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
		</tr>
		<tr>
			<td align="right">供应商ID</td>
			<td align="left">
				<input type="text" class="text_field" name="agent_id" inputName="供应商ID" maxLength="9.5"/>
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
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
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
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"company_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"company_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"company_id")%>">
           	</a>	
       
			 company_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_id")%>">
           	</a>	
       
			 cust_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_code")%>">
           	</a>	
       
			 cust_code</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cust_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cust_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cust_name")%>">
           	</a>	
       
			 cust_name</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_name")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_name")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_name")%>">
           	</a>	
       
			 cost_center_name</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"cost_center_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"cost_center_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"cost_center_id")%>">
           	</a>	
       
			 cost_center_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_code")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_code")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_code")%>">
           	</a>	
       
			 bill_code</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"version")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"version")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"version")%>">
           	</a>	
       
			 version</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_year_month")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_year_month")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_year_month")%>">
           	</a>	
       
			 bill_year_month</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_type_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_type_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_type_bd")%>">
           	</a>	
       
			 bill_type_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_exclusive_security")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_exclusive_security")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_exclusive_security")%>">
           	</a>	
       
			 is_exclusive_security</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_exclusive_accumulation")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_exclusive_accumulation")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_exclusive_accumulation")%>">
           	</a>	
       
			 is_exclusive_accumulation</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_exclusive_salary")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_exclusive_salary")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_exclusive_salary")%>">
           	</a>	
       
			 is_exclusive_salary</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_exclusive_tax")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_exclusive_tax")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_exclusive_tax")%>">
           	</a>	
       
			 is_exclusive_tax</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_deformity")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_deformity")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_deformity")%>">
           	</a>	
       
			 is_deformity</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"salary_scope_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"salary_scope_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"salary_scope_bd")%>">
           	</a>	
       
			 salary_scope_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_amount")%>">
           	</a>	
       
			 bill_amount</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_create_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_create_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_create_status_bd")%>">
           	</a>	
       
			 bill_create_status_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_lock_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_lock_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_lock_status_bd")%>">
           	</a>	
       
			 bill_lock_status_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_gather_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_gather_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_gather_status_bd")%>">
           	</a>	
       
			 bill_gather_status_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"verification_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"verification_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"verification_amount")%>">
           	</a>	
       
			 verification_amount</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_invoice_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_invoice_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_invoice_status_bd")%>">
           	</a>	
       
			 bill_invoice_status_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"invoice_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"invoice_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"invoice_id")%>">
           	</a>	
       
			 invoice_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_closed")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_closed")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_closed")%>">
           	</a>	
       
			 is_closed</th>
			<th>
							
				 	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"closed_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"closed_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"closed_date")%>">
           	</a>	
       
			closed_date</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"gathering_agent_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"gathering_agent_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"gathering_agent_id")%>">
           	</a>	
       
			 gathering_agent_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"bill_agent_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"bill_agent_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"bill_agent_id")%>">
           	</a>	
       
			 bill_agent_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_valid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_valid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_valid")%>">
           	</a>	
       
			 is_valid</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"is_del")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"is_del")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"is_del")%>">
           	</a>	
       
			 is_del</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_user_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_user_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_user_id")%>">
           	</a>	
       
			 last_update_user_id</th>
			<th>
							
				 	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"last_update_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"last_update_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"last_update_date")%>">
           	</a>	
       
			last_update_date</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"rate_odds")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"rate_odds")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"rate_odds")%>">
           	</a>	
       
			 rate_odds</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"outstanding_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"outstanding_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"outstanding_amount")%>">
           	</a>	
       
			 outstanding_amount</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"approve_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"approve_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"approve_bd")%>">
           	</a>	
       
			 approve_bd</th>
			<th>
							
				 	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"applyfortime")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"applyfortime")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"applyfortime")%>">
           	</a>	
       
			applyfortime</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"applyforuserpartyid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"applyforuserpartyid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"applyforuserpartyid")%>">
           	</a>	
       
			 applyforuserpartyid</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"applyforusername")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"applyforusername")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"applyforusername")%>">
           	</a>	
       
			 applyforusername</th>
			<th>
							
				 	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"approvetime")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"approvetime")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"approvetime")%>">
           	</a>	
       
			approvetime</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"approvepartyid")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"approvepartyid")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"approvepartyid")%>">
           	</a>	
       
			 approvepartyid</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"approveusername")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"approveusername")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"approveusername")%>">
           	</a>	
       
			 approveusername</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"approve")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"approve")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"approve")%>">
           	</a>	
       
			 approve</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"applyfor")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"applyfor")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"applyfor")%>">
           	</a>	
       
			 applyfor</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_amout")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_amout")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_amout")%>">
           	</a>	
       
			 adjust_amout</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_desc")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_desc")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_desc")%>">
           	</a>	
       
			 adjust_desc</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_man_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_man_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_man_id")%>">
           	</a>	
       
			 adjust_man_id</th>
			<th>
							
				 	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_date")%>">
           	</a>	
       
			adjust_date</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_status_bd")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_status_bd")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_status_bd")%>">
           	</a>	
       
			 adjust_status_bd</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_audit_man_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_audit_man_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_audit_man_id")%>">
           	</a>	
       
			 adjust_audit_man_id</th>
			<th>
							
				 	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"adjust_audit_date")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"adjust_audit_date")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"adjust_audit_date")%>">
           	</a>	
       
			adjust_audit_date</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"invoice_status")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"invoice_status")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"invoice_status")%>">
           	</a>	
       
			 invoice_status</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"rate_amount")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"rate_amount")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"rate_amount")%>">
           	</a>	
       
			 rate_amount</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"old_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"old_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"old_id")%>">
           	</a>	
       
			 old_id</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"voucher_status")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"voucher_status")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"voucher_status")%>">
           	</a>	
       
			 voucher_status</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"voucher_ym")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"voucher_ym")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"voucher_ym")%>">
           	</a>	
       
			 voucher_ym</th>
			<th>
				
			  	<a href="/FAERP/Agent_billAction.do?cmd=queryAll&VENUS_ORDER_KEY=<%=royoo.common.TagSortUitl.getSortColumn(request,"agent_id")%>">
            	<img src="/FAERP/images/<%=royoo.common.TagSortUitl.getSortImage(request,"agent_id")%>" border="0" title="<%=royoo.common.TagSortUitl.getSortTitle(request,"agent_id")%>">
           	</a>	
       
			 供应商ID</th>
			</tr>
<logic:iterate     name="beans"  id="data" scope="request" indexId="indexs">
		<tr>
		<td class="fex_row"> <input type="checkbox" name="checkbox_template" value="<bean:write name="data" property="id"/>" displayName="<bean:write name="data" property="id"/>"/></td>

<td><bean:write name="data" property="company_id"/>   </td>
			
			<td><bean:write name="data" property="cust_id"/>   </td>
			
			<td><bean:write name="data" property="cust_code"/>   </td>
			
			<td><bean:write name="data" property="cust_name"/>   </td>
			
			<td><bean:write name="data" property="cost_center_name"/>   </td>
			
			<td><bean:write name="data" property="cost_center_id"/>   </td>
			
			<td><bean:write name="data" property="bill_code"/>   </td>
			
			<td><bean:write name="data" property="version"/>   </td>
			
			<td><bean:write name="data" property="bill_year_month"/>   </td>
			
			<td><bean:write name="data" property="bill_type_bd"/>   </td>
			
			<td><bean:write name="data" property="is_exclusive_security"/>   </td>
			
			<td><bean:write name="data" property="is_exclusive_accumulation"/>   </td>
			
			<td><bean:write name="data" property="is_exclusive_salary"/>   </td>
			
			<td><bean:write name="data" property="is_exclusive_tax"/>   </td>
			
			<td><bean:write name="data" property="is_deformity"/>   </td>
			
			<td><bean:write name="data" property="salary_scope_bd"/>   </td>
			
			<td><bean:write name="data" property="bill_amount"/>   </td>
			
			<td><bean:write name="data" property="bill_create_status_bd"/>   </td>
			
			<td><bean:write name="data" property="bill_lock_status_bd"/>   </td>
			
			<td><bean:write name="data" property="bill_gather_status_bd"/>   </td>
			
			<td><bean:write name="data" property="verification_amount"/>   </td>
			
			<td><bean:write name="data" property="bill_invoice_status_bd"/>   </td>
			
			<td><bean:write name="data" property="invoice_id"/>   </td>
			
			<td><bean:write name="data" property="is_closed"/>   </td>
			
			<td><bean:write name="data" property="closed_date"/>   </td>
			<td><bean:write name="data" property="gathering_agent_id"/>   </td>
			
			<td><bean:write name="data" property="bill_agent_id"/>   </td>
			
			<td><bean:write name="data" property="is_valid"/>   </td>
			
			<td><bean:write name="data" property="is_del"/>   </td>
			
			<td><bean:write name="data" property="last_update_user_id"/>   </td>
			
			<td><bean:write name="data" property="last_update_date"/>   </td>
			<td><bean:write name="data" property="rate_odds"/>   </td>
			
			<td><bean:write name="data" property="outstanding_amount"/>   </td>
			
			<td><bean:write name="data" property="approve_bd"/>   </td>
			
			<td><bean:write name="data" property="applyfortime"/>   </td>
			<td><bean:write name="data" property="applyforuserpartyid"/>   </td>
			
			<td><bean:write name="data" property="applyforusername"/>   </td>
			
			<td><bean:write name="data" property="approvetime"/>   </td>
			<td><bean:write name="data" property="approvepartyid"/>   </td>
			
			<td><bean:write name="data" property="approveusername"/>   </td>
			
			<td><bean:write name="data" property="approve"/>   </td>
			
			<td><bean:write name="data" property="applyfor"/>   </td>
			
			<td><bean:write name="data" property="adjust_amout"/>   </td>
			
			<td><bean:write name="data" property="adjust_desc"/>   </td>
			
			<td><bean:write name="data" property="adjust_man_id"/>   </td>
			
			<td><bean:write name="data" property="adjust_date"/>   </td>
			<td><bean:write name="data" property="adjust_status_bd"/>   </td>
			
			<td><bean:write name="data" property="adjust_audit_man_id"/>   </td>
			
			<td><bean:write name="data" property="adjust_audit_date"/>   </td>
			<td><bean:write name="data" property="invoice_status"/>   </td>
			
			<td><bean:write name="data" property="rate_amount"/>   </td>
			
			<td><bean:write name="data" property="old_id"/>   </td>
			
			<td><bean:write name="data" property="voucher_status"/>   </td>
			
			<td><bean:write name="data" property="voucher_ym"/>   </td>
			
			<td><bean:write name="data" property="agent_id"/>   </td>
			
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
	if(request.getAttribute(IAgent_billConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IAgent_billConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
