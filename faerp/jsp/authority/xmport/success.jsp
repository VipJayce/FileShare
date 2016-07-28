<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="venus.frames.mainframe.util.Helper"%>
<%@ page import="gap.authority.sample.xmport.lock.EtlLock" %>
<%@ page import="gap.authority.sample.xmport.lock.SequenceCountLock" %>
<%@ page import="gap.authority.service.syserror.bs.ISysErrorBs" %>
<%@ page import="gap.authority.service.syserror.util.IContants" %>
<%
    EtlLock multiLock = SequenceCountLock.getInstance();
	while(multiLock.isLock())
	    multiLock.useKey();
	ISysErrorBs sysErrorBs = (ISysErrorBs) Helper.getBean(IContants.BS_KEY);
	String queryCondition = " ERROR_TYPE = '1' ";
	int errorCount = sysErrorBs.getRecordCount(queryCondition);
	if (errorCount > 0) //查询是否有导入出错的数据
	  response.sendRedirect(request.getContextPath() + "/jsp/authority/xmport/oneTouchImport.jsp");
%>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Implementation_of_the_import' bundle='${applicationAuResources}' /></title>
</head>
<link href="<venus:base/>/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<body>
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Implementation_of_the_import' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<div id="auDivChild0"> 
<table class="table_div_content" style="width:96%">
	<tr>
		<td>
			<table width="100%">
			  <tr>
				<td align=center><fmt:message key='gap.authority.Import_Results' bundle='${applicationAuResources}' />:<bean:write name = "anser" /></td>
			</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</form>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

