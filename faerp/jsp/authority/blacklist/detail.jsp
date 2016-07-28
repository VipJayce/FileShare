<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>

<%@ page import="gap.authority.service.blacklist.vo.BlackOrWhiteVo"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='gap.authority.Detail_Page' bundle='${applicationAuResources}' /></title>
</head>
<body>
<script language="javascript">
    writeTableTop("<fmt:message key='gap.authority.Detailed_Page' bundle='${applicationAuResources}' />",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<form name="form" method="post">
<table class="table_noFrame">
    <tr>
        <td>
            <input name="button_back" class="button_ellipse" type="button" value="<fmt:message key='gap.authority.Return' bundle='${applicationAuResources}' />"  onclick="javascript:returnBack();" >
        </td>
    </tr>
</table>
<div id="ccParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key='gap.authority.View_Details' bundle='${applicationAuResources}' />
        </td>
    </tr>
</table>
</div>
<div id="ccChild0"> 
<table class="table_div_content">
    <tr> 
    <td>
    <table class="table_div_content_inner">
    <tr>
        <td align="right" width="10%" nowrap><fmt:message key='gap.authority.Blacklist_Name_' bundle='${applicationAuResources}' /></td>
        <td align="left"><bean:write name="bean" property="blackList.name" /></td>
    </tr>
    <tr>
        <td align="right"><fmt:message key='gap.authority.Blacklist_content_' bundle='${applicationAuResources}' /></td>
        <td align="left"><bean:write name="bean" property="content" /></td>
    </tr>
    </table>
    </td>
    </tr>   
</table>
</div>
</form>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

