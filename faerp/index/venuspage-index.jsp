<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<frameset  name="mainFrame" rows="31,*" framespacing="0" frameborder="no" border="0">
  <frame  name="title" src="<%=request.getContextPath()%>/jsp/common/templatemenu.jsp" scrolling="no" noresize>
  <frame name="body" src="<%=request.getContextPath()%>/TemplateAction.do?cmd=queryAll" scrolling="yes" noresize>
</frameset>

<noframes>对不起，您的浏览器不支持框架</noframes>