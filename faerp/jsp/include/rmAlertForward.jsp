<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中国网通（集团）有限公司河北省分公司企业信息门户</title>
</head>
<body>
<script language="javascript">
	writeTableTop('友情提示','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
try {
<%
	String rm_alertStr = request.getParameter("rm_alertStr");
	String rm_targetForwardPath = request.getParameter("rm_targetForwardPath");
	if(rm_alertStr == null || rm_targetForwardPath == null) {
		out.println("alert('调用本页面不正确，请检查程序');");
	} else {
		rm_alertStr = gap.rm.tools.helper.RmStringHelper.replaceStringToScript(rm_alertStr);
		out.println("alert('" + rm_alertStr + "');");
		rm_targetForwardPath = request.getContextPath() + rm_targetForwardPath;
		rm_targetForwardPath = gap.rm.tools.helper.RmStringHelper.replaceStringToScript(rm_targetForwardPath);
		out.println("window.location = '" + rm_targetForwardPath + "';");
	}
%>
} catch(e) {
	alert("rmAlertForward.jsp页面的脚本程序出现异常: + \n" + e.message);
}
</script>