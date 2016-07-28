<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.salary.search.salarysearch.vo.SalarySearchVo" %>
<%@ page import="rayoo.salary.search.salarysearch.util.ISalarySearchConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	SalarySearchVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISalarySearchConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SalarySearchVo)request.getAttribute(ISalarySearchConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/SalarySearchAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/SalarySearchAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SalarySearchAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >sa_batch_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sa_batch_code" inputName="sa_batch_code" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >customer_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="customer_name" inputName="customer_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >customer_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="customer_code" inputName="customer_code" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >customer_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="customer_id" inputName="customer_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >sa_class_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="sa_class_id" inputName="sa_class_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_year_month</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pay_year_month" inputName="pay_year_month" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_verify</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_verify" inputName="is_verify" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >verify_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="verify_time" id="verify_time" inputName="verify_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('verify_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_pay</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_pay" inputName="is_pay" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="pay_time" id="pay_time" inputName="pay_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('pay_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_audit_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pay_audit_id" inputName="pay_audit_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >audit_user</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="audit_user" inputName="audit_user" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pay_name" inputName="pay_name" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bill_year_month</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_year_month" inputName="bill_year_month" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >tax_month</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="tax_month" inputName="tax_month" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_unite_tax</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_unite_tax" inputName="is_unite_tax" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">remarks</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="remarks" inputName="remarks" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >submit_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="submit_user_id" inputName="submit_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >submit_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="submit_time" id="submit_time" inputName="submit_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('submit_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >apply_state</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="apply_state" inputName="apply_state" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >audit_state</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="audit_state" inputName="audit_state" value="'0' " maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >must_day</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="must_day" inputName="must_day" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">reject_cause</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="reject_cause" inputName="reject_cause" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >ebank_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="ebank_time" id="ebank_time" inputName="ebank_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('ebank_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >total_number</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="total_number" inputName="total_number" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >total_amount</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="total_amount" inputName="total_amount" maxLength="23" integerDigits="18" decimalDigits="4" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >fail_number</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="fail_number" inputName="fail_number" maxLength="19" integerDigits="18" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_type_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="payroll_type_bd" inputName="payroll_type_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_state_bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="payroll_state_bd" inputName="payroll_state_bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_del</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="'0'" maxLength="64" />
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
			<td class="td_1" >apply_pay_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="apply_pay_date" id="apply_pay_date" inputName="apply_pay_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_pay_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >audit_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="audit_time" id="audit_time" inputName="audit_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('audit_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gen_money_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gen_money_code" inputName="gen_money_code" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_salary_type</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pay_salary_type" inputName="pay_salary_type" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >not_code_reason</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="not_code_reason" inputName="not_code_reason" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >claim_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="claim_user_id" inputName="claim_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >claim_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="claim_date" id="claim_date" inputName="claim_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('claim_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >real_pay_day</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="real_pay_day" inputName="real_pay_day" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_state</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pay_state" inputName="pay_state" value="'0' " maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >apply_pay_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="apply_pay_time" id="apply_pay_time" inputName="apply_pay_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('apply_pay_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >apply_pay_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="apply_pay_user_id" inputName="apply_pay_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_cs_verify</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_cs_verify" inputName="is_cs_verify" value="'0' " maxLength="1" />
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
