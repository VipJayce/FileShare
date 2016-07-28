<%@ page contentType="text/html; charset=UTF-8" %>
<%
String flag=(String)request.getParameter("flag");

if(flag.equals("factory")){%>
	<frameset rows="0,*" border="0">
		<frame src="about:blank">
		<frame name="listBody" src="<%=request.getContextPath()%>/AjaxSingleTableAction.do?cmd=queryFactory" noresize border="0" frameborder="0">
	</frameset>
<%}else if(flag.equals("product")){%>
	<frameset rows="0,*" border="0">
		<frame src="about:blank">
		<frame name="listBody" src="<%=request.getContextPath()%>/AjaxSingleTableAction.do?cmd=queryProduct" noresize border="0" frameborder="0">
	</frameset>
<%
}

%>
<noframes>对不起，您的浏览器不支持框架</noframes>