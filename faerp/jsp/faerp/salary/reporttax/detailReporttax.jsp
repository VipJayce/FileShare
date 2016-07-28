<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.salary.reporttax.vo.ReporttaxVo" %>
<%@ page import="rayoo.salary.reporttax.util.IReporttaxConstants" %>
<%  //取出本条记录
	ReporttaxVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (ReporttaxVo)request.getAttribute(IReporttaxConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/ReporttaxAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >salary_class_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSalary_class_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_post_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_post_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >tax_table_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTax_table_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_tax：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_tax())%></td>
		</tr>
		<tr>
			<td class="td_1" >remarks：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemarks())%></td>
		</tr>
		<tr>
			<td class="td_1" >payday：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPayday())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_local_pay：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_local_pay())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_sip：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_sip())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_hfp：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_hfp())%></td>
		</tr>
		<tr>
			<td class="td_1" >tax_flag：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTax_flag())%></td>
		</tr>
		<tr>
			<td class="td_1" >salary_tax_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSalary_tax_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >stop_flag：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStop_flag())%></td>
		</tr>
		<tr>
			<td class="td_1" >stop_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStop_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td class="td_1" >tax_bureau：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTax_bureau())%></td>
		</tr>
		<tr>
			<td class="td_1" >tax_region_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTax_region_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPayroll_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >si_source：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSi_source())%></td>
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
			<td class="td_1" >valid_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getValid_date(), 10)%></td>
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