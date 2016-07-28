<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.eppartyrelation.vo.EppartyrelationVo" %>
<%@ page import="rayoo.employeepost.eppartyrelation.util.IEppartyrelationConstants" %>
<%  //取出本条记录
	EppartyrelationVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EppartyrelationVo)request.getAttribute(IEppartyrelationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EppartyrelationAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >党支部成员ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getParty_member_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >员工入离职ID：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_post_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >从何支部转入：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRelationship_from())%></td>
		</tr>
		<tr>
			<td class="td_1" >转入何支部：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getRelationship_to())%></td>
		</tr>
		<tr>
			<td class="td_1" >状态：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStatus())%></td>
		</tr>
		<tr>
			<td class="td_1" >转入人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMove_in_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >转出人：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMove_out_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >转入日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMove_in_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >转出日期：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getMove_out_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >是否党支部书记：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_secretary())%></td>
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
