<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<%@ page import="rayoo.sales.costcenter.util.ICostcenterConstants" %>
<%  //取出本条记录
	CostcenterVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (CostcenterVo)request.getAttribute(ICostcenterConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=queryAll&backFlag=false";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
<div id="right">
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
			<td class="td_1" >客户编号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCustomer_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >成本中心名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCost_center_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >发票抬头：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getReceipt_title())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否有账期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_account_limit())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否财务快递：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_finance_send())%></td>
		</tr>
		<tr>
			<td class="td_1" >约定到款日：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAgree_receive_money_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >到款日所属月：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getReceive_money_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否预开票：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_beforehand_voucher())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否有汇差：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_remittance_error())%></td>
		</tr>
		<tr>
			<td class="td_1" >是否固定垫付：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_fixed_pay_later())%></td>
		</tr>
		<tr>
			<td class="td_1" >联系人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContact_person())%></td>
		</tr>
		<tr>
			<td class="td_1" >联系人地址：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContact_address())%></td>
		</tr>
		<tr>
			<td class="td_1" >邮编：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getZip_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >联系电话1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContact_tel1())%></td>
		</tr>
		<tr>
			<td class="td_1" >联系电话2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getContact_tel2())%></td>
		</tr>
		<tr>
			<td class="td_1" >传真：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFax())%></td>
		</tr>
		<tr>
			<td class="td_1" >电子邮件：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmail())%></td>
		</tr>
		<tr>
			<td class="td_1" >开票规则：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getVoucher_rule())%></td>
		</tr>
		<tr>
			<td class="td_1" >备注：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemarks())%></td>
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
			<td class="td_1" >最后修改人ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >最后修改日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
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
