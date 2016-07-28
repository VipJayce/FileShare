<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agentfinbill.vo.AgentfinbillVo" %>
<%@ page import="rayoo.agent.agentfinbill.util.IAgentfinbillConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	AgentfinbillVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IAgentfinbillConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (AgentfinbillVo)request.getAttribute(IAgentfinbillConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/AgentfinbillAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/AgentfinbillAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/AgentfinbillAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<script language="javascript">
    if(<%=isModify%>)
        writeTableTop('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTop('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>
<form name="form" method="post">

<table class="table_noFrame">
	<tr>
		<td><br>&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_save" class="button_ellipse" type="button" value='<fmt:message key="save"/>' onClickTo="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>">
			<input name="button_cancel" class="button_ellipse" type="button" value='<fmt:message key="cancel"/>'  onClick="javascript:cancel_onClick()" >
		</td>
	</tr>
</table>

<div id="ccParent1"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild1',this,'<%=request.getContextPath()%>/')">
            <c:if test="<%=isModify%>">
                <fmt:message key="update_detail"/>
            </c:if>
            <c:if test="<%=(isModify==false)%>">
                <fmt:message key="add_detail"/>
            </c:if>
		</td>
	</tr>
</table>
</div>

<div id="ccChild1"> 
<table class="table_div_content">
<tr><td> 
	<table class="table_div_content_inner">
		<tr>
			<td align="right">company_id</td>
			<td align="left">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_code</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cust_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cost_center_name</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_name" inputName="cost_center_name" value="" maxLength="50" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">cost_center_id</td>
			<td align="left">
				<input type="text" class="text_field" name="cost_center_id" inputName="cost_center_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_code</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_code" inputName="bill_code" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">version</td>
			<td align="left">
				<input type="text" class="text_field" name="version" inputName="version" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_year_month</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_type_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_type_bd" inputName="bill_type_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_security</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_security" inputName="is_exclusive_security" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_accumulation</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_accumulation" inputName="is_exclusive_accumulation" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_salary</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_salary" inputName="is_exclusive_salary" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_exclusive_tax</td>
			<td align="left">
				<input type="text" class="text_field" name="is_exclusive_tax" inputName="is_exclusive_tax" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_deformity</td>
			<td align="left">
				<input type="text" class="text_field" name="is_deformity" inputName="is_deformity" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">salary_scope_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="salary_scope_bd" inputName="salary_scope_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_amount</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_amount" inputName="bill_amount" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_create_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_create_status_bd" inputName="bill_create_status_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_lock_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_lock_status_bd" inputName="bill_lock_status_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_gather_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_gather_status_bd" inputName="bill_gather_status_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">verification_amount</td>
			<td align="left">
				<input type="text" class="text_field" name="verification_amount" inputName="verification_amount" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_invoice_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_invoice_status_bd" inputName="bill_invoice_status_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">invoice_id</td>
			<td align="left">
				<input type="text" class="text_field" name="invoice_id" inputName="invoice_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_closed</td>
			<td align="left">
				<input type="text" class="text_field" name="is_closed" inputName="is_closed" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">closed_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="closed_date" id="closed_date" inputName="closed_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('closed_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">gathering_agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="gathering_agent_id" inputName="gathering_agent_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">bill_agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="bill_agent_id" inputName="bill_agent_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_valid</td>
			<td align="left">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">is_del</td>
			<td align="left">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_user_id</td>
			<td align="left">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">last_update_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="last_update_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">rate_odds</td>
			<td align="left">
				<input type="text" class="text_field" name="rate_odds" inputName="rate_odds" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">outstanding_amount</td>
			<td align="left">
				<input type="text" class="text_field" name="outstanding_amount" inputName="outstanding_amount" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approve_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="approve_bd" inputName="approve_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyfortime</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="applyfortime" id="applyfortime" inputName="applyfortime" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('applyfortime','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyforuserpartyid</td>
			<td align="left">
				<input type="text" class="text_field" name="applyforuserpartyid" inputName="applyforuserpartyid" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">applyforusername</td>
			<td align="left">
				<input type="text" class="text_field" name="applyforusername" inputName="applyforusername" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approvetime</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="approvetime" id="approvetime" inputName="approvetime" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('approvetime','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approvepartyid</td>
			<td align="left">
				<input type="text" class="text_field" name="approvepartyid" inputName="approvepartyid" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approveusername</td>
			<td align="left">
				<input type="text" class="text_field" name="approveusername" inputName="approveusername" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">approve</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="approve" inputName="approve" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">applyfor</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="applyfor" inputName="applyfor" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">adjust_amout</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_amout" inputName="adjust_amout" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_desc</td>
			<td colspan="3" align="left">
				<textarea class="textarea_limit_words" cols="60" rows="5" name="adjust_desc" inputName="adjust_desc" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td align="right">adjust_man_id</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_man_id" inputName="adjust_man_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="adjust_date" id="adjust_date" inputName="adjust_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_status_bd</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_status_bd" inputName="adjust_status_bd" value="" maxLength="64" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_audit_man_id</td>
			<td align="left">
				<input type="text" class="text_field" name="adjust_audit_man_id" inputName="adjust_audit_man_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">adjust_audit_date</td>
			<td align="left">
				<input type="text" class="text_field_reference_readonly" name="adjust_audit_date" id="adjust_audit_date" inputName="adjust_audit_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_audit_date','<venus:base/>/');"/>
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">invoice_status</td>
			<td align="left">
				<input type="text" class="text_field" name="invoice_status" inputName="invoice_status" value="" maxLength="5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">rate_amount</td>
			<td align="left">
				<input type="text" class="text_field" name="rate_amount" inputName="rate_amount" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">old_id</td>
			<td align="left">
				<input type="text" class="text_field" name="old_id" inputName="old_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">voucher_status</td>
			<td align="left">
				<input type="text" class="text_field" name="voucher_status" inputName="voucher_status" value="" maxLength="1" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">voucher_ym</td>
			<td align="left">
				<input type="text" class="text_field" name="voucher_ym" inputName="voucher_ym" value="" maxLength="3" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right">agent_id</td>
			<td align="left">
				<input type="text" class="text_field" name="agent_id" inputName="agent_id" value="" maxLength="9.5" />
			</td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</td></tr>
</table>
</div>
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
