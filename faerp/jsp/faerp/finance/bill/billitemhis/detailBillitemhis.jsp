<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.bill.billitemhis.vo.BillitemhisVo" %>
<%@ page import="rayoo.finance.bill.billitemhis.util.IBillitemhisConstants" %>
<%  //取出本条记录
	BillitemhisVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (BillitemhisVo)request.getAttribute(IBillitemhisConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/BillitemhisAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >old_bill_item_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getOld_bill_item_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >service_year_month：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getService_year_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >product_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_post_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_post_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >amount：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAmount())%></td>
		</tr>
		<tr>
			<td class="td_1" >serial_no：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSerial_no())%></td>
		</tr>
		<tr>
			<td class="td_1" >p_money：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >e_money：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >p_base：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_base())%></td>
		</tr>
		<tr>
			<td class="td_1" >e_base：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_base())%></td>
		</tr>
		<tr>
			<td class="td_1" >p_ratio：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_ratio())%></td>
		</tr>
		<tr>
			<td class="td_1" >e_ratio：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_ratio())%></td>
		</tr>
		<tr>
			<td class="td_1" >p_add_money：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_add_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >e_add_money：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_add_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >security_product_item_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSecurity_product_item_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >security_product_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getSecurity_product_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_sum：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_sum())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_security：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_exclusive_security())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_accumulation：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_exclusive_accumulation())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_salary：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_exclusive_salary())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_exclusive_tax：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_exclusive_tax())%></td>
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
