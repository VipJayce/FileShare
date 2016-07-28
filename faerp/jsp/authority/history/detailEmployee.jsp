<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.service.history.util.IContants" %>
<%@ page import="gap.authority.sample.employee.vo.EmployeeVo" %>
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
					<td width="20%" align="right"><fmt:message key='gap.authority.Name_0' bundle='${applicationAuResources}' /></td>
					<td width="80%" align="left"><%=StringHelperTools.prt(map.get("person_name"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("person_no"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.English_name_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("english_name"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Staff_category_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("person_type"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Sex_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%="1".equals(map.get("sex"))?venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Male"):venus.frames.i18n.util.LocaleHolder.getMessage("gap.authority.Female")%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Mobile_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("mobile"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Telephone_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("tel"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.E_mail_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("email"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Address_1' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("address"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Postal_Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("postalcode"))%></td>
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

