<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.workattendance.workattendancerule.psncalendar.vo.PSNCALENDARVo" %>
<%@ page import="rayoo.workattendance.workattendancerule.psncalendar.util.IPSNCALENDARConstants" %>
<%  //取出本条记录
	PSNCALENDARVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (PSNCALENDARVo)request.getAttribute(IPSNCALENDARConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
			<td align="right" width="10%" nowrap>出差数据是否汇总：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getAwaydatacostatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>休假数据是否汇总：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLeavedatacostatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>公司主键：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>加班数据是否汇总：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getOvertimedatacostatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>考勤数据是否汇总：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getKqdatacostatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>考勤数据是否生成：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getDatacreatestatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>考勤机数据是否导入：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getDataimportstatus())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>工作时长：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getGzsj())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>是否休假：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getIf_rest())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>当日排班遇假日取消、保留的标志：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCancelflag())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>日历：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCalendar())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>人员主键：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
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
			<td align="right" width="10%" nowrap>最后修改人：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>最后修改日期：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap>分公司id：</td>
			<td align="left"><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
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
