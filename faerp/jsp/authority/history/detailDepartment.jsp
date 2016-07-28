<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.service.history.util.IContants" %>
<%@ page import="gap.authority.sample.department.vo.DepartmentVo" %>
<%@ page import="gap.authority.util.VoHelperTools" %>
<%@ page import="gap.authority.util.StringHelperTools" %>
<%@ page import="java.util.Map" %>
<%@ include file="/jsp/include/global.jsp" %>
<%
	Map map = (Map)request.getAttribute(IContants.REQUEST_BEANS_VALUE);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GAP<fmt:message key='gap.authority.Organizational_competence_system' bundle='${applicationAuResources}' /></title>
</head>
<body class="table_div_content">
<div id="ccChild0"> 
<table>
	<tr>
		<td>
			<table class="table_div_content_inner">
				<tr>
					<td width="20%" align="right"><fmt:message key='gap.authority.Department_Name_' bundle='${applicationAuResources}' /></td>
					<td width="80%" align="left"><%=StringHelperTools.prt(map.get("dept_name"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("dept_no"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Department_ID_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("dept_flag"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Department_Type_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("dept_type"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Sectoral_level_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("dept_level"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Responsible_Person_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("dept_leader"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Remarks_' bundle='${applicationAuResources}' /></td>
					<td colspan="3" align="left"><%=StringHelperTools.prt(map.get("remark"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Created_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("create_date"),19)%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Modified_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("modify_date"),19)%></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</body>

