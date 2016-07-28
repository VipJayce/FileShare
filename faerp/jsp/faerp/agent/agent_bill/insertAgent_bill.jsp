<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agent_bill.vo.Agent_billVo" %>
<%@ page import="rayoo.agent.agent_bill.util.IAgent_billConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	Agent_billVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IAgent_billConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Agent_billVo)request.getAttribute(IAgent_billConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html><body>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/Agent_billAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/Agent_billAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Agent_billAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" >company_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cost_center_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cost_center_name" inputName="cost_center_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cost_center_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cost_center_id" inputName="cost_center_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_code" inputName="bill_code" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >version</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="version" inputName="version" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_year_month</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_type_bd" inputName="bill_type_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_security</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_exclusive_security" inputName="is_exclusive_security" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_accumulation</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_exclusive_accumulation" inputName="is_exclusive_accumulation" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_salary</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_exclusive_salary" inputName="is_exclusive_salary" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_tax</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_exclusive_tax" inputName="is_exclusive_tax" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_deformity</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_deformity" inputName="is_deformity" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >salary_scope_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="salary_scope_bd" inputName="salary_scope_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >bill_amount</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="bill_amount" inputName="bill_amount" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_create_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_create_status_bd" inputName="bill_create_status_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_lock_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_lock_status_bd" inputName="bill_lock_status_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_gather_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_gather_status_bd" inputName="bill_gather_status_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >verification_amount</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="verification_amount" inputName="verification_amount" maxLength="21" integerDigits="18" decimalDigits="2" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_invoice_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_invoice_status_bd" inputName="bill_invoice_status_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >invoice_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="invoice_id" inputName="invoice_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_closed</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_closed" inputName="is_closed" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >closed_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="closed_date" id="closed_date" inputName="closed_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('closed_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gathering_agent_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gathering_agent_id" inputName="gathering_agent_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_agent_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_agent_id" inputName="bill_agent_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_del</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="last_update_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >rate_odds</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="rate_odds" inputName="rate_odds" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >outstanding_amount</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="outstanding_amount" inputName="outstanding_amount" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >approve_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="approve_bd" inputName="approve_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >applyfortime</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="applyfortime" id="applyfortime" inputName="applyfortime" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('applyfortime','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >applyforuserpartyid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="applyforuserpartyid" inputName="applyforuserpartyid" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >applyforusername</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="applyforusername" inputName="applyforusername" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >approvetime</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="approvetime" id="approvetime" inputName="approvetime" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('approvetime','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >approvepartyid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="approvepartyid" inputName="approvepartyid" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >approveusername</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="approveusername" inputName="approveusername" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">approve</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="approve" inputName="approve" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1">applyfor</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="applyfor" inputName="applyfor" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td  class="td_1" >adjust_amout</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="adjust_amout" inputName="adjust_amout" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">adjust_desc</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="adjust_desc" inputName="adjust_desc" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >adjust_man_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="adjust_man_id" inputName="adjust_man_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >adjust_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="adjust_date" id="adjust_date" inputName="adjust_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >adjust_status_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="adjust_status_bd" inputName="adjust_status_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >adjust_audit_man_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="adjust_audit_man_id" inputName="adjust_audit_man_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >adjust_audit_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="adjust_audit_date" id="adjust_audit_date" inputName="adjust_audit_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('adjust_audit_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >invoice_status</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="invoice_status" inputName="invoice_status" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >rate_amount</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="rate_amount" inputName="rate_amount" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >old_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="old_id" inputName="old_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >voucher_status</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="voucher_status" inputName="voucher_status" value="" maxLength="1" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >voucher_ym</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="voucher_ym" inputName="voucher_ym" value="" maxLength="3" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >供应商ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="agent_id" inputName="供应商ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
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
