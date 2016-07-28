<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.salary.salaryorderrelease.vo.SalaryorderreleaseVo" %>
<%@ page import="rayoo.salary.salaryorderrelease.util.ISalaryorderreleaseConstants" %>
<%  //取出本条记录
	SalaryorderreleaseVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SalaryorderreleaseVo)request.getAttribute(ISalaryorderreleaseConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/SalaryorderreleaseAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >company_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >sa_batch_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSa_batch_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >customer_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >sa_class_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSa_class_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_year_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_year_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_verify：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_verify())%></td>
		</tr>
		<tr>
			<td class="td_1" >verify_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getVerify_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >is_pay：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_pay())%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_audit_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_audit_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >audit_user：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAudit_user())%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >bill_year_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_year_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >tax_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTax_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_unite_tax：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_unite_tax())%></td>
		</tr>
		<tr>
			<td class="td_1" >remarks：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >submit_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSubmit_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >submit_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSubmit_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >apply_state：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_state())%></td>
		</tr>
		<tr>
			<td class="td_1" >audit_state：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAudit_state())%></td>
		</tr>
		<tr>
			<td class="td_1" >must_day：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMust_day())%></td>
		</tr>
		<tr>
			<td class="td_1" >reject_cause：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getReject_cause())%></td>
		</tr>
		<tr>
			<td class="td_1" >ebank_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEbank_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >total_number：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTotal_number())%></td>
		</tr>
		<tr>
			<td class="td_1" >total_amount：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTotal_amount())%></td>
		</tr>
		<tr>
			<td class="td_1" >fail_number：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFail_number())%></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPayroll_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_state_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPayroll_state_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >apply_pay_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_pay_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >audit_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAudit_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >gen_money_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGen_money_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_salary_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_salary_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >not_code_reason：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getNot_code_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" >claim_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >claim_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >real_pay_day：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getReal_pay_day())%></td>
		</tr>
		<tr>
			<td class="td_1" >pay_state：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPay_state())%></td>
		</tr>
		<tr>
			<td class="td_1" >apply_pay_time：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_pay_time(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >apply_pay_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_pay_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_cs_verify：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_cs_verify())%></td>
		</tr>
		<tr>
			<td class="td_1" align="right"></td>
			<td class="td_2" align="left"></td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
