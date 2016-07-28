<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.vo.Job_chargeetransfertemplateVo" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.util.IJob_chargeetransfertemplateConstants" %>
<%  //取出本条记录
	Job_chargeetransfertemplateVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (Job_chargeetransfertemplateVo)request.getAttribute(IJob_chargeetransfertemplateConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>模板名称：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getName())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>模板编码：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCode())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>状态：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getStatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>生效日期：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEffectivedate(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>失效日期：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getExpirydate(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>费用转出部门：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOutdept_id())%></td>
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
			<td align="right" width="10%" nowrap>分公司ID：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>客户创建人名：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCreate_user_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>最后修改人ID：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>客户最后修改人名称：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_name())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>最后修改日期：</td>
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
