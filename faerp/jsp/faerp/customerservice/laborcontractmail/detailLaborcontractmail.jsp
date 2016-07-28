<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.laborcontractmail.vo.LaborcontractmailVo" %>
<%@ page import="rayoo.customerservice.laborcontractmail.util.ILaborcontractmailConstants" %>
<%  //取出本条记录
	LaborcontractmailVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (LaborcontractmailVo)request.getAttribute(ILaborcontractmailConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>emp_code：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_code())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cust_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cust_code：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>cust_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>start_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStart_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>end_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEnd_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>salary：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSalary())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>try_start_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTry_start_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>try_end_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTry_end_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>try_salary：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getTry_salary())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>subscribe_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSubscribe_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>labor_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLabor_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>labor_type_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLabor_type_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_deadline：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_deadline())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_work_out：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_work_out())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>welfare_address：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getWelfare_address())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>working_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getWorking_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>send_start_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSend_start_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>send_end_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSend_end_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>remind_status：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getRemind_status())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>position：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getPosition())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>备注：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getRemark())%></td>
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
			<td align="right" width="10%" nowrap>old_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>contract_properties：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getContract_properties())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>contractmail_type：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getContractmail_type())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>contractmail_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getContractmail_status_bd())%></td>
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
