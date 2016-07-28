<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupply.vo.EmpsecuritysupplyVo" %>
<%@ page import="rayoo.customerservice.security.empsecuritysupply.util.IEmpsecuritysupplyConstants" %>
<%  //取出本条记录
	EmpsecuritysupplyVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EmpsecuritysupplyVo)request.getAttribute(IEmpsecuritysupplyConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmpsecuritysupplyAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >社保公积金ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_security_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >产品ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getProduct_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >正常汇缴起始月：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFund_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >缴费起始月：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStart_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >缴费结束月：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEnd_month())%></td>
		</tr>
		<tr>
			<td class="td_1">补缴类型：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(IEmpsecuritysupplyConstants.DICTIONARY_, resultVo.getSupply_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >基数：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBase())%></td>
		</tr>
		<tr>
			<td class="td_1" >金额：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMoney())%></td>
		</tr>
		<tr>
			<td class="td_1" >企业金额：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >个人金额：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >企业滞纳金：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_latefee())%></td>
		</tr>
		<tr>
			<td class="td_1" >个人滞纳金：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_latefee())%></td>
		</tr>
		<tr>
			<td class="td_1" >企业附加金额：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_add_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >个人附加金额：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_add_money())%></td>
		</tr>
		<tr>
			<td class="td_1" >备注：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRemarks())%></td>
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
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
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
