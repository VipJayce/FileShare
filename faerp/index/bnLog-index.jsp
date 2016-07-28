<%@ page contentType="text/html; charset=UTF-8" %>

<frameset  name="mainFrame1" rows="31,*" framespacing="0" frameborder="no" border="0">
  <frame  name="title1" src="<%=request.getContextPath()%>/jsp/bnLog/topMenu.jsp" scrolling="no" noresize>
  <frame name="body1" src="<%=request.getContextPath()%>/BnLogAction.do?cmd=queryAll" scrolling="yes" noresize>
</frameset>

<noframes>对不起，您的浏览器不支持框架</noframes>








