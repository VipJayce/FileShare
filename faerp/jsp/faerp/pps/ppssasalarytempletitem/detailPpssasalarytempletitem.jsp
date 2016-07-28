<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.pps.ppssasalarytempletitem.vo.PpssasalarytempletitemVo" %>
<%@ page import="rayoo.pps.ppssasalarytempletitem.util.IPpssasalarytempletitemConstants" %>
<%  //取出本条记录
	PpssasalarytempletitemVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (PpssasalarytempletitemVo)request.getAttribute(IPpssasalarytempletitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/PpssasalarytempletitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >salary_temp_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSalary_temp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >salary_class_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSalary_class_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >sa_item_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSa_item_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >sa_item_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSa_item_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >sa_item_ename：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSa_item_ename())%></td>
		</tr>
		<tr>
			<td class="td_1" >item_cost_group：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getItem_cost_group())%></td>
		</tr>
		<tr>
			<td class="td_1" >compute_level：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompute_level())%></td>
		</tr>
		<tr>
			<td class="td_1" >item_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getItem_type())%></td>
		</tr>
		<tr>
			<td class="td_1" >ishide：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIshide())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_system：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_system())%></td>
		</tr>
		<tr>
			<td class="td_1" >payroll_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPayroll_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_tax：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_tax())%></td>
		</tr>
		<tr>
			<td class="td_1" >data_source：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getData_source())%></td>
		</tr>
		<tr>
			<td class="td_1" >source_item：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSource_item())%></td>
		</tr>
		<tr>
			<td class="td_1" >compute_order：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompute_order())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_display：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_display())%></td>
		</tr>
		<tr>
			<td class="td_1" >display_order：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDisplay_order())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_bonus：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_bonus())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_labor：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_labor())%></td>
		</tr>
		<tr>
			<td class="td_1" >bonus_months_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBonus_months_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >property：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProperty())%></td>
		</tr>
		<tr>
			<td class="td_1" >item_serial_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getItem_serial_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >item_serial_new_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getItem_serial_new_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >old_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >decimal_num：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDecimal_num())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
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
			<td class="td_1" >welfare_display_order：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getWelfare_display_order())%></td>
		</tr>
		<tr>
			<td class="td_1" >salary_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSalary_type())%></td>
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