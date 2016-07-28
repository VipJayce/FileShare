<%@ page contentType="text/html; charset=GBK" language="java" %>
<html>
<head>
<%@ include file="/jsp/include/global.jsp" %>
<script src="<%=request.getContextPath()%>/js/rm-insert.js" type=text/javascript></script>
<script src="<%=request.getContextPath()%>/jsp/include/FCKeditor/fckeditor.js" type="text/javascript"></script>
		<title>test</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<meta name="robots" content="noindex, nofollow">
	</head>
	<body>
		<form name="form" action="testFck.jsp" method="post" target="_self">
			<textarea id="FCKeditor1" name="FCKeditor1" class="textarea_fckEditor">战无不胜的毛泽东思想万岁！</textarea>
			<br>
			<input type="button" value="上交" onClick="form.submit();">
		</form>
		<p><br/><br/><br/><br/>
		<%
			if(request.getParameter("FCKeditor1") != null) {
				out.print(request.getParameter("FCKeditor1"));
			}
		%>
		</p>
	</body>
</html>
