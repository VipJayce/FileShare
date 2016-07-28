<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%  //取出本条记录
	EmppostVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EmppostVo)request.getAttribute(IEmppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" ><fmt:message key="cust_name"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="cust_code"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="emp_code"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_code())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="emp_name"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_name())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="send_id"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSend_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="quotation_id"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getQuotation_id())%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="emp_post_type"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getEmp_post_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="apply_on_post_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_on_post_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="charge_start_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCharge_start_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="charge_end_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCharge_end_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_employ_notice"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_employ_notice())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_physical_examination"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_physical_examination())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="is_import_client"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_import_client())%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="security_unit_id"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getSecurity_unit_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="on_post_desc"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOn_post_desc())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="post_status"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPost_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="on_post_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOn_post_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="on_post_user_id"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOn_post_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="move_desc"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMove_desc())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="apply_off_post_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_off_post_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="off_post_reason"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getOff_post_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_desc"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOff_post_desc())%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="method_labor_get"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getMethod_labor_get_bd())%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="method_accu_move"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getMethod_accu_move_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="location_retrieve_doc"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLocation_retrieve_doc())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOff_post_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="off_post_user_id"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOff_post_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="first_notice_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFirst_notice_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="first_notice_result"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFirst_notice_result())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="second_notice_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSecond_notice_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="second_notice_result"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSecond_notice_result())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="third_notice_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getThird_notice_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="third_notice_result"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getThird_notice_result())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="notice_desc"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getNotice_desc())%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="exam_process"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getExam_process())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="exam_date"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getExam_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1"><fmt:message key="exam_result"/>：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmppostConstants.DICTIONARY_, resultVo.getExam_result())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="mobile"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMobile())%></td>
		</tr>
		<tr>
			<td class="td_1" ><fmt:message key="email"/>：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail())%></td>
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
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>
