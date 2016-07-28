<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
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
    	<div class="ringht_s">
	<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1">科目编码：</td>
			<td class="td_2">${bean.ccode}</td>
			<td class="td_1">科目名称：</td>
			<td class="td_2">${bean.ccode_name}</td>
		</tr>
		<tr>
			<td class="td_1">编码级次：</td>
			<td class="td_2">${bean.igrade}</td>
			<td class="td_1">科目性质：</td>
			<td class="td_2">${bean.bpropertystr}</td>
		</tr>
	</table>
	<div class="foot_button">
		<input type="button" class="foot_icon_1" value='关闭'   onclick="javascript:back_onClick();" />
    </div>
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
