<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<script language="javascript">
<!--
function test1(frm) {
	frm.action = "<%=request.getContextPath()%>/TestReport.do";
	frm.submit();
}

function test2(frm) {
	frm.action = "<%=request.getContextPath()%>/ExcelReport.do";
	frm.submit();
}
//-->
</script>
</head>

<body >
<script language="javascript">
	writeTableTop('基于ExcelUtils的解决方案','<venus:base/>/');
</script>
<form method="post" target="_blank">
<br><br>
<input type="button" name="btnTest1" value="示例1" class="button_ellipse" onclick="javascript:test1(this.form);"/>
<input type="button" name="btnTest2" value="示例2" class="button_ellipse" onclick="javascript:test2(this.form);"/>
</form>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
</body>

</html>
