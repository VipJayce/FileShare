<html>
<title>Global Application Platform</title>
  <frameset cols="209,*" border="0">
    <frame src="<%=request.getContextPath()%>/jsp/msgbox/TaskMenu.jsp" name="left"/>
	<frame name="bodyFrame" src="<%=request.getContextPath()%>/jsp/gapmsg.jsp"/>
    </frameset>
 
  </frameset>
	<noframes>
		<body>
			<fmt:message key='gap.message.I_am_sorry' bundle='${applicationMessageResources}' />,<fmt:message key='gap.message.Your_browser_does_not_support_frames' bundle='${applicationMessageResources}' />
		</body>
	</noframes>
</html>

