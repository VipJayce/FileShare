<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.inadvance.finverifcation.vo.FinverifcationVo" %>
<%@ page import="rayoo.finance.inadvance.finverifcation.util.IFinverifcationConstants" %>
<%  //取出本条记录
	FinverifcationVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (FinverifcationVo)request.getAttribute(IFinverifcationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/FinverifcationAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >cust_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
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
			<td class="td_1" >cost_center_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCost_center_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >cost_center_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCost_center_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >claim_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >bill_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >invoice_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInvoice_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >ver_amount：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getVer_amount())%></td>
		</tr>
		<tr>
			<td class="td_1" >bill_year_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_year_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >bill_type_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >rate_odds：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRate_odds())%></td>
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
			<td class="td_1" >balance_amount：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBalance_amount())%></td>
		</tr>
		<tr>
			<td class="td_1" >used_verid：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getUsed_verid())%></td>
		</tr>
		<tr>
			<td class="td_1" >ver_invoice_status_bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getVer_invoice_status_bd())%></td>
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
