<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="gap.authority.service.history.util.IContants" %>
<%@ page import="gap.authority.sample.company.vo.CompanyVo" %>
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
					<td width="20%" align="right"><fmt:message key='gap.authority.Company_Name_' bundle='${applicationAuResources}' /></td>
					<td width="80%" align="left"><%=StringHelperTools.prt(map.get("company_name"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("company_no"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_Abbreviation_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("short_name"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_ID_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("company_flag"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Type_0' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("company_type"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Company_level_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("company_level"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Your_area_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("area"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Contact_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("linkman"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Tel_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("tel"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Fax_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("fax"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Postal_Code_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("postalcode"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Address_0' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("address"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.E_mail_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("email"))%></td>
				</tr>
				<tr>
					<td align="right"><fmt:message key='gap.authority.Website_' bundle='${applicationAuResources}' /></td>
					<td align="left"><%=StringHelperTools.prt(map.get("web"))%></td>
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
</td></tr>
</table>
</div>
</body>

