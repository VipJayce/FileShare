<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<jsp:include page="/workflowForm/extendFormHead.jsp" flush="true"/>
<fmt:bundle basename="gap.wf.bpms_resource" prefix="gap.wf.">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="workflow_form"/></title>
</head>

<body>

<logic:present name="formDesignVo">
	<bean:write name="formDesignVo" property="content" filter="false"/>
</logic:present>
<logic:notPresent name="formDesignVo">
	<b><font color="red"><fmt:message key="form_deleted"/></font></b>
</logic:notPresent>
</fmt:bundle>
</body>
</html>

<jsp:include page="/workflowForm/extendFormFoot.jsp" flush="true"/>