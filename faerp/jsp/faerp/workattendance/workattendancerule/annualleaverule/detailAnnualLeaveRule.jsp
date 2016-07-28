<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.workattendance.workattendancerule.annualleaverule.vo.AnnualLeaveRuleVo" %>
<%@ page import="rayoo.workattendance.workattendancerule.annualleaverule.util.IAnnualLeaveRuleConstants" %>
<%  //取出本条记录
	AnnualLeaveRuleVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AnnualLeaveRuleVo)request.getAttribute(IAnnualLeaveRuleConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/AnnualLeaveRuleAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >法定年假天数：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAnnualleavedays())%></td>
		</tr>
		<tr>
			<td class="td_1" >公司福利年假天数：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getC_annualleavedays())%></td>
		</tr>
		<tr>
			<td class="td_1" >法定加班工资倍数：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOvertimemultiple())%></td>
		</tr>
		<tr>
			<td class="td_1" >公司主键：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >分公司主键：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >可调休开始时间：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTakeworksstartdate(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >可调休结束时间：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTakeworksenddate(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >是否有效：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否删除：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >创建用户ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >创建日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCreate_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >公司福利年假加班工资倍数：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getC_overtimemultiple())%></td>
		</tr>
		<tr>
			<td class="td_1" >年份：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAnnualleaveyear())%></td>
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
