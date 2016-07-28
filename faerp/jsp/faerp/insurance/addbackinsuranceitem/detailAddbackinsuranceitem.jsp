<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.insurance.addbackinsuranceitem.vo.AddbackinsuranceitemVo" %>
<%@ page import="rayoo.insurance.addbackinsuranceitem.util.IAddbackinsuranceitemConstants" %>
<%  //取出本条记录
	AddbackinsuranceitemVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AddbackinsuranceitemVo)request.getAttribute(IAddbackinsuranceitemConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/AddbackinsuranceitemAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >add_back_insurance_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAdd_back_insurance_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >insurance_property_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurance_property_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >insurance_address：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurance_address())%></td>
		</tr>
		<tr>
			<td class="td_1" >chil_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChil_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >chil_sex_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChil_sex_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >chil_birthday：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChil_birthday(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >chil_applicant_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChil_applicant_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >chil_append_item：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChil_append_item())%></td>
		</tr>
		<tr>
			<td class="td_1" >备注：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemark())%></td>
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
			<td class="td_1" >start_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStart_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >end_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEnd_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >chil_insurance_status_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getChil_insurance_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >spply_insurance_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSpply_insurance_id())%></td>
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