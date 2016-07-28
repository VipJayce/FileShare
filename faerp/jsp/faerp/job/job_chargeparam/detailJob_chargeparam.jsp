<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.job.job_chargeparam.vo.Job_chargeparamVo" %>
<%@ page import="rayoo.job.job_chargeparam.util.IJob_chargeparamConstants" %>
<%  //取出本条记录
	Job_chargeparamVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (Job_chargeparamVo)request.getAttribute(IJob_chargeparamConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>参数名称：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getParamname())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>参数代码：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getParamcode())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>公式：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getFormula())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>费用划转模板主键：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getChargetransfertemplate_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>数据类型：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getDatatype())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>默认值：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getDefaultvalue())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>参数序号：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getParamnumber())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>备注：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getDescription())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>是否有效：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_valid())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>是否删除：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>company_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>create_user_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCreate_user_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_user_id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_user_name：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>last_update_date：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
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
