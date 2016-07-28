<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.receivable.finclaim.vo.FinclaimVo" %>
<%@ page import="rayoo.finance.receivable.finclaim.util.IFinclaimConstants" %>
<%  //取出本条记录
	FinclaimVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (FinclaimVo)request.getAttribute(IFinclaimConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/FinclaimAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >客户ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >成本中心ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCost_center_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >到款ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIncoming_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >认领类型：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >认领时间(费用帐期)：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_year_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >认领人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >认领金额：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_amount())%></td>
		</tr>
		<tr>
			<td class="td_1" >claim_desc：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getClaim_desc())%></td>
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
