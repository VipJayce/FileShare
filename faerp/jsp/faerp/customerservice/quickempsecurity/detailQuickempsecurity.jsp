<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.quickempsecurity.vo.QuickempsecurityVo" %>
<%@ page import="rayoo.customerservice.quickempsecurity.util.IQuickempsecurityConstants" %>
<%  //取出本条记录
	QuickempsecurityVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (QuickempsecurityVo)request.getAttribute(IQuickempsecurityConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>emp_post_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_post_id())%></td>
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
			<td align="right" width="10%" nowrap>emp_service_item_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_service_item_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_service_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_service_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>social_unit_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSocial_unit_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_social_not_stop：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_social_not_stop())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>social_copy_month：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSocial_copy_month())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>apply_man：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApply_man())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>apply_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApply_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>apply_remark：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApply_remark())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>transact_man：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTransact_man())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>transact_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTransact_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>transact_type_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTransact_type_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>transact_remarks：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTransact_remarks())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>start_month：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStart_month())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>end_month：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEnd_month())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>report_month：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getReport_month())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>fund_month：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFund_month())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>old_cust_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_cust_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>average_wage：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAverage_wage())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>old_average_wage：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_average_wage())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>back_reason：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBack_reason())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>agent_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAgent_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>stop_man：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStop_man())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>stop_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStop_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>stop_type_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStop_type_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>stop_reason_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStop_reason_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>stop_remarks：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStop_remarks())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>security_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSecurity_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>serial_no：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSerial_no())%></td>
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
			<td align="right" width="10%" nowrap>is_del：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>security_group_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSecurity_group_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_account_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_account_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>pre_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getPre_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>aft_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAft_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>next_cust_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getNext_cust_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>nextcust_account：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getNextcust_account())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>old_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>input_type：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getInput_type())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>transact_reason_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTransact_reason_bd())%></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</div>

<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
