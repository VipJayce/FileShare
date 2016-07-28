<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.hirefire.filefeesmanage.vo.FileFeesManageVo" %>
<%@ page import="rayoo.customerservice.hirefire.filefeesmanage.util.IFileFeesManageConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出本条记录
	FileFeesManageVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (FileFeesManageVo)request.getAttribute(IFileFeesManageConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
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
<form name="form" method="post" id="formId">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">员工姓名：</td>
			<td class="td_2">${bean.emp_name }</td>
			<td class="td_1">唯一号：</td>
			<td class="td_2">${bean.emp_code }</td>
		</tr>
		<tr>
			<td class="td_1">证件号码：</td>
			<td class="td_2">${bean.id_card }</td>
			<td class="td_1">缴费开始日期：</td>
			<td class="td_2"><%=RmStringHelper.prt(resultVo.getStart_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1">缴费结束日期：</td>
			<td class="td_2"><%=RmStringHelper.prt(resultVo.getEnd_date(), 10)%></td>
			<td class="td_1">缴费金额：</td>
			<td class="td_2"><%=RmStringHelper.prt(resultVo.getMoney())%></td>
		</tr>
		<tr>
			<td class="td_1">客户名称：</td>
			<td class="td_2">${bean.cust_name }</td>
			<td class="td_1">客户编号：</td>
			<td class="td_2">${bean.cust_code }</td>
		</tr>
		<tr>
			<td class="td_1">数据来源</td>
			<td class="td_2"><%=BaseDataHelper.getNameByCode("DATE_FROM",resultVo.getDate_from()) %></td>
			<td class="td_1">缴纳地点：</td>
			<td class="td_2">${bean.payment_place }</td>
		</tr>
		<tr>
			<td class="td_1">备注：</td>
			<td class="td_2" colspan="3">${bean.remark }</td>
		</tr>
	</table>
</div>
<div class="mx_button" align="center">
	<input type="button" class="icon_2" value='关闭'  onClick="javascript:back_onClick()"/>
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
