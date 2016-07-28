<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.agent.agentfinbillothers.vo.AgentfinbillothersVo" %>
<%@ page import="rayoo.agent.agentfinbillothers.util.IAgentfinbillothersConstants" %>
<%  //取出本条记录
	AgentfinbillothersVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (AgentfinbillothersVo)request.getAttribute(IAgentfinbillothersConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/RoomAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
<script language="javascript">
	writeTableTop('<fmt:message key="detail_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
	<tr>
		<td><br>&nbsp;&nbsp;&nbsp;&nbsp;<input name="button_back" class="button_ellipse" type="button" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" >
		</td>
	</tr>
</table>

<div id="ccParent0"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0"> 
	<table class="viewlistCss" style="width:100%">
		<tr>
			<td align="right" width="10%" nowrap>bill_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getBill_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>charge_item_bd：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCharge_item_bd())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>amount：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAmount())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>charge_desc：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCharge_desc())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_valid：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>is_del：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>old_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOld_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>verification_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getVerification_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>verification_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getVerification_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td align="left"></td>
		</tr>
	</table>
</div>

<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
