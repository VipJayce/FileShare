<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<title>Global Application Platform 3.0</title>
    <frameset id="mainframe" frameborder="no" cols="200,10,*">
      	<frame name="menuFrame"  noresize="" src="<%=request.getContextPath()%>/jsp/dd/controldata/menu.jsp" />
      	<frame id="midFrame" noresize="" scrolling="no" noresize="" name="switchFrame" src="mid.jsp"/>
      	<frame name="bodyFrame" noresize="" src="<%=request.getContextPath()%>/jsp/dd/controldata/body.jsp"/>
    </frameset>
	<noframes>
		<body>
			sorry,your browser can not support frame
		</body>
	</noframes>
</html>