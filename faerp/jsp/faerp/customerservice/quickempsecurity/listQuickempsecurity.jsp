<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.quickempsecurity.vo.QuickempsecurityVo" %>
<%@ page import="rayoo.customerservice.quickempsecurity.util.IQuickempsecurityConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(IQuickempsecurityConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(IQuickempsecurityConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	QuickempsecurityVo resultVo = null;  //定义一个临时的vo变量
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
		form.action="<%=request.getContextPath()%>/QuickempsecurityAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/QuickempsecurityAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/customerservice/quickempsecurity/insertQuickempsecurity.jsp";
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
		form.action="<%=request.getContextPath()%>/QuickempsecurityAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit();
	}

</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post" action="<%=request.getContextPath()%>/QuickempsecurityAction.do">
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
			<td align="right">emp_post_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_post_id" inputName="emp_post_id" maxLength="9.5"/>
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
			<td align="right">emp_service_item_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_service_item_id" inputName="emp_service_item_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_service_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_service_id" inputName="emp_service_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">social_unit_id</td>
			<td align="left">
				<input type="text" class="text_field" name="social_unit_id" inputName="social_unit_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_social_not_stop</td>
			<td align="left">
				<input type="text" class="text_field" name="is_social_not_stop" inputName="is_social_not_stop" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">social_copy_month</td>
			<td align="left">
				<input type="text" class="text_field" name="social_copy_month" inputName="social_copy_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">apply_man</td>
			<td align="left">
				<input type="text" class="text_field" name="apply_man" inputName="apply_man" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">apply_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="apply_date_from" id="apply_date_from" inputName="apply_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="apply_date_to" id="apply_date_to" inputName="apply_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">apply_remark</td>
			<td align="left">
				<input type="text" class="text_field" name="apply_remark" inputName="apply_remark" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">transact_man</td>
			<td align="left">
				<input type="text" class="text_field" name="transact_man" inputName="transact_man" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">transact_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="transact_date_from" id="transact_date_from" inputName="transact_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('transact_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="transact_date_to" id="transact_date_to" inputName="transact_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('transact_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">transact_type_id</td>
			<td align="left">
				<input type="text" class="text_field" name="transact_type_id" inputName="transact_type_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">transact_remarks</td>
			<td align="left">
				<input type="text" class="text_field" name="transact_remarks" inputName="transact_remarks" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">start_month</td>
			<td align="left">
				<input type="text" class="text_field" name="start_month" inputName="start_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">end_month</td>
			<td align="left">
				<input type="text" class="text_field" name="end_month" inputName="end_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">report_month</td>
			<td align="left">
				<input type="text" class="text_field" name="report_month" inputName="report_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">fund_month</td>
			<td align="left">
				<input type="text" class="text_field" name="fund_month" inputName="fund_month" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">old_cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="old_cust_name" inputName="old_cust_name" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">average_wage</td>
			<td align="left">
				<input type="text" class="text_field_half" name="average_wage_from" inputName="average_wage" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="average_wage_to" inputName="average_wage" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">old_average_wage</td>
			<td align="left">
				<input type="text" class="text_field_half" name="old_average_wage_from" inputName="old_average_wage" value="" columnSize="" decimalDigits="4" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="old_average_wage_to" inputName="old_average_wage" value="" columnSize="" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">back_reason</td>
			<td align="left">
				<input type="text" class="text_field" name="back_reason" inputName="back_reason" maxLength="1000"/>
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
			<td align="right">stop_man</td>
			<td align="left">
				<input type="text" class="text_field" name="stop_man" inputName="stop_man" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">stop_date</td>
			<td align="left">
				<input type="text" class="text_field_half_reference_readonly" name="stop_date_from" id="stop_date_from" inputName="stop_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('stop_date_from','<venus:base/>/');"/>&nbsp;到&nbsp;<input type="text" class="text_field_half_reference_readonly" name="stop_date_to" id="stop_date_to" inputName="stop_date"/><img class="refButtonClass" src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('stop_date_to','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">stop_type_id</td>
			<td align="left">
				<input type="text" class="text_field" name="stop_type_id" inputName="stop_type_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">stop_reason_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="stop_reason_bd" inputName="stop_reason_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">stop_remarks</td>
			<td align="left">
				<input type="text" class="text_field" name="stop_remarks" inputName="stop_remarks" maxLength="1000"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">security_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="security_status_bd" inputName="security_status_bd" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">serial_no</td>
			<td align="left">
				<input type="text" class="text_field" name="serial_no" inputName="serial_no" maxLength="64"/>
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
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">security_group_id</td>
			<td align="left">
				<input type="text" class="text_field" name="security_group_id" inputName="security_group_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">emp_account_id</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_account_id" inputName="emp_account_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">pre_id</td>
			<td align="left">
				<input type="text" class="text_field" name="pre_id" inputName="pre_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">aft_id</td>
			<td align="left">
				<input type="text" class="text_field" name="aft_id" inputName="aft_id" maxLength="9.5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">next_cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="next_cust_name" inputName="next_cust_name" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">nextcust_account</td>
			<td align="left">
				<input type="text" class="text_field" name="nextcust_account" inputName="nextcust_account" maxLength="64"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field_half" name="old_id_from" inputName="old_id" value="" columnSize="" decimalDigits="0" />&nbsp;到&nbsp;<input type="text" class="text_field_half" name="old_id_to" inputName="old_id" value="" columnSize="" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">input_type</td>
			<td align="left">
				<input type="text" class="text_field" name="input_type" inputName="input_type" maxLength="5"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">transact_reason_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="transact_reason_bd" inputName="transact_reason_bd" maxLength="64"/>
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
			
			<layout:collectionItem width="8%" title="emp_post_id" property="emp_post_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cust_code" property="cust_code" sortable="true"/>
			
			<layout:collectionItem width="8%" title="cust_name" property="cust_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_service_item_id" property="emp_service_item_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_service_id" property="emp_service_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="social_unit_id" property="social_unit_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="is_social_not_stop" property="is_social_not_stop" sortable="true"/>
			
			<layout:collectionItem width="8%" title="social_copy_month" property="social_copy_month" sortable="true"/>
			
			<layout:collectionItem width="8%" title="apply_man" property="apply_man" sortable="true"/>
			
			<layout:collectionItem width="8%" title="apply_date" property="apply_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="apply_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="apply_remark" property="apply_remark" sortable="true"/>
			
			<layout:collectionItem width="8%" title="transact_man" property="transact_man" sortable="true"/>
			
			<layout:collectionItem width="8%" title="transact_date" property="transact_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="transact_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="transact_type_id" property="transact_type_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="transact_remarks" property="transact_remarks" sortable="true"/>
			
			<layout:collectionItem width="8%" title="start_month" property="start_month" sortable="true"/>
			
			<layout:collectionItem width="8%" title="end_month" property="end_month" sortable="true"/>
			
			<layout:collectionItem width="8%" title="report_month" property="report_month" sortable="true"/>
			
			<layout:collectionItem width="8%" title="fund_month" property="fund_month" sortable="true"/>
			
			<layout:collectionItem width="8%" title="old_cust_name" property="old_cust_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="average_wage" property="average_wage" sortable="true"/>
			
			<layout:collectionItem width="8%" title="old_average_wage" property="old_average_wage" sortable="true"/>
			
			<layout:collectionItem width="8%" title="back_reason" property="back_reason" sortable="true"/>
			
			<layout:collectionItem width="8%" title="agent_id" property="agent_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="stop_man" property="stop_man" sortable="true"/>
			
			<layout:collectionItem width="8%" title="stop_date" property="stop_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="stop_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="stop_type_id" property="stop_type_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="stop_reason_bd" property="stop_reason_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="stop_remarks" property="stop_remarks" sortable="true"/>
			
			<layout:collectionItem width="8%" title="security_status_bd" property="security_status_bd" sortable="true"/>
			
			<layout:collectionItem width="8%" title="serial_no" property="serial_no" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_update_user_id" property="last_update_user_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="last_update_date" property="last_update_date" sortable="true">
				<bean:define id="rmValue" name="rmBean" property="last_update_date"/>
				<%=gap.rm.tools.helper.RmStringHelper.prt(rmValue, 10)%>
			</layout:collectionItem>
			
			<layout:collectionItem width="8%" title="is_del" property="is_del" sortable="true"/>
			
			<layout:collectionItem width="8%" title="security_group_id" property="security_group_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="emp_account_id" property="emp_account_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="pre_id" property="pre_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="aft_id" property="aft_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="next_cust_name" property="next_cust_name" sortable="true"/>
			
			<layout:collectionItem width="8%" title="nextcust_account" property="nextcust_account" sortable="true"/>
			
			<layout:collectionItem width="8%" title="old_id" property="old_id" sortable="true"/>
			
			<layout:collectionItem width="8%" title="input_type" property="input_type" sortable="true"/>
			
			<layout:collectionItem width="8%" title="transact_reason_bd" property="transact_reason_bd" sortable="true"/>
			
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
	if(request.getAttribute(IQuickempsecurityConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IQuickempsecurityConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
