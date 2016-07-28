<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.quickemppost.vo.QuickemppostVo" %>
<%@ page import="rayoo.employeepost.quickemppost.util.IQuickemppostConstants" %>
<%  //取出本条记录
	QuickemppostVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (QuickemppostVo)request.getAttribute(IQuickemppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>cust_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
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
			<td align="right" width="10%" nowrap>emp_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
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
			<td align="right" width="10%" nowrap>send_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSend_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_post_type_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_post_type_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>apply_on_post_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApply_on_post_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>charge_start_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCharge_start_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>charge_end_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCharge_end_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_employ_notice：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_employ_notice())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_physical_examination：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_physical_examination())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_import_client：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_import_client())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>security_unit_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSecurity_unit_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>on_post_desc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOn_post_desc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>post_status_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getPost_status_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>on_post_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOn_post_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>on_post_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOn_post_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>move_pre_post_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getMove_pre_post_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>move_aft_post_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getMove_aft_post_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>move_desc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getMove_desc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>apply_off_post_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getApply_off_post_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>off_post_reason：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOff_post_reason())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>off_post_desc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOff_post_desc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>method_labor_get_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getMethod_labor_get_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>method_accu_move_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getMethod_accu_move_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>location_retrieve_doc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLocation_retrieve_doc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>off_post_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOff_post_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>off_post_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOff_post_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>first_notice_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFirst_notice_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>first_notice_result：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFirst_notice_result())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>second_notice_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSecond_notice_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>second_notice_result：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSecond_notice_result())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>third_notice_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getThird_notice_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>third_notice_result：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getThird_notice_result())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>notice_desc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getNotice_desc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>exam_process：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getExam_process())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>exam_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getExam_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>exam_result：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getExam_result())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>mobile：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getMobile())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>email：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmail())%></td>
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
			<td align="right" width="10%" nowrap>notice_status：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getNotice_status())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>notice_desc2：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getNotice_desc2())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>internal_code：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getInternal_code())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>import_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getImport_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>old_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>company_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_entry_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_entry_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>fund_security_unit_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFund_security_unit_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>hire_security_unit_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getHire_security_unit_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>off_notice_status：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOff_notice_status())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>job_num：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getJob_num())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>hro：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getHro())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>business：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBusiness())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>emp_status：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_status())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>ge_off_post_reason：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getGe_off_post_reason())%></td>
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
