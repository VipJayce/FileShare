<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.job.job_personresume.vo.JOB_PERSONRESUMEVo" %>
<%@ page import="rayoo.job.job_personresume.util.IJOB_PERSONRESUMEConstants" %>
<%  //取出本条记录
	JOB_PERSONRESUMEVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (JOB_PERSONRESUMEVo)request.getAttribute(IJOB_PERSONRESUMEConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>persion_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getPersion_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>iid：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>ipersonid：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIpersonid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>ilan：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIlan())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sname：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSname())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sdept：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSdept())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sposition：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSposition())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sevaluate：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSevaluate())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>straining：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStraining())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sproject：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSproject())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>scertificate：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getScertificate())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sbasicsalary：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSbasicsalary())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sbonus：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSbonus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sallowance：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSallowance())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sstock：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSstock())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>scomments：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getScomments())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>scopypaste：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getScopypaste())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>sfulltext：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getSfulltext())%></td>
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
