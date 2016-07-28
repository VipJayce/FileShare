<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<script language="javascript">
function test1(frm) {
	frm.action = "<%=request.getContextPath()%>/BasicTag.do";
	frm.submit();
}

function test2(frm) {
	frm.action = "<%=request.getContextPath()%>/jsp/report/xls/reporting.jsp";
	frm.submit();
}

</script>
</head>

<body bgcolor="#ffffff">
<script language="javascript">
	writeTableTop('基于Jxls的解决方案','<venus:base/>/');
</script>
<form method="post" target="_blank">
<br><br>
<input type="button" name="btnTest1" value="jxls标记示例" class="button_ellipse" onclick="javascript:test1(this.form);"/>
<input type="button" name="btnTest2" value="报表填报" class="button_ellipse" onclick="javascript:test2(this.form);"/>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>

</html>
