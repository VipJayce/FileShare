<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import = "gap.authority.au.auresource.util.IAuResourceConstants" %>
<%
String isRight=(String)request.getAttribute(IAuResourceConstants.REQUEST_BEAN_VALUE);
%>
<html>
<title><fmt:message key='gap.authority.Record_level_data_permissions_test' bundle='${applicationAuResources}' /></title>
<!-- </head> -->
<script language="javascript">
	writeTableTop("<fmt:message key='gap.authority.Test' bundle='${applicationAuResources}' />",'<venus:base/>/');
</script>
<br>
<%if("true".equals(isRight)){ %>
<center><font color='009900'><fmt:message key='gap.authority.Tested' bundle='${applicationAuResources}' /></font></center>
<%}else{%>
<center><font color='FF0000'><fmt:message key='gap.authority.Test_fails' bundle='${applicationAuResources}' /></font></center>
<%}%>
<br>
<center>
	<input name="button_close" type="button" class="button_ellipse" value="<fmt:message key='gap.authority.Close' bundle='${applicationAuResources}' />" onClick="javascript:window.close();">
</center>
<script language="javascript">
	writeTableBottom('<venus:base/>/');
</script>
<!--</body>  -->
</fmt:bundle>
</html>

