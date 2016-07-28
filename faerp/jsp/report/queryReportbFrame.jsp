<html>
<head>
<title>frame test</title>
</head>
<frameset rows="30%,70%" style="background-color: #000000">
	<frame name=frame1 frameborder="0" marginwidth="500" scrolling="no"  src=<%=request.getContextPath()%>/jsp/report/queryReportb.jsp>
	<frame name=frame2 frameborder="0" style="background-color: #FFFFFF">
</frameset>
</html>
