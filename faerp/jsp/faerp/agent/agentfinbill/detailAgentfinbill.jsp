<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.agent.agentfinbill.vo.AgentfinbillVo" %>
<%@ page import="rayoo.agent.agentfinbill.util.IAgentfinbillConstants" %>
<%  //取出本条记录
	AgentfinbillVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AgentfinbillVo)request.getAttribute(IAgentfinbillConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/RoomAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="detail_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td><br>&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_back" class="button_ellipse" type="button" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" >
		</td>
	</tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
	<table class="viewlistCss" style="width:100%">
		<tr>
			<td align="right" width="10%" nowrap>company_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cust_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cust_code：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cust_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cost_center_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCost_center_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cost_center_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCost_center_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_code：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_code())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>version：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getVersion())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_year_month：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_year_month())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_type_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_type_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_exclusive_security：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_exclusive_security())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_exclusive_accumulation：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_exclusive_accumulation())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_exclusive_salary：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_exclusive_salary())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_exclusive_tax：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_exclusive_tax())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_deformity：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_deformity())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>salary_scope_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSalary_scope_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_amount：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_amount())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_create_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_create_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_lock_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_lock_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_gather_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_gather_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>verification_amount：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getVerification_amount())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_invoice_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_invoice_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>invoice_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getInvoice_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_closed：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_closed())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>closed_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getClosed_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>gathering_agent_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getGathering_agent_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>bill_agent_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_agent_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_valid：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_del：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>rate_odds：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getRate_odds())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>outstanding_amount：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOutstanding_amount())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>approve_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApprove_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>applyfortime：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApplyfortime(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>applyforuserpartyid：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApplyforuserpartyid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>applyforusername：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApplyforusername())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>approvetime：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApprovetime(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>approvepartyid：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApprovepartyid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>approveusername：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApproveusername())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>approve：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApprove())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>applyfor：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApplyfor())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_amout：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_amout())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_desc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_desc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_man_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_man_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_audit_man_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_audit_man_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>adjust_audit_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAdjust_audit_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>invoice_status：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getInvoice_status())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>rate_amount：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getRate_amount())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>old_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>voucher_status：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getVoucher_status())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>voucher_ym：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getVoucher_ym())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>agent_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAgent_id())%></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</div>

<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

</form>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
