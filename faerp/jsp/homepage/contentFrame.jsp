<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="gap.authority.service.sys.vo.SysParamVo"%>
<%@ page import="gap.authority.util.GlobalConstants"%>
<%
     SysParamVo multiTab = GlobalConstants.getSysParam(GlobalConstants.MULTITAB);
     if (multiTab != null && Integer.parseInt(multiTab.getValue()) > 0) { //启用多页签
%>       
<script>
    window.location.href="<%=request.getContextPath()%>/jsp/homepage/body.jsp";
</script>
<% } else { //不使用多页签 %>
<script>
    window.location.href="<%=request.getContextPath()%>/jsp/homepage/simpleBody.jsp";
</script>            
<% } %>