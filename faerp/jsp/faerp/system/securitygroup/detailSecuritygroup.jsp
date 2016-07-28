<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.system.securitygroup.vo.SecuritygroupVo" %>
<%@ page import="rayoo.system.securitygroup.util.ISecuritygroupConstants" %>
<%  //取出本条记录
	SecuritygroupVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (SecuritygroupVo)request.getAttribute(ISecuritygroupConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >省市：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCity_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >社保组名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGroup_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >入职服务名称：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getService_id())%></td>
		</tr>
		<tr>
			<td class="td_1">组类别：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getGroup_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >年度调整月：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAdjust_month())%></td>
		</tr>
		<tr>
			<td class="td_1" >每月办理截止日：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getTransact_day(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >每月停办截止日：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getStop_day(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1">保险托收：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getSs_collection_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1">保险托收方式：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getCollection_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1">停办方式：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getStop_month_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1">补缴月类型：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getSupply_month_type_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >默认显示：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_default_show())%></td>
		</tr>
		<tr>
			<td class="td_1">绑定基数：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getBind_radix_bd())%></td>
		</tr>
		<tr>
			<td class="td_1">使用账号/序号：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getUse_account_or_num_bd())%></td>
		</tr>
		<tr>
			<td class="td_1">企业支付方式：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getE_pay_policy_bd())%></td>
		</tr>
		<tr>
			<td class="td_1">个人支付方式：</td>
			<td class="td_2"><%=gap.rm.project.RmGlobalReference.get(ISecuritygroupConstants.DICTIONARY_, resultVo.getP_pay_policy_bd())%></td>
		</tr>
		<tr>
			<td class="td_1" >说明：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getExplanation())%></td>
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
