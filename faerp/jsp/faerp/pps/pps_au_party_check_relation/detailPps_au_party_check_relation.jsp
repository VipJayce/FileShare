<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.pps.pps_au_party_check_relation.vo.Pps_au_party_check_relationVo" %>
<%@ page import="rayoo.pps.pps_au_party_check_relation.util.IPps_au_party_check_relationConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	Pps_au_party_check_relationVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (Pps_au_party_check_relationVo)request.getAttribute(IPps_au_party_check_relationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        window.close();
    }
</script>
</head>
<body>
<form name="form" method="post">
       <div id="right">
    	<div class="ringht_x" style="height: 260px;">
<div class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >PPS客户名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_cust_name())%></td>
			<td class="td_1" >PPS客户编号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_cust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >PPS复核客户名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_cust_check_name())%></td>
			<td class="td_1" >PPS复核客户编号：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getPps_cust_check_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >备注：</td>
			<td class="td_2" colspan="3"><%=RmStringHelper.prt(resultVo.getO_remark())%></td>
		</tr>
	</table>
</div>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>
</div>
	 </div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
