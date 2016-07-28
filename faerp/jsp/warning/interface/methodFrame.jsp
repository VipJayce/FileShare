<%@ page contentType="text/html; charset=UTF-8" %>
	<%
		String interfaceName=(String)request.getParameter("interfaceName");
		%>

<frameset  name="mainFrame1" rows="*" framespacing="0" frameborder="no" border="0">
  <frame name="body1" src="<%=request.getContextPath()%>/WarningObjectAction.do?cmd=onGetMethod&interfaceName=<%=interfaceName%>" scrolling="yes" noresize>
</frameset>