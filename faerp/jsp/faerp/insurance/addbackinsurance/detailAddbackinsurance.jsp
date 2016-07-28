<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.insurance.addbackinsurance.vo.AddbackinsuranceVo" %>
<%@ page import="rayoo.insurance.addbackinsurance.util.IAddbackinsuranceConstants" %>
<%  //取出本条记录
	AddbackinsuranceVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AddbackinsuranceVo)request.getAttribute(IAddbackinsuranceConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/AddbackinsuranceAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >apply_insurance_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getApply_insurance_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_order_item_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_order_item_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >product_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_id())%></td>
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
			<td class="td_1" >insurance_status_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurance_status_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_post_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_post_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >policy_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPolicy_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >insurance_property_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurance_property_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >insurance_city_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInsurance_city_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >original_product_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOriginal_product_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >aft_product_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAft_product_id())%></td>
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
			<td class="td_1" >is_valid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
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
